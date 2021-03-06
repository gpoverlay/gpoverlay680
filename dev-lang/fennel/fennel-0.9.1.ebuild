# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1,3,4} luajit )

inherit lua-single

DESCRIPTION="Lisp-like language that compiles to Lua"
HOMEPAGE="https://fennel-lang.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~technomancy/fennel"
else
	SRC_URI="https://git.sr.ht/~technomancy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"

src_install() {
	emake LUA_LIB_DIR="${ED}/$(lua_get_lmod_dir)" PREFIX="${ED}/usr" install
	doman ${PN}.1
	dodoc *.md
}
