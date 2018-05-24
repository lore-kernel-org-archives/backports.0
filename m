Return-path: <backports-owner@vger.kernel.org>
Received: from mail-he1eur01on0103.outbound.protection.outlook.com ([104.47.0.103]:45289
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032640AbeEXK5t (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 24 May 2018 06:57:49 -0400
From: Aaron Komisar <aaron.komisar@tandemg.com>
To: backports@vger.kernel.org
Cc: Aaron Komisar <aaron.komisar@tandemg.com>
Subject: [PATCH] Updating id field in backports genl family
Date: Thu, 24 May 2018 13:57:33 +0300
Message-Id: <1527159453-30360-1-git-send-email-aaron.komisar@tandemg.com> (sfid-20180524_125959_621827_68822A27)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Family ID from the original family struct will be used when building
genl messages (sent as nlmsg_type), so the new id should be updated in
the original (older kernel format) family struct too

Signed-off-by: Aaron Komisar <aaron.komisar@tandemg.com>
---
 backport/compat/backport-4.12.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/compat/backport-4.12.c b/backport/compat/backport-4.12.c
index 2372a11..4948b53 100644
--- a/backport/compat/backport-4.12.c
+++ b/backport/compat/backport-4.12.c
@@ -225,6 +225,13 @@ int bp_extack_genl_register_family(struct genl_family *family)
 	/* copy this since the family might access it directly */
 	family->id = copy->family.id;
 	family->attrbuf = copy->family.attrbuf;
+
+	/* family ID from the original family struct will be used when building
+	 * genl messages (sent as nlmsg_type), so the new id should be updated
+	 * in the original (older kernel format) family struct too
+	 */
+	family->family.id = copy->family.id;
+
 #if LINUX_VERSION_IS_GEQ(3,13,0)
 	family->mcgrp_offset = copy->family.mcgrp_offset;
 #endif
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
