Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62955 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161970Ab3DEQir (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 12:38:47 -0400
Received: by mail-pa0-f46.google.com with SMTP id lb1so2132847pab.19
        for <backports@vger.kernel.org>; Fri, 05 Apr 2013 09:38:47 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 5/5] backports: add DRM drivers
Date: Fri,  5 Apr 2013 09:38:19 -0700
Message-Id: <1365179899-7984-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130405_183849_511540_C94044EE)
In-Reply-To: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365179899-7984-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

They are building just fine so enable them.

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Kconfig |    2 ++
 copy-list        |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/backport/Kconfig b/backport/Kconfig
index d0ae17f..8a38d61 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -34,3 +34,5 @@ source drivers/net/ethernet/Kconfig
 
 source drivers/ssb/Kconfig
 source drivers/bcma/Kconfig
+
+source drivers/gpu/drm/Kconfig
diff --git a/copy-list b/copy-list
index 4243619..4c606a5 100644
--- a/copy-list
+++ b/copy-list
@@ -114,3 +114,25 @@ drivers/net/ethernet/broadcom/Kconfig
 drivers/net/ethernet/broadcom/Makefile
 drivers/net/ethernet/broadcom/b44.c
 drivers/net/ethernet/broadcom/b44.h
+
+# DRM
+include/drm/
+include/uapi/drm/
+drivers/platform/x86/intel_ips.h
+
+drivers/gpu/drm/Makefile
+drivers/gpu/drm/Kconfig
+drivers/gpu/drm/ast/
+drivers/gpu/drm/cirrus/
+drivers/gpu/drm/gma500/
+drivers/gpu/drm/i2c/
+drivers/gpu/drm/i810/
+drivers/gpu/drm/i915/
+drivers/gpu/drm/mgag200/
+drivers/gpu/drm/nouveau/core/
+drivers/gpu/drm/nouveau/
+drivers/gpu/drm/radeon/reg_srcs/
+drivers/gpu/drm/radeon/
+drivers/gpu/drm/ttm/
+drivers/gpu/drm/via/
+drivers/gpu/drm/vmwgfx/
-- 
1.7.10.4

