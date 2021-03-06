# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Logging integration for Click"
HOMEPAGE="
	https://github.com/click-contrib/click-log/
	https://pypi.org/project/click-log/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"
BDEPEND="${RDEPEND}"

DOCS=( README.rst )

distutils_enable_tests pytest
