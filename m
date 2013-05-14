Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:47638 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3ENGfo (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 May 2013 02:35:44 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so223822lbv.27
        for <backports@vger.kernel.org>; Mon, 13 May 2013 23:35:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368512752.8252.3.camel@jlt4.sipsolutions.net>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com>
 <1368446524.8300.22.camel@jlt4.sipsolutions.net> <CAB=NE6U1VbZTogeXVmwFN8WxHCHcWN+Ofn5SwiW1ceg2V3ujdQ@mail.gmail.com>
 <1368512752.8252.3.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 13 May 2013 23:35:23 -0700
Message-ID: <CAB=NE6U=rTR2ZKXexPDeyv6VBi8k74wpj5f6SnS3rxQHaDwB0A@mail.gmail.com> (sfid-20130514_083547_164930_241F0913)
Subject: Re: [PATCH 01/12] backports: make compat module use subsys_initcall()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Paul Stewart <pstew@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, May 13, 2013 at 11:25 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> why not just keep module_exit()?

Sure.

>From e9b18b9f99716fb382e7b8e2cde8248fc82806cf Mon Sep 17 00:00:00 2001
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 8 May 2013 19:20:55 +0000
Subject: [PATCH v3] backports: make compat module use subsys_initcall()

This is a no-op for the modular use case of the
backports project but by enabling this it allows
for developers a way to embed the backports releases
onto a target source Linux directory, with obvious
pending modifications, by adding our backport_init()
onto the target kernel's init/main.c start_kernel().

Enable this theoretical use case. Hackers welcome to
go play on this theoretical integration strategy now.

Cc: pstew@chromium.org
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backport/compat/main.c b/backport/compat/main.c
index 90ce751..394e413 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/pm_qos.h>
 #include <linux/workqueue.h>
 #include "compat-2.6.34.h"
@@ -69,7 +70,7 @@ static int __init backport_init(void)

         return 0;
 }
-module_init(backport_init);
+subsys_initcall(backport_init);

 static void __exit backport_exit(void)
 {
