Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29220 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308AbaEPLW3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:29 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 05/13] backports: handle no_fcs change in struct sk_buff
Date: Fri, 16 May 2014 13:21:16 +0200
Message-Id: <1400239284-2916-6-git-send-email-sassmann@kpanic.de> (sfid-20140516_132233_024997_965B70E9)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.4 a new field no_fcs was introduced to struct sk_buff.
Address this by putting ifdef around the code.

commit 3bdc0eba0b8b47797f4a76e377dd8360f317450f
Author: Ben Greear <greearb@candelatech.com>
Date:   Sat Feb 11 15:39:30 2012 +0000

    net: Add framework to allow sending packets with customized CRC.

git describe --contains 3bdc0eba0b8b47797f4a76e377dd8360f317450f
v3.4-rc1~177^2~207

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../collateral-evolutions/network/0035-skb_no_fcs/INFO   | 12 ++++++++++++
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch         | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/INFO
 create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch

diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/INFO b/patches/collateral-evolutions/network/0035-skb_no_fcs/INFO
new file mode 100644
index 0000000..a242c97
--- /dev/null
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/INFO
@@ -0,0 +1,12 @@
+In kernel 3.4 a new field no_fcs was introduced to struct sk_buff.
+Address this by putting ifdef around the code.
+
+
+commit 3bdc0eba0b8b47797f4a76e377dd8360f317450f
+Author: Ben Greear <greearb@candelatech.com>
+Date:   Sat Feb 11 15:39:30 2012 +0000
+
+    net: Add framework to allow sending packets with customized CRC.
+
+git describe --contains 3bdc0eba0b8b47797f4a76e377dd8360f317450f
+v3.4-rc1~177^2~207
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
new file mode 100644
index 0000000..d4aee27
--- /dev/null
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index ccd8f36..132cef8 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -4768,9 +4768,10 @@ static u32 igb_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
+ 	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
+ 				 (E1000_ADVTXD_MAC_TSTAMP));
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
+ 	/* insert frame checksum */
+ 	cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
+-
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) */
+ 	return cmd_type;
+ }
+ 
-- 
1.9.0

