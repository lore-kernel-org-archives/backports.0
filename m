Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:51366 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3EKA1R (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:17 -0400
Received: by mail-ia0-f180.google.com with SMTP id 21so5202718iay.25
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>, pstew@chromium.org
Subject: [PATCH 01/12] backports: make compat module use subsys_initcall()
Date: Fri, 10 May 2013 17:26:52 -0700
Message-Id: <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022718_759369_13B7AB26)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

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
 backport/compat/main.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/backport/compat/main.c b/backport/compat/main.c
index 90ce751..b7dff1a 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -69,7 +69,7 @@ static int __init backport_init(void)
 
         return 0;
 }
-module_init(backport_init);
+subsys_initcall(backport_init);
 
 static void __exit backport_exit(void)
 {
@@ -78,5 +78,4 @@ static void __exit backport_exit(void)
 
         return;
 }
-module_exit(backport_exit);
-
+__exitcall(backport_exit);
-- 
1.7.10.4

