Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:54051 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBez (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:34:55 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6057384pbc.21
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:34:55 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Arik Nemtsov <arik@wizery.com>,
	Arik Nemtsov <arikx.nemtsov@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 03/10] backports: device: don't redefine DEVICE_ATTR_RO
Date: Fri, 11 Apr 2014 18:34:28 -0700
Message-Id: <1397266475-14442-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033457_346870_4B6ECDC9)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Arik Nemtsov <arik@wizery.com>

Some old custom kernels have it defined.

Signed-off-by: Arik Nemtsov <arikx.nemtsov@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index ebfc01a..a54756a 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -193,8 +193,10 @@ backport_device_release_driver(struct device *dev)
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#ifndef DEVICE_ATTR_RO
 #define DEVICE_ATTR_RO(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
+#endif
 #define DEVICE_ATTR_RW(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RW(_name)
 #endif
-- 
1.9.1

