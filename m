Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59902 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMlw (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:52 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so4674219pab.13
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Amerigo Wang <amwang@redhat.com>
Subject: [PATCH 09/27] backports: backport definition of struct frag_queue
Date: Sat,  5 Apr 2014 05:40:43 -0700
Message-Id: <1396701662-15165-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144154_163290_4821EA3E)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit b836c99f by Amerigo which got added on v3.7 generalized
the conntrack struct frag_queue while unifying the conntrack
reassembly expire code with a standard one. Although we won't
use the expiry code, another subsystem which we backport, the
ieee802154 6lowpan subsystem, makes use of this structure for
its own reassembly code. This makes that structure available
for older kernels.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains b836c99f
v3.7-rc1~145^2~136

Cc: Amerigo Wang <amwang@redhat.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/net/ipv6.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
index 9a370a0..51f55b4 100644
--- a/backport/backport-include/net/ipv6.h
+++ b/backport/backport-include/net/ipv6.h
@@ -3,6 +3,25 @@
 #include_next <net/ipv6.h>
 #include <linux/version.h>
 #include <net/addrconf.h>
+#include <net/inet_frag.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+/*
+ *	Equivalent of ipv4 struct ip
+ */
+struct frag_queue {
+	struct inet_frag_queue  q;
+
+	__be32                  id;             /* fragment id          */
+	u32                     user;
+	struct in6_addr         saddr;
+	struct in6_addr         daddr;
+
+	int                     iif;
+	unsigned int            csum;
+	__u16                   nhoffset;
+};
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)) && (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
 #define ipv6_addr_hash LINUX_BACKPORT(ipv6_addr_hash)
-- 
1.8.5.3

