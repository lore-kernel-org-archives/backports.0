Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48908 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab3EQLBE (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 May 2013 07:01:04 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so3455375pad.19
        for <backports@vger.kernel.org>; Fri, 17 May 2013 04:01:03 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/3] backports: refresh patches for next-20130501
Date: Fri, 17 May 2013 04:00:45 -0700
Message-Id: <1368788445-1641-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_130107_529506_B81077B2)
In-Reply-To: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
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

real    30m46.042s
user    816m2.488s
sys     126m33.079s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_gpu_drm_i915_intel_opregion.patch                        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
index 334ff43..b4dcd2a 100644
--- a/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
+++ b/patches/collateral-evolutions/drm/05-i915-define-acpi-video-class/drivers_gpu_drm_i915_intel_opregion.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/i915/intel_opregion.c
 +++ b/drivers/gpu/drm/i915/intel_opregion.c
-@@ -259,6 +259,9 @@ static int intel_opregion_video_event(st
+@@ -250,6 +250,9 @@ static int intel_opregion_video_event(st
  	struct acpi_bus_event *event = data;
  	int ret = NOTIFY_OK;
  
-- 
1.7.10.4

