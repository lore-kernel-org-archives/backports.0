Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57632 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab3EFVwb (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 17:52:31 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so2222585pdj.40
        for <backports@vger.kernel.org>; Mon, 06 May 2013 14:52:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 3/4] backports: disable some regulator drivers on 3.4 and 3.5
Date: Mon,  6 May 2013 14:52:07 -0700
Message-Id: <1367877128-10812-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130506_235232_851102_AEB46AE7)
In-Reply-To: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We enabled regulator subsystem support as of 3.4 but given that
the regulator subsystem has advanced quite a bit on 3.5 and 3.6
and that we cannot backport the regulator as its part of the
core kernel we have no option but to only enable drivers on their
kernels if they don't depend on the new regulator features.

$ time ckmake --check-exports --allyesconfig

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

real    30m12.875s
user    797m38.663s
sys     126m56.572s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/dependencies b/dependencies
index 6768d74..5ae6bce 100644
--- a/dependencies
+++ b/dependencies
@@ -69,6 +69,33 @@ REGULATOR_WM8350 DISABLE
 REGULATOR_PALMAS DISABLE
 REGULATOR_DA9055 DISABLE
 REGULATOR_S5M8767 DISABLE
+# These have further core regulator kernel dependencies
+# we can't easily backport.
+REGULATOR_AAT2870 3.6
+REGULATOR_DA903X 3.5
+REGULATOR_DA9052 3.5
+REGULATOR_FAN53555 3.5
+REGULATOR_ISL6271A 3.5
+REGULATOR_LP3971 3.6
+REGULATOR_LP3972 3.6
+REGULATOR_LP8755 3.5
+REGULATOR_MAX1586 3.6
+REGULATOR_MAX8649 3.5
+REGULATOR_MAX8660 3.5
+REGULATOR_MAX8925 3.5
+REGULATOR_MAX8998 3.5
+REGULATOR_MC13783 3.6
+REGULATOR_MC13892 3.6
+REGULATOR_MC13XXX_CORE 3.6
+REGULATOR_PCAP 3.6
+REGULATOR_PCF50633 3.5
+REGULATOR_TPS51632 3.6
+REGULATOR_TPS6105X 3.6
+REGULATOR_TPS65023 3.6
+REGULATOR_TPS6507X 3.6
+REGULATOR_TPS6524X 3.6
+REGULATOR_WM8400 3.5
+REGULATOR_WM8994 3.5
 
 # Media
 MEDIA_SUPPORT 3.2
-- 
1.7.10.4

