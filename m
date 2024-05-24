Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3012F368
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570602; cv=none; b=f0ysPHjhGYm5bXSzdbExb5xNkNdvWrY6o3DQQdLN2KCIQZua+2NlqmOvGIGnvOk6kl0YWmS2K/MqAdDgksmSCrMrlOeBBxvQ6pqi0/GJptMwYeUgs4U2zC9CYVEb4zF1Kbtyij4dLa/vdLu5Mp2/16lUaqzo0NIoBnvrEVACCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570602; c=relaxed/simple;
	bh=PIHsxp865AdLGUrIcU+XTaD9fz66OPOJWMjRB2Y+Ls8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRtoHVdW/YNjAGnazeYlOqU0uCjvAmBasN03f3mAlI/VEuDWg3CiXVK1xxhA8K4udvmAZ7Q7K/2f3Q8Hm4iUk9TWzcluYxDX5l2UdS7/oLskZWgnzitkI9vcTV0nJ6uYxwIQvZQZOYsENKbtShyg7mMgpE5h873/f4m/QbHe7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=joCOEvGV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="joCOEvGV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b4W+STmQLXNKMoVznW9RPzBQCdllgJuGZO4Ga+3EcoU=;
	t=1716570601; x=1717780201; b=joCOEvGVr9nSy2ehgcF1wTlc+XMBOIuWIsus7asUCDunCt2
	0T62HO+bi9D9seQx/vQ733DyL6GNY4mVTmgKqFgIw586nB8qg26Q5BPKcPTleZCG1dKBqQ2w7mt8R
	SQa3ik5vogxAy7tn4tX1qnuLMe1lL0y9UFV+l1PMaX6LUvojlIf3GURDAugQOjBwo1Db6jhkw6T/v
	YN+kH+Oqh4XG9YZrFGHDOG2C7s/vFAuRxkROnG7WxtWJpzQrF9bml6OGLZyXslYq8iNO7aYivGnb6
	Z3WtLYUfu68uyyQNt+9aETOqQPTxBRdWScoNHhkZ468LWwGfoyGOhQJH0XJu0xag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQY-00000008Xuw-0Im1;
	Fri, 24 May 2024 19:09:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 46/74] backports: add skb_get_dsfield()
Date: Fri, 24 May 2024 19:07:58 +0200
Message-ID: <20240524190907.d09ab5d1bfb6.Ia5da0970fd85b5844c99eae51c822dbe1e4ec81c@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

That may also require skb_protocol() and skb_vlan_tag_present()

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/inet_ecn.h | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 backport/backport-include/net/inet_ecn.h

diff --git a/backport/backport-include/net/inet_ecn.h b/backport/backport-include/net/inet_ecn.h
new file mode 100644
index 000000000000..df83d3e179ec
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
2.45.1

