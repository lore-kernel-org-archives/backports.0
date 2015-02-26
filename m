Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:3227 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbbBZMuD (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 26 Feb 2015 07:50:03 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: allow building backports package on 4.0+ kernel
Date: Thu, 26 Feb 2015 13:49:58 +0100
Message-ID: <1424954998-31984-1-git-send-email-arend@broadcom.com> (sfid-20150226_135011_981321_0099BE5A)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When attempting to build backport package the error message
"Kernel version parse failed" popped up. Realizing the machine
was already running a 4.0-rc1 kernel, this patch fixes the
issue. At least until kernel 9.x it will.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/Makefile b/backport/Makefile
index c21b813..1c39f64 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -85,7 +85,7 @@ mrproper:
 			done								\
 		) > Kconfig.kernel							;\
 		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) kernelversion |	\
-			sed 's/^\(\(3\|2\.6\)\.[0-9]\+\).*/\1/;t;d')			;\
+			sed 's/^\(\([3-9]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')			;\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
 		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
-- 
1.9.1

