# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=LEONT
DIST_VERSION=0.004

inherit perl-module

DESCRIPTION="Thread specific signal masks"

SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="
	>=virtual/perl-Exporter-5.570.0
	virtual/perl-XSLoader
"
BDEPEND="${RDEPEND}
	>=dev-perl/Module-Build-0.360.100
	test? (
		virtual/perl-File-Spec
		virtual/perl-IO
		virtual/perl-Test-Simple
	)
"

src_test() {
	perl_rm_files "t/release-pod-syntax.t" "t/release-pod-coverage.t"
	perl-module_src_test
}
