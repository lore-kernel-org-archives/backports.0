Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46348 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMmH (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:07 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so4671068pab.37
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:07 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>
Subject: [PATCH 12/27] backports: backport inet_frag_maybe_warn_overflow()
Date: Sat,  5 Apr 2014 05:40:46 -0700
Message-Id: <1396701662-15165-13-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_631093_E7C8823F)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the ieee802154 reassembly code. This is
a straight forward backport.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 5a3da1fe95
v3.9-rc4~27^2

commit 5a3da1fe9561828d0ca7eca664b16ec2b9bf0055
Author: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date:   Fri Mar 15 11:32:30 2013 +0000

    inet: limit length of fragment queue hash table bucket lists

    This patch introduces a constant limit of the fragment queue hash
    table bucket list lengths. Currently the limit 128 is choosen somewhat
    arbitrary and just ensures that we can fill up the fragment cache with
    empty packets up to the default ip_frag_high_thresh limits. It should
    just protect from list iteration eating considerable amounts of cpu.

    If we reach the maximum length in one hash bucket a warning is printed.
    This is implemented on the caller side of inet_frag_find to distinguish
    between the different users of inet_fragment.c.

    I dropped the out of memory warning in the ipv4 fragment lookup path,
    because we already get a warning by the slab allocator.

    Cc: Eric Dumazet <eric.dumazet@gmail.com>
    Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>
    Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
    Acked-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/net/inet_frag.h |  5 +++++
 backport/compat/compat-3.9.c              | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index 167792b..3c9e11a 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -34,6 +34,11 @@ static inline int sum_frag_mem_limit(struct netns_frags *nf)
 {
 	return atomic_read(&nf->mem);
 }
+
+#define inet_frag_maybe_warn_overflow LINUX_BACKPORT(inet_frag_maybe_warn_overflow)
+void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
+				   const char *prefix);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
 
+
 #endif /* __BACKPORT__NET_FRAG_H__ */
diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
index df10d7d..5a4f523 100644
--- a/backport/compat/compat-3.9.c
+++ b/backport/compat/compat-3.9.c
@@ -15,6 +15,8 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
+#include <net/inet_frag.h>
+#include <net/sock.h>
 
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 {
@@ -56,3 +58,15 @@ void eth_commit_mac_addr_change(struct net_device *dev, void *p)
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
 }
 EXPORT_SYMBOL_GPL(eth_commit_mac_addr_change);
+
+void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
+				   const char *prefix)
+{
+	static const char msg[] = "inet_frag_find: Fragment hash bucket"
+		" list length grew over limit " __stringify(INETFRAGS_MAXDEPTH)
+		". Dropping fragment.\n";
+
+	if (PTR_ERR(q) == -ENOBUFS)
+		LIMIT_NETDEBUG(KERN_WARNING "%s%s", prefix, msg);
+}
+EXPORT_SYMBOL_GPL(inet_frag_maybe_warn_overflow);
-- 
1.8.5.3

