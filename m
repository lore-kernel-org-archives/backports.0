Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50202 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3KYXBu (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 Nov 2013 18:01:50 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 19B742034B
	for <backports@vger.kernel.org>; Mon, 25 Nov 2013 23:01:49 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id D764A2018A
	for <backports@vger.kernel.org>; Mon, 25 Nov 2013 23:01:47 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 63381] cpumask.h error
Date: Mon, 25 Nov 2013 23:01:45 +0000
Message-ID: <bug-63381-58281-1rIdvcJfPQ@https.bugzilla.kernel.org/> (sfid-20131126_000152_010942_B301900C)
In-Reply-To: <bug-63381-58281@https.bugzilla.kernel.org/>
References: <bug-63381-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=63381

--- Comment #5 from DarinV <darin.vancoevering@gmail.com> ---
Well I still get an error. I am attaching the whole terminal output so you guys
can see all of it.

supergamer://home/supervl/Desktop/backports-20131122-2
root:# make menuconfig
Generating local configuration database from kernel ... done.
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o mconf.o mconf.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o zconf.tab.o zconf.tab.c
menu.c: In function `get_symbol_str':
menu.c:515: warning: 'jump' might be used uninitialized in this function
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/checklist.o
lxdialog/checklist.ccc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
-fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o
lxdialog/inputbox.o lxdialog/inputbox.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/menubox.o
lxdialog/menubox.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/textbox.o
lxdialog/textbox.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/util.o lxdialog/util.c
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
-DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o lxdialog/yesno.o lxdialog/yesno.c
cc -Wl,--no-as-needed -lncursesw  mconf.o zconf.tab.o lxdialog/checklist.o
lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o
lxdialog/yesno.o   -o mconf


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

supergamer://home/supervl/Desktop/backports-20131122-2
root:# make
cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer   -c
-o conf.o conf.c
cc   conf.o zconf.tab.o   -o conf
#
# configuration written to .config
#
Building backport-include/backport/autoconf.h ... done.

  WARNING: Symbol version dump /usr/src/linux-2.6.27.57/Module.symvers
           is missing; modules will have no dependencies and modversions.

  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/main.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.28.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.29.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.32.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.33.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.34.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.35.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.36.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.37.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/compat-2.6.39.o
  CC [M]  /home/supervl/Desktop/backports-20131122-2/compat/kstrtox.o
In file included from include/linux/cpumask.h:139,
                 from include/asm/processor.h:25,
                 from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/linux/types.h:37,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/backports-20131122-2/compat/kstrtox.c:14:
include/linux/bitmap.h: In function `bitmap_zero':
include/linux/bitmap.h:145: error: implicit declaration of function
`DIV_ROUND_UP'
In file included from include/asm/processor.h:25,
                 from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/linux/types.h:37,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/backports-20131122-2/compat/kstrtox.c:14:
include/linux/cpumask.h: At top level:
include/linux/cpumask.h:141: error: variable-size type declared outside of any
function
include/linux/cpumask.h:276: error: variable-size type declared outside of any
function
In file included from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/linux/types.h:37,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/backports-20131122-2/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/backports-20131122-2/compat/kstrtox.c:14:
include/asm/processor.h: In function `native_get_debugreg':
include/asm/processor.h:443: error: implicit declaration of function `BUG'
make[6]: *** [/home/supervl/Desktop/backports-20131122-2/compat/kstrtox.o]
Error 1
make[5]: *** [/home/supervl/Desktop/backports-20131122-2/compat] Error 2
make[4]: *** [_module_/home/supervl/Desktop/backports-20131122-2] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2
supergamer://home/supervl/Desktop/backports-20131122-2
root:#

-- 
You are receiving this mail because:
You are the assignee for the bug.
