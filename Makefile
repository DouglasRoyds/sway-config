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

executables = bin/i3status-append \
              bin/sway-prelock \
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
	@echo "You will have to manually symlink the config files into ~/.config/sway/"

install:
	@install -d $(DESTDIR)$(bindir)
	@install -d $(DESTDIR)$(docdir)
	@install -v -m775 $(executables) $(DESTDIR)$(bindir)
	@install -v -m664 $(docfiles) $(DESTDIR)$(docdir)

checkinstall:
	checkinstall --pkgname=$(PACKAGE) --nodoc
	@echo
	@echo "Now you should symlink the config files into your home directory:"
	@echo
	@echo "   $$ ln -s $(pwd)/sway ~/.config"
	@echo "   $$ ln -s $(pwd)/i3status ~/.config"
	@echo "   $$ ln -s ~/my/preferred/wallpaper.jpg sway/wallpaper"
	@echo "   $$ ls -l ~/.config/sway ~/.config/i3status"

