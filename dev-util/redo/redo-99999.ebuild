# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_8 )
PYTHON_REQ_USE="sqlite"
inherit git-r3 multiprocessing python-utils-r1 python-single-r1

DESCRIPTION="Smaller, easier, more powerful, and more reliable than make"
HOMEPAGE="https://github.com/apenwarr/redo"
EGIT_REPO_URI="https://github.com/apenwarr/redo"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	$(python_gen_cond_dep '
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
	')
	${PYTHON_DEPS}
"
RDEPEND="
	${BDEPEND}
"

src_configure() {
	echo ${PYTHON} > redo/whichpython || die
}

src_compile() {
	./do -j$(makeopts_jobs) build || die
}

src_test() {
	local ARCH= CFLAGS= CXXFLAGS= LDFLAGS=
	./do -j$(makeopts_jobs) test || die
}

src_install() {
	DESTDIR="${D}" \
	DOCDIR="${D}/usr/share/doc/${PF}" \
	LIBDIR="${D}/$(python_get_sitedir)/${PN}" \
	./do -j$(makeopts_jobs) \
		install || die

	python_fix_shebang "${D}"

	sed -i \
		-e 's|/lib/|/'"$(get_libdir)"'/|g' \
		"${D}"/usr/bin/* || die

	python_optimize
}
