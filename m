Return-path: <backports-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:54408
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752543AbcBHKmR (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Feb 2016 05:42:17 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backport: add empty inline for wireless_nlevent_flush()
Date: Mon,  8 Feb 2016 11:42:15 +0100
Message-Id: <1454928135-8154-1-git-send-email-arend@broadcom.com> (sfid-20160208_114226_341591_0D740BD4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The function was added in v4.5 kernel. As it can not be backported
it is provided for older kernels as an empty inline.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Not sure whether LINUX_BACKPORT() macro should be used. Let me
know if that is needed.

Regards,
Arend
---
 backport/backport-include/net/iw_handler.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index 11135c8..03a4fd1 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -25,4 +25,7 @@ iwe_stream_add_point_check(struct iw_request_info *info, char *stream,
 	return res;
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+static inline void wireless_nlevent_flush(void) {}
+#endif
 #endif /* __BACKPORT_IW_HANDLER_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
