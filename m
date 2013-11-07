Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55861 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab3KGU2h (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] backports: remove usage of ipv6_stub
Date: Thu,  7 Nov 2013 21:27:56 +0100
Message-Id: <1383856078-19823-10-git-send-email-hauke@hauke-m.de> (sfid-20131107_212838_446251_C40510DF)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We can not easily backport ipv6_stub which provides some IPv6 function
callbacks. These patches are removing usage of ipv6_stub which was
introduces in this commit:
commit 5f81bd2e5d804ca93f3ec8873451b22d2f454721
Author: Cong Wang <amwang@redhat.com>
Date:   Sat Aug 31 13:44:30 2013 +0800

    ipv6: export a stub for IPv6 symbols used by vxlan

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/80-ipv6_stub/INFO                      |    9 ++++++
 .../network/80-ipv6_stub/cdc_mbim.patch            |   29 ++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/80-ipv6_stub/INFO
 create mode 100644 patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch

diff --git a/patches/collateral-evolutions/network/80-ipv6_stub/INFO b/patches/collateral-evolutions/network/80-ipv6_stub/INFO
new file mode 100644
index 0000000..e244cda
--- /dev/null
+++ b/patches/collateral-evolutions/network/80-ipv6_stub/INFO
@@ -0,0 +1,9 @@
+We can not easily backport ipv6_stub which provides some IPv6 function 
+callbacks.
+These patches are removing usage of ipv6_stub which was introduces in 
+this commit:
+commit 5f81bd2e5d804ca93f3ec8873451b22d2f454721
+Author: Cong Wang <amwang@redhat.com>
+Date:   Sat Aug 31 13:44:30 2013 +0800
+
+    ipv6: export a stub for IPv6 symbols used by vxlan
diff --git a/patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch b/patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch
new file mode 100644
index 0000000..5c8b62e
--- /dev/null
+++ b/patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch
@@ -0,0 +1,29 @@
+--- a/drivers/net/usb/cdc_mbim.c
++++ b/drivers/net/usb/cdc_mbim.c
+@@ -184,6 +184,7 @@ error:
+ 	return NULL;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ /* Some devices are known to send Neigbor Solicitation messages and
+  * require Neigbor Advertisement replies.  The IPv6 core will not
+  * respond since IFF_NOARP is set, so we must handle them ourselves.
+@@ -236,6 +237,7 @@ static bool is_neigh_solicit(u8 *buf, si
+ 		msg->icmph.icmp6_code == 0 &&
+ 		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
+ 
+ 
+ static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
+@@ -252,8 +254,10 @@ static struct sk_buff *cdc_mbim_process_
+ 			proto = htons(ETH_P_IP);
+ 			break;
+ 		case 0x60:
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
+ 			if (is_neigh_solicit(buf, len))
+ 				do_neigh_solicit(dev, buf, tci);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
+ 			proto = htons(ETH_P_IPV6);
+ 			break;
+ 		default:
-- 
1.7.10.4

