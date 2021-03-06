# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="A pluggable API specification generator"
HOMEPAGE="https://github.com/marshmallow-code/apispec/"
SRC_URI="
	https://github.com/marshmallow-code/apispec/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}
	test? (
		dev-python/bottle[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		>=dev-python/marshmallow-3.13.0[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/sphinx-issues \
	dev-python/sphinx_rtd_theme

EPYTEST_DESELECT=(
	# requires unpackaged prance
	tests/test_ext_marshmallow_openapi.py::test_openapi_tools_validate_v2
	tests/test_ext_marshmallow_openapi.py::test_openapi_tools_validate_v3
)
