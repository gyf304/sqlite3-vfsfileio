EXT = .so
CFLAGS ?= -Os -Wall -Wextra -Werror -Wpedantic -Wconversion

ifeq ($(OS),Windows_NT)
	EXT = .dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		EXT = .dylib
	endif
endif

.PHONY: all clean test

all: vfsfileio$(EXT)

clean:
	rm -f vfsfileio$(EXT)
	rm -rf vfsfileio$(EXT).dSYM
	rm -f test.sql.*

vfsfileio$(EXT): vfsfileio.c
	$(CC) $(CFLAGS) -shared -fPIC -o $@ $<

test.sql.expected: test.sql
	sed -rn 's/.*-- expected: (.*)$$/\1/p' $< > $@

test.sql.output: vfsfileio$(EXT) test.sql
	sqlite3 :memory: ".load ./vfsfileio$(EXT)" ".read test.sql" .exit > $@

test: test.sql.expected test.sql.output
	diff -u test.sql.expected test.sql.output
