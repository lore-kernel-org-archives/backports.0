Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:65119 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaHIPX3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 9 Aug 2014 11:23:29 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so8720463pad.24
        for <backports@vger.kernel.org>; Sat, 09 Aug 2014 08:23:29 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH] backports: fix mconf compilation on OpenSUSE factory
Date: Sat,  9 Aug 2014 08:23:23 -0700
Message-Id: <1407597803-11371-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140809_172333_446755_55AB6E1D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

On OpenSUSE factory 'make menuconfig' fails to compile with:

cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
-fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o
lxdialog/yesno.o lxdialog/yesno.c
cc -Wl,--no-as-needed -lncursesw  mconf.o zconf.tab.o
lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o
lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o   -o mconf
/usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld:
/lib64/libncursesw.so.5: undefined reference to symbol 'acs_map'
/usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../lib64/libtinfo.so:
error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status

This is fixed by linking with -ltinfo. I've test builded this on
Debian and OpenSUSE factory.

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 backport/kconf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
index dfd793a..c9c39a3 100644
--- a/backport/kconf/Makefile
+++ b/backport/kconf/Makefile
@@ -3,7 +3,7 @@ CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
 LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
 
 conf: conf.o zconf.tab.o
-mconf: LDFLAGS = -Wl,--no-as-needed $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
+mconf: LDFLAGS = -Wl,--no-as-needed -ltinfo $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
 mconf: CFLAGS += -DCURSES_LOC="<ncurses.h>" -DLOCALE
 mconf: mconf.o zconf.tab.o $(LXDIALOG)
 
-- 
2.0.3

