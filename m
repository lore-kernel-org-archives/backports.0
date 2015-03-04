Return-path: <backports-owner@vger.kernel.org>
Received: from dedo.coelho.fi ([88.198.205.34]:60504 "EHLO dedo.coelho.fi"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932480AbbCDJZS (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 4 Mar 2015 04:25:18 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, arend@broadcom.com, mcgrof@suse.com
Date: Wed,  4 Mar 2015 11:06:50 +0200
Message-Id: <1425460010-16275-1-git-send-email-luca@coelho.fi> (sfid-20150304_102522_917082_0206987A)
In-Reply-To: <1424956829.1885.27.camel@sipsolutions.net>
References: <1424956829.1885.27.camel@sipsolutions.net>
Subject: [PATCH] backports: add support for 4.x kernels
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luciano Coelho <luciano.coelho@intel.com>

Adjust the kernel version parsing and list of backport files
generation for 4.x kernels.

Signed-off-by: Luciano Coelho <luciano.coelho@intel.com>
---
I was working on the same thing and Johannes told me that Arend had a
similar patch.  Maybe this one can be used?

 backport/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index ea3982b..c4962c9 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -85,11 +85,12 @@ mrproper:
 			done								\
 		) > Kconfig.kernel							;\
 		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) kernelversion |	\
-			sed 's/^\(\(3\|2\.6\)\.[0-9]\+\).*/\1/;t;d')			;\
+			sed 's/^\(\([3-4]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')		;\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
 		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
-		kvers="$$kvers $$(seq 0 99 | sed 's/^/3./')"				;\
+		kvers="$$kvers $$(seq 0 19 | sed 's/^/3./')"				;\
+		kvers="$$kvers $$(seq 0 99 | sed 's/^/4./')"				;\
 		print=0									;\
 		for v in $$kvers ; do							\
 			if [ "$$print" = "1" ] ; then					\
-- 
2.1.4

