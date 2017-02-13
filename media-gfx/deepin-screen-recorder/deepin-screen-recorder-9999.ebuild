# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils eutils

DESCRIPTION="Deepin Screencasting Application"
HOMEPAGE="https://github.com/manateelazycat/deepin-screen-recorder/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/manateelazycat/${PN}.git"
else
	SRC_URI="https://github.com/manateelazycat/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gif +mp4"

RDEPEND="dev-qt/qtwidgets:5
		dev-qt/qtnetwork:5
		dev-qt/qtgui:5
		dev-qt/qtdbus:5
		dev-qt/qtx11extras:5
		gif? ( media-gfx/byzanz )
		mp4? ( virtual/ffmpeg )
		"

DEPEND="${RDEPEND}
		x11-libs/xcb-util
		x11-libs/libxcb
	    "

src_prepare() {
#	sed -i "s|qApp->applicationDirPath()|\"/usr/share/${PN}\"|g" main_window.cpp
#	sed -i "s|qApp->applicationDirPath()|\"/usr/share/${PN}\"|g" record_process.cpp
	sed -i "s|qApp->applicationDirPath()|\"/usr/share/${PN}/image\"|g" src/utils.cpp
	eqmake5 src/${PN}.pro
}

src_install() {
#	emake INSTALL_ROOT=${D} install
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r image

	doicon image/${PN}.png image/${PN}.svg

	insinto /usr/share/applications
	doins ${PN}.desktop
}
