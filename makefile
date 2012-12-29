# Copyright © 2012 Martin Ueding <dev@martin-ueding.de>

# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 2 of the License, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.

# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

SHELL = /bin/bash

desktopfiles = think-dock-off.desktop think-dock-on.desktop think-rotate-flip.desktop think-rotate-left.desktop think-rotate.desktop
scripts = think-dock think-dock-hook think-resume think-resume-hook think-rotate think-startup think-startup-hook think-touch think-touchpad

all:
	make -C doc

install:
	install -d "$(DESTDIR)/usr/share/applications/"
	for desktopfile in $(desktopfiles); do \
		install -m 644 "$$desktopfile" -t "$(DESTDIR)/usr/share/applications/"; \
		done
#
	install -d "$(DESTDIR)/usr/bin/"
	for script in $(scripts); do \
		install "$$script" -t "$(DESTDIR)/usr/bin/"; \
		done
#
	install -d "$(DESTDIR)/lib/udev/rules.d/"
	install 81-thinkpad-dock.rules -t "$(DESTDIR)/lib/udev/rules.d/"
#
	install -d "$(DESTDIR)/etc/pm/sleep.d/"
	install 00_think-resume.sh -t "$(DESTDIR)/etc/pm/sleep.d/"
#
	install -d "$(DESTDIR)/etc/init.d/"
	install think-keycodes -t "$(DESTDIR)/etc/init.d/"
# FIXME What happens if we are not installing it to the actual system, but some
# other DESTDIR, like when packaging this? The package install script would
# need to run the following line then.
	if [[ -z "$(DESTDIR)" ]]; then update-rc.d think-keycodes defaults; fi

	make -C doc install

clean:
	make -C doc clean
