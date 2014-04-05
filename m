Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41636 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaDEMnC (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:43:02 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so4669283pab.39
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:43:01 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Amerigo Wang <amwang@redhat.com>,
	linux-zigbee-devel@lists.sourceforge.net
Subject: [PATCH 23/27] backports: backport ieee802154 6lowpan support down to 3.5
Date: Sat,  5 Apr 2014 05:40:57 -0700
Message-Id: <1396701662-15165-24-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_850048_BC9EC2F1)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 633fc86ff62 added the ieee802154_6lowpan namespace
and 7240cdec60b extended it (as on linux-next next-20140311).
Its important to note though that 633fc86ff62 also extends the
global net namespace. Since we cannot extend the global net
namespace we define our own backport namespace for 6lowpan
that can be used only be used by our backported subsystems,
nothing more. Since ieee802154_6lowpan requires support for
net_get_random_once() which uses static keys and a slew of
new skb fragment support we simply require at least 3.5 to
use 6lowpan. I did my best effort to backport this to kernels
older than 3.5 but quickly ran into a slew of hairy issues.

The last thing we needed to address was usage of the helper
inet_frag_evictor() added by Alexander via commit 6b102865e7
through v3.7. Since we can't backport that with macros or
inline helpers we add a patch to carry the changes there. If
that grows we can consider using Coccinelle.

If you are going to try to backport 6lowpan to kernels older
than 3.5 be warned that the litmus test for patches will be
to pass ckmake --allyesconfig for all supported kernels for
every patch you provide.

Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Amerigo Wang <amwang@redhat.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/net/net_namespace.h      |  22 +++-
 backport/compat/backport-3.15.c                    |  14 ++
 copy-list                                          |   1 +
 dependencies                                       |   3 +-
 .../0001-6lowpan-namespace.patch                   | 143 +++++++++++++++++++++
 .../0002-include-new-netns-headers.patch           |  12 ++
 .../0012-ieee802154-6lowpan-namespace.patch        |  63 +++++++++
 .../network/0013-net-user-ns.patch                 |  17 +++
 .../network/0014-inet_frag_evictor.patch           |  20 +++
 9 files changed, 291 insertions(+), 4 deletions(-)
 create mode 100644 patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
 create mode 100644 patches/0000-upstream-backport-changes/0002-include-new-netns-headers.patch
 create mode 100644 patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
 create mode 100644 patches/collateral-evolutions/network/0013-net-user-ns.patch
 create mode 100644 patches/collateral-evolutions/network/0014-inet_frag_evictor.patch

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index f23702f..efad88e 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -2,10 +2,8 @@
 #define _COMPAT_NET_NET_NAMESPACE_H 1
 
 #include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,23))
+#include <net/netns/ieee802154_6lowpan.h>
 #include_next <net/net_namespace.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,23)) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
 #ifdef CONFIG_NET_NS
@@ -60,4 +58,22 @@ struct net *sock_net(const struct sock *sk)
 }
 #endif /* < 2.6.26 */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+/*
+ * we provide backport for 6lowpan as per the dependencies file
+ * down to 3.5 only.
+ */
+extern struct netns_ieee802154_lowpan ieee802154_lowpan;
+struct netns_ieee802154_lowpan *net_ieee802154_lowpan(struct net *net);
+#endif
+#else
+/* This can be removed once and if this gets upstream */
+static inline struct netns_ieee802154_lowpan *
+net_ieee802154_lowpan(struct net *net)
+{
+	return &net->ieee802154_lowpan;
+}
+#endif
+
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index 67d672b..545e0c2 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (c) 2015  Luis R. Rodriguez <mcgrof@do-not-panic.com>
  *
  * Backport functionality introduced in Linux 3.15.
  *
