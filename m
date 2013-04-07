Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:63033 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161252Ab3DGCWf (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:35 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so2616063pab.8
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:34 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 7/9] compat: backport ASYNC_DOMAIN_EXCLUSIVE()
Date: Sat,  6 Apr 2013 19:22:00 -0700
Message-Id: <1365301322-19327-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042236_684798_2BA6F603)
In-Reply-To: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

For older kernels this is simply a matter of using
LIST_HEAD.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 2955b47d
v3.6-rc1~103^2~4

commit 2955b47d2c1983998a8c5915cb96884e67f7cb53
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Mon Jul 9 19:33:25 2012 -0700

    [SCSI] async: introduce 'async_domain' type

    This is in preparation for teaching async_synchronize_full() to sync all
    pending async work, and not just on the async_running domain.  This
    conversion is functionally equivalent, just embedding the existing list
    in a new async_domain type.

    The .registered attribute is used in a later patch to distinguish
    between domains that want to be flushed by async_synchronize_full()
    versus those that only expect async_synchronize_{full|cookie}_domain to
    be used for flushing.

    [jejb: add async.h to scsi_priv.h for struct async_domain]
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>
    Acked-by: Arjan van de Ven <arjan@linux.intel.com>
    Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Tested-by: Eldad Zack <eldad@fogrefinery.com>
    Signed-off-by: James Bottomley <JBottomley@Parallels.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.6.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/include/linux/compat-3.6.h b/backport/include/linux/compat-3.6.h
index 8fddd31..49f4d3b 100644
--- a/backport/include/linux/compat-3.6.h
+++ b/backport/include/linux/compat-3.6.h
@@ -9,6 +9,9 @@
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
 #include <linux/i2c.h>
+
+#define ASYNC_DOMAIN_EXCLUSIVE(_domain) LIST_HEAD(_domain)
+
 /* Unlocked flavor */
 #define __i2c_transfer LINUX_BACKPORT(__i2c_transfer)
 extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
-- 
1.7.10.4

