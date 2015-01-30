Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:54984 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763102AbbA3UMq (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 30 Jan 2015 15:12:46 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH 1/2] backport: small copy&paste error fixed
Date: Fri, 30 Jan 2015 21:12:37 +0100
Message-ID: <1422648758-31361-1-git-send-email-arend@broadcom.com> (sfid-20150130_211248_258620_DD582D84)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Changed the version number in the file header comment.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/compat/backport-3.19.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index c633f38..0b59bef 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
  *
- * Backport functionality introduced in Linux 3.18.
+ * Backport functionality introduced in Linux 3.19.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.9.1

