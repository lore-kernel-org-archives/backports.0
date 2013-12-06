Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53518 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab3LFSaG (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 6 Dec 2013 13:30:06 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so1037539wgh.14
        for <backports@vger.kernel.org>; Fri, 06 Dec 2013 10:30:04 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Felix Fietkau <nbd@openwrt.org>,
	John Stultz <johnstul@us.ibm.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 2/3] backports: backport getrawmonotonic() with do_posix_clock_monotonic_gettime()
Date: Fri,  6 Dec 2013 19:29:29 +0100
Message-Id: <1386354570-23940-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20131206_193008_341264_A3F8D83E)
In-Reply-To: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
References: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We cannot properly backport getrawmonotonic() as it requires some
in-kernel changes which cannot be backported so the best thing we
can do is provide at least the monotonic time. This will only be
done as a compromise for kernels that didn't have getrawmonotonic()
which are kernels < 2.6.28, which hopefully we can just deprecate
completely soon. The example users which pushes us to backport this
is change via linux-next 09d8e315d for ath9k, titled:

"ath9k_hw: fix TSF save/restore around chip reset"

The original commit that added getrawmonotonic() was 2d42244ae.

mcgrof@cerro ~/linux-next (git::master)$ git describe --contains 2d42244ae
v2.6.28-rc1~82^2~1

commit 2d42244ae71d6c7b0884b5664cf2eda30fb2ae68
Author: John Stultz <johnstul@us.ibm.com>
Date:   Wed Aug 20 16:37:30 2008 -0700

    clocksource: introduce CLOCK_MONOTONIC_RAW

    In talking with Josip Loncaric, and his work on clock synchronization (see
    btime.sf.net), he mentioned that for really close synchronization, it is
    useful to have access to "hardware time", that is a notion of time that is
    not in any way adjusted by the clock slewing done to keep close time sync.

    Part of the issue is if we are using the kernel's ntp adjusted
    representation of time in order to measure how we should correct time, we
    can run into what Paul McKenney aptly described as "Painting a road using
    the lines we're painting as the guide".

    I had been thinking of a similar problem, and was trying to come up with a
    way to give users access to a purely hardware based time representation
    that avoided users having to know the underlying frequency and mask values
    needed to deal with the wide variety of possible underlying hardware
    counters.

    My solution is to introduce CLOCK_MONOTONIC_RAW.  This exposes a
    nanosecond based time value, that increments starting at bootup and has no
    frequency adjustments made to it what so ever.

    The time is accessed from userspace via the posix_clock_gettime() syscall,
    passing CLOCK_MONOTONIC_RAW as the clock_id.

    Signed-off-by: John Stultz <johnstul@us.ibm.com>
    Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

Cc: Felix Fietkau <nbd@openwrt.org>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/time.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
index 0bc12de..efda485 100644
--- a/backport/backport-include/linux/time.h
+++ b/backport/backport-include/linux/time.h
@@ -3,6 +3,10 @@
 #include_next <linux/time.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
+#define getrawmonotonic(ts) do_posix_clock_monotonic_gettime(ts)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
 /*
  * Similar to the struct tm in userspace <time.h>, but it needs to be here so
-- 
1.8.4.3

