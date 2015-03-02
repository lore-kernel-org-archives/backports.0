Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41876 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbbCBLkd (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 2 Mar 2015 06:40:33 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE820117
	for <backports@vger.kernel.org>; Mon,  2 Mar 2015 11:40:31 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 581A320115
	for <backports@vger.kernel.org>; Mon,  2 Mar 2015 11:40:29 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94131] New: Unable to do make menuconfig in backports-3.18.1-1
Date: Mon, 02 Mar 2015 11:40:28 +0000
Message-ID: <bug-94131-58281@https.bugzilla.kernel.org/> (sfid-20150302_124038_099503_57637BA9)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94131

            Bug ID: 94131
           Summary: Unable to do make menuconfig in backports-3.18.1-1
           Product: Backports project
           Version: unspecified
    Kernel Version: >2.6
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: m.dziczkowski@prokonto.pl
        Regression: No

After executing "make menuconfig" in backports-3.18.1-1, I get following output
(includes error messages):

user@system# make menuconfig

cc -Wl,--add-needed -lncurses  mconf.o zconf.tab.o lxdialog/checklist.o
lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o
lxdialog/yesno.o   -o mconf
mconf.o: In function `show_help':
mconf.c:(.text+0x7f7): undefined reference to `stdscr'
lxdialog/checklist.o: In function `print_arrows':
checklist.c:(.text+0x31): undefined reference to `wmove'
checklist.c:(.text+0x4e): undefined reference to `acs_map'
checklist.c:(.text+0x5a): undefined reference to `waddch'
checklist.c:(.text+0x72): undefined reference to `waddnstr'
checklist.c:(.text+0x86): undefined reference to `wmove'
checklist.c:(.text+0xb0): undefined reference to `acs_map'
checklist.c:(.text+0xbc): undefined reference to `waddch'
checklist.c:(.text+0xed): undefined reference to `acs_map'
checklist.c:(.text+0xf9): undefined reference to `waddch'
checklist.c:(.text+0xfe): undefined reference to `acs_map'
checklist.c:(.text+0x10a): undefined reference to `waddch'
checklist.c:(.text+0x10f): undefined reference to `acs_map'
checklist.c:(.text+0x11b): undefined reference to `waddch'
checklist.c:(.text+0x120): undefined reference to `acs_map'
checklist.c:(.text+0x145): undefined reference to `acs_map'
checklist.c:(.text+0x151): undefined reference to `waddch'
checklist.c:(.text+0x156): undefined reference to `acs_map'
checklist.c:(.text+0x162): undefined reference to `waddch'
checklist.c:(.text+0x167): undefined reference to `acs_map'
checklist.c:(.text+0x173): undefined reference to `waddch'
checklist.c:(.text+0x178): undefined reference to `acs_map'
checklist.c:(.text+0x184): undefined reference to `waddch'
lxdialog/checklist.o: In function `print_item':
checklist.c:(.text+0x1fe): undefined reference to `wmove'
checklist.c:(.text+0x21f): undefined reference to `waddch'
checklist.c:(.text+0x240): undefined reference to `wmove'
checklist.c:(.text+0x297): undefined reference to `wmove'
checklist.c:(.text+0x2ab): undefined reference to `waddch'
checklist.c:(.text+0x2d7): undefined reference to `waddnstr'
checklist.c:(.text+0x2f7): undefined reference to `wmove'
checklist.c:(.text+0x2ff): undefined reference to `wrefresh'
checklist.c:(.text+0x33f): undefined reference to `wprintw'
lxdialog/checklist.o: In function `print_buttons':
checklist.c:(.text+0x3f9): undefined reference to `wmove'
lxdialog/checklist.o: In function `dialog_checklist':
checklist.c:(.text+0x4b6): undefined reference to `stdscr'
checklist.c:(.text+0x50a): undefined reference to `COLS'
checklist.c:(.text+0x51e): undefined reference to `LINES'
checklist.c:(.text+0x550): undefined reference to `stdscr'
checklist.c:(.text+0x574): undefined reference to `newwin'
checklist.c:(.text+0x58a): undefined reference to `keypad'
checklist.c:(.text+0x5ef): undefined reference to `wmove'
checklist.c:(.text+0x5f9): undefined reference to `acs_map'
checklist.c:(.text+0x605): undefined reference to `waddch'
checklist.c:(.text+0x621): undefined reference to `acs_map'
checklist.c:(.text+0x630): undefined reference to `waddch'
checklist.c:(.text+0x655): undefined reference to `acs_map'
checklist.c:(.text+0x661): undefined reference to `waddch'
checklist.c:(.text+0x6e3): undefined reference to `subwin'
checklist.c:(.text+0x6f7): undefined reference to `keypad'
checklist.c:(.text+0x887): undefined reference to `wnoutrefresh'
checklist.c:(.text+0x893): undefined reference to `wnoutrefresh'
checklist.c:(.text+0x898): undefined reference to `doupdate'
checklist.c:(.text+0x8b0): undefined reference to `wgetch'
checklist.c:(.text+0x9c1): undefined reference to `delwin'
checklist.c:(.text+0x9cd): undefined reference to `delwin'
checklist.c:(.text+0x9d7): undefined reference to `stdscr'
checklist.c:(.text+0xa69): undefined reference to `wnoutrefresh'
checklist.c:(.text+0xa71): undefined reference to `wrefresh'
checklist.c:(.text+0xa8c): undefined reference to `delwin'
checklist.c:(.text+0xa98): undefined reference to `delwin'
checklist.c:(.text+0xaed): undefined reference to `scrollok'
checklist.c:(.text+0xafd): undefined reference to `wscrl'
checklist.c:(.text+0xb0d): undefined reference to `scrollok'
checklist.c:(.text+0xb68): undefined reference to `wnoutrefresh'
checklist.c:(.text+0xb70): undefined reference to `wrefresh'
checklist.c:(.text+0xbd4): undefined reference to `wrefresh'
checklist.c:(.text+0xbd9): undefined reference to `doupdate'
checklist.c:(.text+0xc71): undefined reference to `delwin'
checklist.c:(.text+0xc7d): undefined reference to `delwin'
checklist.c:(.text+0xcf5): undefined reference to `doupdate'
checklist.c:(.text+0xd5a): undefined reference to `scrollok'
checklist.c:(.text+0xd6a): undefined reference to `wscrl'
checklist.c:(.text+0xd7a): undefined reference to `scrollok'
checklist.c:(.text+0xde0): undefined reference to `wnoutrefresh'
checklist.c:(.text+0xdec): undefined reference to `wrefresh'
checklist.c:(.text+0xe0a): undefined reference to `doupdate'
checklist.c:(.text+0xe1e): undefined reference to `acs_map'
checklist.c:(.text+0xe2e): undefined reference to `waddch'
lxdialog/checklist.o: In function `print_arrows':
checklist.c:(.text+0xdc): undefined reference to `waddnstr'
checklist.c:(.text+0x134): undefined reference to `waddch'
lxdialog/checklist.o: In function `print_buttons':
checklist.c:(.text+0x409): undefined reference to `wrefresh'
lxdialog/inputbox.o: In function `print_buttons':
inputbox.c:(.text+0xa9): undefined reference to `wmove'
lxdialog/inputbox.o: In function `dialog_inputbox':
inputbox.c:(.text+0x118): undefined reference to `stdscr'
inputbox.c:(.text+0x150): undefined reference to `COLS'
inputbox.c:(.text+0x166): undefined reference to `LINES'
inputbox.c:(.text+0x1a3): undefined reference to `newwin'
inputbox.c:(.text+0x1b5): undefined reference to `keypad'
inputbox.c:(.text+0x20f): undefined reference to `wmove'
inputbox.c:(.text+0x219): undefined reference to `acs_map'
inputbox.c:(.text+0x225): undefined reference to `waddch'
inputbox.c:(.text+0x239): undefined reference to `acs_map'
inputbox.c:(.text+0x248): undefined reference to `waddch'
inputbox.c:(.text+0x261): undefined reference to `acs_map'
inputbox.c:(.text+0x26d): undefined reference to `waddch'
inputbox.c:(.text+0x323): undefined reference to `wmove'
inputbox.c:(.text+0x3b7): undefined reference to `waddch'
inputbox.c:(.text+0x3dc): undefined reference to `wmove'
inputbox.c:(.text+0x3e4): undefined reference to `wrefresh'
inputbox.c:(.text+0x400): undefined reference to `wgetch'
inputbox.c:(.text+0x454): undefined reference to `delwin'
inputbox.c:(.text+0x49a): undefined reference to `delwin'
inputbox.c:(.text+0x532): undefined reference to `wmove'
inputbox.c:(.text+0x57f): undefined reference to `waddch'
inputbox.c:(.text+0x59f): undefined reference to `wmove'
inputbox.c:(.text+0x5a7): undefined reference to `wrefresh'
inputbox.c:(.text+0x5d3): undefined reference to `delwin'
inputbox.c:(.text+0x5fc): undefined reference to `waddnstr'
inputbox.c:(.text+0x61c): undefined reference to `delwin'
inputbox.c:(.text+0x654): undefined reference to `delwin'
inputbox.c:(.text+0x65e): undefined reference to `stdscr'
inputbox.c:(.text+0x736): undefined reference to `wmove'
inputbox.c:(.text+0x787): undefined reference to `waddch'
inputbox.c:(.text+0x7ae): undefined reference to `wmove'
inputbox.c:(.text+0x7b6): undefined reference to `wrefresh'
inputbox.c:(.text+0x88f): undefined reference to `wmove'
inputbox.c:(.text+0x924): undefined reference to `wmove'
inputbox.c:(.text+0x92c): undefined reference to `wrefresh'
inputbox.c:(.text+0x951): undefined reference to `acs_map'
inputbox.c:(.text+0x961): undefined reference to `waddch'
inputbox.c:(.text+0xa15): undefined reference to `wmove'
inputbox.c:(.text+0xa72): undefined reference to `wmove'
inputbox.c:(.text+0xa7a): undefined reference to `wrefresh'
inputbox.c:(.text+0xab2): undefined reference to `wmove'
inputbox.c:(.text+0xb07): undefined reference to `waddch'
inputbox.c:(.text+0xb27): undefined reference to `wmove'
inputbox.c:(.text+0xb8e): undefined reference to `waddch'
inputbox.c:(.text+0xbad): undefined reference to `wmove'
inputbox.c:(.text+0xbd9): undefined reference to `waddch'
inputbox.c:(.text+0xbe3): undefined reference to `flash'
inputbox.c:(.text+0xc06): undefined reference to `waddch'
inputbox.c:(.text+0xc30): undefined reference to `wmove'
inputbox.c:(.text+0xc7b): undefined reference to `waddch'
inputbox.c:(.text+0xc9e): undefined reference to `wmove'
inputbox.c:(.text+0xcb7): undefined reference to `waddch'
lxdialog/inputbox.o: In function `print_buttons':
inputbox.c:(.text+0xb9): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `do_scroll':
menubox.c:(.text+0x18): undefined reference to `scrollok'
menubox.c:(.text+0x24): undefined reference to `wscrl'
menubox.c:(.text+0x34): undefined reference to `scrollok'
menubox.c:(.text+0x3e): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `do_print_item':
menubox.c:(.text+0xe0): undefined reference to `wmove'
menubox.c:(.text+0xe8): undefined reference to `wclrtoeol'
menubox.c:(.text+0x10e): undefined reference to `wmove'
menubox.c:(.text+0x127): undefined reference to `waddnstr'
menubox.c:(.text+0x15e): undefined reference to `wmove'
menubox.c:(.text+0x177): undefined reference to `waddch'
menubox.c:(.text+0x193): undefined reference to `wmove'
menubox.c:(.text+0x1c4): undefined reference to `wmove'
menubox.c:(.text+0x1d0): undefined reference to `wclrtoeol'
lxdialog/menubox.o: In function `print_buttons':
menubox.c:(.text+0x346): undefined reference to `wmove'
lxdialog/menubox.o: In function `print_arrows.constprop.0':
menubox.c:(.text+0x39e): undefined reference to `wmove'
menubox.c:(.text+0x3b3): undefined reference to `acs_map'
menubox.c:(.text+0x3bf): undefined reference to `waddch'
menubox.c:(.text+0x3d7): undefined reference to `waddnstr'
menubox.c:(.text+0x3ea): undefined reference to `wmove'
menubox.c:(.text+0x3f2): undefined reference to `wrefresh'
menubox.c:(.text+0x411): undefined reference to `acs_map'
menubox.c:(.text+0x41d): undefined reference to `waddch'
menubox.c:(.text+0x422): undefined reference to `acs_map'
menubox.c:(.text+0x42e): undefined reference to `waddch'
menubox.c:(.text+0x433): undefined reference to `acs_map'
menubox.c:(.text+0x43f): undefined reference to `waddch'
menubox.c:(.text+0x444): undefined reference to `acs_map'
menubox.c:(.text+0x450): undefined reference to `waddch'
menubox.c:(.text+0x468): undefined reference to `wmove'
menubox.c:(.text+0x48d): undefined reference to `acs_map'
menubox.c:(.text+0x499): undefined reference to `waddch'
menubox.c:(.text+0x4b1): undefined reference to `waddnstr'
menubox.c:(.text+0x4c1): undefined reference to `acs_map'
menubox.c:(.text+0x4cd): undefined reference to `waddch'
menubox.c:(.text+0x4d2): undefined reference to `acs_map'
menubox.c:(.text+0x4de): undefined reference to `waddch'
menubox.c:(.text+0x4e3): undefined reference to `acs_map'
menubox.c:(.text+0x4ef): undefined reference to `waddch'
menubox.c:(.text+0x4f4): undefined reference to `acs_map'
menubox.c:(.text+0x500): undefined reference to `waddch'
menubox.c:(.text+0x51d): undefined reference to `wmove'
lxdialog/menubox.o: In function `dialog_menu':
menubox.c:(.text+0x558): undefined reference to `stdscr'
menubox.c:(.text+0x5df): undefined reference to `COLS'
menubox.c:(.text+0x5f6): undefined reference to `LINES'
menubox.c:(.text+0x620): undefined reference to `stdscr'
menubox.c:(.text+0x644): undefined reference to `newwin'
menubox.c:(.text+0x65a): undefined reference to `keypad'
menubox.c:(.text+0x6bb): undefined reference to `wmove'
menubox.c:(.text+0x6c5): undefined reference to `acs_map'
menubox.c:(.text+0x6d1): undefined reference to `waddch'
menubox.c:(.text+0x6f1): undefined reference to `acs_map'
menubox.c:(.text+0x700): undefined reference to `waddch'
menubox.c:(.text+0x731): undefined reference to `wbkgdset'
menubox.c:(.text+0x736): undefined reference to `acs_map'
menubox.c:(.text+0x742): undefined reference to `waddch'
menubox.c:(.text+0x7c2): undefined reference to `subwin'
menubox.c:(.text+0x7d6): undefined reference to `keypad'
menubox.c:(.text+0x929): undefined reference to `wnoutrefresh'
menubox.c:(.text+0x982): undefined reference to `wmove'
menubox.c:(.text+0x98a): undefined reference to `wrefresh'
menubox.c:(.text+0x9a8): undefined reference to `wgetch'
menubox.c:(.text+0xaa8): undefined reference to `delwin'
menubox.c:(.text+0xab4): undefined reference to `delwin'
menubox.c:(.text+0xba0): undefined reference to `wnoutrefresh'
menubox.c:(.text+0xbac): undefined reference to `wrefresh'
menubox.c:(.text+0xefa): undefined reference to `delwin'
menubox.c:(.text+0xf06): undefined reference to `delwin'
menubox.c:(.text+0xf0b): undefined reference to `stdscr'
menubox.c:(.text+0xf5a): undefined reference to `scrollok'
menubox.c:(.text+0x10ef): undefined reference to `wrefresh'
menubox.c:(.text+0x112d): undefined reference to `delwin'
menubox.c:(.text+0x1139): undefined reference to `delwin'
menubox.c:(.text+0x1229): undefined reference to `wbkgdset'
menubox.c:(.text+0x122e): undefined reference to `acs_map'
menubox.c:(.text+0x123e): undefined reference to `waddch'
lxdialog/menubox.o: In function `do_print_item':
menubox.c:(.text+0x1ab): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `print_buttons':
menubox.c:(.text+0x356): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `print_arrows.constprop.0':
menubox.c:(.text+0x478): undefined reference to `wrefresh'
lxdialog/textbox.o: In function `refresh_text_box':
textbox.c:(.text+0x21c): undefined reference to `wmove'
textbox.c:(.text+0x22c): undefined reference to `waddch'
textbox.c:(.text+0x24d): undefined reference to `waddnstr'
textbox.c:(.text+0x255): undefined reference to `wclrtoeol'
textbox.c:(.text+0x284): undefined reference to `wnoutrefresh'
textbox.c:(.text+0x2ad): undefined reference to `wbkgdset'
textbox.c:(.text+0x2f0): undefined reference to `wmove'
textbox.c:(.text+0x304): undefined reference to `wprintw'
textbox.c:(.text+0x31c): undefined reference to `wmove'
textbox.c:(.text+0x346): undefined reference to `wbkgdset'
lxdialog/textbox.o: In function `dialog_textbox':
textbox.c:(.text+0x3e7): undefined reference to `stdscr'
textbox.c:(.text+0x42e): undefined reference to `COLS'
textbox.c:(.text+0x457): undefined reference to `LINES'
textbox.c:(.text+0x490): undefined reference to `newwin'
textbox.c:(.text+0x4a2): undefined reference to `keypad'
textbox.c:(.text+0x4ca): undefined reference to `subwin'
textbox.c:(.text+0x4e9): undefined reference to `wbkgdset'
textbox.c:(.text+0x4f9): undefined reference to `keypad'
textbox.c:(.text+0x55a): undefined reference to `wmove'
textbox.c:(.text+0x564): undefined reference to `acs_map'
textbox.c:(.text+0x570): undefined reference to `waddch'
textbox.c:(.text+0x581): undefined reference to `acs_map'
textbox.c:(.text+0x590): undefined reference to `waddch'
textbox.c:(.text+0x5b5): undefined reference to `wbkgdset'
textbox.c:(.text+0x5ba): undefined reference to `acs_map'
textbox.c:(.text+0x5c6): undefined reference to `waddch'
textbox.c:(.text+0x632): undefined reference to `wnoutrefresh'
textbox.c:(.text+0x68e): undefined reference to `wgetch'
textbox.c:(.text+0x6fb): undefined reference to `delwin'
textbox.c:(.text+0x703): undefined reference to `delwin'
textbox.c:(.text+0x70e): undefined reference to `stdscr'
textbox.c:(.text+0x78e): undefined reference to `delwin'
textbox.c:(.text+0x796): undefined reference to `delwin'
textbox.c:(.text+0xaae): undefined reference to `wbkgdset'
textbox.c:(.text+0xab3): undefined reference to `acs_map'
textbox.c:(.text+0xac3): undefined reference to `waddch'
textbox.c:(.text+0xb40): undefined reference to `wnoutrefresh'
lxdialog/textbox.o: In function `refresh_text_box':
textbox.c:(.text+0x32c): undefined reference to `wrefresh'
lxdialog/util.o: In function `init_one_color':
util.c:(.text+0x478): undefined reference to `init_pair'
lxdialog/util.o: In function `attr_clear':
util.c:(.text+0x4f2): undefined reference to `wmove'
util.c:(.text+0x50f): undefined reference to `waddch'
lxdialog/util.o: In function `dialog_clear':
util.c:(.text+0x56e): undefined reference to `COLS'
util.c:(.text+0x577): undefined reference to `LINES'
util.c:(.text+0x580): undefined reference to `stdscr'
util.c:(.text+0x59a): undefined reference to `stdscr'
util.c:(.text+0x5bf): undefined reference to `wmove'
util.c:(.text+0x5da): undefined reference to `stdscr'
util.c:(.text+0x5e2): undefined reference to `waddnstr'
util.c:(.text+0x5e7): undefined reference to `stdscr'
util.c:(.text+0x5ff): undefined reference to `wmove'
util.c:(.text+0x605): undefined reference to `COLS'
util.c:(.text+0x619): undefined reference to `acs_map'
util.c:(.text+0x625): undefined reference to `stdscr'
util.c:(.text+0x62d): undefined reference to `waddch'
util.c:(.text+0x632): undefined reference to `COLS'
util.c:(.text+0x63e): undefined reference to `stdscr'
util.c:(.text+0x646): undefined reference to `wnoutrefresh'
lxdialog/util.o: In function `init_dialog':
util.c:(.text+0x656): undefined reference to `initscr'
util.c:(.text+0x65b): undefined reference to `stdscr'
util.c:(.text+0x820): undefined reference to `stdscr'
util.c:(.text+0x830): undefined reference to `keypad'
util.c:(.text+0x835): undefined reference to `cbreak'
util.c:(.text+0x83a): undefined reference to `noecho'
util.c:(.text+0x856): undefined reference to `has_colors'
util.c:(.text+0x863): undefined reference to `start_color'
util.c:(.text+0xcf7): undefined reference to `has_colors'
util.c:(.text+0xd16): undefined reference to `has_colors'
util.c:(.text+0xd3d): undefined reference to `endwin'
lxdialog/util.o: In function `end_dialog':
util.c:(.text+0xd74): undefined reference to `stdscr'
util.c:(.text+0xd7c): undefined reference to `wmove'
util.c:(.text+0xd81): undefined reference to `stdscr'
util.c:(.text+0xd89): undefined reference to `wrefresh'
lxdialog/util.o: In function `print_title':
util.c:(.text+0xdf5): undefined reference to `wmove'
util.c:(.text+0xe0a): undefined reference to `waddch'
util.c:(.text+0xe1e): undefined reference to `wmove'
util.c:(.text+0xe33): undefined reference to `waddnstr'
lxdialog/util.o: In function `print_autowrap':
util.c:(.text+0xfb3): undefined reference to `wmove'
util.c:(.text+0xfc7): undefined reference to `waddnstr'
util.c:(.text+0x10ac): undefined reference to `wmove'
util.c:(.text+0x10c0): undefined reference to `waddnstr'
lxdialog/util.o: In function `print_button':
util.c:(.text+0x1105): undefined reference to `wmove'
util.c:(.text+0x1132): undefined reference to `waddnstr'
util.c:(.text+0x1187): undefined reference to `waddch'
util.c:(.text+0x11ba): undefined reference to `waddch'
util.c:(.text+0x11d6): undefined reference to `waddnstr'
util.c:(.text+0x11f6): undefined reference to `waddnstr'
util.c:(.text+0x1237): undefined reference to `waddch'
util.c:(.text+0x1253): undefined reference to `waddnstr'
util.c:(.text+0x127a): undefined reference to `waddch'
util.c:(.text+0x1292): undefined reference to `waddnstr'
lxdialog/util.o: In function `draw_box':
util.c:(.text+0x1308): undefined reference to `wmove'
util.c:(.text+0x134d): undefined reference to `waddch'
util.c:(.text+0x1376): undefined reference to `acs_map'
util.c:(.text+0x1382): undefined reference to `waddch'
util.c:(.text+0x139f): undefined reference to `acs_map'
util.c:(.text+0x13ab): undefined reference to `waddch'
util.c:(.text+0x13bf): undefined reference to `acs_map'
util.c:(.text+0x13cb): undefined reference to `waddch'
util.c:(.text+0x13de): undefined reference to `acs_map'
util.c:(.text+0x13ea): undefined reference to `waddch'
util.c:(.text+0x13f9): undefined reference to `acs_map'
util.c:(.text+0x1405): undefined reference to `waddch'
util.c:(.text+0x141f): undefined reference to `acs_map'
util.c:(.text+0x142b): undefined reference to `waddch'
util.c:(.text+0x143a): undefined reference to `acs_map'
util.c:(.text+0x1446): undefined reference to `waddch'
util.c:(.text+0x1455): undefined reference to `acs_map'
util.c:(.text+0x1461): undefined reference to `waddch'
lxdialog/util.o: In function `draw_shadow':
util.c:(.text+0x1494): undefined reference to `has_colors'
util.c:(.text+0x14c5): undefined reference to `wmove'
util.c:(.text+0x14d7): undefined reference to `winch'
util.c:(.text+0x14e6): undefined reference to `waddch'
util.c:(.text+0x150f): undefined reference to `wmove'
util.c:(.text+0x1517): undefined reference to `winch'
util.c:(.text+0x1526): undefined reference to `waddch'
util.c:(.text+0x152e): undefined reference to `winch'
util.c:(.text+0x153d): undefined reference to `waddch'
lxdialog/util.o: In function `on_key_esc':
util.c:(.text+0x1656): undefined reference to `nodelay'
util.c:(.text+0x1666): undefined reference to `keypad'
util.c:(.text+0x166e): undefined reference to `wgetch'
util.c:(.text+0x1678): undefined reference to `wgetch'
util.c:(.text+0x1684): undefined reference to `wgetch'
util.c:(.text+0x1699): undefined reference to `nodelay'
util.c:(.text+0x16a9): undefined reference to `keypad'
util.c:(.text+0x16df): undefined reference to `ungetch'
lxdialog/util.o: In function `attr_clear':
util.c:(.text+0x550): undefined reference to `wtouchln'
lxdialog/util.o: In function `end_dialog':
util.c:(.text+0xd91): undefined reference to `endwin'
lxdialog/util.o: In function `print_title':
util.c:(.text+0xe4b): undefined reference to `waddch'
lxdialog/util.o: In function `print_button':
util.c:(.text+0x121a): undefined reference to `wmove'
lxdialog/util.o: In function `draw_shadow':
util.c:(.text+0x1551): undefined reference to `wnoutrefresh'
lxdialog/yesno.o: In function `print_buttons':
yesno.c:(.text+0xac): undefined reference to `wmove'
lxdialog/yesno.o: In function `dialog_yesno':
yesno.c:(.text+0xf1): undefined reference to `stdscr'
yesno.c:(.text+0x129): undefined reference to `COLS'
yesno.c:(.text+0x13f): undefined reference to `LINES'
yesno.c:(.text+0x17c): undefined reference to `newwin'
yesno.c:(.text+0x18e): undefined reference to `keypad'
yesno.c:(.text+0x1e8): undefined reference to `wmove'
yesno.c:(.text+0x1f2): undefined reference to `acs_map'
yesno.c:(.text+0x1fe): undefined reference to `waddch'
yesno.c:(.text+0x211): undefined reference to `acs_map'
yesno.c:(.text+0x220): undefined reference to `waddch'
yesno.c:(.text+0x239): undefined reference to `acs_map'
yesno.c:(.text+0x245): undefined reference to `waddch'
yesno.c:(.text+0x2a1): undefined reference to `wgetch'
yesno.c:(.text+0x2cf): undefined reference to `delwin'
yesno.c:(.text+0x300): undefined reference to `delwin'
yesno.c:(.text+0x31e): undefined reference to `delwin'
yesno.c:(.text+0x36a): undefined reference to `wrefresh'
yesno.c:(.text+0x37b): undefined reference to `delwin'
yesno.c:(.text+0x393): undefined reference to `delwin'
yesno.c:(.text+0x39d): undefined reference to `stdscr'
yesno.c:(.text+0x3f1): undefined reference to `acs_map'
yesno.c:(.text+0x401): undefined reference to `waddch'
lxdialog/yesno.o: In function `print_buttons':
yesno.c:(.text+0xbc): undefined reference to `wrefresh'
collect2: error: ld returned 1 exit status
make[2]: *** [mconf] Error 1
make[1]: *** [menuconfig] Error 2
make: *** [menuconfig] Error 2

Please create a fixed version of it as soon as possible

-- 
You are receiving this mail because:
You are the assignee for the bug.
