Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:51822 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759254AbdKPOi6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 16 Nov 2017 09:38:58 -0500
From: Felix Fietkau <nbd@nbd.name>
To: backports@vger.kernel.org
Subject: [PATCH 3/4] backports: fix events with extack backport
Date: Thu, 16 Nov 2017 15:38:54 +0100
Message-Id: <20171116143855.12307-3-nbd@nbd.name> (sfid-20171116_153900_662092_C20D1167)
In-Reply-To: <20171116143855.12307-1-nbd@nbd.name>
References: <20171116143855.12307-1-nbd@nbd.name>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The multicast group offset needs to be synced after registering the
family, otherwise multicast messages will use the wrong id

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/compat/backport-4.12.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/backport-4.12.c b/backport/compat/backport-4.12.c
index f997b6c5..5e763084 100644
--- a/backport/compat/backport-4.12.c
+++ b/backport/compat/backport-4.12.c
@@ -224,6 +224,7 @@ int bp_extack_genl_register_family(struct genl_family *family)
 
 	/* copy this since the family might access it directly */
 	family->attrbuf = copy->family.attrbuf;
+	family->mcgrp_offset = copy->family.mcgrp_offset;
 
 	mutex_lock(&copies_mutex);
 	list_add_tail(&copy->list, &copies_list);
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
