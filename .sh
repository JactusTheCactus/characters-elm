#!/usr/bin/env bash
set -euo pipefail
flag() {
	for f in "$@"; do
		[[ -e ".flags/$f" ]] || return 1
	done
}
if flag local; then
	tsc
	node dist/pug.js
	sass --no-source-map src/style.scss dist/style.css
	mkdir -p src/{bak,tmp}
	for i in src/*.elm; do
		i="${i#src/}"
		ELM=src/$i
		TMP=src/tmp/$i
		BAK=src/bak/$i
		echo $i
		cp $ELM $BAK
		if $(perl -0777 -pe '
			s/\n{2,}/\n/g;
			s/(?<=\b0x)0+(?=[0-9A-F]+\b)//g;
		' $ELM > $TMP) && [[ -s $TMP ]]; then
			mv $TMP $ELM
			if [[ $ELM = "src/Main.elm" ]]; then
				elm make $ELM --output=dist/elm.js
			fi
		else
			cp $BAK $ELM
			echo "RegEx Clean Error!" >&2
		fi
	done
	rm -rf src/bak
	rm -rf src/tmp
fi