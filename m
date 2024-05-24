Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C9376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570586; cv=none; b=UnP1mmACQ8n0UjgHSJLPIOM3C48z9EYrPxmoT0aIWnPQ2Z+JIeY81jHzDfVoH04IBq2Er+XNuX0gDNxxOcGr8nonggXSqXYr2Quo9/2MBu8TugxWjvI/vVkqEOiaXseHM7KeWGTuvEqESzJlxBqxZiIRq3+WxPaPQRa4H2yQntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570586; c=relaxed/simple;
	bh=anqTfcf1zWdVexi+iwjrg4XjrVEmbEkm4cT8dNPiwLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt0MLzhO1eGdseb6YzIVnxq9gv0pk0Lg/kCM8SvSCwQ7/blOOldzJf2xRv9Eu2UAtydFIv1ddD8kyjxUpTCPL+LbTSKHtGiUTtAdJp4B4J4x/JMkOBJoNcFxVZyQCiFr6iz8bCPuB0fJso7kp7GRo8fpUgKCt3WksB9Dbmh0j1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UW6zqmJ9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UW6zqmJ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3DEWumzBFui8f8LaDQSMc/2S/tt67EZZNWRHzmaq0vw=;
	t=1716570584; x=1717780184; b=UW6zqmJ9y0abvuAcUUg0fSzwlpftb/xdapnitBlQgRSCoKT
	lclbMJ2Zm4Q+FYUCQHew2D+oVQ0rvh6vtmaHKRaWA9uDXasV9G8K9Nmf5Eqe36X7lf/dOUSWZzPyQ
	qncgKQU+TiFwBccdXJv5sciZlBF/kglDu+olBTGmE38F2nqr1PXS+02eT+Y56w0oiyqo8WZmZln5u
	6NjfA3Sv3jFr4fgYaeX6P9BNAwsBCMoDxjpQnhJhE3SaJj+dNSgDpv7p0fpqjB1KVfexlitjOdIvA
	0yK3gKqLOOht+UwObKWp3FM+7WCrFIPtQO0h1/4tHq5oXSLSnu3DLvMrbBsVoOeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQH-00000008Xuw-3Ya2;
	Fri, 24 May 2024 19:09:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 34/74] backport: fix dropreason handling
