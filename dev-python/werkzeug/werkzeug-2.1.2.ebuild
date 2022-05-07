# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="
	https://palletsprojects.com/p/werkzeug/
	https://pypi.org/project/Werkzeug/
	https://github.com/pallets/werkzeug/
"
SRC_URI="
	https://github.com/pallets/werkzeug/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

# NOTE: remove the loong mask after greenlet gains support for loong
# see https://github.com/python-greenlet/greenlet/pull/257
BDEPEND="
	test? (
		dev-python/ephemeral-port-reserve[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/pytest-xprocess[${PYTHON_USEDEP}]
		dev-python/watchdog[${PYTHON_USEDEP}]
		!alpha? ( !hppa? ( !ia64? (
			dev-python/cryptography[${PYTHON_USEDEP}]
		) ) )
		!hppa? ( !ia64? ( !loong? (
			$(python_gen_cond_dep '
				dev-python/greenlet[${PYTHON_USEDEP}]
			' 'python*')
		) ) )
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()
	if ! has_version "dev-python/cryptography[${PYTHON_USEDEP}]"; then
		EPYTEST_DESELECT+=(
			"tests/test_serving.py::test_server[https]"
			tests/test_serving.py::test_ssl_dev_cert
			tests/test_serving.py::test_ssl_object
		)
	fi

	# the default portage tempdir is too long for AF_UNIX sockets
	local -x TMPDIR=/tmp
	epytest -p no:django -p no:httpbin tests
}