Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:53841 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758553Ab3FCPyj (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 3 Jun 2013 11:54:39 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: use check-lxdialog.sh
Date: Mon,  3 Jun 2013 17:54:33 +0200
Message-Id: <1370274874-31049-1-git-send-email-johannes@sipsolutions.net> (sfid-20130603_175441_019675_F2049FC6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

We ship it, so we should use it. This should fix issues
like one distro needing "-lncurses -ltinfo" and others
requiring just "-lncurses" and not having "tinfo".

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/kconf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
index ff5c270..dfd793a 100644
--- a/backport/kconf/Makefile
+++ b/backport/kconf/Makefile
@@ -3,7 +3,7 @@ CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
 LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
 
 conf: conf.o zconf.tab.o
-mconf: LDFLAGS = -Wl,--no-as-needed -lncurses -ltinfo
+mconf: LDFLAGS = -Wl,--no-as-needed $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
 mconf: CFLAGS += -DCURSES_LOC="<ncurses.h>" -DLOCALE
 mconf: mconf.o zconf.tab.o $(LXDIALOG)
 
-- 
1.8.0

