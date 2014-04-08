Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48531 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbaDHDdV (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:33:21 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so384500pdj.6
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:33:20 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	James Hogan <james.hogan@imgtec.com>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Mark Brown <broonie@linaro.org>
Subject: [PATCH 11/12] backports: add kernel base requirement of 3.5 to IR_IMG
Date: Mon,  7 Apr 2014 20:32:22 -0700
Message-Id: <1396927943-25589-12-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053322_823710_DE4CD0D6)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

IR_IMG is a new driver added by James via 160a8f8a and letter
integrated into the build via commit 54b29120 as of linux-next
tag next-20140320 which may make it to Linux through v3.15. This
new driver makes use of devm_clk_get() but this was added via
a8a97db9 and that get merged as of v3.5. It seems we can easily
backport a8a97db9 but these days I'm starting to leave this up to the
folks interested in the drivers to choose / participate and only
they would know if this is worth it. Is 3.5 a good starting point
kernel to require for drivers which depend on the new clock APIs?

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains a8a97db9
v3.5-rc1~183^2~2

Cc: James Hogan <james.hogan@imgtec.com>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Mark Brown <broonie@linaro.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 3729d30..36c0b87 100644
--- a/dependencies
+++ b/dependencies
@@ -254,3 +254,5 @@ IEEE802154_MRF24J40 3.5
 IEEE802154 3.1
 IEEE802154_6LOWPAN 3.5
 IEEE802154_AT86RF230 3.3
+
+IR_IMG 3.5
-- 
1.8.5.3

