# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..10} )
PYTHON_REQ_USE="xml(+)"
VALA_USE_DEPEND="vapigen"

inherit meson python-any-r1 systemd vala xdg

DESCRIPTION="A location information D-Bus service"
HOMEPAGE="https://gitlab.freedesktop.org/geoclue/geoclue/wikis/home"
SRC_URI="https://gitlab.freedesktop.org/geoclue/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1+ GPL-2+"
SLOT="2.0"
KEYWORDS="~alpha amd64 arm arm64 ~ia64 ~mips ppc ppc64 ~riscv ~sparc x86"
IUSE="+introspection gtk-doc modemmanager vala zeroconf"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	>=dev-libs/glib-2.44:2
	>=dev-libs/json-glib-0.14.0
	>=net-libs/libsoup-2.42.0:2.4
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
	modemmanager? ( >=net-misc/modemmanager-1.6 )
	zeroconf? ( >=net-dns/avahi-0.6.10[dbus] )
	x11-libs/libnotify
"
RDEPEND="${DEPEND}
	acct-user/geoclue
	sys-apps/dbus
"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/gdbus-codegen
	dev-util/glib-utils
	gtk-doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1 )
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	vala? ( $(vala_depend) )
"

PATCHES=(
	"${FILESDIR}"/2.5.3-optional-vapi.patch
)

src_prepare() {
	xdg_src_prepare
	use vala && vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dlibgeoclue=true
		$(meson_use introspection)
		$(meson_use vala vapi)
		$(meson_use gtk-doc)
		$(meson_use modemmanager 3g-source)
		$(meson_use modemmanager cdma-source)
		$(meson_use modemmanager modem-gps-source)
		$(meson_use zeroconf nmea-source)
		-Denable-backend=true
		-Ddemo-agent=true
		-Dsystemd-system-unit-dir="$(systemd_get_systemunitdir)"
		-Ddbus-srv-user=geoclue
	)
	meson_src_configure
}
