Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33165 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab3DMOOW (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 10:14:22 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so1900846pad.20
        for <backports@vger.kernel.org>; Sat, 13 Apr 2013 07:14:22 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 7/7] backports: add intel_ips support
Date: Sat, 13 Apr 2013 07:13:44 -0700
Message-Id: <1365862424-6530-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161446_939837_D2DBB7D0)
In-Reply-To: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

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

real    39m35.615s
user    1068m47.428s
sys     155m55.657s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Kconfig         |    2 ++
 backport/Makefile.kernel |    1 +
 copy-list                |    7 +++++++
 dependencies             |    2 ++
 4 files changed, 12 insertions(+)

diff --git a/backport/Kconfig b/backport/Kconfig
index 2c75cd8..3103f10 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -41,3 +41,5 @@ source net/nfc/Kconfig
 
 source drivers/regulator/Kconfig
 source drivers/media/Kconfig
+
+source drivers/platform/x86/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 27b44da..096e80c 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -33,3 +33,4 @@ obj-$(CPTCFG_NFC) += net/nfc/
 obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_REGULATOR) += drivers/regulator/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
+obj-$(CPTCFG_INTEL_IPS) += drivers/platform/x86/
diff --git a/copy-list b/copy-list
index 0c25be5..b49901d 100644
--- a/copy-list
+++ b/copy-list
@@ -185,3 +185,10 @@ include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
 
 drivers/media/
+
+# Platform
+drivers/platform/x86/Kconfig
+drivers/platform/x86/Makefile
+drivers/platform/x86/intel_ips.c
+drivers/platform/x86/intel_ips.h
+include/asm-generic/io-64-nonatomic-lo-hi.h
diff --git a/dependencies b/dependencies
index 0658289..f939b90 100644
--- a/dependencies
+++ b/dependencies
@@ -157,3 +157,5 @@ BT_HIDP 2.6.33
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
 NFC 3.1
+
+INTEL_IPS 3.2
-- 
1.7.10.4

