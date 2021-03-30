
FILES = src/main.nim
CACHE = .cache

default: development

development: ${FILES}
	nim --debugInfo --assertions:on --linedir:on --define:debug --nimcache:${CACHE} c ${FILES}
	@mv src/main ./build/

autobuild:
	# find . -depth 1 -name \*.nim | entr -cp make
	echo ${FILES} | entr -c make

debugger: ${FILES}
	nim --debugger:on --nimcache:${CACHE} c ${FILES}

release: ${FILES}
	nim -d:release --opt:speed --nimcache:${CACHE} c ${FILES}
	@mv src/main ./build/

docs:
	nim doc ${FILES}
	#nim buildIndex ${FILES}

clean:
	cat .hgignore | xargs rm -rf

