Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49221 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab3EGLXb (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 07:23:31 -0400
Received: by mail-pd0-f169.google.com with SMTP id bv13so302091pdb.28
        for <backports@vger.kernel.org>; Tue, 07 May 2013 04:23:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] backports: refresh patches for next-20130403
Date: Tue,  7 May 2013 04:23:20 -0700
Message-Id: <1367925800-18555-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_132332_344882_4B3F2CA6)
In-Reply-To: <1367925800-18555-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367925800-18555-1-git-send-email-mcgrof@do-not-panic.com>
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
26  3.9.0               [  OK  ]

real    29m44.962s
user    785m54.059s
sys     123m53.217s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_gpu_drm_radeon_radeon_bios.patch                         |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
index c2453e2..bf04724 100644
--- a/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
+++ b/patches/collateral-evolutions/drm/10-radeon-revert-acpi-table-size-check/drivers_gpu_drm_radeon_radeon_bios.patch
@@ -1,6 +1,6 @@
 --- a/drivers/gpu/drm/radeon/radeon_bios.c
 +++ b/drivers/gpu/drm/radeon/radeon_bios.c
-@@ -554,12 +554,21 @@ static bool radeon_acpi_vfct_bios(struct
+@@ -577,12 +577,21 @@ static bool radeon_acpi_vfct_bios(struct
  {
  	bool ret = false;
  	struct acpi_table_header *hdr;
-- 
1.7.10.4

