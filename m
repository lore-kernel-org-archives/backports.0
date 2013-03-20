Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: ben@decadent.org.uk,
	noelamac@gmail.com,
	linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au,
	andi@firstfloor.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 03/30] compat: embrace LINUX_BACKPORT() for v2.6.24
Date: Wed, 20 Mar 2013 02:22:28 -0700
Message-Id: <1363771375-31715-4-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1363771375-31715-1-git-send-email-mcgrof@do-not-panic.com>
References: <1363771375-31715-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/compat-2.6.24.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/compat-2.6.24.h b/include/linux/compat-2.6.24.h
index 456dcb6..5448604 100644
--- a/include/linux/compat-2.6.24.h
+++ b/include/linux/compat-2.6.24.h
@@ -45,6 +45,7 @@ struct net {
 
 #ifdef CONFIG_NET
 /* Init's network namespace */
+#define init_net LINUX_BACKPORT(init_net)
 extern struct net init_net;
 #define INIT_NET_NS(net_ns) .net_ns = &init_net,
 #else
@@ -162,12 +163,16 @@ struct ssb_device_id {
 #define dev_get_by_index(a, b)		dev_get_by_index(b)
 #define __dev_get_by_index(a, b)	__dev_get_by_index(b)
 
+#define eth_header LINUX_BACKPORT(eth_header)
 extern int		eth_header(struct sk_buff *skb, struct net_device *dev,
 				unsigned short type, void *daddr,
 				void *saddr, unsigned len);
+#define eth_rebuild_header LINUX_BACKPORT(eth_rebuild_header)
 extern int		eth_rebuild_header(struct sk_buff *skb);
+#define eth_header_cache_update LINUX_BACKPORT(eth_header_cache_update)
 extern void		eth_header_cache_update(struct hh_cache *hh, struct net_device *dev,
 				unsigned char * haddr);
+#define eth_header_cache LINUX_BACKPORT(eth_header_cache)
 extern int		eth_header_cache(struct neighbour *neigh,
 			struct hh_cache *hh);
 
-- 
1.7.10.4
