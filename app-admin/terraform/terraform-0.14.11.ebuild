# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A tool for building, changing, and combining infrastructure safely"
HOMEPAGE="https://www.terraform.io/"

EGO_PN="github.com/hashicorp/${PN}"
SRC_URI="https://github.com/hashicorp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://dev.gentoo.org/~williamh/dist/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD-2 BSD-4 ECL-2.0 imagemagick ISC JSON MIT MIT-with-advertising MPL-2.0 unicode"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

DOCS=( {README,CHANGELOG}.md )

src_compile() {
	ego build -o bin/terraform
}

src_install() {
	dobin bin/terraform
	einstalldocs
}

pkg_postinst() {
	elog "If you would like to install shell completions please run:"
	elog "    terraform -install-autocomplete"
}
