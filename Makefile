ELMFLAGS =

out/js/%.js: src/%.elm
	mkdir -p out/js
	elm make $< ${ELMFLAGS} --output=$@

default: out/js/Main.js
	mkdir -p out
	cp index.html out/

clean:
	rm -rf out

release:
	make ELMFLAGS="--optimize"

srv: default
	cd out;python -m http.server
