Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:50410 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab3DMOOE (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 10:14:04 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so1844371pde.18
        for <backports@vger.kernel.org>; Sat, 13 Apr 2013 07:14:03 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/7] compat: backport IORESOURCE_REG definition
Date: Sat, 13 Apr 2013 07:13:40 -0700
Message-Id: <1365862424-6530-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161406_250570_6E2153E7)
In-Reply-To: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This was added to help regmap drivers avoid having
to use some non memory mapped equivalent, IORESOURCE_IO,
to help avoid confusion. This is simply carried over.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 72dcb119
v3.7-rc1~112^2~84

commit 72dcb1197228b50bfb709ba97c2d53013c605868
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Tue Aug 7 19:42:45 2012 +0100

    resources: Add register address resource type

    Currently a bunch of I2C/SPI MFD drivers are using IORESOURCE_IO for
    register address ranges. Since this causes some confusion due to the
    primary use of this resource type for PCI/ISA I/O ports create a new
    resource type IORESOURCE_REG.

    Unfortunately the current resource types are specified as bitmasks and
    there are no free bitmasks even though they really shouldn't be used as
    such so we define the new type as IORESOURCE_IO | IORESOURCE_MEM.
    Benjamin Herrenschmidt and Russell King have both verified that none of
    the users in this series will have a problem with this, and no new code
    should be affected.

    This patch was written by Russell King but he found himself unable to
    take the patch further.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
    Tested-by: Haojian Zhuang <haojian.zhuang@gmail.com>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/include/linux/compat-3.7.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/include/linux/compat-3.7.h b/backport/include/linux/compat-3.7.h
index 96662e3..c7a4ebc 100644
--- a/backport/include/linux/compat-3.7.h
+++ b/backport/include/linux/compat-3.7.h
@@ -17,6 +17,8 @@
 
 #define VM_DONTDUMP    VM_NODUMP
 
+#define IORESOURCE_REG	0x00000300	/* Register offsets */
+
 #ifdef CONFIG_USER_NS
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
-- 
1.7.10.4

