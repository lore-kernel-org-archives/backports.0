Return-path: <backports-owner@vger.kernel.org>
Received: from mail.avionic-design.de ([87.253.173.79]:23260 "EHLO
        mail.avionic-design.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbeIJSYI (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 10 Sep 2018 14:24:08 -0400
From: Alban Bedel <alban.bedel@avionic-design.de>
To: <hauke@hauke-m.de>, <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>,
        Alban Bedel <alban.bedel@avionic-design.de>
Subject: [PATCH] backports: crypto_memneq has been backported to 3.12 and 3.10
Date: Mon, 10 Sep 2018 15:14:48 +0200
Message-ID: <20180910131448.23225-1-alban.bedel@avionic-design.de> (sfid-20180910_153135_699821_F2DF8D7C)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

crypto_memneq has been backported in 3.12.59 and 3.10.106, it
shouldn't be built for these kernels.

Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
---
 backport/backport-include/crypto/algapi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/crypto/algapi.h b/backport/backport-include/crypto/algapi.h
index b6fbdd9b..ac6ea848 100644
--- a/backport/backport-include/crypto/algapi.h
+++ b/backport/backport-include/crypto/algapi.h
@@ -3,7 +3,9 @@
 #include <linux/version.h>
 #include_next <crypto/algapi.h>
 
-#if LINUX_VERSION_IS_LESS(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0) && \
+    !LINUX_VERSION_IN_RANGE(3,12,59, 3,12,255) && \
+    !LINUX_VERSION_IN_RANGE(3,10,106, 3,10,255)
 #define __crypto_memneq LINUX_BACKPORT(__crypto_memneq)
 noinline unsigned long __crypto_memneq(const void *a, const void *b, size_t size);
 #define crypto_memneq LINUX_BACKPORT(crypto_memneq)
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
