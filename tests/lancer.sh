#!/bin/bash
# Beta-tests : compile chaque fichier de tests/beta/ et résume erreurs et
# avertissements. Les PDF vont dans tests/sortie/ (ignorés par git).
#
#   tests/lancer.sh            → tous les tests
#   tests/lancer.sh 06 41      → seulement les tests dont le nom commence ainsi

cd "$(dirname "$0")/.."

# Compilateur : `typst` s'il est installé, sinon celui de l'extension Tinymist de VSCodium.
if command -v typst > /dev/null; then
  TYPST=typst
else
  TYPST=$(ls -d ~/.var/app/com.vscodium.codium/data/codium/extensions/myriad-dreamin.tinymist-*/out/tinymist | tail -1)
  export TYPST_PACKAGE_CACHE_PATH=~/.var/app/com.vscodium.codium/cache/typst/packages
fi

mkdir -p tests/sortie
for f in tests/beta/*.typ; do
  nom=$(basename "$f" .typ)
  if [ $# -gt 0 ]; then
    garder=0
    for p in "$@"; do [[ $nom == $p* ]] && garder=1; done
    [ $garder = 1 ] || continue
  fi
  messages=$("$TYPST" compile --root . "$f" "tests/sortie/$nom.pdf" 2>&1)
  if echo "$messages" | grep -qi '^error'; then etat="ERREUR"
  elif echo "$messages" | grep -qi '^warning'; then etat="avertissement"
  else etat="ok"; fi
  printf '%-36s %s\n' "$nom" "$etat"
  if [ "$etat" != ok ]; then
    echo "$messages" | grep -iE '^(error|warning)|^ *= hint' | head -4 | sed 's/^/    /'
  fi
done
