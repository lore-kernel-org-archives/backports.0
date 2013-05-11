Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58224 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab3EKA1j (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:39 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so9435919iee.9
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:39 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 06/12] backports: remove ath5k trace fix patch
Date: Fri, 10 May 2013 17:26:57 -0700
Message-Id: <1368232023-23817-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022741_145855_3D290C91)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This is no longer required thanks to commit cc5569f6
present on next-20130415.

commit cc5569f63ecb82965f3fe2fde5e60bf1689d107a
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Apr 11 16:22:08 2013 +0200

    ath5k: use more idiomatic tracing include style

    Pretty much everywhere that uses a trace definition
    header that's not in include/trace/events/ uses the
    make system for the include path rather than putting
    it into the sources, so do that in ath5k as well.

    This came up during backporting work (where this is
    required), but since all other drivers do it this
    way upstream it seemed applicable.

    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/73-ath5k-tracing/ath5k.patch           |   21 --------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/73-ath5k-tracing/ath5k.patch

diff --git a/patches/collateral-evolutions/network/73-ath5k-tracing/ath5k.patch b/patches/collateral-evolutions/network/73-ath5k-tracing/ath5k.patch
deleted file mode 100644
index 1adb3f9..0000000
--- a/patches/collateral-evolutions/network/73-ath5k-tracing/ath5k.patch
+++ /dev/null
@@ -1,21 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/trace.h
-+++ b/drivers/net/wireless/ath/ath5k/trace.h
-@@ -97,7 +97,7 @@ TRACE_EVENT(ath5k_tx_complete,
- #if defined(CONFIG_ATH5K_TRACER) && !defined(__CHECKER__)
- 
- #undef TRACE_INCLUDE_PATH
--#define TRACE_INCLUDE_PATH ../../drivers/net/wireless/ath/ath5k
-+#define TRACE_INCLUDE_PATH .
- #undef TRACE_INCLUDE_FILE
- #define TRACE_INCLUDE_FILE trace
- 
---- a/drivers/net/wireless/ath/ath5k/Makefile
-+++ b/drivers/net/wireless/ath/ath5k/Makefile
-@@ -10,6 +10,7 @@ ath5k-y				+= phy.o
- ath5k-y				+= reset.o
- ath5k-y				+= attach.o
- ath5k-y				+= base.o
-+CFLAGS_base.o			+= -I$(src)
- ath5k-y				+= led.o
- ath5k-y				+= rfkill.o
- ath5k-y				+= ani.o
-- 
1.7.10.4

