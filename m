Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:51836 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922Ab3J3Wwx (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 30 Oct 2013 18:52:53 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A63432041D
	for <backports@vger.kernel.org>; Wed, 30 Oct 2013 22:52:47 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id E94A42041C
	for <backports@vger.kernel.org>; Wed, 30 Oct 2013 22:52:41 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 64091] New: backports build error
Date: Wed, 30 Oct 2013 22:52:41 +0000
Message-ID: <bug-64091-58281@https.bugzilla.kernel.org/> (sfid-20131030_235305_394849_23CD7505)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64091

            Bug ID: 64091
           Summary: backports build error
           Product: Backports project
           Version: unspecified
    Kernel Version: 2.6.27.57
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: darin.vancoevering@gmail.com
        Regression: No

Created attachment 112831
  --> https://bugzilla.kernel.org/attachment.cgi?id=112831&action=edit
config used. This config works with backport 3.8 version.

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

supergamer://home/supervl/Desktop/1/backports-3.11.6-1
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

  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/main.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.28.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.29.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.32.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.33.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.34.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.35.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.36.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.37.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/compat-2.6.39.o
  CC [M]  /home/supervl/Desktop/1/backports-3.11.6-1/compat/kstrtox.o
In file included from include/linux/cpumask.h:139,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/cpumask.h:3,
                 from include/asm/processor.h:25,
                 from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/types.h:47,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/compat/kstrtox.c:14:
include/linux/bitmap.h: In function `bitmap_zero':
include/linux/bitmap.h:145: error: implicit declaration of function
`DIV_ROUND_UP'
In file included from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/cpumask.h:3,
                 from include/asm/processor.h:25,
                 from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/types.h:47,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/compat/kstrtox.c:14:
include/linux/cpumask.h: At top level:
include/linux/cpumask.h:141: error: variable-size type declared outside of any
function
include/linux/cpumask.h:276: error: variable-size type declared outside of any
function
In file included from include/asm/processor.h:25,
                 from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/types.h:47,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/compat/kstrtox.c:14:
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/cpumask.h:7:
error: variable-size type declared outside of any function
In file included from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/asm/atomic.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/types.h:47,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/backport-include/linux/kernel.h:3,
                 from
/home/supervl/Desktop/1/backports-3.11.6-1/compat/kstrtox.c:14:
include/asm/processor.h: In function `native_get_debugreg':
include/asm/processor.h:443: error: implicit declaration of function `BUG'
make[6]: *** [/home/supervl/Desktop/1/backports-3.11.6-1/compat/kstrtox.o]
Error 1
make[5]: *** [/home/supervl/Desktop/1/backports-3.11.6-1/compat] Error 2
make[4]: *** [_module_/home/supervl/Desktop/1/backports-3.11.6-1] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2
supergamer://home/supervl/Desktop/1/backports-3.11.6-1
root:#

-- 
You are receiving this mail because:
You are the assignee for the bug.
