Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50849 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161302Ab3DGCWX (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:23 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx1so2680543pab.28
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:22 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 4/9] compat: backport EPROBE_DEFER value
Date: Sat,  6 Apr 2013 19:21:57 -0700
Message-Id: <1365301322-19327-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042226_160596_57FC64C3)
In-Reply-To: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Grant added the ability to the driver core to return
EPROBE_DEFER at device driver probe time and for that to
trigger a later deferred probe through a workqueue. It
seems we could in theory backport this functionality but
that requires quite a bit of work. For now just pass on
the EPROBE_DEFER definition safely and for older kernels
than 3.4 the EPROBE_DEFER would be treated as a regular
probe error.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains d1c3414c
v3.4-rc1~187^2~10

commit d1c3414c2a9d10ef7f0f7665f5d2947cd088c093
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Mon Mar 5 08:47:41 2012 -0700

    drivercore: Add driver probe deferral mechanism

    Allow drivers to report at probe time that they cannot get all the resources
    required by the device, and should be retried at a later time.

    This should completely solve the problem of getting devices
    initialized in the right order.  Right now this is mostly handled by
    mucking about with initcall ordering which is a complete hack, and
    doesn't even remotely handle the case where device drivers are in
    modules.  This approach completely sidesteps the issues by allowing
    driver registration to occur in any order, and any driver can request
    to be retried after a few more other drivers get probed.

    v4: - Integrate Manjunath's addition of a separate workqueue
        - Change -EAGAIN to -EPROBE_DEFER for drivers to trigger deferral
        - Update comment blocks to reflect how the code really works
    v3: - Hold off workqueue scheduling until late_initcall so that the bulk
          of driver probes are complete before we start retrying deferred devices.
        - Tested with simple use cases.  Still needs more testing though.
          Using it to get rid of the gpio early_initcall madness, or to replace
          the ASoC internal probe deferral code would be ideal.
    v2: - added locking so it should no longer be utterly broken in that regard
        - remove device from deferred list at device_del time.
        - Still completely untested with any real use case, but has been
          boot tested.

    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Dilan Lee <dilee@nvidia.com>
    Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
    Cc: Alan Stern <stern@rowland.harvard.edu>
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
    Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Acked-by: David Daney <david.daney@cavium.com>
    Reviewed-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.4.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/include/linux/compat-3.4.h b/backport/include/linux/compat-3.4.h
index 01a72b7..2a53cef 100644
--- a/backport/include/linux/compat-3.4.h
+++ b/backport/include/linux/compat-3.4.h
@@ -11,6 +11,8 @@
 #include <linux/kconfig.h>
 #endif
 
+#define EPROBE_DEFER   517     /* Driver requests probe retry */
+
 /*
  * defined here to allow things to compile but technically
  * using this for memory regions will yield in a no-op on newer
-- 
1.7.10.4

