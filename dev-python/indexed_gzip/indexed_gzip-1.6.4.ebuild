# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Fast random access of gzip files in Python"
HOMEPAGE="https://github.com/pauldmccarthy/indexed_gzip"
SRC_URI="https://github.com/pauldmccarthy/indexed_gzip/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sys-libs/zlib:="
DEPEND=${RDEPEND}
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
	)
	"

distutils_enable_tests pytest

src_prepare() {
	sed -i -e 's:--cov=indexed_gzip::' setup.cfg || die
	distutils-r1_src_prepare
}

src_compile() {
	if use test; then
		export INDEXED_GZIP_TESTING=1
	fi
	distutils-r1_src_compile
}

python_test() {
	cd "${BUILD_DIR}"/lib/indexed_gzip/tests || die
	epytest
}
