# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for utilities for the GNOME desktop"
HOMEPAGE="https://wiki.gnome.org/Apps/Attic/GnomeUtils"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"

RDEPEND="
	>=app-admin/gnome-system-log-${PV}
	>=app-dicts/gnome-dictionary-${PV}
	>=gnome-extra/gnome-search-tool-3.6.0
	>=media-gfx/gnome-font-viewer-${PV}
	>=media-gfx/gnome-screenshot-${PV}
	>=sys-apps/baobab-${PV}
"
