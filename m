Return-path: <backports-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59628 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbaJ2Hy2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Oct 2014 03:54:28 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: fix mconf compilation on Ubuntu
Date: Wed, 29 Oct 2014 09:49:31 +0200
Message-Id: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20141029_085430_011170_5AE98E06)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since

commit de427857852e7194b9ae80571425ba0d2c29ef55
Author: Luis R. Rodriguez <mcgrof@suse.com>
Date:   Sun Sep 14 06:05:29 2014 -0700

    backports: fix mconf compilation library assumptions

I can't compile mconf on my Ubuntu trusty machine.
This fixes that by making Luis's patch conditional.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/kconf/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
index dfd793a..8398f35 100644
--- a/backport/kconf/Makefile
+++ b/backport/kconf/Makefile
@@ -3,7 +3,15 @@ CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
 LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
 
 conf: conf.o zconf.tab.o
-mconf: LDFLAGS = -Wl,--no-as-needed $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
+
+RELEASE=$(shell lsb_release -si)
+ifeq ($(RELEASE), Ubuntu)
+	AS_NEEDED=--no-as-needed
+else
+	AS_NEEDED=--add-needed
+endif
+mconf: LDFLAGS = -Wl,$(AS_NEEDED) $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
+
 mconf: CFLAGS += -DCURSES_LOC="<ncurses.h>" -DLOCALE
 mconf: mconf.o zconf.tab.o $(LXDIALOG)
 
-- 
1.9.1

