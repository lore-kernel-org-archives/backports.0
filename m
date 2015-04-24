Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:59309 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964937AbbDXPFq (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Apr 2015 11:05:46 -0400
Message-ID: <553A5BBC.1030903@kpanic.de> (sfid-20150424_170555_971214_6D019ADD)
Date: Fri, 24 Apr 2015 17:05:32 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH 3/4] backports: deal with struct timespec64 changes
References: <1429788825-18466-1-git-send-email-sassmann@kpanic.de> <1429788825-18466-4-git-send-email-sassmann@kpanic.de> <553951A1.3070108@hauke-m.de>
In-Reply-To: <553951A1.3070108@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 23.04.2015 22:10, Hauke Mehrtens wrote:
> On 04/23/2015 01:33 PM, Stefan Assmann wrote:
>> igb now makes use of struct timespec64. Deal with the required
>> changes via cocci patches where possible. There's one occasion
>> where coccinelle is not able to deal with defining a struct and
>> assigning another struct on the same line.
>> Example:
>> struct timespec64 now, then = ns_to_timespec64(delta);
>> Deal with this in a separate patch for now.
> 
> I think it would be easier if you just replace timespec64 with timespec
> in the header files.
> 
> Like:
> #define ns_to_timespec64 ns_to_timespec
> #define timespec64 timespec
> 
> Then cocci is only needed to replace the settime64 members with settime
> and so on.

That seems to work better than I expected. :)
Here's a new patch.

  Stefan

>From b4d4d61c80be782f0cffa151e2eab3774c6cb4f9 Mon Sep 17 00:00:00 2001
From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed, 22 Apr 2015 10:25:56 -0400
Subject: [PATCH v2] backports: deal with struct timespec64 changes

In kernel 3.17 struct timespec64 was introduced.

commit 361a3bf00582469877f8d18ff20f1efa6b781274
Author: John Stultz <john.stultz@linaro.org>
Date:   Wed Jul 16 21:03:58 2014 +0000

    time64: Add time64.h header and define struct timespec64

git describe --contains 361a3bf00582469877f8d18ff20f1efa6b781274
v3.17-rc1~109^2~62

Deal with the required changes via defines.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/time.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 backport/backport-include/linux/time.h

diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
new file mode 100644
index 0000000..3d958fe
--- /dev/null
+++ b/backport/backport-include/linux/time.h
@@ -0,0 +1,32 @@
+#ifndef __BACKPORT_LINUX_TIME_H
+#define __BACKPORT_LINUX_TIME_H
+#include_next <linux/time.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+/* Map the ktime_t to timespec conversion to ns_to_timespec function */
+#define ktime_to_timespec(kt)		ns_to_timespec((kt).tv64)
+
+/* Map the ktime_t to timespec conversion to ns_to_timespec function */
+#define ktime_to_timespec64(kt)		ns_to_timespec64((kt).tv64)
+
+/* Map the ktime_t to timeval conversion to ns_to_timeval function */
+#define ktime_to_timeval(kt)		ns_to_timeval((kt).tv64)
+
+/* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
+#define ktime_to_ns(kt)			((kt).tv64)
+
+#define timespec64_equal		timespec_equal
+#define timespec64_compare		timespec_compare
+#define set_normalized_timespec64	set_normalized_timespec
+#define timespec64_add_safe		timespec_add_safe
+#define timespec64_add			timespec_add
+#define timespec64_sub			timespec_sub
+#define timespec64_valid		timespec_valid
+#define timespec64_valid_strict		timespec_valid_strict
+#define timespec64_to_ns		timespec_to_ns
+#define ns_to_timespec64		ns_to_timespec
+#define timespec64_add_ns		timespec_add_ns
+#define timespec64			timespec
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) */
+
+#endif /* __BACKPORT_LINUX_TIME_H */
-- 
2.1.0