@@ -11,6 +12,19 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <net/net_namespace.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+/* the above kernel dependency is set to match the dependencies file */
+struct netns_ieee802154_lowpan ieee802154_lowpan;
+EXPORT_SYMBOL_GPL(ieee802154_lowpan);
+
+struct netns_ieee802154_lowpan *net_ieee802154_lowpan(struct net *net)
+{
+	return &ieee802154_lowpan;
+}
+EXPORT_SYMBOL_GPL(net_ieee802154_lowpan);
+#endif
 
 /**
  * devm_kstrdup - Allocate resource managed space and
diff --git a/copy-list b/copy-list
index ceb80ba..76ce1c3 100644
--- a/copy-list
+++ b/copy-list
@@ -181,6 +181,7 @@ include/linux/platform_data/vsp1.h
 include/linux/platform_data/camera-rcar.h
 
 include/net/6lowpan.h
+include/net/netns/ieee802154_6lowpan.h
 include/net/nl802154.h
 include/net/mac802154.h
 include/net/ieee802154.h
diff --git a/dependencies b/dependencies
index ec8348b..f5f7229 100644
--- a/dependencies
+++ b/dependencies
@@ -232,4 +232,5 @@ INTEL_IPS 3.2
 NFC_MEI_PHY 3.10
 
 IEEE802154_MRF24J40 3.5
-IEEE802154 2.6.38
+IEEE802154 3.1
+IEEE802154_6LOWPAN 3.5
diff --git a/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch b/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
new file mode 100644
index 0000000..2f88b28
--- /dev/null
+++ b/patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
@@ -0,0 +1,143 @@
+This will be sent upstream, then we can remove this.
+The first hunk however was removed as it doesn't apply to
+our backport framework which declared net_ieee802154_lowpan(),
+for now we carry that for older and newer kernels in our own
+backport/backport-include/net/net_namespace.h file.
+
+From 2e509dac53558fda87061b06f081fde5a7cb8051 Mon Sep 17 00:00:00 2001
+From: "Luis R. Rodriguez" <mcgrof@suse.com>
+Date: Mon, 31 Mar 2014 01:53:22 -0700
+Subject: [PATCH] 6lowpan: add helper to get 6lowpan namespace
+
+This will simplify the new reassembly backport
+with no code changes.
+
+Cc:Alexander Aring <alex.aring@gmail.com>
+Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
+---
+diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
+index f4ac957..0bcbef3 100644
+-- 
+1.9.0
+
+--- a/net/ieee802154/reassembly.c
++++ b/net/ieee802154/reassembly.c
+@@ -123,6 +123,8 @@ fq_find(struct net *net, const struct ie
+ 	struct inet_frag_queue *q;
+ 	struct lowpan_create_arg arg;
+ 	unsigned int hash;
++	struct netns_ieee802154_lowpan *ieee802154_lowpan =
++		net_ieee802154_lowpan(net);
+ 
+ 	arg.tag = frag_info->d_tag;
+ 	arg.d_size = frag_info->d_size;
+@@ -132,7 +134,7 @@ fq_find(struct net *net, const struct ie
+ 	read_lock(&lowpan_frags.lock);
+ 	hash = lowpan_hash_frag(frag_info->d_tag, frag_info->d_size, src, dst);
+ 
+-	q = inet_frag_find(&net->ieee802154_lowpan.frags,
++	q = inet_frag_find(&ieee802154_lowpan->frags,
+ 			   &lowpan_frags, &arg, hash);
+ 	if (IS_ERR_OR_NULL(q)) {
+ 		inet_frag_maybe_warn_overflow(q, pr_fmt());
+@@ -361,16 +363,18 @@ int lowpan_frag_rcv(struct sk_buff *skb,
+ 	struct lowpan_frag_queue *fq;
+ 	struct net *net = dev_net(skb->dev);
+ 	struct ieee802154_frag_info *frag_info = &mac_cb(skb)->frag_info;
++	struct netns_ieee802154_lowpan *ieee802154_lowpan =
++		net_ieee802154_lowpan(net);
+ 	int err;
+ 
+ 	err = lowpan_get_frag_info(skb, frag_type, frag_info);
+ 	if (err < 0)
+ 		goto err;
+ 
+-	if (frag_info->d_size > net->ieee802154_lowpan.max_dsize)
++	if (frag_info->d_size > ieee802154_lowpan->max_dsize)
+ 		goto err;
+ 
+-	inet_frag_evictor(&net->ieee802154_lowpan.frags, &lowpan_frags, false);
++	inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags, false);
+ 
+ 	fq = fq_find(net, frag_info, &mac_cb(skb)->sa, &mac_cb(skb)->da);
+ 	if (fq != NULL) {
+@@ -453,6 +457,8 @@ static int __net_init lowpan_frags_ns_sy
+ {
+ 	struct ctl_table *table;
+ 	struct ctl_table_header *hdr;
++	struct netns_ieee802154_lowpan *ieee802154_lowpan =
++		net_ieee802154_lowpan(net);
+ 
+ 	table = lowpan_frags_ns_ctl_table;
+ 	if (!net_eq(net, &init_net)) {
+@@ -461,10 +467,10 @@ static int __net_init lowpan_frags_ns_sy
+ 		if (table == NULL)
+ 			goto err_alloc;
+ 
+-		table[0].data = &net->ieee802154_lowpan.frags.high_thresh;
+-		table[1].data = &net->ieee802154_lowpan.frags.low_thresh;
+-		table[2].data = &net->ieee802154_lowpan.frags.timeout;
+-		table[3].data = &net->ieee802154_lowpan.max_dsize;
++		table[0].data = &ieee802154_lowpan->frags.high_thresh;
++		table[1].data = &ieee802154_lowpan->frags.low_thresh;
++		table[2].data = &ieee802154_lowpan->frags.timeout;
++		table[3].data = &ieee802154_lowpan->max_dsize;
+ 
+ 		/* Don't export sysctls to unprivileged users */
+ 		if (net->user_ns != &init_user_ns)
+@@ -475,7 +481,7 @@ static int __net_init lowpan_frags_ns_sy
+ 	if (hdr == NULL)
+ 		goto err_reg;
+ 
+-	net->ieee802154_lowpan.sysctl.frags_hdr = hdr;
++	ieee802154_lowpan->sysctl.frags_hdr = hdr;
+ 	return 0;
+ 
+ err_reg:
+@@ -488,9 +494,11 @@ err_alloc:
+ static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
+ {
+ 	struct ctl_table *table;
++	struct netns_ieee802154_lowpan *ieee802154_lowpan =
++		net_ieee802154_lowpan(net);
+ 
+-	table = net->ieee802154_lowpan.sysctl.frags_hdr->ctl_table_arg;
+-	unregister_net_sysctl_table(net->ieee802154_lowpan.sysctl.frags_hdr);
++	table = ieee802154_lowpan->sysctl.frags_hdr->ctl_table_arg;
++	unregister_net_sysctl_table(ieee802154_lowpan->sysctl.frags_hdr);
+ 	if (!net_eq(net, &init_net))
+ 		kfree(table);
+ }
+@@ -531,20 +539,26 @@ static inline void lowpan_frags_sysctl_u
+ 
+ static int __net_init lowpan_frags_init_net(struct net *net)
+ {
+-	net->ieee802154_lowpan.frags.high_thresh = IPV6_FRAG_HIGH_THRESH;
+-	net->ieee802154_lowpan.frags.low_thresh = IPV6_FRAG_LOW_THRESH;
+-	net->ieee802154_lowpan.frags.timeout = IPV6_FRAG_TIMEOUT;
+-	net->ieee802154_lowpan.max_dsize = 0xFFFF;
++	struct netns_ieee802154_lowpan *ieee802154_lowpan =
++		net_ieee802154_lowpan(net);
+ 
+-	inet_frags_init_net(&net->ieee802154_lowpan.frags);
++	ieee802154_lowpan->frags.high_thresh = IPV6_FRAG_HIGH_THRESH;
++	ieee802154_lowpan->frags.low_thresh = IPV6_FRAG_LOW_THRESH;
++	ieee802154_lowpan->frags.timeout = IPV6_FRAG_TIMEOUT;
++	ieee802154_lowpan->max_dsize = 0xFFFF;
++
++	inet_frags_init_net(&ieee802154_lowpan->frags);
+ 
+ 	return lowpan_frags_ns_sysctl_register(net);
+ }
+ 
+ static void __net_exit lowpan_frags_exit_net(struct net *net)
+ {
++	struct netns_ieee802154_lowpan *ieee802154_lowpan =
++		net_ieee802154_lowpan(net);
++
+ 	lowpan_frags_ns_sysctl_unregister(net);
+-	inet_frags_exit_net(&net->ieee802154_lowpan.frags, &lowpan_frags);
++	inet_frags_exit_net(&ieee802154_lowpan->frags, &lowpan_frags);
+ }
+ 
+ static struct pernet_operations lowpan_frags_ops = {
diff --git a/patches/0000-upstream-backport-changes/0002-include-new-netns-headers.patch b/patches/0000-upstream-backport-changes/0002-include-new-netns-headers.patch
new file mode 100644
index 0000000..3b00450
--- /dev/null
+++ b/patches/0000-upstream-backport-changes/0002-include-new-netns-headers.patch
@@ -0,0 +1,12 @@
+This can reasonably be sent upstream.
+
+--- a/include/net/6lowpan.h
++++ b/include/net/6lowpan.h
+@@ -54,6 +54,7 @@
+ #define __6LOWPAN_H__
+ 
+ #include <net/ipv6.h>
++#include <net/net_namespace.h>
+ 
+ #define UIP_802154_SHORTADDR_LEN	2  /* compressed ipv6 address length */
+ #define UIP_IPH_LEN			40 /* ipv6 fixed header size */
diff --git a/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
new file mode 100644
index 0000000..218a768
--- /dev/null
+++ b/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
@@ -0,0 +1,63 @@
+This is required unless we add some macro wrappers for this
+type of static work upstream but not sure if that is a good
+idea yet.
+
+--- a/net/ieee802154/reassembly.c
++++ b/net/ieee802154/reassembly.c
+@@ -104,7 +104,11 @@ static void lowpan_frag_expire(unsigned
+ 	struct net *net;
+ 
+ 	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
++#else
++	net = &init_net;
++#endif
+ 
+ 	lowpan_expire_frag_queue(fq, &lowpan_frags);
+ }
+@@ -386,28 +390,44 @@ EXPORT_SYMBOL(lowpan_frag_rcv);
+ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
+ 	{
+ 		.procname	= "6lowpanfrag_high_thresh",
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 		.data		= &init_net.ieee802154_lowpan.frags.high_thresh,
++#else
++		.data		= &ieee802154_lowpan.frags.high_thresh,
++#endif
+ 		.maxlen		= sizeof(int),
+ 		.mode		= 0644,
+ 		.proc_handler	= proc_dointvec
+ 	},
+ 	{
+ 		.procname	= "6lowpanfrag_low_thresh",
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 		.data		= &init_net.ieee802154_lowpan.frags.low_thresh,
++#else
++		.data		= &ieee802154_lowpan.frags.low_thresh,
++#endif
+ 		.maxlen		= sizeof(int),
+ 		.mode		= 0644,
+ 		.proc_handler	= proc_dointvec
+ 	},
+ 	{
+ 		.procname	= "6lowpanfrag_time",
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 		.data		= &init_net.ieee802154_lowpan.frags.timeout,
++#else
++		.data		= &ieee802154_lowpan.frags.timeout,
++#endif
+ 		.maxlen		= sizeof(int),
+ 		.mode		= 0644,
+ 		.proc_handler	= proc_dointvec_jiffies,
+ 	},
+ 	{
+ 		.procname	= "6lowpanfrag_max_datagram_size",
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
+ 		.data		= &init_net.ieee802154_lowpan.max_dsize,
++#else
++		.data		= &ieee802154_lowpan.max_dsize,
++#endif
+ 		.maxlen		= sizeof(int),
+ 		.mode		= 0644,
+ 		.proc_handler	= proc_dointvec
diff --git a/patches/collateral-evolutions/network/0013-net-user-ns.patch b/patches/collateral-evolutions/network/0013-net-user-ns.patch
new file mode 100644
index 0000000..25752ca
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-net-user-ns.patch
@@ -0,0 +1,17 @@
+network namespaces didn't get usernamespaces pegged until 3.8
+via commit 038e7332b8.
+
+--- a/net/ieee802154/reassembly.c
++++ b/net/ieee802154/reassembly.c
+@@ -472,9 +472,11 @@ static int __net_init lowpan_frags_ns_sy
+ 		table[2].data = &ieee802154_lowpan->frags.timeout;
+ 		table[3].data = &ieee802154_lowpan->max_dsize;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
+ 		/* Don't export sysctls to unprivileged users */
+ 		if (net->user_ns != &init_user_ns)
+ 			table[0].procname = NULL;
++#endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,8,0) */
+ 	}
+ 
+ 	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
diff --git a/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch b/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
new file mode 100644
index 0000000..cfcbb4d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
@@ -0,0 +1,20 @@
+We can't backport this with a macro or inline helper, so just
+carry the patch and if this grows consider Coccinelle SmPL version.
+
+--- a/net/ieee802154/reassembly.c
++++ b/net/ieee802154/reassembly.c
+@@ -374,7 +374,14 @@ int lowpan_frag_rcv(struct sk_buff *skb,
+ 	if (frag_info->d_size > ieee802154_lowpan->max_dsize)
+ 		goto err;
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags, false);
++#else
++	if (atomic_read(&ieee802154_lowpan->frags.mem) <= &ieee802154_lowpan->frags.high_thresh)
++		return 0;
++	else
++		inet_frag_evictor(&ieee802154_lowpan->frags, &lowpan_frags);
++#endif
+ 
+ 	fq = fq_find(net, frag_info, &mac_cb(skb)->sa, &mac_cb(skb)->da);
+ 	if (fq != NULL) {
-- 
1.8.5.3