Date: Fri, 24 May 2024 19:07:46 +0200
Message-ID: <20240524190907.5870f67925c4.If8aac2d9d3c4fb7a22eed3e4ca6fd8fbaf0cdcd1@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h   |  10 +-
 backport/backport-include/net/dropreason.h | 327 +++------------------
 2 files changed, 42 insertions(+), 295 deletions(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 909f0a9d63c0..bc4d5e5450a5 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -76,11 +76,17 @@ static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(6,4,0)
+static inline void
+LINUX_BACKPORT(kfree_skb_reason)(struct sk_buff *skb, u32 reason)
+{
 #if LINUX_VERSION_IS_LESS(5,17,0)
-static inline void kfree_skb_reason(struct sk_buff *skb, u32 reason)
-{
 	dev_kfree_skb(skb);
+#else
+	kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+#endif
 }
+#define kfree_skb_reason LINUX_BACKPORT(kfree_skb_reason)
 #endif
 
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/net/dropreason.h b/backport/backport-include/net/dropreason.h
index d35187af1547..c0855503c04f 100644
--- a/backport/backport-include/net/dropreason.h
+++ b/backport/backport-include/net/dropreason.h
@@ -1,27 +1,34 @@
 #ifndef __BACKPORT_DROPREASON_H
 #define __BACKPORT_DROPREASON_H
 
+#if LINUX_VERSION_IS_GEQ(6,0,0)
+#include_next <net/dropreason.h>
+#else
+#include <linux/skbuff.h>
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+#define SKB_DROP_REASON_MAX	1
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,18,0)
+/*
+ * Same as SKB_DROP_REASON_NOT_SPECIFIED on some kernels,
+ * but that's OK since we won't report these reasons to
+ * the kernel anyway until 6.4, see kfree_skb_reason().
+ */
+#define SKB_NOT_DROPPED_YET	0
+#endif
+
+#if LINUX_VERSION_IS_LESS(6,2,0)
+#define SKB_CONSUMED		(SKB_DROP_REASON_MAX + 1)
+#endif
+
 #if LINUX_VERSION_IS_LESS(6,4,0)
-/**
- * enum skb_drop_reason_subsys - subsystem tag for (extended) drop reasons
- */
 enum skb_drop_reason_subsys {
-	/** @SKB_DROP_REASON_SUBSYS_CORE: core drop reasons defined above */
 	SKB_DROP_REASON_SUBSYS_CORE,
-
-	/**
-	 * @SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE: mac80211 drop reasons
-	 * for unusable frames, see net/mac80211/drop.h
-	 */
 	SKB_DROP_REASON_SUBSYS_MAC80211_UNUSABLE,
-
-	/**
-	 * @SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR: mac80211 drop reasons
-	 * for frames still going to monitor, see net/mac80211/drop.h
-	 */
 	SKB_DROP_REASON_SUBSYS_MAC80211_MONITOR,
-
-	/** @SKB_DROP_REASON_SUBSYS_NUM: number of subsystems defined */
 	SKB_DROP_REASON_SUBSYS_NUM
 };
 
@@ -30,283 +37,17 @@ struct drop_reason_list {
 	size_t n_reasons;
 };
 
-/**
- * enum skb_drop_reason - the reasons of skb drops
- *
- * The reason of skb drop, which is used in kfree_skb_reason().
- */
-enum skb_drop_reason {
-	/**
-	 * @SKB_NOT_DROPPED_YET: skb is not dropped yet (used for no-drop case)
-	 */
-	SKB_NOT_DROPPED_YET = 0,
-	/** @SKB_CONSUMED: packet has been consumed */
-	SKB_CONSUMED,
-	/** @SKB_DROP_REASON_NOT_SPECIFIED: drop reason is not specified */
-	SKB_DROP_REASON_NOT_SPECIFIED,
-	/** @SKB_DROP_REASON_NO_SOCKET: socket not found */
-	SKB_DROP_REASON_NO_SOCKET,
-	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
-	SKB_DROP_REASON_PKT_TOO_SMALL,
-	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
-	SKB_DROP_REASON_TCP_CSUM,
-	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
-	SKB_DROP_REASON_SOCKET_FILTER,
-	/** @SKB_DROP_REASON_UDP_CSUM: UDP checksum error */
-	SKB_DROP_REASON_UDP_CSUM,
-	/** @SKB_DROP_REASON_NETFILTER_DROP: dropped by netfilter */
-	SKB_DROP_REASON_NETFILTER_DROP,
-	/**
-	 * @SKB_DROP_REASON_OTHERHOST: packet don't belong to current host
-	 * (interface is in promisc mode)
-	 */
-	SKB_DROP_REASON_OTHERHOST,
-	/** @SKB_DROP_REASON_IP_CSUM: IP checksum error */
-	SKB_DROP_REASON_IP_CSUM,
-	/**
-	 * @SKB_DROP_REASON_IP_INHDR: there is something wrong with IP header (see
-	 * IPSTATS_MIB_INHDRERRORS)
-	 */
-	SKB_DROP_REASON_IP_INHDR,
-	/**
-	 * @SKB_DROP_REASON_IP_RPFILTER: IP rpfilter validate failed. see the
-	 * document for rp_filter in ip-sysctl.rst for more information
-	 */
-	SKB_DROP_REASON_IP_RPFILTER,
-	/**
-	 * @SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST: destination address of L2 is
-	 * multicast, but L3 is unicast.
-	 */
-	SKB_DROP_REASON_UNICAST_IN_L2_MULTICAST,
-	/** @SKB_DROP_REASON_XFRM_POLICY: xfrm policy check failed */
-	SKB_DROP_REASON_XFRM_POLICY,
-	/** @SKB_DROP_REASON_IP_NOPROTO: no support for IP protocol */
-	SKB_DROP_REASON_IP_NOPROTO,
-	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
-	SKB_DROP_REASON_SOCKET_RCVBUFF,
-	/**
-	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limition, such as udp packet
-	 * drop out of udp_memory_allocated.
-	 */
-	SKB_DROP_REASON_PROTO_MEM,
-	/**
-	 * @SKB_DROP_REASON_TCP_MD5NOTFOUND: no MD5 hash and one expected,
-	 * corresponding to LINUX_MIB_TCPMD5NOTFOUND
-	 */
-	SKB_DROP_REASON_TCP_MD5NOTFOUND,
-	/**
-	 * @SKB_DROP_REASON_TCP_MD5UNEXPECTED: MD5 hash and we're not expecting
-	 * one, corresponding to LINUX_MIB_TCPMD5UNEXPECTED
-	 */
-	SKB_DROP_REASON_TCP_MD5UNEXPECTED,
-	/**
-	 * @SKB_DROP_REASON_TCP_MD5FAILURE: MD5 hash and its wrong, corresponding
-	 * to LINUX_MIB_TCPMD5FAILURE
-	 */
-	SKB_DROP_REASON_TCP_MD5FAILURE,
-	/**
-	 * @SKB_DROP_REASON_SOCKET_BACKLOG: failed to add skb to socket backlog (
-	 * see LINUX_MIB_TCPBACKLOGDROP)
-	 */
-	SKB_DROP_REASON_SOCKET_BACKLOG,
-	/** @SKB_DROP_REASON_TCP_FLAGS: TCP flags invalid */
-	SKB_DROP_REASON_TCP_FLAGS,
-	/**
-	 * @SKB_DROP_REASON_TCP_ZEROWINDOW: TCP receive window size is zero,
-	 * see LINUX_MIB_TCPZEROWINDOWDROP
-	 */
-	SKB_DROP_REASON_TCP_ZEROWINDOW,
-	/**
-	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data reveived is already
-	 * received before (spurious retrans may happened), see
-	 * LINUX_MIB_DELAYEDACKLOST
-	 */
-	SKB_DROP_REASON_TCP_OLD_DATA,
-	/**
-	 * @SKB_DROP_REASON_TCP_OVERWINDOW: the TCP data is out of window,
-	 * the seq of the first byte exceed the right edges of receive
-	 * window
-	 */
-	SKB_DROP_REASON_TCP_OVERWINDOW,
-	/**
-	 * @SKB_DROP_REASON_TCP_OFOMERGE: the data of skb is already in the ofo
-	 * queue, corresponding to LINUX_MIB_TCPOFOMERGE
-	 */
-	SKB_DROP_REASON_TCP_OFOMERGE,
-	/**
-	 * @SKB_DROP_REASON_TCP_RFC7323_PAWS: PAWS check, corresponding to
-	 * LINUX_MIB_PAWSESTABREJECTED
-	 */
-	SKB_DROP_REASON_TCP_RFC7323_PAWS,
-	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
-	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
-	/** @SKB_DROP_REASON_TCP_RESET: Invalid RST packet */
-	SKB_DROP_REASON_TCP_RESET,
-	/**
-	 * @SKB_DROP_REASON_TCP_INVALID_SYN: Incoming packet has unexpected
-	 * SYN flag
-	 */
-	SKB_DROP_REASON_TCP_INVALID_SYN,
-	/** @SKB_DROP_REASON_TCP_CLOSE: TCP socket in CLOSE state */
-	SKB_DROP_REASON_TCP_CLOSE,
-	/** @SKB_DROP_REASON_TCP_FASTOPEN: dropped by FASTOPEN request socket */
-	SKB_DROP_REASON_TCP_FASTOPEN,
-	/** @SKB_DROP_REASON_TCP_OLD_ACK: TCP ACK is old, but in window */
-	SKB_DROP_REASON_TCP_OLD_ACK,
-	/** @SKB_DROP_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
-	SKB_DROP_REASON_TCP_TOO_OLD_ACK,
-	/**
-	 * @SKB_DROP_REASON_TCP_ACK_UNSENT_DATA: TCP ACK for data we haven't
-	 * sent yet
-	 */
-	SKB_DROP_REASON_TCP_ACK_UNSENT_DATA,
-	/** @SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE: pruned from TCP OFO queue */
-	SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE,
-	/** @SKB_DROP_REASON_TCP_OFO_DROP: data already in receive queue */
-	SKB_DROP_REASON_TCP_OFO_DROP,
-	/** @SKB_DROP_REASON_IP_OUTNOROUTES: route lookup failed */
-	SKB_DROP_REASON_IP_OUTNOROUTES,
-	/**
-	 * @SKB_DROP_REASON_BPF_CGROUP_EGRESS: dropped by BPF_PROG_TYPE_CGROUP_SKB
-	 * eBPF program
-	 */
-	SKB_DROP_REASON_BPF_CGROUP_EGRESS,
-	/** @SKB_DROP_REASON_IPV6DISABLED: IPv6 is disabled on the device */
-	SKB_DROP_REASON_IPV6DISABLED,
-	/** @SKB_DROP_REASON_NEIGH_CREATEFAIL: failed to create neigh entry */
-	SKB_DROP_REASON_NEIGH_CREATEFAIL,
-	/** @SKB_DROP_REASON_NEIGH_FAILED: neigh entry in failed state */
-	SKB_DROP_REASON_NEIGH_FAILED,
-	/** @SKB_DROP_REASON_NEIGH_QUEUEFULL: arp_queue for neigh entry is full */
-	SKB_DROP_REASON_NEIGH_QUEUEFULL,
-	/** @SKB_DROP_REASON_NEIGH_DEAD: neigh entry is dead */
-	SKB_DROP_REASON_NEIGH_DEAD,
-	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
-	SKB_DROP_REASON_TC_EGRESS,
-	/**
-	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
-	 * failed to enqueue to current qdisc)
-	 */
-	SKB_DROP_REASON_QDISC_DROP,
-	/**
-	 * @SKB_DROP_REASON_CPU_BACKLOG: failed to enqueue the skb to the per CPU
-	 * backlog queue. This can be caused by backlog queue full (see
-	 * netdev_max_backlog in net.rst) or RPS flow limit
-	 */
-	SKB_DROP_REASON_CPU_BACKLOG,
-	/** @SKB_DROP_REASON_XDP: dropped by XDP in input path */
-	SKB_DROP_REASON_XDP,
-	/** @SKB_DROP_REASON_TC_INGRESS: dropped in TC ingress HOOK */
-	SKB_DROP_REASON_TC_INGRESS,
-	/** @SKB_DROP_REASON_UNHANDLED_PROTO: protocol not implemented or not supported */
-	SKB_DROP_REASON_UNHANDLED_PROTO,
-	/** @SKB_DROP_REASON_SKB_CSUM: sk_buff checksum computation error */
-	SKB_DROP_REASON_SKB_CSUM,
-	/** @SKB_DROP_REASON_SKB_GSO_SEG: gso segmentation error */
-	SKB_DROP_REASON_SKB_GSO_SEG,
-	/**
-	 * @SKB_DROP_REASON_SKB_UCOPY_FAULT: failed to copy data from user space,
-	 * e.g., via zerocopy_sg_from_iter() or skb_orphan_frags_rx()
-	 */
-	SKB_DROP_REASON_SKB_UCOPY_FAULT,
-	/** @SKB_DROP_REASON_DEV_HDR: device driver specific header/metadata is invalid */
-	SKB_DROP_REASON_DEV_HDR,
-	/**
-	 * @SKB_DROP_REASON_DEV_READY: the device is not ready to xmit/recv due to
-	 * any of its data structure that is not up/ready/initialized,
-	 * e.g., the IFF_UP is not set, or driver specific tun->tfiles[txq]
-	 * is not initialized
-	 */
-	SKB_DROP_REASON_DEV_READY,
-	/** @SKB_DROP_REASON_FULL_RING: ring buffer is full */
-	SKB_DROP_REASON_FULL_RING,
-	/** @SKB_DROP_REASON_NOMEM: error due to OOM */
-	SKB_DROP_REASON_NOMEM,
-	/**
-	 * @SKB_DROP_REASON_HDR_TRUNC: failed to trunc/extract the header from
-	 * networking data, e.g., failed to pull the protocol header from
-	 * frags via pskb_may_pull()
-	 */
-	SKB_DROP_REASON_HDR_TRUNC,
-	/**
-	 * @SKB_DROP_REASON_TAP_FILTER: dropped by (ebpf) filter directly attached
-	 * to tun/tap, e.g., via TUNSETFILTEREBPF
-	 */
-	SKB_DROP_REASON_TAP_FILTER,
-	/**
-	 * @SKB_DROP_REASON_TAP_TXFILTER: dropped by tx filter implemented at
-	 * tun/tap, e.g., check_filter()
-	 */
-	SKB_DROP_REASON_TAP_TXFILTER,
-	/** @SKB_DROP_REASON_ICMP_CSUM: ICMP checksum error */
-	SKB_DROP_REASON_ICMP_CSUM,
-	/**
-	 * @SKB_DROP_REASON_INVALID_PROTO: the packet doesn't follow RFC 2211,
-	 * such as a broadcasts ICMP_TIMESTAMP
-	 */
-	SKB_DROP_REASON_INVALID_PROTO,
-	/**
-	 * @SKB_DROP_REASON_IP_INADDRERRORS: host unreachable, corresponding to
-	 * IPSTATS_MIB_INADDRERRORS
-	 */
-	SKB_DROP_REASON_IP_INADDRERRORS,
-	/**
-	 * @SKB_DROP_REASON_IP_INNOROUTES: network unreachable, corresponding to
-	 * IPSTATS_MIB_INADDRERRORS
-	 */
-	SKB_DROP_REASON_IP_INNOROUTES,
-	/**
-	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
-	 * MTU)
-	 */
-	SKB_DROP_REASON_PKT_TOO_BIG,
-	/** @SKB_DROP_REASON_DUP_FRAG: duplicate fragment */
-	SKB_DROP_REASON_DUP_FRAG,
-	/** @SKB_DROP_REASON_FRAG_REASM_TIMEOUT: fragment reassembly timeout */
-	SKB_DROP_REASON_FRAG_REASM_TIMEOUT,
-	/**
-	 * @SKB_DROP_REASON_FRAG_TOO_FAR: ipv4 fragment too far.
-	 * (/proc/sys/net/ipv4/ipfrag_max_dist)
-	 */
-	SKB_DROP_REASON_FRAG_TOO_FAR,
-	/**
-	 * @SKB_DROP_REASON_TCP_MINTTL: ipv4 ttl or ipv6 hoplimit below
-	 * the threshold (IP_MINTTL or IPV6_MINHOPCOUNT).
-	 */
-	SKB_DROP_REASON_TCP_MINTTL,
-	/** @SKB_DROP_REASON_IPV6_BAD_EXTHDR: Bad IPv6 extension header. */
-	SKB_DROP_REASON_IPV6_BAD_EXTHDR,
-	/** @SKB_DROP_REASON_IPV6_NDISC_FRAG: invalid frag (suppress_frag_ndisc). */
-	SKB_DROP_REASON_IPV6_NDISC_FRAG,
-	/** @SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT: invalid hop limit. */
-	SKB_DROP_REASON_IPV6_NDISC_HOP_LIMIT,
-	/** @SKB_DROP_REASON_IPV6_NDISC_BAD_CODE: invalid NDISC icmp6 code. */
-	SKB_DROP_REASON_IPV6_NDISC_BAD_CODE,
-	/** @SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS: invalid NDISC options. */
-	SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS,
-	/**
-	 * @SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST: NEIGHBOUR SOLICITATION
-	 * for another host.
-	 */
-	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
-	/**
-	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
-	 * shouldn't be used as a real 'reason' - only for tracing code gen
-	 */
-	SKB_DROP_REASON_MAX,
-
-	/**
-	 * @SKB_DROP_REASON_SUBSYS_MASK: subsystem mask in drop reasons,
-	 * see &enum skb_drop_reason_subsys
-	 */
-	SKB_DROP_REASON_SUBSYS_MASK = 0xffff0000,
-};
-
 #define SKB_DROP_REASON_SUBSYS_SHIFT	16
+#define SKB_DROP_REASON_SUBSYS_MASK	0xffff0000
 
-void drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
-				  const struct drop_reason_list *list);
-void drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys);
-#endif
-#endif
+static inline void
+drop_reasons_register_subsys(enum skb_drop_reason_subsys subsys,
+			     const struct drop_reason_list *list)
+{}
 
+static inline void
+drop_reasons_unregister_subsys(enum skb_drop_reason_subsys subsys)
+{}
+#endif /* <= 6.4 */
+
+#endif
-- 
2.45.1

