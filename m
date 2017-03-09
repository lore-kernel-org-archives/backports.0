Return-path: <backports-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:43465 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932332AbdCINFd (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 9 Mar 2017 08:05:33 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/4] backports: add backport for idr_remove
Date: Thu,  9 Mar 2017 12:57:31 +0000
Message-Id: <1489064253-3652-3-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140610_090838_BA14C134)
In-Reply-To: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit d3e709e63e97 ("idr: Return the deleted entry from
idr_remove") the function signature changed so provide a backport
which does a idr_find() and subsequent idr_remove().

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi Johannes,

Not sure if the find/remove approach is a good one here. Better solutions
are welcome.

Regards,
Arend
---
 backport/backport-include/linux/idr.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/idr.h b/backport/backport-include/linux/idr.h
index d7cf9f0..01aa2c2 100644
--- a/backport/backport-include/linux/idr.h
+++ b/backport/backport-include/linux/idr.h
@@ -61,4 +61,14 @@ static inline void idr_preload_end(void)
 	for (id = 0; ((entry) = idr_get_next(idp, &(id))) != NULL; ++id)
 #endif

+#if LINUX_VERSION_IS_LESS(4, 11, 0)
+static inline void *backport_idr_remove(struct idr *idr, int id)
+{
+	void *item = idr_find(idr, id);
+	idr_remove(idr, id);
+	return item;
+}
+#define idr_remove	backport_idr_remove
+#endif
+
 #endif /* __BACKPORT_IDR_H */
--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
