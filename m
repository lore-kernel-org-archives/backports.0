Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A351A38C5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532136; cv=none; b=YM2aVGC2b7v2A8bx8OlJxp6V+5611f9nXUbz3D+F/1mclOAQNpueNwRVkNHZcvDyIGBpKJbOaEsx3ALKhhv7kWF5NjDVA+U2XnB0BfyZl4yOsN1ftLp3bpNqLjhQstoc16yh1WHhOMa5rlrU6ZwOqvvA0sHEa8/UtuQGSato4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532136; c=relaxed/simple;
	bh=9RmQM6XDh3gItE5+ntrAJs997NP2JC5I+bEgXY5RPTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuFH+xX5dvmF7MbAnATJW3FuLChkDaHNdb25wpC16lBe+04youSxH1S17Ymwkla+mrA4eB9wAuFgfaDEEr9tUfydnniwm2yWGC6liUmerQvBYdFsljUefMs29+E2J5pcYqjkpljP43Bxx1mGqKTGpB5Bh/TPhXAm623g85dmSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=hUDKJ+fV; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="hUDKJ+fV"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdV5gYpz9srJ;
	Fri, 28 Jun 2024 01:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3KEUr9CGfr1tziCj0g/zRUiTougI1Z1ohVONscMzCw=;
	b=hUDKJ+fVyu6VQr6YRwXQuyMrGIQ3t3oou9my5NLuybzsL4azvn3WWNzoZzWAFImBSTrnDg
	qhWRJc6rQ9Ih9pLmdIIz9E4tagn5//e6RF+3zhi4xhPBFtzF6Hi4USC0qJ8cY/hbsLbbV1
	SXv5dP8NHHCsCa4skHf3K5qTMQj9wLz0uPHfuU4nym0nltAKkx6PEUHaVenXUU5Z0aFTWz
	RSd/Tn1jEdbymuK4YEabQvIfyLe9mpkf78Kdq70O9kEduPZzvdE+CbvtE6cIWEwVwWikON
	A1mipCXzYw10iMbkIPxIipBySGg+M8wiQ2yBTKZiuW7u//Hxc34IbGhx2iCA8Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 26/75] backports: add skb_get_dsfield()
Date: Fri, 28 Jun 2024 01:47:12 +0200
Message-ID: <20240627234808.1253337-27-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdV5gYpz9srJ

From: Johannes Berg <johannes.berg@intel.com>

That may also require skb_protocol() and skb_vlan_tag_present()

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/inet_ecn.h | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 backport/backport-include/net/inet_ecn.h

diff --git a/backport/backport-include/net/inet_ecn.h b/backport/backport-include/net/inet_ecn.h
new file mode 100644
index 00000000..df83d3e1
--- /dev/null
+++ b/backport/backport-include/net/inet_ecn.h
@@ -0,0 +1,66 @@
+#ifndef __BACKPORT_NET_INET_ECN_H
+#define __BACKPORT_NET_INET_ECN_H
+#include_next <net/inet_ecn.h>
+#include <linux/version.h>
+#include <linux/if_vlan.h>
+
+#ifndef skb_vlan_tag_present
+#define skb_vlan_tag_present(__skb)       ((__skb)->vlan_present)
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,7,10) &&			\
+	!LINUX_VERSION_IN_RANGE(4,14,212, 4,15,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,19,134, 4,20,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,4,248, 4,5,0) &&	\
+	!LINUX_VERSION_IN_RANGE(4,9,248, 4,10,0) &&	\
+	!LINUX_VERSION_IN_RANGE(5,4,53, 5,5,0)
+/* A getter for the SKB protocol field which will handle VLAN tags consistently
+ * whether VLAN acceleration is enabled or not.
+ */
+static inline __be16 skb_protocol(const struct sk_buff *skb, bool skip_vlan)
+{
+	unsigned int offset = skb_mac_offset(skb) + sizeof(struct ethhdr);
+	__be16 proto = skb->protocol;
+
+	if (!skip_vlan)
+		/* VLAN acceleration strips the VLAN header from the skb and
+		 * moves it to skb->vlan_proto
+		 */
+		return skb_vlan_tag_present(skb) ? skb->vlan_proto : proto;
+
+	while (eth_type_vlan(proto)) {
+		struct vlan_hdr vhdr, *vh;
+
+		vh = skb_header_pointer(skb, offset, sizeof(vhdr), &vhdr);
+		if (!vh)
+			break;
+
+		proto = vh->h_vlan_encapsulated_proto;
+		offset += sizeof(vhdr);
+	}
+
+	return proto;
+}
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,16,0)
+#define skb_get_dsfield LINUX_BACKPORT(skb_get_dsfield)
+static inline int skb_get_dsfield(struct sk_buff *skb)
+{
+	switch (skb_protocol(skb, true)) {
+	case cpu_to_be16(ETH_P_IP):
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			break;
+		return ipv4_get_dsfield(ip_hdr(skb));
+
+	case cpu_to_be16(ETH_P_IPV6):
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			break;
+		return ipv6_get_dsfield(ipv6_hdr(skb));
+	}
+
+	return -1;
+}
+#endif
+
+#endif /* __BACKPORT_NET_INET_ECN_H */
-- 
2.45.2

