Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50948 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRLw (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:52 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:29 +0300
Message-Id: <20180920112842.27198-2-luca@coelho.fi> (sfid-20180920_132852_170955_A44C90A5)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 01/14] backport: fix compilation with IPV6 not set
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

At least in some older kernel versions (e.g. 3.10), the tcp.h header
file is not implicitly included from other headers if CONFIG_IPV6 is
not set, so we need to include it in backport-4.4.c.  Also, there is
an IPv6 structure that is used, so we should ifdef it away when IPv6
is not enabled.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-4.4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
index 1c11a2064e53..7966e94928e7 100644
--- a/backport/compat/backport-4.4.c
+++ b/backport/compat/backport-4.4.c
@@ -15,6 +15,7 @@
 #include <linux/if_vlan.h>
 #include <linux/mm.h>
 #include <linux/skbuff.h>
+#include <linux/tcp.h>
 #include <net/ip.h>
 #include <net/tso.h>
 #include <asm/unaligned.h>
@@ -95,9 +96,14 @@ void tso_build_hdr(struct sk_buff *skb, char *hdr, struct tso_t *tso,
 		iph->tot_len = htons(size + hdr_len - mac_hdr_len);
 		tso->ip_id++;
 	} else {
+#ifdef CONFIG_IPV6
 		struct ipv6hdr *iph = (void *)(hdr + mac_hdr_len);
 
 		iph->payload_len = htons(size + tcp_hdrlen(skb));
+#else /* CONFIG_IPV6 */
+		/* tso->ipv6 should never be set if IPV6 is not enabeld */
+		WARN_ON(1);
+#endif /* CONFIG_IPV6 */
 	}
 	tcph = (struct tcphdr *)(hdr + skb_transport_offset(skb));
 	put_unaligned_be32(tso->tcp_seq, &tcph->seq);
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
