Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47889 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab3EKA1o (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:44 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so9435343iec.29
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:44 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 07/12] backports: enable the CONFIG_DRM_QXL driver on >= v3.3
Date: Fri, 10 May 2013 17:26:58 -0700
Message-Id: <1368232023-23817-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022745_798441_3EE4176D)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This provides a requirement of the new qxl DRM driver to
be available only on kernels >= 3.3. The requirement
comes from the usage of radix_tree_for_each_slot() that
this uses the new radix bit-optimized iterator added
via 78c1d7848 on 3.4. We backport this via the compat
module but only for v3.3 given that addressing this
backport for v3.2 requires addressing e2bdb933 which
changes the radix_tree_node.

qxl was added on next-20130415.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 78c1d7848
v3.4-rc2~15^2~26

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains e2bdb933
v3.3-rc1~81^2~8

Someone wishing to #ifdef this to enable qxl support on
v3.2 by using the old radix_tree_gang_lookup_slot()
can look at 0fc9d1040313047edf6a39fd4d7c7defdca97c62
as an example collateral evolution change.

commit f64122c1f6ade301585569863b4b3b18f6e4e332
Author: Dave Airlie <airlied@gmail.com>
Date:   Mon Feb 25 14:47:55 2013 +1000

    drm: add new QXL driver. (v1.4)

    QXL is a paravirtual graphics device used by the Spice virtual desktop
    interface.

    The drivers uses GEM and TTM to manage memory, the qxl hw fencing however
    is quite different than normal TTM expects, we have to keep track of a number
    of non-linear fence ids per bo that we need to have released by the hardware.

    The releases are freed from a workqueue that wakes up and processes the
    release ring.

    releases are suballocated from a BO, there are 3 release categories, drawables,
    surfaces and cursor cmds. The hw also has 3 rings for commands, cursor and release handling.

    The hardware also have a surface id tracking mechnaism and the driver
    encapsulates it completely inside the kernel, userspace never sees the actual hw sur
    ids.

    This requires a newer version of the QXL userspace driver, so shouldn't be
    enabled until that has been placed into your distro of choice.

    Authors: Dave Airlie, Alon Levy

    v1.1: fixup some issues in the ioctl interface with padding
    v1.2: add module device table
    v1.3: fix nomodeset, fbcon leak, dumb bo create, release ring irq,
          don't try flush release ring (broken hw), fix -modesetting.
    v1.4: fbcon cpu usage reduction + suitable accel flags.

    Signed-off-by: Alon Levy <alevy@redhat.com>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dependencies b/dependencies
index 5ae6bce..c85577c 100644
--- a/dependencies
+++ b/dependencies
@@ -47,6 +47,12 @@ MWIFIEX 2.6.27
 HDMI 3.2
 DRM 3.2
 DRM_TTM 3.2
+# See e2bdb933, this was added on v3.3, in order to
+# support DRM_QXL on 3.2 you'd have to backport 78c1d7848
+# to 3.2 on BACKPORT_BUILD_RADIX_HELPERS and that requires
+# taking into consideration the radix_tree_node rcu change
+# on e2bdb933.
+DRM_QXL 3.3
 
 # Regulator
 # Because of -EPROBE_DEFER see commit d1c3414c and note that
-- 
1.7.10.4

