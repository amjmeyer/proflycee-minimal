#!/bin/bash
# Tests du paquet, en trois groupes :
#
#   beta/       contrôle visuel : chaque fichier doit compiler sans erreur ni
#               avertissement ; les PDF vont dans tests/sortie/ (ignorés par git)
#   unitaires/  vérifications automatiques (assert) : un échec = une erreur
#               de compilation, avec le message de l'assertion
#   erreurs/    entrées invalides : chaque fichier doit ÉCHOUER, avec le
#               message annoncé en première ligne (« // attendu : … »)
#
#   tests/lancer.sh            → tous les tests
#   tests/lancer.sh 06 41      → seulement les tests dont le nom commence ainsi
#                                (dans chaque groupe)

cd "$(dirname "$0")/.."

# Compilateur : `typst` s'il est installé, sinon celui de l'extension Tinymist de VSCodium.
if command -v typst > /dev/null; then
  TYPST=typst
else
  TYPST=$(ls -d ~/.var/app/com.vscodium.codium/data/codium/extensions/myriad-dreamin.tinymist-*/out/tinymist | tail -1)
  export TYPST_PACKAGE_CACHE_PATH=~/.var/app/com.vscodium.codium/cache/typst/packages
fi

# garder(nom) : vrai si aucun filtre, ou si le nom commence par l'un d'eux
garder() {
  [ ${#FILTRES[@]} -eq 0 ] && return 0
  for p in "${FILTRES[@]}"; do [[ $1 == $p* ]] && return 0; done
  return 1
}
FILTRES=("$@")
ECHECS=0

mkdir -p tests/sortie

echo "== beta (contrôle visuel)"
for f in tests/beta/*.typ; do
  nom=$(basename "$f" .typ)
  garder "$nom" || continue
  messages=$("$TYPST" compile --root . "$f" "tests/sortie/$nom.pdf" 2>&1)
  if echo "$messages" | grep -qi '^error'; then etat="ERREUR"; ECHECS=$((ECHECS + 1))
  elif echo "$messages" | grep -qi '^warning'; then etat="avertissement"
  else etat="ok"; fi
  printf '%-36s %s\n' "$nom" "$etat"
  if [ "$etat" != ok ]; then
    echo "$messages" | grep -iE '^(error|warning)|^ *= hint' | head -4 | sed 's/^/    /'
  fi
done

echo "== unitaires"
for f in tests/unitaires/*.typ; do
  nom=$(basename "$f" .typ)
  [ "$nom" = aide ] && continue
  garder "$nom" || continue
  debut=$(date +%s.%N)
  messages=$("$TYPST" compile --root . "$f" "tests/sortie/u-$nom.pdf" 2>&1)
  duree=$(LC_NUMERIC=C printf '%.1f' "$(echo "$(date +%s.%N) - $debut" | bc)" | tr . ,)
  if echo "$messages" | grep -qi '^error'; then
    printf '%-36s %s\n' "$nom" "ÉCHEC (${duree} s)"
    ECHECS=$((ECHECS + 1))
    echo "$messages" | grep -iE '^error|┌─' | head -2 | sed 's/^/    /'
  else
    printf '%-36s %s\n' "$nom" "ok (${duree} s)"
  fi
done

echo "== erreurs attendues"
for f in tests/erreurs/*.typ; do
  nom=$(basename "$f" .typ)
  garder "$nom" || continue
  attendu=$(head -1 "$f" | sed 's|^// attendu : ||')
  messages=$("$TYPST" compile --root . "$f" "tests/sortie/e-$nom.pdf" 2>&1)
  if ! echo "$messages" | grep -qi '^error'; then
    printf '%-36s %s\n' "$nom" "ÉCHEC : compile sans erreur"
    ECHECS=$((ECHECS + 1))
  elif echo "$messages" | grep -qF -- "$attendu"; then
    printf '%-36s %s\n' "$nom" "ok"
  else
    printf '%-36s %s\n' "$nom" "ÉCHEC : autre message"
    ECHECS=$((ECHECS + 1))
    echo "    attendu : $attendu"
    echo "$messages" | grep -i '^error' | head -1 | sed 's/^/    obtenu  : /'
  fi
done

echo
if [ $ECHECS -eq 0 ]; then echo "Tout est bon."; else echo "$ECHECS échec(s)."; fi
exit $ECHECS
