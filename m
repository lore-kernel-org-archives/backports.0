Return-path: <backports-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46483 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbaJ1RKu convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Oct 2014 13:10:50 -0400
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez (mcgrof@do-not-panic.com)"
	<mcgrof@do-not-panic.com>
Subject: failure to build backports on ubuntu
Date: Tue, 28 Oct 2014 17:08:31 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB31B55873E@hasmsx107.ger.corp.intel.com> (sfid-20141028_181107_674682_FAB04133)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

Since 

commit de427857852e7194b9ae80571425ba0d2c29ef55
Author: Luis R. Rodriguez <mcgrof@suse.com>
Date:   Sun Sep 14 06:05:29 2014 -0700

    backports: fix mconf compilation library assumptions

I can't make menuconfig. Reverting this patch fixes it.

Full error is here:

$ make menuconfig
Generating local configuration database from kernel ... done.
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o mconf.o mconf.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o zconf.tab.o zconf.tab.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/checklist.o lxdialog/checklist.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/inputbox.o lxdialog/inputbox.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/menubox.o lxdialog/menubox.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/textbox.o lxdialog/textbox.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/util.o lxdialog/util.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/yesno.o lxdialog/yesno.c
cc -Wl,--add-needed -lncurses  mconf.o zconf.tab.o lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o   -o mconf
mconf.o: In function `show_help':
mconf.c:(.text+0x744): undefined reference to `stdscr'
lxdialog/checklist.o: In function `print_arrows':
checklist.c:(.text+0x2c): undefined reference to `wmove'
checklist.c:(.text+0x4c): undefined reference to `acs_map'
checklist.c:(.text+0x54): undefined reference to `waddch'
checklist.c:(.text+0x66): undefined reference to `waddnstr'
checklist.c:(.text+0x76): undefined reference to `wmove'
checklist.c:(.text+0xa0): undefined reference to `acs_map'
checklist.c:(.text+0xa8): undefined reference to `waddch'
checklist.c:(.text+0xe3): undefined reference to `acs_map'
checklist.c:(.text+0xeb): undefined reference to `waddch'
checklist.c:(.text+0xf2): undefined reference to `acs_map'
checklist.c:(.text+0xfa): undefined reference to `waddch'
checklist.c:(.text+0x101): undefined reference to `acs_map'
checklist.c:(.text+0x109): undefined reference to `waddch'
checklist.c:(.text+0x110): undefined reference to `acs_map'
checklist.c:(.text+0x143): undefined reference to `acs_map'
checklist.c:(.text+0x14b): undefined reference to `waddch'
checklist.c:(.text+0x152): undefined reference to `acs_map'
checklist.c:(.text+0x15a): undefined reference to `waddch'
checklist.c:(.text+0x161): undefined reference to `acs_map'
checklist.c:(.text+0x169): undefined reference to `waddch'
checklist.c:(.text+0x170): undefined reference to `acs_map'
checklist.c:(.text+0x178): undefined reference to `waddch'
lxdialog/checklist.o: In function `print_item':
checklist.c:(.text+0x1fd): undefined reference to `wmove'
checklist.c:(.text+0x21c): undefined reference to `waddch'
checklist.c:(.text+0x235): undefined reference to `wmove'
checklist.c:(.text+0x28e): undefined reference to `wmove'
checklist.c:(.text+0x2a0): undefined reference to `waddch'
checklist.c:(.text+0x2cd): undefined reference to `waddnstr'
checklist.c:(.text+0x2e6): undefined reference to `wmove'
checklist.c:(.text+0x2ee): undefined reference to `wrefresh'
checklist.c:(.text+0x328): undefined reference to `wprintw'
lxdialog/checklist.o: In function `print_buttons':
checklist.c:(.text+0x3cb): undefined reference to `wmove'
lxdialog/checklist.o: In function `dialog_checklist':
checklist.c:(.text+0x4cf): undefined reference to `stdscr'
checklist.c:(.text+0x52a): undefined reference to `COLS'
checklist.c:(.text+0x536): undefined reference to `stdscr'
checklist.c:(.text+0x54c): undefined reference to `LINES'
checklist.c:(.text+0x572): undefined reference to `newwin'
checklist.c:(.text+0x587): undefined reference to `keypad'
checklist.c:(.text+0x5ce): undefined reference to `wmove'
checklist.c:(.text+0x5da): undefined reference to `acs_map'
checklist.c:(.text+0x5e2): undefined reference to `waddch'
checklist.c:(.text+0x603): undefined reference to `acs_map'
checklist.c:(.text+0x60f): undefined reference to `waddch'
checklist.c:(.text+0x637): undefined reference to `acs_map'
checklist.c:(.text+0x63f): undefined reference to `waddch'
checklist.c:(.text+0x6a5): undefined reference to `subwin'
checklist.c:(.text+0x6b7): undefined reference to `keypad'
checklist.c:(.text+0x84d): undefined reference to `wnoutrefresh'
checklist.c:(.text+0x857): undefined reference to `wnoutrefresh'
checklist.c:(.text+0x85c): undefined reference to `doupdate'
checklist.c:(.text+0x876): undefined reference to `wgetch'
checklist.c:(.text+0x99d): undefined reference to `delwin'
checklist.c:(.text+0x9a7): undefined reference to `delwin'
checklist.c:(.text+0xa30): undefined reference to `wnoutrefresh'
checklist.c:(.text+0xa38): undefined reference to `wrefresh'
checklist.c:(.text+0xa51): undefined reference to `delwin'
checklist.c:(.text+0xa5b): undefined reference to `delwin'
checklist.c:(.text+0xab2): undefined reference to `scrollok'
checklist.c:(.text+0xabf): undefined reference to `wscrl'
checklist.c:(.text+0xac9): undefined reference to `scrollok'
checklist.c:(.text+0xb22): undefined reference to `wnoutrefresh'
checklist.c:(.text+0xb2a): undefined reference to `wrefresh'
checklist.c:(.text+0xb8b): undefined reference to `wrefresh'
checklist.c:(.text+0xb90): undefined reference to `doupdate'
checklist.c:(.text+0xc06): undefined reference to `delwin'
checklist.c:(.text+0xc10): undefined reference to `delwin'
checklist.c:(.text+0xcc2): undefined reference to `doupdate'
checklist.c:(.text+0xd22): undefined reference to `scrollok'
checklist.c:(.text+0xd2f): undefined reference to `wscrl'
checklist.c:(.text+0xd39): undefined reference to `scrollok'
checklist.c:(.text+0xda2): undefined reference to `wnoutrefresh'
checklist.c:(.text+0xdaa): undefined reference to `wrefresh'
checklist.c:(.text+0xdc6): undefined reference to `doupdate'
checklist.c:(.text+0xdd2): undefined reference to `acs_map'
checklist.c:(.text+0xdd9): undefined reference to `waddch'
lxdialog/checklist.o: In function `print_arrows':
checklist.c:(.text+0xc8): undefined reference to `waddnstr'
checklist.c:(.text+0x126): undefined reference to `waddch'
lxdialog/checklist.o: In function `print_buttons':
checklist.c:(.text+0x3dd): undefined reference to `wrefresh'
lxdialog/inputbox.o: In function `print_buttons':
inputbox.c:(.text+0x8b): undefined reference to `wmove'
lxdialog/inputbox.o: In function `dialog_inputbox':
inputbox.c:(.text+0x114): undefined reference to `stdscr'
inputbox.c:(.text+0x150): undefined reference to `COLS'
inputbox.c:(.text+0x166): undefined reference to `LINES'
inputbox.c:(.text+0x18c): undefined reference to `newwin'
inputbox.c:(.text+0x19c): undefined reference to `keypad'
inputbox.c:(.text+0x1df): undefined reference to `wmove'
inputbox.c:(.text+0x1eb): undefined reference to `acs_map'
inputbox.c:(.text+0x1f3): undefined reference to `waddch'
inputbox.c:(.text+0x20b): undefined reference to `acs_map'
inputbox.c:(.text+0x216): undefined reference to `waddch'
inputbox.c:(.text+0x238): undefined reference to `acs_map'
inputbox.c:(.text+0x23d): undefined reference to `waddch'
inputbox.c:(.text+0x2d1): undefined reference to `wmove'
inputbox.c:(.text+0x35c): undefined reference to `waddch'
inputbox.c:(.text+0x370): undefined reference to `wmove'
inputbox.c:(.text+0x378): undefined reference to `wrefresh'
inputbox.c:(.text+0x3a2): undefined reference to `wgetch'
inputbox.c:(.text+0x404): undefined reference to `delwin'
inputbox.c:(.text+0x44f): undefined reference to `delwin'
inputbox.c:(.text+0x4f0): undefined reference to `wmove'
inputbox.c:(.text+0x536): undefined reference to `waddch'
inputbox.c:(.text+0x54b): undefined reference to `wmove'
inputbox.c:(.text+0x553): undefined reference to `wrefresh'
inputbox.c:(.text+0x584): undefined reference to `delwin'
inputbox.c:(.text+0x5ae): undefined reference to `waddnstr'
inputbox.c:(.text+0x5c4): undefined reference to `delwin'
inputbox.c:(.text+0x606): undefined reference to `delwin'
inputbox.c:(.text+0x6f3): undefined reference to `wmove'
inputbox.c:(.text+0x746): undefined reference to `waddch'
inputbox.c:(.text+0x75e): undefined reference to `wmove'
inputbox.c:(.text+0x766): undefined reference to `wrefresh'
inputbox.c:(.text+0x835): undefined reference to `wmove'
inputbox.c:(.text+0x8ac): undefined reference to `wmove'
inputbox.c:(.text+0x8b4): undefined reference to `wrefresh'
inputbox.c:(.text+0x8cb): undefined reference to `acs_map'
inputbox.c:(.text+0x8d2): undefined reference to `waddch'
inputbox.c:(.text+0x94b): undefined reference to `wmove'
inputbox.c:(.text+0x977): undefined reference to `wmove'
inputbox.c:(.text+0x97f): undefined reference to `wrefresh'
inputbox.c:(.text+0x9c8): undefined reference to `wmove'
inputbox.c:(.text+0xa11): undefined reference to `waddch'
inputbox.c:(.text+0xa27): undefined reference to `wmove'
inputbox.c:(.text+0xa99): undefined reference to `waddch'
inputbox.c:(.text+0xab2): undefined reference to `wmove'
inputbox.c:(.text+0xad9): undefined reference to `waddch'
inputbox.c:(.text+0xae3): undefined reference to `flash'
inputbox.c:(.text+0xaf5): undefined reference to `waddch'
inputbox.c:(.text+0xb1a): undefined reference to `wmove'
inputbox.c:(.text+0xb5d): undefined reference to `waddch'
inputbox.c:(.text+0xb71): undefined reference to `wmove'
inputbox.c:(.text+0xb83): undefined reference to `waddch'
lxdialog/inputbox.o: In function `print_buttons':
inputbox.c:(.text+0x9d): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `do_scroll':
menubox.c:(.text+0x12): undefined reference to `scrollok'
menubox.c:(.text+0x1c): undefined reference to `wscrl'
menubox.c:(.text+0x26): undefined reference to `scrollok'
lxdialog/menubox.o: In function `do_print_item':
menubox.c:(.text+0xc2): undefined reference to `wmove'
menubox.c:(.text+0xca): undefined reference to `wclrtoeol'
menubox.c:(.text+0xf1): undefined reference to `wmove'
menubox.c:(.text+0x106): undefined reference to `waddnstr'
menubox.c:(.text+0x13a): undefined reference to `wmove'
menubox.c:(.text+0x14d): undefined reference to `waddch'
menubox.c:(.text+0x166): undefined reference to `wmove'
menubox.c:(.text+0x198): undefined reference to `wmove'
menubox.c:(.text+0x19f): undefined reference to `wclrtoeol'
lxdialog/menubox.o: In function `print_buttons':
menubox.c:(.text+0x2bc): undefined reference to `wmove'
lxdialog/menubox.o: In function `print_arrows.constprop.0':
menubox.c:(.text+0x31a): undefined reference to `wmove'
menubox.c:(.text+0x335): undefined reference to `acs_map'
menubox.c:(.text+0x33d): undefined reference to `waddch'
menubox.c:(.text+0x34f): undefined reference to `waddnstr'
menubox.c:(.text+0x35d): undefined reference to `wmove'
menubox.c:(.text+0x365): undefined reference to `wrefresh'
menubox.c:(.text+0x389): undefined reference to `acs_map'
menubox.c:(.text+0x391): undefined reference to `waddch'
menubox.c:(.text+0x398): undefined reference to `acs_map'
menubox.c:(.text+0x3a0): undefined reference to `waddch'
menubox.c:(.text+0x3a7): undefined reference to `acs_map'
menubox.c:(.text+0x3af): undefined reference to `waddch'
menubox.c:(.text+0x3b6): undefined reference to `acs_map'
menubox.c:(.text+0x3be): undefined reference to `waddch'
menubox.c:(.text+0x3cd): undefined reference to `wmove'
menubox.c:(.text+0x403): undefined reference to `acs_map'
menubox.c:(.text+0x40b): undefined reference to `waddch'
menubox.c:(.text+0x41d): undefined reference to `waddnstr'
menubox.c:(.text+0x436): undefined reference to `acs_map'
menubox.c:(.text+0x43e): undefined reference to `waddch'
menubox.c:(.text+0x445): undefined reference to `acs_map'
menubox.c:(.text+0x44d): undefined reference to `waddch'
menubox.c:(.text+0x454): undefined reference to `acs_map'
menubox.c:(.text+0x45c): undefined reference to `waddch'
menubox.c:(.text+0x463): undefined reference to `acs_map'
menubox.c:(.text+0x46b): undefined reference to `waddch'
menubox.c:(.text+0x47e): undefined reference to `wmove'
lxdialog/menubox.o: In function `dialog_menu':
menubox.c:(.text+0x4b1): undefined reference to `stdscr'
menubox.c:(.text+0x54a): undefined reference to `COLS'
menubox.c:(.text+0x555): undefined reference to `stdscr'
menubox.c:(.text+0x56d): undefined reference to `LINES'
menubox.c:(.text+0x59f): undefined reference to `newwin'
menubox.c:(.text+0x5b4): undefined reference to `keypad'
menubox.c:(.text+0x5ff): undefined reference to `wmove'
menubox.c:(.text+0x60b): undefined reference to `acs_map'
menubox.c:(.text+0x613): undefined reference to `waddch'
menubox.c:(.text+0x63b): undefined reference to `acs_map'
menubox.c:(.text+0x646): undefined reference to `waddch'
menubox.c:(.text+0x678): undefined reference to `wbkgdset'
menubox.c:(.text+0x67f): undefined reference to `acs_map'
menubox.c:(.text+0x687): undefined reference to `waddch'
menubox.c:(.text+0x6e4): undefined reference to `subwin'
menubox.c:(.text+0x6f4): undefined reference to `keypad'
menubox.c:(.text+0x847): undefined reference to `wnoutrefresh'
menubox.c:(.text+0x899): undefined reference to `wmove'
menubox.c:(.text+0x8a1): undefined reference to `wrefresh'
menubox.c:(.text+0x8bc): undefined reference to `wgetch'
menubox.c:(.text+0x9c4): undefined reference to `delwin'
menubox.c:(.text+0x9ce): undefined reference to `delwin'
menubox.c:(.text+0xac8): undefined reference to `wnoutrefresh'
menubox.c:(.text+0xad0): undefined reference to `wrefresh'
menubox.c:(.text+0xe1a): undefined reference to `delwin'
menubox.c:(.text+0xe24): undefined reference to `delwin'
menubox.c:(.text+0xe2b): undefined reference to `stdscr'
menubox.c:(.text+0xe7b): undefined reference to `scrollok'
menubox.c:(.text+0xff5): undefined reference to `wrefresh'
menubox.c:(.text+0x102f): undefined reference to `delwin'
menubox.c:(.text+0x1039): undefined reference to `delwin'
menubox.c:(.text+0x1137): undefined reference to `wbkgdset'
menubox.c:(.text+0x113e): undefined reference to `acs_map'
menubox.c:(.text+0x1145): undefined reference to `waddch'
lxdialog/menubox.o: In function `do_scroll':
menubox.c:(.text+0x36): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `do_print_item':
menubox.c:(.text+0x184): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `print_buttons':
menubox.c:(.text+0x2ce): undefined reference to `wrefresh'
lxdialog/menubox.o: In function `print_arrows.constprop.0':
menubox.c:(.text+0x3e3): undefined reference to `wrefresh'
lxdialog/textbox.o: In function `refresh_text_box':
textbox.c:(.text+0x219): undefined reference to `wmove'
textbox.c:(.text+0x226): undefined reference to `waddch'
textbox.c:(.text+0x244): undefined reference to `waddnstr'
textbox.c:(.text+0x24c): undefined reference to `wclrtoeol'
textbox.c:(.text+0x27d): undefined reference to `wnoutrefresh'
textbox.c:(.text+0x2a7): undefined reference to `wbkgdset'
textbox.c:(.text+0x2f3): undefined reference to `wmove'
textbox.c:(.text+0x304): undefined reference to `wprintw'
textbox.c:(.text+0x314): undefined reference to `wmove'
textbox.c:(.text+0x340): undefined reference to `wbkgdset'
lxdialog/textbox.o: In function `dialog_textbox':
textbox.c:(.text+0x416): undefined reference to `stdscr'
textbox.c:(.text+0x470): undefined reference to `COLS'
textbox.c:(.text+0x48a): undefined reference to `LINES'
textbox.c:(.text+0x4ba): undefined reference to `newwin'
textbox.c:(.text+0x4ca): undefined reference to `keypad'
textbox.c:(.text+0x4e7): undefined reference to `subwin'
textbox.c:(.text+0x508): undefined reference to `wbkgdset'
textbox.c:(.text+0x515): undefined reference to `keypad'
textbox.c:(.text+0x557): undefined reference to `wmove'
textbox.c:(.text+0x563): undefined reference to `acs_map'
textbox.c:(.text+0x56b): undefined reference to `waddch'
textbox.c:(.text+0x583): undefined reference to `acs_map'
textbox.c:(.text+0x58f): undefined reference to `waddch'
textbox.c:(.text+0x5b6): undefined reference to `wbkgdset'
textbox.c:(.text+0x5bd): undefined reference to `acs_map'
textbox.c:(.text+0x5c5): undefined reference to `waddch'
textbox.c:(.text+0x613): undefined reference to `wnoutrefresh'
textbox.c:(.text+0x671): undefined reference to `wgetch'
textbox.c:(.text+0x6dc): undefined reference to `delwin'
textbox.c:(.text+0x6e4): undefined reference to `delwin'
textbox.c:(.text+0x6f0): undefined reference to `stdscr'
textbox.c:(.text+0x77c): undefined reference to `delwin'
textbox.c:(.text+0x784): undefined reference to `delwin'
textbox.c:(.text+0x8db): undefined reference to `wgetch'
textbox.c:(.text+0xb30): undefined reference to `wbkgdset'
textbox.c:(.text+0xb37): undefined reference to `acs_map'
textbox.c:(.text+0xb3e): undefined reference to `waddch'
textbox.c:(.text+0xb8f): undefined reference to `wnoutrefresh'
lxdialog/textbox.o: In function `refresh_text_box':
textbox.c:(.text+0x32a): undefined reference to `wrefresh'
lxdialog/util.o: In function `init_one_color':
util.c:(.text+0x46f): undefined reference to `init_pair'
lxdialog/util.o: In function `attr_clear':
util.c:(.text+0x4d1): undefined reference to `wmove'
util.c:(.text+0x4ec): undefined reference to `waddch'
lxdialog/util.o: In function `dialog_clear':
util.c:(.text+0x539): undefined reference to `COLS'
util.c:(.text+0x53f): undefined reference to `LINES'
util.c:(.text+0x546): undefined reference to `stdscr'
util.c:(.text+0x561): undefined reference to `stdscr'
util.c:(.text+0x57d): undefined reference to `wmove'
util.c:(.text+0x590): undefined reference to `stdscr'
util.c:(.text+0x59a): undefined reference to `waddnstr'
util.c:(.text+0x5a1): undefined reference to `stdscr'
util.c:(.text+0x5b0): undefined reference to `wmove'
util.c:(.text+0x5b6): undefined reference to `COLS'
util.c:(.text+0x5cb): undefined reference to `acs_map'
util.c:(.text+0x5d2): undefined reference to `stdscr'
util.c:(.text+0x5da): undefined reference to `waddch'
util.c:(.text+0x5e0): undefined reference to `COLS'
util.c:(.text+0x5ef): undefined reference to `stdscr'
lxdialog/util.o: In function `init_dialog':
util.c:(.text+0x605): undefined reference to `initscr'
util.c:(.text+0x60c): undefined reference to `stdscr'
util.c:(.text+0x7f2): undefined reference to `stdscr'
util.c:(.text+0x7fc): undefined reference to `keypad'
util.c:(.text+0x801): undefined reference to `cbreak'
util.c:(.text+0x806): undefined reference to `noecho'
util.c:(.text+0x821): undefined reference to `has_colors'
util.c:(.text+0x831): undefined reference to `start_color'
util.c:(.text+0xcc7): undefined reference to `has_colors'
util.c:(.text+0xce6): undefined reference to `has_colors'
util.c:(.text+0xd15): undefined reference to `endwin'
lxdialog/util.o: In function `end_dialog':
util.c:(.text+0xd39): undefined reference to `stdscr'
util.c:(.text+0xd3e): undefined reference to `wmove'
util.c:(.text+0xd45): undefined reference to `stdscr'
util.c:(.text+0xd4a): undefined reference to `wrefresh'
lxdialog/util.o: In function `print_title':
util.c:(.text+0xdba): undefined reference to `wmove'
util.c:(.text+0xdcc): undefined reference to `waddch'
util.c:(.text+0xdd9): undefined reference to `wmove'
util.c:(.text+0xdeb): undefined reference to `waddnstr'
lxdialog/util.o: In function `print_autowrap':
util.c:(.text+0xf6a): undefined reference to `wmove'
util.c:(.text+0xf7a): undefined reference to `waddnstr'
util.c:(.text+0x104e): undefined reference to `wmove'
util.c:(.text+0x105e): undefined reference to `waddnstr'
lxdialog/util.o: In function `print_button':
util.c:(.text+0x1093): undefined reference to `wmove'
util.c:(.text+0x10c0): undefined reference to `waddnstr'
util.c:(.text+0x111d): undefined reference to `waddch'
util.c:(.text+0x114c): undefined reference to `waddch'
util.c:(.text+0x1168): undefined reference to `waddnstr'
util.c:(.text+0x1185): undefined reference to `waddnstr'
util.c:(.text+0x11c8): undefined reference to `waddch'
util.c:(.text+0x11e4): undefined reference to `waddnstr'
util.c:(.text+0x1204): undefined reference to `waddch'
util.c:(.text+0x1214): undefined reference to `waddnstr'
lxdialog/util.o: In function `draw_box':
util.c:(.text+0x12a9): undefined reference to `wmove'
util.c:(.text+0x12fb): undefined reference to `waddch'
util.c:(.text+0x1338): undefined reference to `acs_map'
util.c:(.text+0x1340): undefined reference to `waddch'
util.c:(.text+0x1359): undefined reference to `acs_map'
util.c:(.text+0x1361): undefined reference to `waddch'
util.c:(.text+0x1381): undefined reference to `acs_map'
util.c:(.text+0x1389): undefined reference to `waddch'
util.c:(.text+0x13a0): undefined reference to `acs_map'
util.c:(.text+0x13a8): undefined reference to `waddch'
util.c:(.text+0x13b9): undefined reference to `acs_map'
util.c:(.text+0x13c1): undefined reference to `waddch'
util.c:(.text+0x13d2): undefined reference to `acs_map'
util.c:(.text+0x13da): undefined reference to `waddch'
util.c:(.text+0x13fa): undefined reference to `acs_map'
util.c:(.text+0x1402): undefined reference to `waddch'
util.c:(.text+0x1413): undefined reference to `acs_map'
util.c:(.text+0x141b): undefined reference to `waddch'
lxdialog/util.o: In function `draw_shadow':
util.c:(.text+0x144d): undefined reference to `has_colors'
util.c:(.text+0x147a): undefined reference to `wmove'
util.c:(.text+0x1490): undefined reference to `winch'
util.c:(.text+0x149b): undefined reference to `waddch'
util.c:(.text+0x14b9): undefined reference to `wmove'
util.c:(.text+0x14c4): undefined reference to `winch'
util.c:(.text+0x14cf): undefined reference to `waddch'
util.c:(.text+0x14d7): undefined reference to `winch'
util.c:(.text+0x14e2): undefined reference to `waddch'
lxdialog/util.o: In function `on_key_esc':
util.c:(.text+0x160d): undefined reference to `nodelay'
util.c:(.text+0x1617): undefined reference to `keypad'
util.c:(.text+0x161f): undefined reference to `wgetch'
util.c:(.text+0x1629): undefined reference to `wgetch'
util.c:(.text+0x1634): undefined reference to `wgetch'
util.c:(.text+0x1643): undefined reference to `nodelay'
util.c:(.text+0x1650): undefined reference to `keypad'
util.c:(.text+0x1686): undefined reference to `ungetch'
lxdialog/util.o: In function `attr_clear':
util.c:(.text+0x522): undefined reference to `wtouchln'
lxdialog/util.o: In function `dialog_clear':
util.c:(.text+0x5f4): undefined reference to `wnoutrefresh'
lxdialog/util.o: In function `end_dialog':
util.c:(.text+0xd53): undefined reference to `endwin'
lxdialog/util.o: In function `print_title':
util.c:(.text+0xe02): undefined reference to `waddch'
lxdialog/util.o: In function `print_button':
util.c:(.text+0x11a3): undefined reference to `wmove'
lxdialog/util.o: In function `draw_shadow':
util.c:(.text+0x14fd): undefined reference to `wnoutrefresh'
lxdialog/yesno.o: In function `print_buttons':
yesno.c:(.text+0x86): undefined reference to `wmove'
lxdialog/yesno.o: In function `dialog_yesno':
yesno.c:(.text+0xdc): undefined reference to `stdscr'
yesno.c:(.text+0x118): undefined reference to `COLS'
yesno.c:(.text+0x131): undefined reference to `LINES'
yesno.c:(.text+0x15a): undefined reference to `newwin'
yesno.c:(.text+0x16a): undefined reference to `keypad'
yesno.c:(.text+0x1ac): undefined reference to `wmove'
yesno.c:(.text+0x1b8): undefined reference to `acs_map'
yesno.c:(.text+0x1c0): undefined reference to `waddch'
yesno.c:(.text+0x1d3): undefined reference to `acs_map'
yesno.c:(.text+0x1df): undefined reference to `waddch'
yesno.c:(.text+0x202): undefined reference to `acs_map'
yesno.c:(.text+0x207): undefined reference to `waddch'
yesno.c:(.text+0x257): undefined reference to `wgetch'
yesno.c:(.text+0x284): undefined reference to `delwin'
yesno.c:(.text+0x2c0): undefined reference to `delwin'
yesno.c:(.text+0x2e6): undefined reference to `delwin'
yesno.c:(.text+0x32e): undefined reference to `wrefresh'
yesno.c:(.text+0x345): undefined reference to `delwin'
yesno.c:(.text+0x363): undefined reference to `delwin'
yesno.c:(.text+0x3a3): undefined reference to `acs_map'
yesno.c:(.text+0x3aa): undefined reference to `waddch'
lxdialog/yesno.o: In function `print_buttons':
yesno.c:(.text+0x98): undefined reference to `wrefresh'
collect2: error: ld returned 1 exit status
make[2]: *** [mconf] Error 1
make[1]: *** [menuconfig] Error 2
make: *** [menuconfig] Error 2


