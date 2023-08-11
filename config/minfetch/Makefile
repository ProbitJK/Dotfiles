CC=cc
CFLAGS=-Wall -Wextra -Wpedantic -std=c99 -ggdb -O3
INSTALLDIR=~/.local/bin
BINARY=minfetch

all: $(BINARY)

install: $(BINARY)
	install -D $< $(INSTALLDIR)

$(BINARY): $(BINARY).c
	$(CC) $(CFLAGS) $< -o $@

clean: $(BINARY)
	rm $(BINARY)

uninstall:
	rm $(INSTALLDIR)/$(BINARY)
