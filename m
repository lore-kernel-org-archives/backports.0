Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63413 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab3DJLgN (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:13 -0400
Received: by mail-pb0-f52.google.com with SMTP id mc8so218351pbc.25
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 08/18] compat: backport dev_get_regmap()
Date: Wed, 10 Apr 2013 04:35:18 -0700
Message-Id: <1365593728-5720-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133616_052163_D93E260A)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We can't backport dev_get_regmap() unless we backport regmap
fully onto compat, but users typically try to get the regmap in
other ways first:

        if (config->regmap)
                rdev->regmap = config->regmap;
        else if (dev_get_regmap(dev, NULL))
                rdev->regmap = dev_get_regmap(dev, NULL);
        else if (dev->parent)
                rdev->regmap = dev_get_regmap(dev->parent, NULL);

So this would option would just not be available for.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 72b39f6f
v3.5-rc1~117^2~7^3

commit 72b39f6f2b5a6b0beff14b80bed9756f151218a9
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Tue May 8 17:44:40 2012 +0100

    regmap: Implement dev_get_regmap()

    Use devres to implement dev_get_regmap(). This should mean that in almost
    all cases devices wishing to take advantage of framework features based on
    regmap shouldn't need to explicitly pass the regmap into the framework.
    This simplifies device setup a bit.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.5.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/include/linux/compat-3.5.h b/backport/include/linux/compat-3.5.h
index 1515a5b..e21048d 100644
--- a/backport/include/linux/compat-3.5.h
+++ b/backport/include/linux/compat-3.5.h
@@ -11,6 +11,15 @@
 #include <net/netlink.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#include <linux/regmap.h>
+
+#define dev_get_regmap LINUX_BACKPORT(dev_get_regmap)
+static inline
+struct regmap *dev_get_regmap(struct device *dev, const char *name)
+{
+	return NULL;
+}
+
 #define devres_release LINUX_BACKPORT(devres_release)
 extern int devres_release(struct device *dev, dr_release_t release,
 			  dr_match_t match, void *match_data);
-- 
1.7.10.4

