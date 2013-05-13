Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33091 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab3EMKYx (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 06:24:53 -0400
Received: by mail-pb0-f41.google.com with SMTP id xb12so356914pbc.28
        for <backports@vger.kernel.org>; Mon, 13 May 2013 03:24:53 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/3] backports: refresh patches for next-20130426
Date: Mon, 13 May 2013 03:24:35 -0700
Message-Id: <1368440675-23190-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130513_122455_234892_F466D3DE)
In-Reply-To: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

== ckmake-report.log ==

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
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m52.106s
user    816m17.749s
sys     127m27.702s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_gpu_drm_i915_intel_opregion.patch                        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
index 2ad5abf..334ff43 100644
--- a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
+++ b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/intel_opregion.c
 +++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -307,6 +307,9 @@ static int intel_opregion_video_event(st
+@@ -259,6 +259,9 @@ static int intel_opregion_video_event(st
  	struct acpi_bus_event *event = data;
  	int ret = NOTIFY_OK;
  
-- 
1.7.10.4

