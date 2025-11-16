#!/usr/bin/env bash
set -euo pipefail
flag() {
	for f in "$@"; do
		[[ -e ".flags/$f" ]] || return 1
	done
}
tsc
node dist/pug.js
sass --no-source-map src/style.scss dist/style.css
for ELM in src/*.elm; do
	TMP=$(mktemp)
	BAK="$ELM.bak"
	cp "$ELM" "$BAK"
	if perl -0777 -pe '
		s/\n{2,}/\n/g;
		s/(?<=\b0x)0+(?=[0-9A-F]+\b)//g;
	' "$ELM" > "$TMP" && [[ -s "$TMP" ]]; then
		mv "$TMP" "$ELM"
		rm "$BAK"
	else
		mv "$BAK" "$ELM"
		echo "RegEx Clean Error!" >&2
	fi
done
elm make src/Main.elm \
	--optimize \
	--output=dist/elm.js
./elm.sh