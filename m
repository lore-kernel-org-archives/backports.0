Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:58074 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbdKTSBe (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 20 Nov 2017 13:01:34 -0500
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Subject: [PATCH] backports: fix nlmsg_type on responses with extack backport
Date: Mon, 20 Nov 2017 19:01:32 +0100
Message-Id: <20171120180132.12531-1-nbd@nbd.name> (sfid-20171120_190138_725650_9A898143)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is filled with family->id, which needs to be set after registering
the copy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/compat/backport-4.12.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/backport-4.12.c b/backport/compat/backport-4.12.c
index b9b1d64e..2372a118 100644
--- a/backport/compat/backport-4.12.c
+++ b/backport/compat/backport-4.12.c
@@ -223,6 +223,7 @@ int bp_extack_genl_register_family(struct genl_family *family)
 	}
 
 	/* copy this since the family might access it directly */
+	family->id = copy->family.id;
 	family->attrbuf = copy->family.attrbuf;
 #if LINUX_VERSION_IS_GEQ(3,13,0)
 	family->mcgrp_offset = copy->family.mcgrp_offset;
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
