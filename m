Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44195 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756877Ab3GKWMa (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/19] backports: use check-lxdialog.sh
Date: Fri, 12 Jul 2013 00:11:30 +0200
Message-Id: <1373580702-24752-9-git-send-email-hauke@hauke-m.de> (sfid-20130712_001235_850584_B10ADB55)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Upstream commit d58be321df286371d50ed54e835efeea087a9fac

We ship it, so we should use it. This should fix issues
like one distro needing "-lncurses -ltinfo" and others
requiring just "-lncurses" and not having "tinfo".

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/kconfig/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/kconfig/Makefile b/backport/kconfig/Makefile
index ff5c270..dfd793a 100644
--- a/backport/kconfig/Makefile
+++ b/backport/kconfig/Makefile
@@ -3,7 +3,7 @@ CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
 LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
 
 conf: conf.o zconf.tab.o
-mconf: LDFLAGS = -Wl,--no-as-needed -lncurses -ltinfo
+mconf: LDFLAGS = -Wl,--no-as-needed $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
 mconf: CFLAGS += -DCURSES_LOC="<ncurses.h>" -DLOCALE
 mconf: mconf.o zconf.tab.o $(LXDIALOG)
 
-- 
1.7.10.4

