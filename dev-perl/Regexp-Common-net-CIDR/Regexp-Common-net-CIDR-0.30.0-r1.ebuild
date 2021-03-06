# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=BPS
DIST_VERSION=0.03
inherit perl-module

DESCRIPTION="Provides patterns for CIDR blocks"

SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="
	dev-perl/Regexp-Common
"
BDEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.590.0
	test? ( virtual/perl-Test-Simple )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.03-no-dot-inc.patch"
	"${FILESDIR}/${PN}-0.03-basic-tests.patch"
)
