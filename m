Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35015 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab3EMR3h convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 13:29:37 -0400
Received: by mail-lb0-f171.google.com with SMTP id u10so6686611lbi.16
        for <backports@vger.kernel.org>; Mon, 13 May 2013 10:29:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368446524.8300.22.camel@jlt4.sipsolutions.net>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com> <1368446524.8300.22.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 13 May 2013 10:29:14 -0700
Message-ID: <CAB=NE6U1VbZTogeXVmwFN8WxHCHcWN+Ofn5SwiW1ceg2V3ujdQ@mail.gmail.com> (sfid-20130513_192939_246916_5F1AE308)
Subject: Re: [PATCH 01/12] backports: make compat module use subsys_initcall()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Paul Stewart <pstew@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, May 13, 2013 at 5:02 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2013-05-10 at 17:26 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> This is a no-op for the modular use case of the
>> backports project but by enabling this it allows
>> for developers a way to embed the backports releases
>> onto a target source Linux directory, with obvious
>> pending modifications, by adding our backport_init()
>> onto the target kernel's init/main.c start_kernel().
>>
>> Enable this theoretical use case. Hackers welcome to
>> go play on this theoretical integration strategy now.
>
> I applied all but this one, it caused a compiler warning that seemed
> important (missing an include?)
>
> /tmp/i/compat/main.c:83:1: warning: data definition has no type or
> storage class [enabled by default]
> /tmp/i/compat/main.c:83:1: warning: type defaults to ‘int’ in
> declaration of ‘__exitcall’ [-Wimplicit-int]
> /tmp/i/compat/main.c:83:1: warning: parameter names (without types) in
> function declaration [enabled by default]
> /tmp/i/compat/main.c:76:123: warning: ‘backport_exit’ defined but not
> used [-Wunused-function]

Sorry can you try this?

>From e9b18b9f99716fb382e7b8e2cde8248fc82806cf Mon Sep 17 00:00:00 2001
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 8 May 2013 19:20:55 +0000
Subject: [PATCH v2] backports: make compat module use subsys_initcall()

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
@@ -78,5 +79,4 @@ static void __exit backport_exit(void)

         return;
 }
-module_exit(backport_exit);
-
+__exitcall(backport_exit);
--
1.7.10.4


  Luis
