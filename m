Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56145 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757293AbcGJVO7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/19] header: add empty for_each_child_of_node()
Date: Sun, 10 Jul 2016 23:14:34 +0200
Message-Id: <1468185285-28265-9-git-send-email-hauke@hauke-m.de> (sfid-20160710_231504_671004_F791B6EB)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by bcma driver and was added to mainline kernel in
commit aba3dfff9a "dt: add empty for_each_child_of_node,
of_find_property".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/of.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 8089803..1a38034 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -199,4 +199,9 @@ static inline const char* of_node_full_name(const struct device_node *np)
 #endif /* CONFIG_OF */
 #endif /* < 3.6 */
 
+#ifndef for_each_child_of_node
+#define for_each_child_of_node(parent, child) \
+	while (0)
+#endif
+
 #endif	/* _COMPAT_LINUX_OF_H */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
