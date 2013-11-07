Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55844 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790Ab3KGU20 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:26 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/11] backports: add ipv6_addr_is_solict_mult()
Date: Thu,  7 Nov 2013 21:27:52 +0100
Message-Id: <1383856078-19823-6-git-send-email-hauke@hauke-m.de> (sfid-20131107_212836_657464_A38109C7)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/net/usb/cdc_mbim.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/addrconf.h |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/net/addrconf.h

diff --git a/backport/backport-include/net/addrconf.h b/backport/backport-include/net/addrconf.h
new file mode 100644
index 0000000..c4caa99
--- /dev/null
+++ b/backport/backport-include/net/addrconf.h
@@ -0,0 +1,25 @@
+#ifndef _BACKPORT_NET_ADDRCONF_H
+#define _BACKPORT_NET_ADDRCONF_H 1
+
+#include_next <net/addrconf.h>
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
+{
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
+	__u64 *p = (__u64 *)addr;
+	return ((p[0] ^ cpu_to_be64(0xff02000000000000UL)) |
+		((p[1] ^ cpu_to_be64(0x00000001ff000000UL)) &
+		 cpu_to_be64(0xffffffffff000000UL))) == 0UL;
+#else
+	return ((addr->s6_addr32[0] ^ htonl(0xff020000)) |
+		addr->s6_addr32[1] |
+		(addr->s6_addr32[2] ^ htonl(0x00000001)) |
+		(addr->s6_addr[12] ^ 0xff)) == 0;
+#endif
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+
+#endif	/* _BACKPORT_NET_ADDRCONF_H */
-- 
1.7.10.4

