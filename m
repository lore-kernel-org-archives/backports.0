Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38345 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcEOGZo (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 15 May 2016 02:25:44 -0400
Received: by mail-ig0-f172.google.com with SMTP id m9so27267335ige.1
        for <backports@vger.kernel.org>; Sat, 14 May 2016 23:25:43 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 15 May 2016 09:25:43 +0300
Message-ID: <CANUX_P1i8MYwsbcnvjbqrHZ77aMOZHZ6ug3VzHvn=3pUU_czyw@mail.gmail.com> (sfid-20160515_082547_385567_1B073874)
Subject: wireless_nlevent_flush backported to stable kernels
From: Emmanuel Grumbach <egrumbach@gmail.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

Johanne's patch:

commit cb150b9d23be6ee7f3a0fff29784f1c5b5ac514d
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Wed Jan 27 13:29:34 2016 +0100

    cfg80211/wext: fix message ordering


has been backported to more stable kernels and hence backport needs to
take that into account.
I am using Ubuntu's wily kernel (4.2 based) and apparently, they
backported Johanne's fix as well.

On my system, I fixed it with the patch below, but it is surely not good enough.

diff --git a/backport-include/net/iw_handler.h
b/backport-include/net/iw_handler.h
index e205d1e..b9c0144 100644
--- a/backport-include/net/iw_handler.h
+++ b/backport-include/net/iw_handler.h
@@ -25,7 +25,8 @@ iwe_stream_add_point_check(struct iw_request_info
*info, char *stream,
        return res;
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,6)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,6) &&      \
+    LINUX_VERSION_CODE < KERNEL_VERSION(4,1,21)
 static inline void wireless_nlevent_flush(void) {}
 #endif
 #endif /* __BACKPORT_IW_HANDLER_H */


Emmanuel Grumbach
egrumbach@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe backports" in
