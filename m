Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41373 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaGQUOx (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Jul 2014 16:14:53 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so3714058pde.4
        for <backports@vger.kernel.org>; Thu, 17 Jul 2014 13:14:53 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: make regulator palmas driver depend on v3.15
Date: Thu, 17 Jul 2014 13:14:47 -0700
Message-Id: <1405628087-10679-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140717_221456_339494_32BA544B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The regulator palmas driver makes use of the new struct regulator_desc
enable_val and disable_val added via commit ca5d1b352 on v3.15 to help
overcome an issue on assumptions on how regulator drivers enable /
disable the regulator with only one value / mask. We can't port this
so just require at least v3.15 for it.

mcgrof@ergon ~/linux (git::master)$ git describe --contains ca5d1b352
v3.15-rc1~148^2~4^3

commit ca5d1b3524b4d90a2e2f1f71583c1dca6b96fd92
Author: Carlo Caione <carlo@caione.org>
Date:   Wed Mar 5 22:11:29 2014 +0100

    regulator: helpers: Modify helpers enabling multi-bit control

    This patch extends the regulator helpers to account for device that use
    multiple bits for control when using regmap enable/disable/bypass ops.

    The actual regulator helpers wrongly assume that the regulator control
    is always performed using single bits, using in the regulator_desc
    struct only two parameters *_reg and *_mask defining register and mask
    for control.

    This patch extends this struct and introduces the helpers to take into
    account devices where control is performed using multiple bits and
    specific multi-bit values are used for enabling/disabling/bypassing the
    regulator.

    Signed-off-by: Carlo Caione <carlo@caione.org>
    Signed-off-by: Mark Brown <broonie@linaro.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 2888bec..c38098c 100644
--- a/dependencies
+++ b/dependencies
@@ -50,7 +50,7 @@ REGULATOR_MAX14577 3.16
 REGULATOR_MC13783 3.6
 REGULATOR_MC13892 3.6
 REGULATOR_MC13XXX_CORE 3.6
-REGULATOR_PALMAS 3.12
+REGULATOR_PALMAS 3.15
 REGULATOR_PCAP 3.6
 REGULATOR_PCF50633 3.8
 REGULATOR_PFUZE100 3.6
-- 
1.9.1

