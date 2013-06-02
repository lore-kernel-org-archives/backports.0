Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:50047 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab3FBRlr (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 13:41:47 -0400
Message-ID: <1370194899.8366.5.camel@jlt4.sipsolutions.net> (sfid-20130602_194149_387937_1A5420EA)
Subject: Re: Buid backports-20130528 on ArchLinux: /usr/bin/ld: cannot find
 -ltinfo
From: Johannes Berg <johannes@sipsolutions.net>
To: "Anh K. Huynh" <kyanh@viettug.org>
Cc: backports@vger.kernel.org
Date: Sun, 02 Jun 2013 19:41:39 +0200
In-Reply-To: <20130602220934.3079ee4f@icy> (sfid-20130602_170957_728483_48913C26)
References: <20130602220934.3079ee4f@icy>
	 (sfid-20130602_170957_728483_48913C26)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-06-02 at 22:09 +0700, Anh K. Huynh wrote:
> Hello,
> 
> I'm building the `backports-20130528` on ArchLinux (kernel = 3.2.46).
> I see the error as in http://pastie.org/7996763 .
> 
> I don't have any problem when building the new Linux kernel. When I
> remove the `tinfo` support from the file `kconf/Makefile` I can run 
> `make menuconfig` perfectly.
> 
> Is the `tinfo` library really needed to run `make menuconfig` when
> building backports drivers?

It was needed on some distros, and not on others. This is probably the
best option?

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
 

johannes


