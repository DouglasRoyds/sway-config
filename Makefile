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

executables = bin/current_temperature \
              bin/current_temperature_from_northcott \
              bin/i3status-append \
              bin/sway-prelock \
              bin/sway-session \
              bin/sway-unlock

docfiles = $(wildcard *.md)

wayland_sessiondir = /usr/share/wayland-sessions
wayland_session = wayland-sessions/sway-douglas.desktop

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
	@install -d $(DESTDIR)$(wayland_sessiondir)
	@install -v -m775 $(executables) $(DESTDIR)$(bindir)
	@install -v -m664 $(docfiles) $(DESTDIR)$(docdir)
	@install -v -m644 $(wayland_session) $(DESTDIR)$(wayland_sessiondir)

checkinstall:
	checkinstall --pkgname=$(PACKAGE) --nodoc
	@echo
	@echo "Now you should symlink the config files into your home directory:"
	@echo
	@echo "   $$ ln -s $(pwd)/sway ~/.config"
	@echo "   $$ ln -s $(pwd)/i3status ~/.config"
	@echo "   $$ ln -s ~/my/preferred/wallpaper.jpg sway/wallpaper"
	@echo "   $$ ls -l ~/.config/sway ~/.config/i3status"
	@echo
	@echo "Add the current temperature script to the crontab:"
	@echo
	@echo "   $$ crontab -e"
	@echo "   */15 * * * * /usr/local/bin/current_temperature_from_northcott > ~/.current_temperature"


