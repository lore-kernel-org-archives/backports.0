Return-path: <backports-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45782 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751822AbeD3LQG (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 30 Apr 2018 07:16:06 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: backports@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH 3/3] backport-include: deal with struct sock::sk_pacing_shift
Date: Mon, 30 Apr 2018 13:15:46 +0200
Message-Id: <1525086946-6352-4-git-send-email-arend.vanspriel@broadcom.com> (sfid-20180430_131607_532140_220152AC)
In-Reply-To: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 4.15 the field sk_pacing_shift was introduced to allow
(wifi) drivers to change the behaviour of TSQ. In 4.16 a helper
function was added which mac80211 is using. So backport the helper
which is just a stub for kernels prior to 4.15.

Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
As noted in the commit message this patch makes the helper function
an empty stub for kernels prior to 4.15, which introduced the field
sk_pacing_shift. Maybe it would be possible to accomplish similar
thing by modifying struct sk_buff::true_size, but I am not too familiar
with TSQ so I did not go there.

Regards,
Arend
---
 backport/backport-include/net/sock.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 89191f3..39bf008 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -63,4 +63,16 @@ static inline void sk_clear_bit(int nr, struct sock *sk)
 }
 #endif /* < 4.5 */
 
+#if LINUX_VERSION_IS_LESS(4,16,0)
+#define sk_pacing_shift_update LINUX_BACKPORT(sk_pacing_shift_update)
+static inline void sk_pacing_shift_update(struct sock *sk, int val)
+{
+#if LINUX_VERSION_IS_GEQ(4,15,0)
+	if (!sk || !sk_fullsock(sk) || sk->sk_pacing_shift == val)
+		return;
+	sk->sk_pacing_shift = val;
+#endif /* >= 4.15 */
+}
+#endif /* < 4.16 */
+
 #endif /* __BACKPORT_NET_SOCK_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
