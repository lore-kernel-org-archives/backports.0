Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56090 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab3DEPNh (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 11:13:37 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=5D=20backports=3A=20Add=20NFC=20patches?=
Date: Fri,  5 Apr 2013 17:13:29 +0200
Message-Id: <1365174812-2672-3-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_171340_839979_33794609)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These are NFC patches refreshed on next-20130328

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 .../0005-netlink-portid/net_nfc_netlink.patch      |   71 ++++++++++++++++++++
 .../network/53-pr_fmt/net_nfc_core.patch           |   13 ++++
 .../network/53-pr_fmt/net_nfc_hci_command.patch    |   13 ++++
 .../network/53-pr_fmt/net_nfc_hci_core.patch       |   13 ++++
 .../network/53-pr_fmt/net_nfc_hci_hcp.patch        |   13 ++++
 .../network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch  |   13 ++++
 .../network/53-pr_fmt/net_nfc_llcp_commands.patch  |   13 ++++
 .../network/53-pr_fmt/net_nfc_llcp_llcp.patch      |   13 ++++
 .../network/53-pr_fmt/net_nfc_llcp_sock.patch      |   13 ++++
 .../network/53-pr_fmt/net_nfc_nci_core.patch       |   13 ++++
 .../network/53-pr_fmt/net_nfc_nci_data.patch       |   13 ++++
 .../network/53-pr_fmt/net_nfc_nci_ntf.patch        |   13 ++++
 .../network/53-pr_fmt/net_nfc_nci_rsp.patch        |   12 ++++
 .../network/53-pr_fmt/net_nfc_netlink.patch        |   13 ++++
 .../network/53-pr_fmt/net_nfc_rawsock.patch        |   13 ++++
 .../network/74-driver-core-constify-data/INFO      |    7 ++
 .../net_nfc_core.patch                             |   14 ++++
 .../network/75-module-alias-genl-family/INFO       |    7 ++
 .../75-module-alias-genl-family/net_nfc_core.patch |   12 ++++
 .../network/76-module-i2c-driver/INFO              |    7 ++
 .../drivers_nfc_microread_i2c.patch                |   14 ++++
 .../drivers_nfc_pn544_i2c.patch                    |   14 ++++
 22 files changed, 327 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/net_nfc_netlink.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_core.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_command.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_core.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_hcp.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_commands.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_llcp.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_sock.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_core.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_data.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_ntf.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_rsp.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_netlink.patch
 create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_rawsock.patch
 create mode 100644 patches/collateral-evolutions/network/74-driver-core-constify-data/INFO
 create mode 100644 patches/collateral-evolutions/network/74-driver-core-constify-data/net_nfc_core.patch
 create mode 100644 patches/collateral-evolutions/network/75-module-alias-genl-family/INFO
 create mode 100644 patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch
 create mode 100644 patches/collateral-evolutions/network/76-module-i2c-driver/INFO
 create mode 100644 patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch
 create mode 100644 patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch

diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/net_nfc_netlink.patch b/patches/collateral-evolutions/network/0005-netlink-portid/net_nfc_netlink.patch
new file mode 100644
index 0000000..61770ce
--- /dev/null
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/net_nfc_netlink.patch
@@ -0,0 +1,71 @@
+--- a/net/nfc/netlink.c
++++ b/net/nfc/netlink.c
+@@ -69,7 +69,7 @@ static int nfc_genl_send_target(struct s
+ {
+ 	void *hdr;
+ 
+-	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
++	hdr = genlmsg_put(msg, NETLINK_CB_PORTID(cb->skb), cb->nlh->nlmsg_seq,
+ 			  &nfc_genl_family, flags, NFC_CMD_GET_TARGET);
+ 	if (!hdr)
+ 		return -EMSGSIZE;
+@@ -482,7 +482,7 @@ static int nfc_genl_dump_devices(struct
+ 	while (dev) {
+ 		int rc;
+ 
+-		rc = nfc_genl_send_device(skb, dev, NETLINK_CB(cb->skb).portid,
++		rc = nfc_genl_send_device(skb, dev, NETLINK_CB_PORTID(cb->skb),
+ 					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
+ 		if (rc < 0)
+ 			break;
+@@ -601,7 +601,7 @@ static int nfc_genl_get_device(struct sk
+ 		goto out_putdev;
+ 	}
+ 
+-	rc = nfc_genl_send_device(msg, dev, info->snd_portid, info->snd_seq,
++	rc = nfc_genl_send_device(msg, dev, genl_info_snd_portid(info), info->snd_seq,
+ 				  NULL, 0);
+ 	if (rc < 0)
+ 		goto out_free;
+@@ -692,7 +692,7 @@ static int nfc_genl_start_poll(struct sk
+ 
+ 	rc = nfc_start_poll(dev, im_protocols, tm_protocols);
+ 	if (!rc)
+-		dev->genl_data.poll_req_portid = info->snd_portid;
++		dev->genl_data.poll_req_portid = genl_info_snd_portid(info);
+ 
+ 	mutex_unlock(&dev->genl_data.genl_data_mutex);
+ 
+@@ -726,7 +726,7 @@ static int nfc_genl_stop_poll(struct sk_
+ 
+ 	mutex_lock(&dev->genl_data.genl_data_mutex);
+ 
+-	if (dev->genl_data.poll_req_portid != info->snd_portid) {
++	if (dev->genl_data.poll_req_portid != genl_info_snd_portid(info)) {
+ 		rc = -EBUSY;
+ 		goto out;
+ 	}
+@@ -852,7 +852,7 @@ static int nfc_genl_llc_get_params(struc
+ 		goto exit;
+ 	}
+ 
+-	rc = nfc_genl_send_params(msg, local, info->snd_portid, info->snd_seq);
++	rc = nfc_genl_send_params(msg, local, genl_info_snd_portid(info), info->snd_seq);
+ 
+ exit:
+ 	device_unlock(&dev->dev);
+@@ -1135,12 +1135,12 @@ static int nfc_genl_rcv_nl_event(struct
+ 	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
+ 		goto out;
+ 
+-	pr_debug("NETLINK_URELEASE event from id %d\n", n->portid);
++	pr_debug("NETLINK_URELEASE event from id %d\n", netlink_notify_portid(n));
+ 
+ 	w = kmalloc(sizeof(*w), GFP_ATOMIC);
+ 	if (w) {
+ 		INIT_WORK((struct work_struct *) w, nfc_urelease_event_work);
+-		w->portid = n->portid;
++		w->portid = netlink_notify_portid(n);
+ 		schedule_work((struct work_struct *) w);
+ 	}
+ 
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_core.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_core.patch
new file mode 100644
index 0000000..feffc96
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_core.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/core.c
++++ b/net/nfc/core.c
+@@ -21,8 +21,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_command.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_command.patch
new file mode 100644
index 0000000..97ea3b4
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_command.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/hci/command.c
++++ b/net/nfc/hci/command.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "hci: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/sched.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_core.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_core.patch
new file mode 100644
index 0000000..9b29afb
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_core.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/hci/core.c
++++ b/net/nfc/hci/core.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "hci: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_hcp.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_hcp.patch
new file mode 100644
index 0000000..38c9484
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_hcp.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/hci/hcp.c
++++ b/net/nfc/hci/hcp.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "hci: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch
new file mode 100644
index 0000000..5088e2f
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/hci/llc_shdlc.c
++++ b/net/nfc/hci/llc_shdlc.c
+@@ -18,8 +18,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "shdlc: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/types.h>
+ #include <linux/sched.h>
+ #include <linux/wait.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_commands.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_commands.patch
new file mode 100644
index 0000000..b896f67
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_commands.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/llcp/commands.c
++++ b/net/nfc/llcp/commands.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_llcp.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_llcp.patch
new file mode 100644
index 0000000..33abb45
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_llcp.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/llcp/llcp.c
++++ b/net/nfc/llcp/llcp.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/list.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_sock.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_sock.patch
new file mode 100644
index 0000000..90cee84
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_sock.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/llcp/sock.c
++++ b/net/nfc/llcp/sock.c
+@@ -17,8 +17,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) "llcp: %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/init.h>
+ #include <linux/kernel.h>
+ #include <linux/module.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_core.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_core.patch
new file mode 100644
index 0000000..f38a7e0
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_core.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/nci/core.c
++++ b/net/nfc/nci/core.c
+@@ -25,8 +25,10 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/module.h>
+ #include <linux/types.h>
+ #include <linux/workqueue.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_data.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_data.patch
new file mode 100644
index 0000000..bc9c53c
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_data.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/nci/data.c
++++ b/net/nfc/nci/data.c
+@@ -21,8 +21,10 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/types.h>
+ #include <linux/interrupt.h>
+ #include <linux/wait.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_ntf.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_ntf.patch
new file mode 100644
index 0000000..f5708b7
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_ntf.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/nci/ntf.c
++++ b/net/nfc/nci/ntf.c
+@@ -25,8 +25,10 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <linux/types.h>
+ #include <linux/interrupt.h>
+ #include <linux/bitops.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_rsp.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_rsp.patch
new file mode 100644
index 0000000..27f264b
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_rsp.patch
@@ -0,0 +1,12 @@
+--- a/net/nfc/nci/rsp.c
++++ b/net/nfc/nci/rsp.c
+@@ -25,7 +25,9 @@
+  *
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
++#include <linux/printk.h>
+ 
+ #include <linux/types.h>
+ #include <linux/interrupt.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_netlink.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_netlink.patch
new file mode 100644
index 0000000..916410c
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_netlink.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/netlink.c
++++ b/net/nfc/netlink.c
+@@ -21,8 +21,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <net/genetlink.h>
+ #include <linux/nfc.h>
+ #include <linux/slab.h>
diff --git a/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_rawsock.patch b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_rawsock.patch
new file mode 100644
index 0000000..a2090b1
--- /dev/null
+++ b/patches/collateral-evolutions/network/53-pr_fmt/net_nfc_rawsock.patch
@@ -0,0 +1,13 @@
+--- a/net/nfc/rawsock.c
++++ b/net/nfc/rawsock.c
+@@ -21,8 +21,10 @@
+  * 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+  */
+ 
++#undef pr_fmt
+ #define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
+ 
++#include <linux/printk.h>
+ #include <net/tcp_states.h>
+ #include <linux/nfc.h>
+ #include <linux/export.h>
diff --git a/patches/collateral-evolutions/network/74-driver-core-constify-data/INFO b/patches/collateral-evolutions/network/74-driver-core-constify-data/INFO
new file mode 100644
index 0000000..1ea1662
--- /dev/null
+++ b/patches/collateral-evolutions/network/74-driver-core-constify-data/INFO
@@ -0,0 +1,7 @@
+This backports:
+
+commit 9f3b795a626ee79574595e06d1437fe0c7d51d29
+Author: Michał Mirosław <mirq-linux@rere.qmqm.pl>
+Date:   Fri Feb 1 20:40:17 2013 +0100
+
+    driver-core: constify data for class_find_device()
diff --git a/patches/collateral-evolutions/network/74-driver-core-constify-data/net_nfc_core.patch b/patches/collateral-evolutions/network/74-driver-core-constify-data/net_nfc_core.patch
new file mode 100644
index 0000000..d09365f
--- /dev/null
+++ b/patches/collateral-evolutions/network/74-driver-core-constify-data/net_nfc_core.patch
@@ -0,0 +1,14 @@
+--- a/net/nfc/core.c
++++ b/net/nfc/core.c
+@@ -732,7 +732,11 @@ struct class nfc_class = {
+ };
+ EXPORT_SYMBOL(nfc_class);
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
+ static int match_idx(struct device *d, const void *data)
++#else
++static int match_idx(struct device *d, void *data)
++#endif
+ {
+ 	struct nfc_dev *dev = to_nfc_dev(d);
+ 	const unsigned int *idx = data;
diff --git a/patches/collateral-evolutions/network/75-module-alias-genl-family/INFO b/patches/collateral-evolutions/network/75-module-alias-genl-family/INFO
new file mode 100644
index 0000000..1a6b12c
--- /dev/null
+++ b/patches/collateral-evolutions/network/75-module-alias-genl-family/INFO
@@ -0,0 +1,7 @@
+This backports:
+
+commit e9412c37082b5c932e83364aaed0c38c2ce33acb
+Author: Neil Horman <nhorman@tuxdriver.com>
+Date:   Tue May 29 09:30:41 2012 +0000
+
+    genetlink: Build a generic netlink family module alias
diff --git a/patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch b/patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch
new file mode 100644
index 0000000..b3cdb7e
--- /dev/null
+++ b/patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch
@@ -0,0 +1,12 @@
+--- a/net/nfc/core.c
++++ b/net/nfc/core.c
+@@ -941,4 +941,9 @@ MODULE_DESCRIPTION("NFC Core ver " VERSI
+ MODULE_VERSION(VERSION);
+ MODULE_LICENSE("GPL");
+ MODULE_ALIAS_NETPROTO(PF_NFC);
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+ MODULE_ALIAS_GENL_FAMILY(NFC_GENL_NAME);
++#else
++MODULE_ALIAS("net-pf-" __stringify(PF_NETLINK) "-proto-" \
++__stringify(NETLINK_GENERIC) "-type-" NFC_GENL_NAME);
++#endif
diff --git a/patches/collateral-evolutions/network/76-module-i2c-driver/INFO b/patches/collateral-evolutions/network/76-module-i2c-driver/INFO
new file mode 100644
index 0000000..04333a7
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-module-i2c-driver/INFO
@@ -0,0 +1,7 @@
+This backports:
+
+commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
+Author: Lars-Peter Clausen <lars@metafoo.de>
+Date:   Wed Nov 16 10:13:36 2011 +0100
+
+    I2C: Add helper macro for i2c_driver boilerplate
diff --git a/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch
new file mode 100644
index 0000000..c84dcd3
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch
@@ -0,0 +1,14 @@
+--- a/drivers/nfc/microread/i2c.c
++++ b/drivers/nfc/microread/i2c.c
+@@ -334,7 +334,11 @@ static struct i2c_driver microread_i2c_d
+ 	.id_table	= microread_i2c_id,
+ };
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
+ module_i2c_driver(microread_i2c_driver);
++#else
++module_driver(microread_i2c_driver, i2c_add_driver, i2c_del_driver)
++#endif
+ 
+ MODULE_LICENSE("GPL");
+ MODULE_DESCRIPTION(DRIVER_DESC);
diff --git a/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch
new file mode 100644
index 0000000..45cba3b
--- /dev/null
+++ b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch
@@ -0,0 +1,14 @@
+--- a/drivers/nfc/pn544/i2c.c
++++ b/drivers/nfc/pn544/i2c.c
+@@ -464,7 +464,11 @@ static struct i2c_driver pn544_hci_i2c_d
+ 	.remove = pn544_hci_i2c_remove,
+ };
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
+ module_i2c_driver(pn544_hci_i2c_driver);
++#else
++module_driver(pn544_hci_i2c_driver, i2c_add_driver, i2c_del_driver)
++#endif
+ 
+ MODULE_LICENSE("GPL");
+ MODULE_DESCRIPTION(DRIVER_DESC);
-- 
1.7.10.4

