#!/usr/bin/make
# An install-only makefile to allow easy running of checkinstall.

PACKAGE = sway-config
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datarootdir = $(prefix)/share
docdir = $(datarootdir)/doc/$(PACKAGE)
DESTDIR = /
pwd = $(shell pwd)

executables = bin/sway-prelock \
              bin/sway-unlock

docfiles = $(wildcard *.md)

help:
	@echo "An install-only makefile to allow easy running of checkinstall:"
	@echo
	@echo "   $$ sudo make checkinstall"
	@echo
	@echo "Installs the following executables:"
	@echo
	@echo -n "   "; echo $(executables) | sed 's# \+#\n   #g'
	@echo
	@echo "You will have to manually symlink the config file into ~/.config/sway/"

install:
	@install -d $(DESTDIR)$(bindir)
	@install -d $(DESTDIR)$(docdir)
	@install -v -m775 $(executables) $(DESTDIR)$(bindir)
	@install -v -m664 $(docfiles) $(DESTDIR)$(docdir)

checkinstall:
	checkinstall --pkgname=$(PACKAGE) --nodoc
	@echo
	@echo "Now you should symlink the config file into your home directory:"
	@echo
	@echo "   $$ mkdir -p ~/.config/sway"
	@echo "   $$ ln -s $(pwd)/config ~/.config/sway"
	@echo "   $$ ls -l ~/.config/sway"

