# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic toolchain-funcs

DESCRIPTION="Discover DHCP and BootP servers on a directly-attached Ethernet network"
HOMEPAGE="https://www.net.princeton.edu/software/dhcp_probe/"
SRC_URI="https://www.net.princeton.edu/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.2.1-r2"
RDEPEND="${DEPEND}"

DOCS=(
	AUTHORS
	ChangeLog
	NEWS
	README
	TODO
	extras/dhcp_probe.cf.sample
)

PATCHES=(
	"${FILESDIR}"/${PN}-1.3.1-respect-AR.patch
	"${FILESDIR}"/${PN}-1.3.1-fix-configure-CPP.patch
)

src_prepare() {
	default

	# for AR patch
	eautoreconf
}

src_configure() {
	# configure uses CPP
	tc-export CPP

	use amd64 && append-cppflags -D__ARCH__=64

	STRIP=true econf
}

src_install() {
	default

	dodoc "${FILESDIR}"/${PN}_mail

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
