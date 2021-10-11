Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C7DC4167B
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4A660EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhJKWZL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhJKWZD (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F30BC06161C
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:23:02 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HStbR2wXczQk1r;
        Tue, 12 Oct 2021 00:22:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxOw28xzzXXWgDRxUWy/6S8Bnw5TwoV4ej8MUTsKBks=;
        b=vq0iprazu3A2Tghnnqw+/FrXZwJ5/V50ApA5Hcx7FJ98w499JpmuAm9TsDN7k0d5x+34Ve
        +p1KE9DbldFIQsHVckjcT+h9z84rj7exMScdkEX2J2Be/bDBMt8SXqccVhcYhx0D7mJ2Hc
        Cg4feTUjwQB8+gIkJKMZxf5TYoYVYrU25G9Z4PPIUATmNcuxrWKsn7OwmECd0duizBgANS
        BeoCb67agyynrUNjPxEp3rMcLap5iU95189TD4WGH9P6VqOEF8/KJH5TN+8wsrjrgA8bSy
        5zLChXxOTuAgO5usr1vwK6dAdqvicb7+k64mM93lxRUcDbhuHiC+tawvmBI4Ww==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/14] backports: Remove 3.X kernel patches
Date:   Tue, 12 Oct 2021 00:22:18 +0200
Message-Id: <20211011222227.1189850-6-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E5BC188C
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all patches which are only needed for compatibility with
kernel < 3.19.
After this change backports will only work with kernel 3.19 and later.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netlink.h     |   3 -
 backport/backport-include/net/genetlink.h     |  13 +-
 backport/compat/backport-genetlink.c          |   6 +-
 .../0005-uapi-compromise/mwifiex.patch        |  22 ----
 .../0001-group_attr_class.cocci               |  80 ------------
 .../0001-group-attr/0002-group_attr_bus.cocci |  78 ------------
 .../0001-group-attr/0003-class_groups.cocci   |  54 --------
 patches/0001-group-attr/INFO                  |  40 ------
 patches/0001-netlink-portid.cocci             |  17 ---
 ...2-disable-dump-adjust-on-old-kernels.patch |  46 -------
 patches/0012-driver-quirks/INFO               |   2 -
 .../drivers_net_wireless_cw1200_sdio.patch    |  15 ---
 .../0013-fix-makefile-includes/ath10k.patch   |  10 --
 .../net_wireless_nl80211.patch                |  12 --
 ...drivers_net_wireless_ipw2x00_ipw2100.patch |  14 ---
 patches/0016-libertas-olpc-ec-wakeup/INFO     |   5 -
 ...drivers_net_wireless_libertas_if_usb.patch |  18 ---
 patches/0017-get_ts_info/INFO                 |  27 ----
 patches/0017-get_ts_info/get_ts_info.cocci    |  19 ---
 patches/0019-usb_driver_lpm.cocci             |   9 --
 patches/0020-tty-termios/INFO                 |  23 ----
 patches/0021-umode_t-api-change/ath10k.patch  |  14 ---
 patches/0021-umode_t-api-change/ath9k.patch   |  14 ---
 patches/0022-define-tracing/INFO              |   9 --
 patches/0022-define-tracing/ath6kl.patch      |  12 --
 patches/0022-define-tracing/cfg80211.patch    |  10 --
 patches/0022-define-tracing/mt7601u.patch     |  12 --
 patches/0022-define-tracing/wil6210.patch     |  12 --
 patches/0024-led-blink-api/INFO               |  13 --
 patches/0024-led-blink-api/mac80211.patch     |  51 --------
 patches/0025-usb-sg/INFO                      |  17 ---
 patches/0025-usb-sg/usbnet.patch              |  73 -----------
 patches/0026-ipv6_stub/INFO                   |  12 --
 patches/0026-ipv6_stub/cdc_mbim.patch         |  29 -----
 patches/0027-genl-const/INFO                  |  15 ---
 patches/0027-genl-const/genl-const.cocci      |  10 --
 patches/0028-select_queue/mac80211.patch      |  24 +---
 patches/0028-select_queue/mwifiex.patch       |  12 +-
 .../0029-struct_hid_ll_driver-extensions/INFO |  16 ---
 patches/0030-qdisc_tx_busylock/INFO           |  22 ----
 patches/0031-sk_data_ready.cocci              | 119 ------------------
 patches/0032-sriov_configure/INFO             |  13 --
 .../sriov_configure.cocci                     |  19 ---
 patches/0033-ndo_vlan_rx_vid/INFO             |  23 ----
 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch   |  48 -------
 patches/0034-ndo_set_vf_spoofchk/INFO         |  12 --
 .../set_vf_spoofchk.cocci                     |  41 ------
 patches/0035-skb_no_fcs/INFO                  |  12 --
 patches/0035-skb_no_fcs/skb_no_fcs.cocci      |   7 --
 patches/0036-ethtool_eee/INFO                 |  12 --
 patches/0036-ethtool_eee/ethtool_eee.cocci    |  37 ------
 patches/0037-ethtool_get_module/INFO          |  14 ---
 .../0037-ethtool_get_module/get_module.cocci  |  37 ------
 patches/0038-ethtool_rxfh_indir/INFO          |  13 --
 patches/0039-ethtool_rxnfc/INFO               |  14 ---
 patches/0039-ethtool_rxnfc/rxnfc.cocci        |  22 ----
 patches/0040-ethtool_cmd_mdix/INFO            |  13 --
 .../ethtool_cmd_mdix.cocci                    |  14 ---
 patches/0042-pci_error_handlers/INFO          |  12 --
 .../igb_pci_error_handlers.cocci              |   9 --
 patches/0043-ndo_set_vf_rate/INFO             |  17 ---
 .../0043-ndo_set_vf_rate/set_vf_rate.cocci    |  50 --------
 .../0049-no-pfmemalloc/no-pfmemalloc.cocci    |   9 --
 patches/0051-no-wakeup_path/ssb.patch         |  12 --
 patches/0052-deactivate-ptp-pin/INFO          |  20 ---
 patches/0055-name_assign_type/brcmfmac.patch  |  12 --
 patches/0055-netdev-tstats.cocci              |  11 --
 patches/0056-ndo_features_check/INFO          |  12 --
 .../features_check.cocci                      |  19 ---
 patches/0059-skb_xmit_more/INFO               |  10 --
 patches/0059-uuid-in-mei/INFO                 |   7 --
 patches/0060-trace_field_struct/INFO          |  11 --
 patches/0060-trace_field_struct/mt7601u.patch |  33 -----
 patches/0061-termios_rwsem/INFO               |  11 --
 patches/0069-iwlwifi-pd-string-fix.patch      |  75 -----------
 patches/0069-remove-of_irq/bcma.patch         |  24 ----
 patches/0071-skb-head_frag/wireless.patch     |  14 ---
 patches/0074-skb-wifi-acked.cocci             |   8 --
 patches/0076-reset-notify.cocci               |  19 ---
 patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |  22 ----
 patches/0100-revert-small_ops/mac80211.patch  |   4 +-
 patches/devcoredump.patch                     |  63 +---------
 83 files changed, 18 insertions(+), 1828 deletions(-)
 delete mode 100644 patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
 delete mode 100644 patches/0001-group-attr/0001-group_attr_class.cocci
 delete mode 100644 patches/0001-group-attr/0002-group_attr_bus.cocci
 delete mode 100644 patches/0001-group-attr/0003-class_groups.cocci
 delete mode 100644 patches/0001-group-attr/INFO
 delete mode 100644 patches/0001-netlink-portid.cocci
 delete mode 100644 patches/0002-disable-dump-adjust-on-old-kernels.patch
 delete mode 100644 patches/0012-driver-quirks/INFO
 delete mode 100644 patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
 delete mode 100644 patches/0013-fix-makefile-includes/ath10k.patch
 delete mode 100644 patches/0014-netlink_seq/net_wireless_nl80211.patch
 delete mode 100644 patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
 delete mode 100644 patches/0016-libertas-olpc-ec-wakeup/INFO
 delete mode 100644 patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
 delete mode 100644 patches/0017-get_ts_info/INFO
 delete mode 100644 patches/0017-get_ts_info/get_ts_info.cocci
 delete mode 100644 patches/0019-usb_driver_lpm.cocci
 delete mode 100644 patches/0020-tty-termios/INFO
 delete mode 100644 patches/0021-umode_t-api-change/ath10k.patch
 delete mode 100644 patches/0021-umode_t-api-change/ath9k.patch
 delete mode 100644 patches/0022-define-tracing/INFO
 delete mode 100644 patches/0022-define-tracing/ath6kl.patch
 delete mode 100644 patches/0022-define-tracing/cfg80211.patch
 delete mode 100644 patches/0022-define-tracing/mt7601u.patch
 delete mode 100644 patches/0022-define-tracing/wil6210.patch
 delete mode 100644 patches/0024-led-blink-api/INFO
 delete mode 100644 patches/0024-led-blink-api/mac80211.patch
 delete mode 100644 patches/0025-usb-sg/INFO
 delete mode 100644 patches/0025-usb-sg/usbnet.patch
 delete mode 100644 patches/0026-ipv6_stub/INFO
 delete mode 100644 patches/0026-ipv6_stub/cdc_mbim.patch
 delete mode 100644 patches/0027-genl-const/INFO
 delete mode 100644 patches/0027-genl-const/genl-const.cocci
 delete mode 100644 patches/0029-struct_hid_ll_driver-extensions/INFO
 delete mode 100644 patches/0030-qdisc_tx_busylock/INFO
 delete mode 100644 patches/0031-sk_data_ready.cocci
 delete mode 100644 patches/0032-sriov_configure/INFO
 delete mode 100644 patches/0032-sriov_configure/sriov_configure.cocci
 delete mode 100644 patches/0033-ndo_vlan_rx_vid/INFO
 delete mode 100644 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
 delete mode 100644 patches/0034-ndo_set_vf_spoofchk/INFO
 delete mode 100644 patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
 delete mode 100644 patches/0035-skb_no_fcs/INFO
 delete mode 100644 patches/0035-skb_no_fcs/skb_no_fcs.cocci
 delete mode 100644 patches/0036-ethtool_eee/INFO
 delete mode 100644 patches/0036-ethtool_eee/ethtool_eee.cocci
 delete mode 100644 patches/0037-ethtool_get_module/INFO
 delete mode 100644 patches/0037-ethtool_get_module/get_module.cocci
 delete mode 100644 patches/0038-ethtool_rxfh_indir/INFO
 delete mode 100644 patches/0039-ethtool_rxnfc/INFO
 delete mode 100644 patches/0039-ethtool_rxnfc/rxnfc.cocci
 delete mode 100644 patches/0040-ethtool_cmd_mdix/INFO
 delete mode 100644 patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
 delete mode 100644 patches/0042-pci_error_handlers/INFO
 delete mode 100644 patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
 delete mode 100644 patches/0043-ndo_set_vf_rate/INFO
 delete mode 100644 patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
 delete mode 100644 patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
 delete mode 100644 patches/0051-no-wakeup_path/ssb.patch
 delete mode 100644 patches/0052-deactivate-ptp-pin/INFO
 delete mode 100644 patches/0055-name_assign_type/brcmfmac.patch
 delete mode 100644 patches/0055-netdev-tstats.cocci
 delete mode 100644 patches/0056-ndo_features_check/INFO
 delete mode 100644 patches/0056-ndo_features_check/features_check.cocci
 delete mode 100644 patches/0059-skb_xmit_more/INFO
 delete mode 100644 patches/0059-uuid-in-mei/INFO
 delete mode 100644 patches/0060-trace_field_struct/INFO
 delete mode 100644 patches/0060-trace_field_struct/mt7601u.patch
 delete mode 100644 patches/0061-termios_rwsem/INFO
 delete mode 100644 patches/0069-iwlwifi-pd-string-fix.patch
 delete mode 100644 patches/0069-remove-of_irq/bcma.patch
 delete mode 100644 patches/0071-skb-head_frag/wireless.patch
 delete mode 100644 patches/0074-skb-wifi-acked.cocci
 delete mode 100644 patches/0076-reset-notify.cocci
 delete mode 100644 patches/0085-iwlwifi-pci-device-removal.patch

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 61d81bbf..f1860243 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -42,9 +42,6 @@ struct netlink_ext_ack {
 } while (0)
 #endif
 
-/* this is for patches we apply */
-#define netlink_notify_portid(__notify) (__notify->portid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).portid
 
 #ifndef NL_SET_BAD_ATTR
 #define NL_SET_BAD_ATTR(extack, attr) do {		\
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index befb8ce0..75f1eced 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -50,11 +50,6 @@ static inline void *genl_info_userhdr(struct genl_info *info)
 	return (u8 *)info->genlhdr + GENL_HDRLEN;
 }
 
-/* this is for patches we apply */
-#define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-
-#define __genl_const const
-
 #if LINUX_VERSION_IS_LESS(4,10,0)
 #define __genl_ro_after_init
 #else
@@ -151,10 +146,10 @@ struct backport_genl_family {
 	bool			netnsok;
 	bool			parallel_ops;
 	const struct nla_policy *policy;
-	int			(*pre_doit)(__genl_const struct genl_ops *ops,
+	int			(*pre_doit)(const struct genl_ops *ops,
 					    struct sk_buff *skb,
 					    struct genl_info *info);
-	void			(*post_doit)(__genl_const struct genl_ops *ops,
+	void			(*post_doit)(const struct genl_ops *ops,
 					     struct sk_buff *skb,
 					     struct genl_info *info);
 /*
@@ -163,8 +158,8 @@ struct backport_genl_family {
 	void			(*mcast_unbind)(struct net *net, int group);
  */
 	struct nlattr **	attrbuf;	/* private */
-	__genl_const struct genl_ops *	ops;
-	__genl_const struct genl_multicast_group *mcgrps;
+	const struct genl_ops *	ops;
+	const struct genl_multicast_group *mcgrps;
 	unsigned int		n_ops;
 	unsigned int		n_mcgrps;
 	struct module		*module;
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 97d2c60e..89cdd9c0 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -17,7 +17,7 @@
 #include <net/netlink.h>
 #include <net/sock.h>
 
-static const struct genl_family *find_family_real_ops(__genl_const struct genl_ops **ops)
+static const struct genl_family *find_family_real_ops(const struct genl_ops **ops)
 {
 	const struct genl_family *family;
 	const struct genl_ops *tmp_ops = *ops;
@@ -148,7 +148,7 @@ static int extack_doit(struct sk_buff *skb, struct genl_info *info)
 }
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
-static int backport_pre_doit(__genl_const struct genl_ops *ops,
+static int backport_pre_doit(const struct genl_ops *ops,
 			     struct sk_buff *skb,
 			     struct genl_info *info)
 {
@@ -198,7 +198,7 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 	return err;
 }
 
-static void backport_post_doit(__genl_const struct genl_ops *ops,
+static void backport_post_doit(const struct genl_ops *ops,
 			       struct sk_buff *skb,
 			       struct genl_info *info)
 {
diff --git a/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch b/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
deleted file mode 100644
index b7b2ec2b..00000000
--- a/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/drivers/net/wireless/marvell/mwifiex/decl.h
-+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
-@@ -26,7 +26,7 @@
- #include <linux/wait.h>
- #include <linux/timer.h>
- #include <linux/ieee80211.h>
--#include <uapi/linux/if_arp.h>
-+#include <linux/if_arp.h>
- #include <net/cfg80211.h>
- 
- #define MWIFIEX_BSS_COEX_COUNT	     2
---- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
-+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
-@@ -17,7 +17,7 @@
-  * this warranty disclaimer.
-  */
- 
--#include <uapi/linux/ipv6.h>
-+#include <linux/ipv6.h>
- #include <net/ndisc.h>
- #include "decl.h"
- #include "ioctl.h"
diff --git a/patches/0001-group-attr/0001-group_attr_class.cocci b/patches/0001-group-attr/0001-group_attr_class.cocci
deleted file mode 100644
index b08cb3cd..00000000
--- a/patches/0001-group-attr/0001-group_attr_class.cocci
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
-The new attribute sysfs group was added onto struct class via
-commit d05a6f96c
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains d05a6f96c
-v3.11-rc2~18^2~3
-
-This backpoort makes use of the helpers to backport this more efficiently.
-Refer to the INFO file for documentation there on that.
-
-commit d05a6f96c76062b5f25858ac02cf677602076f7e
-Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-Date:   Sun Jul 14 16:05:58 2013 -0700
-
-    driver core: add default groups to struct class
-
-    We should be using groups, not attribute lists, for classes to allow
-    subdirectories, and soon, binary files.  Groups are just more flexible
-    overall, so add them.
-
-    The dev_attrs list will go away after all in-kernel users are converted
-    to use dev_groups.
-
-    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
-    Tested-by: Guenter Roeck <linux@roeck-us.net>
-    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-*/
-
-@ attribute_group @
-identifier group;
-declarer name ATTRIBUTE_GROUPS;
-@@
-
-ATTRIBUTE_GROUPS(group);
-
-@script:python attribute_groups_name@
-group << attribute_group.group;
-groups;
-@@
-coccinelle.groups = group + "_groups"
-
-@ class_group @
-identifier group_class;
-identifier attribute_groups_name.groups;
-fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
-@@
-
-struct class group_class = {
-+#if LINUX_VERSION_IS_GEQ(3,11,0)
-	.dev_groups = groups,
-+#else
-+	.dev_attrs = group_dev_attr,
-+#endif
-};
-
-@ attribute_group_mod depends on class_group @
-declarer name ATTRIBUTE_GROUPS_BACKPORT;
-identifier attribute_group.group;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,11,0)
-ATTRIBUTE_GROUPS(group);
-+#else
-+#define BP_ATTR_GRP_STRUCT device_attribute
-+ATTRIBUTE_GROUPS_BACKPORT(group);
-+#endif
-
-@ class_registering @
-identifier class_register, ret;
-identifier class_group.group_class;
-fresh identifier group_class_init = "init_" ## attribute_group.group ## "_attrs";
-@@
-
-(
-+	group_class_init();
-	return class_register(&group_class);
-|
-+	group_class_init();
-	ret = class_register(&group_class);
-)
diff --git a/patches/0001-group-attr/0002-group_attr_bus.cocci b/patches/0001-group-attr/0002-group_attr_bus.cocci
deleted file mode 100644
index 5d75144d..00000000
--- a/patches/0001-group-attr/0002-group_attr_bus.cocci
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
-The new attribute sysfs group was added onto struct bus_type via
-commit fa6fdb33b
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains fa6fdb33b
-v3.12-rc1~184^2~89
-
-This backport makes use of the helpers to backport this more efficiently.
-Refer to the INFO file for documentation there on that.
-
-commit fa6fdb33b486a8afc5439c504da8d581e142c77d
-Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-Date:   Thu Aug 8 15:22:55 2013 -0700
-
-    driver core: bus_type: add dev_groups
-
-    attribute groups are much more flexible than just a list of attributes,
-    due to their support for visibility of the attributes, and binary
-    attributes. Add dev_groups to struct bus_type which should be used
-    instead of dev_attrs.
-
-    dev_attrs will be removed from the structure soon.
-
-    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-*/
-
-@ attribute_group @
-identifier group;
-declarer name ATTRIBUTE_GROUPS;
-@@
-
-ATTRIBUTE_GROUPS(group);
-
-@script:python attribute_groups_name@
-group << attribute_group.group;
-groups;
-@@
-coccinelle.groups = group + "_groups"
-
-@ bus_group @
-identifier group_bus;
-identifier attribute_groups_name.groups;
-fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
-@@
-
-struct bus_type group_bus = {
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
-	.dev_groups = groups,
-+#else
-+	.dev_attrs = group_dev_attr,
-+#endif
-};
-
-@ attribute_group_mod depends on bus_group @
-declarer name ATTRIBUTE_GROUPS_BACKPORT;
-identifier attribute_group.group;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
-ATTRIBUTE_GROUPS(group);
-+#else
-+#define BP_ATTR_GRP_STRUCT device_attribute
-+ATTRIBUTE_GROUPS_BACKPORT(group);
-+#endif
-
-@ bus_registering @
-identifier bus_register, ret;
-identifier bus_group.group_bus;
-fresh identifier group_bus_init = "init_" ## attribute_group.group ## "_attrs";
-@@
-
-(
-+       group_bus_init();
-        return bus_register(&group_bus);
-|
-+       group_bus_init();
-        ret = bus_register(&group_bus);
-)
diff --git a/patches/0001-group-attr/0003-class_groups.cocci b/patches/0001-group-attr/0003-class_groups.cocci
deleted file mode 100644
index 781f6c2b..00000000
--- a/patches/0001-group-attr/0003-class_groups.cocci
+++ /dev/null
@@ -1,54 +0,0 @@
-/* see upstream commit ced6473e74867 */
-
-@ attribute_group @
-identifier group;
-declarer name ATTRIBUTE_GROUPS;
-@@
-
-ATTRIBUTE_GROUPS(group);
-
-@script:python attribute_groups_name@
-group << attribute_group.group;
-groups;
-@@
-coccinelle.groups = group + "_groups"
-
-@ class_group @
-identifier group_class;
-identifier attribute_groups_name.groups;
-fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
-@@
-
-struct class group_class = {
-+#if LINUX_VERSION_IS_GEQ(4,10,0)
-	.class_groups = groups,
-+#else
-+	.class_attrs = group_dev_attr,
-+#endif
-};
-
-@ attribute_group_mod depends on class_group @
-declarer name ATTRIBUTE_GROUPS_BACKPORT;
-identifier attribute_group.group;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(4,10,0)
-ATTRIBUTE_GROUPS(group);
-+#else
-+#define BP_ATTR_GRP_STRUCT class_attribute
-+ATTRIBUTE_GROUPS_BACKPORT(group);
-+#endif
-
-@ class_registering @
-identifier class_register, ret;
-identifier class_group.group_class;
-fresh identifier group_class_init = "init_" ## attribute_group.group ## "_attrs";
-@@
-
-(
-+	group_class_init();
-	return class_register(&group_class);
-|
-+	group_class_init();
-	ret = class_register(&group_class);
-)
diff --git a/patches/0001-group-attr/INFO b/patches/0001-group-attr/INFO
deleted file mode 100644
index 87590d5c..00000000
--- a/patches/0001-group-attr/INFO
+++ /dev/null
@@ -1,40 +0,0 @@
-The new attribute sysfs group was added via these commits:
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains f2f37f58b
-v3.11-rc2~18^2~9
-mcgrof@ergon ~/linux (git::master)$ git describe --contains 3493f69f4
-v3.11-rc2~18^2~2
-
-We backport them with our own respective set of helpers. Each new data
-structure that gets an attribute group needs a respective SmPL set of
-rules for the transformation. We might be able to share the rules for
-lookup / indexing between rules some how. These lookup reveal would
-be used for inherent structural searches, pivots, if you will.
-
-The changes that added the new APIs:
-
-commit f2f37f58b1b933b06d6d84e80a31a1b500fb0db2
-Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-Date:   Sun Jul 14 16:05:52 2013 -0700
-
-    sysfs.h: add ATTRIBUTE_GROUPS() macro
-
-    To make it easier for driver subsystems to work with attribute groups,
-    create the ATTRIBUTE_GROUPS macro to remove some of the repetitive
-    typing for the most common use for attribute groups.
-
-    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
-    Tested-by: Guenter Roeck <linux@roeck-us.net>
-    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-
-commit 3493f69f4c4e8703961919a9a56c2d2e6a25b46f
-Author: Oliver Schinagl <oliver@schinagl.nl>
-Date:   Sun Jul 14 16:05:59 2013 -0700
-
-    sysfs: add more helper macro's for (bin_)attribute(_groups)
-
-    With the recent changes to sysfs there's various helper macro's.
-    However there's no RW, RO BIN_ helper macro's. This patch adds them.
-
-    Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
-    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/patches/0001-netlink-portid.cocci b/patches/0001-netlink-portid.cocci
deleted file mode 100644
index 5fc504ef..00000000
--- a/patches/0001-netlink-portid.cocci
+++ /dev/null
@@ -1,17 +0,0 @@
-@@
-struct netlink_notify *notify;
-@@
--notify->portid
-+netlink_notify_portid(notify)
-
-@@
-struct genl_info *info;
-@@
--info->snd_portid
-+genl_info_snd_portid(info)
-
-@@
-expression skb;
-@@
--NETLINK_CB(skb).portid
-+NETLINK_CB_PORTID(skb)
diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
deleted file mode 100644
index 2dea3fd1..00000000
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ /dev/null
@@ -1,46 +0,0 @@
-On older kernels, we can't do this workaround, so if you use
-an old 64-bit kernel with compat you'd better upgrade.
-
-For more details of this work around refer to this commit
-upstream that deals with the code added:
-
-commit 645e77def93f1dd0e211c7244fbe152dac8a7100
-Author: Johannes Berg <johannes.berg@intel.com>
-Date:   Fri Mar 1 14:03:49 2013 +0100
-
-    nl80211: increase wiphy dump size dynamically
-    
-    Given a device with many channels capabilities the wiphy
-    information can still overflow even though its size in
-    3.9 was reduced to 3.8 levels. For new userspace and
-    kernel 3.10 we're going to implement a new "split dump"
-    protocol that can use multiple messages per wiphy.
-    
-    For now though, add a workaround to be able to send more
-    information to userspace. Since generic netlink doesn't
-    have a way to set the minimum dump size globally, and we
-    wouldn't really want to set it globally anyway, increase
-    the size only when needed, as described in the comments.
-    As userspace might not be prepared for large buffers, we
-    can only use 4k.
-    
-    Also increase the size for the get_wiphy command.
-
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -2771,6 +2771,7 @@ static int nl80211_dump_wiphy(struct sk_
- 						 cb->nlh->nlmsg_seq,
- 						 NLM_F_MULTI, state);
- 			if (ret < 0) {
-+#if LINUX_VERSION_IS_GEQ(3,1,0)
- 				/*
- 				 * If sending the wiphy data didn't fit (ENOBUFS
- 				 * or EMSGSIZE returned), this SKB is still
-@@ -2792,6 +2793,7 @@ static int nl80211_dump_wiphy(struct sk_
- 					rtnl_unlock();
- 					return 1;
- 				}
-+#endif
- 				idx--;
- 				break;
- 			}
diff --git a/patches/0012-driver-quirks/INFO b/patches/0012-driver-quirks/INFO
deleted file mode 100644
index 56d3cbd7..00000000
--- a/patches/0012-driver-quirks/INFO
+++ /dev/null
@@ -1,2 +0,0 @@
-Some quirks require base kernel updates, these are work
-around for kernels that would not have these quirks.
diff --git a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
deleted file mode 100644
index 4f592b92..00000000
--- a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
-+++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
-@@ -245,6 +245,12 @@ static size_t cw1200_sdio_align_size(str
- 	else
- 		size = sdio_align_size(self->func, size);
- 
-+#if LINUX_VERSION_IS_LESS(3, 2, 0)
-+	/* A quirk to handle this was committed in 3.2-rc */
-+	if (size == SDIO_BLOCK_SIZE)
-+		size += SDIO_BLOCK_SIZE;  /* HW bug; force use of block mode */
-+#endif
-+
- 	return size;
- }
- 
diff --git a/patches/0013-fix-makefile-includes/ath10k.patch b/patches/0013-fix-makefile-includes/ath10k.patch
deleted file mode 100644
index 0c324eba..00000000
--- a/patches/0013-fix-makefile-includes/ath10k.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/ath/ath10k/htt.h
-+++ b/drivers/net/wireless/ath/ath10k/htt.h
-@@ -9,6 +9,7 @@
- #define _HTT_H_
- 
- #include <linux/bug.h>
-+#include <linux/idr.h>
- #include <linux/interrupt.h>
- #include <linux/dmapool.h>
- #include <linux/hashtable.h>
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
deleted file mode 100644
index 8b34d5e7..00000000
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -9315,7 +9315,9 @@ static int nl80211_dump_scan(struct sk_b
- 	if (start == 0)
- 		cfg80211_bss_expire(rdev);
- 
-+#if LINUX_VERSION_IS_GEQ(3,1,0)
- 	cb->seq = rdev->bss_generation;
-+#endif
- 
- 	list_for_each_entry(scan, &rdev->bss_list, list) {
- 		if (++idx <= start)
diff --git a/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
deleted file mode 100644
index 3b3499e2..00000000
--- a/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
-+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
-@@ -161,7 +161,11 @@ that only one external action is invoked
- #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2100 Network Driver"
- #define DRV_COPYRIGHT	"Copyright(c) 2003-2006 Intel Corporation"
- 
-+#if LINUX_VERSION_IS_LESS(3,2,0)
-+static struct pm_qos_request_list ipw2100_pm_qos_req;
-+#else
- static struct pm_qos_request ipw2100_pm_qos_req;
-+#endif
- 
- /* Debugging stuff */
- #ifdef CONFIG_IPW2100_DEBUG
diff --git a/patches/0016-libertas-olpc-ec-wakeup/INFO b/patches/0016-libertas-olpc-ec-wakeup/INFO
deleted file mode 100644
index ddb4f335..00000000
--- a/patches/0016-libertas-olpc-ec-wakeup/INFO
+++ /dev/null
@@ -1,5 +0,0 @@
-This section of the libertas driver calls functions that simply don't
-exist before the release of 3.1.  This code in question was an addition,
-not a change from any existing code.  It is safe to simply remove it for
-older kernels.
-
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
deleted file mode 100644
index 8fab382a..00000000
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/drivers/net/wireless/marvell/libertas/if_usb.c
-+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -941,6 +941,7 @@ static int if_usb_suspend(struct usb_int
- 		goto out;
- 	}
- 
-+#if LINUX_VERSION_IS_GEQ(3,1,0)
- #ifdef CONFIG_OLPC
- 	if (machine_is_olpc()) {
- 		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -949,6 +950,7 @@ static int if_usb_suspend(struct usb_int
- 			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
- 	}
- #endif
-+#endif
- 
- 	ret = lbs_suspend(priv);
- 	if (ret)
diff --git a/patches/0017-get_ts_info/INFO b/patches/0017-get_ts_info/INFO
deleted file mode 100644
index a43dd308..00000000
--- a/patches/0017-get_ts_info/INFO
+++ /dev/null
@@ -1,27 +0,0 @@
-Linux 3.5 will have get_ts_info to support the Precision Time Protocol.
-
-http://linuxptp.sourceforge.net/
-http://en.wikipedia.org/wiki/Precision_Time_Protocol
-
-We cannot backport this support given that this introduces
-a data structure change on the ethtool_ops.
-
-commit c8f3a8c31069137fe0100e6920558f1a7487ef3c
-Author: Richard Cochran <richardcochran@gmail.com>
-Date:   Tue Apr 3 22:59:17 2012 +0000
-
-    ethtool: Introduce a method for getting time stamping capabilities.
-    
-    This commit adds a new ethtool ioctl that exposes the SO_TIMESTAMPING
-    capabilities of a network interface. In addition, user space programs
-    can use this ioctl to discover the PTP Hardware Clock (PHC) device
-    associated with the interface.
-    
-    Since software receive time stamps are handled by the stack, the generic
-    ethtool code can answer the query correctly in case the MAC or PHY
-    drivers lack special time stamping features.
-    
-    Signed-off-by: Richard Cochran <richardcochran@gmail.com>
-    Reviewed-by: Ben Hutchings <bhutchings@solarflare.com>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
diff --git a/patches/0017-get_ts_info/get_ts_info.cocci b/patches/0017-get_ts_info/get_ts_info.cocci
deleted file mode 100644
index 43f4339f..00000000
--- a/patches/0017-get_ts_info/get_ts_info.cocci
+++ /dev/null
@@ -1,19 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct ethtool_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-.get_ts_info = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
-};
-
-// ----------------------------------------------------------------------
-
-@@
-identifier r1.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
diff --git a/patches/0019-usb_driver_lpm.cocci b/patches/0019-usb_driver_lpm.cocci
deleted file mode 100644
index 793ca4e6..00000000
--- a/patches/0019-usb_driver_lpm.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@@
-identifier backport_driver;
-@@
-struct usb_driver backport_driver = {
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-	.disable_hub_initiated_lpm = 1,
-+#endif
-...
-};
diff --git a/patches/0020-tty-termios/INFO b/patches/0020-tty-termios/INFO
deleted file mode 100644
index abd5c360..00000000
--- a/patches/0020-tty-termios/INFO
+++ /dev/null
@@ -1,23 +0,0 @@
-This patch requires a manual backport:
-
-commit adc8d746caa67fff4b53ba3e5163a6cbacc3b523
-Author: Alan Cox <alan@linux.intel.com>
-Date:   Sat Jul 14 15:31:47 2012 +0100
-
-    tty: move the termios object into the tty
-    
-    This will let us sort out a whole pile of tty related races. The
-    alternative would be to keep points and refcount the termios objects.
-    However
-    1. They are tiny anyway
-    2. Many devices don't use the stored copies
-    3. We can remove a pty special case
-    
-    Signed-off-by: Alan Cox <alan@linux.intel.com>
-    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-
-We cannot use compat.git for this given that the assignment
-was not done through a static inline helper.
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains adc8d746caa67fff4b53ba3e5163a6cbacc3b523
-v3.7-rc1~172^2~187
diff --git a/patches/0021-umode_t-api-change/ath10k.patch b/patches/0021-umode_t-api-change/ath10k.patch
deleted file mode 100644
index 1b040554..00000000
--- a/patches/0021-umode_t-api-change/ath10k.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath10k/spectral.c
-+++ b/drivers/net/wireless/ath/ath10k/spectral.c
-@@ -475,7 +475,11 @@ static const struct file_operations fops
- 
- static struct dentry *create_buf_file_handler(const char *filename,
- 					      struct dentry *parent,
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 					      umode_t mode,
-+#else
-+					      int mode,
-+#endif
- 					      struct rchan_buf *buf,
- 					      int *is_global)
- {
diff --git a/patches/0021-umode_t-api-change/ath9k.patch b/patches/0021-umode_t-api-change/ath9k.patch
deleted file mode 100644
index 1be51cb9..00000000
--- a/patches/0021-umode_t-api-change/ath9k.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/common-spectral.c
-+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
-@@ -1031,7 +1031,11 @@ static const struct file_operations fops
- 
- static struct dentry *create_buf_file_handler(const char *filename,
- 					      struct dentry *parent,
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 					      umode_t mode,
-+#else
-+					      int mode,
-+#endif
- 					      struct rchan_buf *buf,
- 					      int *is_global)
- {
diff --git a/patches/0022-define-tracing/INFO b/patches/0022-define-tracing/INFO
deleted file mode 100644
index 19290872..00000000
--- a/patches/0022-define-tracing/INFO
+++ /dev/null
@@ -1,9 +0,0 @@
-For some reason the tracing on older kernels requires
-the tracing to be declared before it's defined; it's
-broken when the trace header is only included to create
-the tracepoints.
-
-Since new kernels don't, add patches for the two places
-that rely on the new behaviour.
-
-The kernel that requires this has not been identified...
diff --git a/patches/0022-define-tracing/ath6kl.patch b/patches/0022-define-tracing/ath6kl.patch
deleted file mode 100644
index d0bf8944..00000000
--- a/patches/0022-define-tracing/ath6kl.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/trace.c
-+++ b/drivers/net/wireless/ath/ath6kl/trace.c
-@@ -15,6 +15,9 @@
-  */
- 
- #include <linux/module.h>
-+#if LINUX_VERSION_IS_LESS(3,1,0)
-+#include <linux/interrupt.h>
-+#endif
- 
- #define CREATE_TRACE_POINTS
- #include "trace.h"
diff --git a/patches/0022-define-tracing/cfg80211.patch b/patches/0022-define-tracing/cfg80211.patch
deleted file mode 100644
index e2b57a8c..00000000
--- a/patches/0022-define-tracing/cfg80211.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/wireless/trace.c
-+++ b/net/wireless/trace.c
-@@ -1,4 +1,7 @@
- #include <linux/module.h>
-+#if LINUX_VERSION_IS_LESS(3,1,0)
-+#include <linux/interrupt.h>
-+#endif
- 
- #ifndef __CHECKER__
- #define CREATE_TRACE_POINTS
diff --git a/patches/0022-define-tracing/mt7601u.patch b/patches/0022-define-tracing/mt7601u.patch
deleted file mode 100644
index 7649944b..00000000
--- a/patches/0022-define-tracing/mt7601u.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/mediatek/mt7601u/trace.c
-+++ b/drivers/net/wireless/mediatek/mt7601u/trace.c
-@@ -5,6 +5,9 @@
-  */
- 
- #include <linux/module.h>
-+#if LINUX_VERSION_IS_LESS(3,4,0)
-+#include <linux/interrupt.h>
-+#endif
- 
- #ifndef __CHECKER__
- #define CREATE_TRACE_POINTS
diff --git a/patches/0022-define-tracing/wil6210.patch b/patches/0022-define-tracing/wil6210.patch
deleted file mode 100644
index a1093d16..00000000
--- a/patches/0022-define-tracing/wil6210.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ath/wil6210/trace.c
-+++ b/drivers/net/wireless/ath/wil6210/trace.c
-@@ -4,6 +4,9 @@
-  */
- 
- #include <linux/module.h>
-+#if LINUX_VERSION_IS_LESS(3,1,0)
-+#include <linux/interrupt.h>
-+#endif
- 
- #define CREATE_TRACE_POINTS
- #include "trace.h"
diff --git a/patches/0024-led-blink-api/INFO b/patches/0024-led-blink-api/INFO
deleted file mode 100644
index f5f4d30b..00000000
--- a/patches/0024-led-blink-api/INFO
+++ /dev/null
@@ -1,13 +0,0 @@
-backports: use old led api on old kernel versions.
-
-Usage of a new led api was introduced in mac80211, this patch make
-backports use the old api on older kernel versions. This could cause a
-problem with the led, the transmit led could stay on if nothing is
-transfered.
-
-This backports the following upstream commit:
-commit e47f2509e5f182f4df144406de6f2bc78179d57e
-Author: Fabio Baltieri <fabio.baltieri@gmail.com>
-Date:   Thu Jul 25 12:00:26 2013 +0200
-
-    mac80211: use oneshot blink API for LED triggers
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
deleted file mode 100644
index b1712de4..00000000
--- a/patches/0024-led-blink-api/mac80211.patch
+++ /dev/null
@@ -1,51 +0,0 @@
---- a/net/mac80211/ieee80211_i.h
-+++ b/net/mac80211/ieee80211_i.h
-@@ -1320,6 +1320,7 @@ struct ieee80211_local {
- 	struct mutex chanctx_mtx;
- 
- #ifdef CONFIG_MAC80211_LEDS
-+	int tx_led_counter, rx_led_counter;
- 	struct led_trigger tx_led, rx_led, assoc_led, radio_led;
- 	struct led_trigger tpt_led;
- 	atomic_t tx_led_active, rx_led_active, assoc_led_active;
---- a/net/mac80211/led.h
-+++ b/net/mac80211/led.h
-@@ -13,22 +13,36 @@
- static inline void ieee80211_led_rx(struct ieee80211_local *local)
- {
- #ifdef CONFIG_MAC80211_LEDS
--	unsigned long led_delay = MAC80211_BLINK_DELAY;
-+	unsigned long led_delay __maybe_unused = MAC80211_BLINK_DELAY;
- 
- 	if (!atomic_read(&local->rx_led_active))
- 		return;
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
- 	led_trigger_blink_oneshot(&local->rx_led, &led_delay, &led_delay, 0);
-+#else
-+	if (local->rx_led_counter++ % 2 == 0)
-+		led_trigger_event(&local->rx_led, LED_OFF);
-+	else
-+		led_trigger_event(&local->rx_led, LED_FULL);
-+#endif
- #endif
- }
- 
- static inline void ieee80211_led_tx(struct ieee80211_local *local)
- {
- #ifdef CONFIG_MAC80211_LEDS
--	unsigned long led_delay = MAC80211_BLINK_DELAY;
-+	unsigned long led_delay __maybe_unused = MAC80211_BLINK_DELAY;
- 
- 	if (!atomic_read(&local->tx_led_active))
- 		return;
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
- 	led_trigger_blink_oneshot(&local->tx_led, &led_delay, &led_delay, 0);
-+#else
-+	if (local->tx_led_counter++ % 2 == 0)
-+		led_trigger_event(&local->tx_led, LED_OFF);
-+	else
-+		led_trigger_event(&local->tx_led, LED_FULL);
-+#endif
- #endif
- }
- 
diff --git a/patches/0025-usb-sg/INFO b/patches/0025-usb-sg/INFO
deleted file mode 100644
index 0d4981a8..00000000
--- a/patches/0025-usb-sg/INFO
+++ /dev/null
@@ -1,17 +0,0 @@
-backports: do not use DMA SG on old kernel versions
-
-the usb net driver now uses the dma sg api which is not available on
-old kernels, this patch removed the usage of the dma sg api for old
-kernel versions.
-
-This backports the following upstream commit:
-commit 638c5115a794981441246fa8fa5d95c1875af5ba
-Author: Ming Lei <ming.lei@canonical.com>
-Date:   Thu Aug 8 21:48:24 2013 +0800
-
-    USBNET: support DMA SG
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains 638c5115a794981441246fa8fa5d95c1875af5ba
-v3.12-rc1~186^2~110
-
-XXX: this patch seems odd, the kernel versoin used seems off.
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
deleted file mode 100644
index ed72fefc..00000000
--- a/patches/0025-usb-sg/usbnet.patch
+++ /dev/null
@@ -1,73 +0,0 @@
---- a/drivers/net/usb/usbnet.c
-+++ b/drivers/net/usb/usbnet.c
-@@ -1285,6 +1285,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
- 
- /*-------------------------------------------------------------------------*/
- 
-+#if LINUX_VERSION_IS_GEQ(3,35,0)
- static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
- {
- 	unsigned num_sgs, total_len = 0;
-@@ -1317,6 +1318,12 @@ static int build_dma_sg(const struct sk_
- 
- 	return 1;
- }
-+#else
-+static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
-+{
-+	return -ENXIO;
-+}
-+#endif
- 
- netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
- 				     struct net_device *net)
-@@ -1373,12 +1380,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
- 		if (!(info->flags & FLAG_SEND_ZLP)) {
- 			if (!(info->flags & FLAG_MULTI_PACKET)) {
- 				length++;
-+#if LINUX_VERSION_IS_GEQ(3,35,0)
- 				if (skb_tailroom(skb) && !urb->num_sgs) {
- 					skb->data[skb->len] = 0;
- 					__skb_put(skb, 1);
- 				} else if (urb->num_sgs)
- 					sg_set_buf(&urb->sg[urb->num_sgs++],
- 							dev->padding_pkt, 1);
-+#else
-+				if (skb_tailroom(skb)) {
-+					skb->data[skb->len] = 0;
-+					__skb_put(skb, 1);
-+				}
-+#endif
- 			}
- 		} else
- 			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1450,7 +1464,9 @@ not_drop:
- 		if (skb)
- 			dev_kfree_skb_any (skb);
- 		if (urb) {
-+#if LINUX_VERSION_IS_GEQ(3,35,0)
- 			kfree(urb->sg);
-+#endif
- 			usb_free_urb(urb);
- 		}
- 	} else
-@@ -1503,7 +1519,9 @@ static void usbnet_bh (struct timer_list
- 			rx_process (dev, skb);
- 			continue;
- 		case tx_done:
-+#if LINUX_VERSION_IS_GEQ(3,35,0)
- 			kfree(entry->urb->sg);
-+#endif
- 			fallthrough;
- 		case rx_cleanup:
- 			usb_free_urb (entry->urb);
-@@ -1878,7 +1896,9 @@ int usbnet_resume (struct usb_interface
- 			retval = usb_submit_urb(res, GFP_ATOMIC);
- 			if (retval < 0) {
- 				dev_kfree_skb_any(skb);
-+#if LINUX_VERSION_IS_GEQ(3,35,0)
- 				kfree(res->sg);
-+#endif
- 				usb_free_urb(res);
- 				usb_autopm_put_interface_async(dev->intf);
- 			} else {
diff --git a/patches/0026-ipv6_stub/INFO b/patches/0026-ipv6_stub/INFO
deleted file mode 100644
index 3128b561..00000000
--- a/patches/0026-ipv6_stub/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-We can not easily backport ipv6_stub which provides some IPv6 function 
-callbacks.
-These patches are removing usage of ipv6_stub which was introduces in 
-this commit:
-commit 5f81bd2e5d804ca93f3ec8873451b22d2f454721
-Author: Cong Wang <amwang@redhat.com>
-Date:   Sat Aug 31 13:44:30 2013 +0800
-
-    ipv6: export a stub for IPv6 symbols used by vxlan
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains 5f81bd2e5d804ca93f3ec8873451b22d2f454721
-v3.12-rc1~132^2~101
diff --git a/patches/0026-ipv6_stub/cdc_mbim.patch b/patches/0026-ipv6_stub/cdc_mbim.patch
deleted file mode 100644
index 868928bb..00000000
--- a/patches/0026-ipv6_stub/cdc_mbim.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/drivers/net/usb/cdc_mbim.c
-+++ b/drivers/net/usb/cdc_mbim.c
-@@ -300,6 +300,7 @@ error:
- 	return NULL;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- /* Some devices are known to send Neigbor Solicitation messages and
-  * require Neigbor Advertisement replies.  The IPv6 core will not
-  * respond since IFF_NOARP is set, so we must handle them ourselves.
-@@ -360,6 +361,7 @@ static bool is_neigh_solicit(u8 *buf, si
- 		msg->icmph.icmp6_code == 0 &&
- 		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
- }
-+#endif /* LINUX_VERSION_IS_GEQ(3,12,0) */
- 
- 
- static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
-@@ -376,8 +378,10 @@ static struct sk_buff *cdc_mbim_process_
- 			proto = htons(ETH_P_IP);
- 			break;
- 		case 0x60:
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 			if (is_neigh_solicit(buf, len))
- 				do_neigh_solicit(dev, buf, tci);
-+#endif /* LINUX_VERSION_IS_GEQ(3,12,0) */
- 			proto = htons(ETH_P_IPV6);
- 			break;
- 		default:
diff --git a/patches/0027-genl-const/INFO b/patches/0027-genl-const/INFO
deleted file mode 100644
index 192c5c65..00000000
--- a/patches/0027-genl-const/INFO
+++ /dev/null
@@ -1,15 +0,0 @@
-Newer kernels make generic netlink ops and multicast groups
-const, but older can't have that. We therefore introduce
-__genl_const, which can be defined depending on the kernel.
-
-What kernel versions require this?
-
-XXX: try to SmPLify
-
-The struct genl_ops gave the *option* to make it const via:
-mcgrof@ergon ~/linux (git::master)$ git describe --contains f84f771d9
-v3.13-rc1~33^2~32^2~2
-
-The struct genl_multicast_group was *forced* to be const via:
-mcgrof@ergon ~/linux (git::master)$ git describe --contains 2a94fe48f
-v3.13-rc1~33^2^2
diff --git a/patches/0027-genl-const/genl-const.cocci b/patches/0027-genl-const/genl-const.cocci
deleted file mode 100644
index 58824c72..00000000
--- a/patches/0027-genl-const/genl-const.cocci
+++ /dev/null
@@ -1,10 +0,0 @@
-@@
-attribute name __genl_const;
-@@
-(
--const struct genl_multicast_group
-+__genl_const struct genl_multicast_group
-|
--const struct genl_ops
-+__genl_const struct genl_ops
-)
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index eae033ad..36738162 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -695,9 +695,29 @@ static void ieee80211_uninit(struct net_
+@@ -695,9 +695,21 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -13,24 +13,16 @@
 +					 struct sk_buff *skb,
 +					 struct net_device *sb_dev,
 +					 select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++#else
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 +					 struct sk_buff *skb,
 +					 void *accel_priv,
 +					 select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_IS_GEQ(3,13,0)
-+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-+					 struct sk_buff *skb,
-+					 void *accel_priv)
-+#else
-+static u16 ieee80211_netdev_select_queue(struct net_device *dev,
-+					 struct sk_buff *skb)
 +#endif
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -719,9 +739,29 @@ static const struct net_device_ops ieee8
+@@ -719,9 +731,21 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
@@ -43,19 +35,11 @@
 +					  struct sk_buff *skb,
 +					  struct net_device *sb_dev,
 +					  select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++#else
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 +					  struct sk_buff *skb,
 +					  void *accel_priv,
 +					  select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_IS_GEQ(3,13,0)
-+static u16 ieee80211_monitor_select_queue(struct net_device *dev,
-+					  struct sk_buff *skb,
-+					  void *accel_priv)
-+#else
-+static u16 ieee80211_monitor_select_queue(struct net_device *dev,
-+					  struct sk_buff *skb)
 +#endif
  {
  	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index fa99dba0..24d146ed 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1279,9 +1279,28 @@ static struct net_device_stats *mwifiex_
+@@ -1279,9 +1279,20 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
@@ -13,18 +13,10 @@
 +mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
 +				struct net_device *sb_dev,
 +				select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++#else
 +static u16
 +mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
 +				void *accel_priv, select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_IS_GEQ(3,13,0)
-+static u16
-+mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
-+				void *accel_priv)
-+#else
-+static u16
-+mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb)
 +#endif
  {
  	skb->priority = cfg80211_classify8021d(skb, NULL);
diff --git a/patches/0029-struct_hid_ll_driver-extensions/INFO b/patches/0029-struct_hid_ll_driver-extensions/INFO
deleted file mode 100644
index 01810115..00000000
--- a/patches/0029-struct_hid_ll_driver-extensions/INFO
+++ /dev/null
@@ -1,16 +0,0 @@
-This is backported because of:
-
-commit cd4dc0821bc97947f25c8483a4aa0711bff8619a
-Author: Frank Praznik <frank.praznik@oh.rr.com>
-Date:   Wed Jan 22 13:49:41 2014 -0500
-
-    HID: Add transport-driver callbacks to the hid_ll_driver struct
-    
-    Add raw_request and output_report callbacks to the hid_ll_driver struct.
-    
-    Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
-    Acked-by: David Herrmann <dh.herrmann@gmail.com>
-    Signed-off-by: Jiri Kosina <jkosina@suse.cz>
-
-This did not make it to v3.14, so its only present on linux-next, its
-available for example on next-20140409
diff --git a/patches/0030-qdisc_tx_busylock/INFO b/patches/0030-qdisc_tx_busylock/INFO
deleted file mode 100644
index e5d96233..00000000
--- a/patches/0030-qdisc_tx_busylock/INFO
+++ /dev/null
@@ -1,22 +0,0 @@
-struct net_device got an extension with the member qdisc_tx_busylock
-as of commit 23d3b8bfb. For older kernels we need to ifdef around that
-as its now available.
-
-mcgrof@ergon ~/linux (git::master)$ git describe --contains 23d3b8bfb
-v3.7-rc1~145^2~208
-
-commit 23d3b8bfb8eb20e7d96afa09991e6a5ed1c83164
-Author: Eric Dumazet <edumazet@google.com>
-Date:   Wed Sep 5 01:02:56 2012 +0000
-
-    net: qdisc busylock needs lockdep annotations
-    
-    It seems we need to provide ability for stacked devices
-    to use specific lock_class_key for sch->busylock
-    
-    We could instead default l2tpeth tx_queue_len to 0 (no qdisc), but
-    a user might use a qdisc anyway.
-    
-    (So same fixes are probably needed on non LLTX stacked drivers)
-
-[ the commit log goes we only include up to here to help with context ]
diff --git a/patches/0031-sk_data_ready.cocci b/patches/0031-sk_data_ready.cocci
deleted file mode 100644
index 44a41c96..00000000
--- a/patches/0031-sk_data_ready.cocci
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
-Commit 676d2369 by David removed the skb->len arguments passed onto
-the struct sock sk_data_ready() callback. This was done as its racy,
-a few drivers were passing 0 to it, and it was not really used.
-By removing it the raciness is addresed but to backport this we are
-going to have to deal with the races as-is on older kernels. This was
-merged as of v3.15:
-
-mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 676d2369
-v3.15-rc1~8^2~10
-
-Since this is not a define or static inline we can't easily replace this with
-the backports module or header files, instead we use SmPL grammar to generalize
-the backport for all use cases. Note that in order to backport this we won't
-know what older kernel drivers were using before this change, it could have
-been 0 or skb->len for the length parameter, since we have to infer something
-we choose skb->len *iff* skb_queue_tail() was used right before it, otherwise
-we infer to throw 0.
-
-commit 676d23690fb62b5d51ba5d659935e9f7d9da9f8e
-Author: David S. Miller <davem@davemloft.net>
-Date:   Fri Apr 11 16:15:36 2014 -0400
-
-    net: Fix use after free by removing length arg from sk_data_ready callbacks.
-    
-    Several spots in the kernel perform a sequence like:
-    
-        skb_queue_tail(&sk->s_receive_queue, skb);
-        sk->sk_data_ready(sk, skb->len);
-    
-    But at the moment we place the SKB onto the socket receive queue it
-    can be consumed and freed up.  So this skb->len access is potentially
-    to freed up memory.
-    
-    Furthermore, the skb->len can be modified by the consumer so it is
-    possible that the value isn't accurate.
-    
-    And finally, no actual implementation of this callback actually uses
-    the length argument.  And since nobody actually cared about it's
-    value, lots of call sites pass arbitrary values in such as '0' and
-    even '1'.
-    
-    So just remove the length argument from the callback, that way there
-    is no confusion whatsoever and all of these use-after-free cases get
-    fixed as a side effect.
-    
-    Based upon a patch by Eric Dumazet and his suggestion to audit this
-    issue tree-wide.
-    
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-*/
-
-@ sk_data_ready_assigned @
-expression E;
-identifier drv_data_ready;
-@@
-
-	E->sk_data_ready = drv_data_ready;
-
-@ sk_data_ready_declared depends on sk_data_ready_assigned @
-identifier sk;
-identifier sk_data_ready_assigned.drv_data_ready;
-fresh identifier backport_drv_data_ready = "backport_" ## drv_data_ready;
-@@
-
-drv_data_ready(struct sock *sk)
-{
-	...
-}
-
-+#if LINUX_VERSION_IS_LESS(3,15,0)
-+static void backport_drv_data_ready(struct sock *sk, int unused)
-+{
-+	drv_data_ready(sk);
-+}
-+#endif
-
-@ sk_data_ready_assigned_mod_e depends on sk_data_ready_assigned @
-expression E;
-identifier sk_data_ready_assigned.drv_data_ready;
-fresh identifier backport_drv_data_ready = "backport_" ## drv_data_ready;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
-	E->sk_data_ready = drv_data_ready;
-+#else
-+	E->sk_data_ready = backport_drv_data_ready;
-+#endif
-
-@ sk_data_ready_found @
-expression E;
-struct sock *sk;
-@@
-
-	E->sk_data_ready(sk);
-
-@ sk_data_ready_skips_skb_queue_tail_E depends on sk_data_ready_found @
-expression E;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
-	E->sk_data_ready(E);
-+#else
-+	E->sk_data_ready(E, 0);
-+#endif
-
-@ sk_data_ready_uses_skb_queue_tail depends on sk_data_ready_found && !sk_data_ready_skips_skb_queue_tail_E @
-struct sock *sk;
-struct sk_buff *skb;
-identifier sk_data_ready;
-@@
-
-	skb_queue_tail(&sk->sk_receive_queue, skb);
-+#if LINUX_VERSION_IS_GEQ(3,15,0)
-	sk->sk_data_ready(sk);
-+#else
-+	sk->sk_data_ready(sk, skb->len);
-+#endif
-
diff --git a/patches/0032-sriov_configure/INFO b/patches/0032-sriov_configure/INFO
deleted file mode 100644
index 813d3528..00000000
--- a/patches/0032-sriov_configure/INFO
+++ /dev/null
@@ -1,13 +0,0 @@
-In kernel 3.8 struct pci_driver got a new function pointer sriov_configure.
-Address this by putting ifdef around the code.
-
-
-commit 1789382a72a537447d65ea4131d8bcc1ad85ce7b
-Author: Donald Dutile <ddutile@redhat.com>
-Date:   Mon Nov 5 15:20:36 2012 -0500
-
-    PCI: SRIOV control and status via sysfs
-
-git describe --contains 1789382a72a537447d65ea4131d8bcc1ad85ce7b
-v3.8-rc1~128^2~6^2~4
-
diff --git a/patches/0032-sriov_configure/sriov_configure.cocci b/patches/0032-sriov_configure/sriov_configure.cocci
deleted file mode 100644
index 9f9f1794..00000000
--- a/patches/0032-sriov_configure/sriov_configure.cocci
+++ /dev/null
@@ -1,19 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct pci_driver s = {
-+#if LINUX_VERSION_IS_GEQ(3,8,0)
-.sriov_configure = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
-};
-
-// ----------------------------------------------------------------------
-
-@@
-identifier r1.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,8,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
diff --git a/patches/0033-ndo_vlan_rx_vid/INFO b/patches/0033-ndo_vlan_rx_vid/INFO
deleted file mode 100644
index 9a612535..00000000
--- a/patches/0033-ndo_vlan_rx_vid/INFO
+++ /dev/null
@@ -1,23 +0,0 @@
-In kernel 3.3 and 3.10 struct net_device_ops function pointers
-ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid changed.
-Address this by putting ifdef around the code.
-
-
-commit 8e586137e6b63af1e881b328466ab5ffbe562510
-Author: Jiri Pirko <jpirko@redhat.com>
-Date:   Thu Dec 8 19:52:37 2011 -0500
-
-    net: make vlan ndo_vlan_rx_[add/kill]_vid return error value
-
-git describe --contains 8e586137e6b63af1e881b328466ab5ffbe562510
-v3.3-rc1~182^2~291
-
-
-commit 80d5c3689b886308247da295a228a54df49a44f6
-Author: Patrick McHardy <kaber@trash.net>
-Date:   Fri Apr 19 02:04:28 2013 +0000
-
-    net: vlan: prepare for 802.1ad VLAN filtering offload
-
-git describe --contains 80d5c3689b886308247da295a228a54df49a44f6
-v3.10-rc1~66^2~97^2~4
diff --git a/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch b/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
deleted file mode 100644
index 5938950a..00000000
--- a/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
+++ /dev/null
@@ -1,48 +0,0 @@
---- a/drivers/net/usb/cdc_mbim.c
-+++ b/drivers/net/usb/cdc_mbim.c
-@@ -68,7 +68,13 @@ static int cdc_mbim_wdm_manage_power(str
- 	return cdc_mbim_manage_power(dev, status);
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
-+#elif LINUX_VERSION_IS_GEQ(3,3,0)
-+static int cdc_mbim_rx_add_vid(struct net_device *netdev, u16 vid)
-+#else
-+static void cdc_mbim_rx_add_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
- {
- 	struct usbnet *dev = netdev_priv(netdev);
- 	struct cdc_mbim_state *info = (void *)&dev->data;
-@@ -76,13 +82,21 @@ static int cdc_mbim_rx_add_vid(struct ne
- 	/* creation of this VLAN is a request to tag IP session 0 */
- 	if (vid == MBIM_IPS0_VID)
- 		info->flags |= FLAG_IPS0_VLAN;
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 	else
- 		if (vid >= 512)	/* we don't map these to MBIM session */
- 			return -EINVAL;
- 	return 0;
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,10,0)
- static int cdc_mbim_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
-+#elif LINUX_VERSION_IS_GEQ(3,3,0)
-+static int cdc_mbim_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#else
-+static void cdc_mbim_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
- {
- 	struct usbnet *dev = netdev_priv(netdev);
- 	struct cdc_mbim_state *info = (void *)&dev->data;
-@@ -90,7 +104,9 @@ static int cdc_mbim_rx_kill_vid(struct n
- 	/* this is a request for an untagged IP session 0 */
- 	if (vid == MBIM_IPS0_VID)
- 		info->flags &= ~FLAG_IPS0_VLAN;
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
- 	return 0;
-+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
- }
- 
- static const struct net_device_ops cdc_mbim_netdev_ops = {
diff --git a/patches/0034-ndo_set_vf_spoofchk/INFO b/patches/0034-ndo_set_vf_spoofchk/INFO
deleted file mode 100644
index 31c4a7e7..00000000
--- a/patches/0034-ndo_set_vf_spoofchk/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-In kernel 3.2 struct net_device_ops got a new function pointer
-ndo_set_vf_spoofchk. Address this by putting ifdef around the code.
-
-
-commit 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
-Author: Greg Rose <gregory.v.rose@intel.com>
-Date:   Sat Oct 8 03:05:24 2011 +0000
-
-    if_link: Add additional parameter to IFLA_VF_INFO for spoof checking
-
-git describe --contains 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
-v3.2-rc1~129^2~87
diff --git a/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci b/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
deleted file mode 100644
index de3e6e7d..00000000
--- a/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
+++ /dev/null
@@ -1,41 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct net_device_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
-.ndo_set_vf_spoofchk = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-};
-
-@r2@
-identifier s, func2;
-@@
-
-struct net_device_ops s = {
-.ndo_get_vf_config = func2,
-};
-
-// ----------------------------------------------------------------------
-
-@@
-identifier r1.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
-
-@@
-identifier r2.func2, ivi;
-expression assign;
-@@
-
-func2(...  ,struct ifla_vf_info *ivi)
-{
- <...
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
- ivi->spoofchk = assign;
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
- ...>
-}
diff --git a/patches/0035-skb_no_fcs/INFO b/patches/0035-skb_no_fcs/INFO
deleted file mode 100644
index a242c97e..00000000
--- a/patches/0035-skb_no_fcs/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-In kernel 3.4 a new field no_fcs was introduced to struct sk_buff.
-Address this by putting ifdef around the code.
-
-
-commit 3bdc0eba0b8b47797f4a76e377dd8360f317450f
-Author: Ben Greear <greearb@candelatech.com>
-Date:   Sat Feb 11 15:39:30 2012 +0000
-
-    net: Add framework to allow sending packets with customized CRC.
-
-git describe --contains 3bdc0eba0b8b47797f4a76e377dd8360f317450f
-v3.4-rc1~177^2~207
diff --git a/patches/0035-skb_no_fcs/skb_no_fcs.cocci b/patches/0035-skb_no_fcs/skb_no_fcs.cocci
deleted file mode 100644
index 12eaf6d7..00000000
--- a/patches/0035-skb_no_fcs/skb_no_fcs.cocci
+++ /dev/null
@@ -1,7 +0,0 @@
-@r1@
-expression E1,E2;
-struct sk_buff *skb;
-@@
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- E1 ^= E2(..., skb->no_fcs, ...)
-+#endif /* if LINUX_VERSION_IS_GEQ(3,18,0) */
diff --git a/patches/0036-ethtool_eee/INFO b/patches/0036-ethtool_eee/INFO
deleted file mode 100644
index 32650f76..00000000
--- a/patches/0036-ethtool_eee/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-In kernel 3.6 struct ethtool_ops received 2 new function pointers get_eee
-and set_eee. Address this by putting ifdef around the code.
-
-
-commit 80f12eccce775dc6bb93dba9b52529740f929237
-Author: Yuval Mintz <yuvalmin@broadcom.com>
-Date:   Wed Jun 6 17:13:06 2012 +0000
-
-    Added kernel support in EEE Ethtool commands
-
-git describe --contains 80f12eccce775dc6bb93dba9b52529740f929237
-v3.6-rc1~125^2~587
diff --git a/patches/0036-ethtool_eee/ethtool_eee.cocci b/patches/0036-ethtool_eee/ethtool_eee.cocci
deleted file mode 100644
index 48b0467e..00000000
--- a/patches/0036-ethtool_eee/ethtool_eee.cocci
+++ /dev/null
@@ -1,37 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct ethtool_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
-.get_eee = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
-};
-
-@r2@
-identifier s, func;
-@@
-
-struct ethtool_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
-.set_eee = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
-};
-
-// ----------------------------------------------------------------------
-
-@@
-identifier r1.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
-
-@@
-identifier r2.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
diff --git a/patches/0037-ethtool_get_module/INFO b/patches/0037-ethtool_get_module/INFO
deleted file mode 100644
index d2cc4fe7..00000000
--- a/patches/0037-ethtool_get_module/INFO
+++ /dev/null
@@ -1,14 +0,0 @@
-In kernel 3.5 struct ethtool_ops received 2 new function pointers
-get_module_info and get_module_eeprom. Address this by putting ifdef around
-the code.
-
-
-commit 41c3cb6d20f0252308e9796fa4f3dacb4960de91
-Author: Stuart Hodgson <smhodgson@solarflare.com>
-Date:   Thu Apr 19 09:44:42 2012 +0100
-
-    ethtool: Extend the ethtool API to obtain plugin module eeprom data
-
-git describe --contains 41c3cb6d20f0252308e9796fa4f3dacb4960de91
-v3.5-rc1~109^2~124^2~2
-
diff --git a/patches/0037-ethtool_get_module/get_module.cocci b/patches/0037-ethtool_get_module/get_module.cocci
deleted file mode 100644
index eead7904..00000000
--- a/patches/0037-ethtool_get_module/get_module.cocci
+++ /dev/null
@@ -1,37 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct ethtool_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-.get_module_info = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
-};
-
-@r2@
-identifier s, func;
-@@
-
-struct ethtool_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-.get_module_eeprom = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
-};
-
-// ----------------------------------------------------------------------
-
-@@
-identifier r1.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
-
-@@
-identifier r2.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,5,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
diff --git a/patches/0038-ethtool_rxfh_indir/INFO b/patches/0038-ethtool_rxfh_indir/INFO
deleted file mode 100644
index 0e050aa3..00000000
--- a/patches/0038-ethtool_rxfh_indir/INFO
+++ /dev/null
@@ -1,13 +0,0 @@
-In kernel 3.3 struct ethtool_ops received 3 new function pointers
-get_rxfh_indir_size, get_rxfh_indir, set_rxfh_indir.
-Address this by putting ifdef around the code.
-
-
-commit 7850f63f1620512631445b901ae11cd149e7375c
-Author: Ben Hutchings <bhutchings@solarflare.com>
-Date:   Thu Dec 15 13:55:01 2011 +0000
-
-    ethtool: Centralise validation of ETHTOOL_{G, S}RXFHINDIR parameters
-
-git describe --contains 7850f63f1620512631445b901ae11cd149e7375c
-v3.3-rc1~182^2~192
diff --git a/patches/0039-ethtool_rxnfc/INFO b/patches/0039-ethtool_rxnfc/INFO
deleted file mode 100644
index 55ad3802..00000000
--- a/patches/0039-ethtool_rxnfc/INFO
+++ /dev/null
@@ -1,14 +0,0 @@
-In kernel 3.2 an argument type of function pointer get_rxnfc in
-struct ethtool_ops changed from void to u32.
-Address this by putting ifdef around the code.
-
-
-commit 815c7db5c809ea3d5735de3131ecdf758b0e14ff
-Author: Ben Hutchings <bhutchings@solarflare.com>
-Date:   Tue Sep 6 13:49:12 2011 +0000
-
-    ethtool: Clean up definitions of rule location arrays in RX NFC
-
-git describe --contains 815c7db5c809ea3d5735de3131ecdf758b0e14ff
-v3.2-rc1~129^2~272
-
diff --git a/patches/0039-ethtool_rxnfc/rxnfc.cocci b/patches/0039-ethtool_rxnfc/rxnfc.cocci
deleted file mode 100644
index 72920439..00000000
--- a/patches/0039-ethtool_rxnfc/rxnfc.cocci
+++ /dev/null
@@ -1,22 +0,0 @@
-@r@
-identifier s,func;
-@@
-
-struct ethtool_ops s = {
-.get_rxnfc = func,
-};
-
-@@
-identifier r.func,rule_locs;
-typedef u32;
-@@
-
-// ----------------------------------------------------------------------
-
-func(...
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
-,u32 *rule_locs
-+#else
-+,void *rule_locs
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
- ) { ... }
diff --git a/patches/0040-ethtool_cmd_mdix/INFO b/patches/0040-ethtool_cmd_mdix/INFO
deleted file mode 100644
index 21e4adde..00000000
--- a/patches/0040-ethtool_cmd_mdix/INFO
+++ /dev/null
@@ -1,13 +0,0 @@
-In kernel 3.7 struct ethtool_cmd received eth_tp_mdix and eth_tp_mdix_ctrl.
-Address this by putting ifdef around the code using these struct components.
-
-
-commit 6f6bbc186dc8e4e0c628db7decbd1a5e02cb5fd8
-Author: Jesse Brandeburg <jesse.brandeburg@intel.com>
-Date:   Thu Jul 26 02:30:53 2012 +0000
-
-    ethtool.h: MDI setting support
-
-git describe --contains 6f6bbc186dc8e4e0c628db7decbd1a5e02cb5fd8
-v3.7-rc1~145^2~300^2~5
-
diff --git a/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci b/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
deleted file mode 100644
index 479821e5..00000000
--- a/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
+++ /dev/null
@@ -1,14 +0,0 @@
-@r1@
-expression E1;
-struct ethtool_cmd *ecmd;
-@@
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- ecmd->eth_tp_mdix_ctrl = E1;
-+#endif /* if LINUX_VERSION_IS_GEQ(3,7,0) */
-
-@r2@
-struct ethtool_cmd *ecmd;
-@@
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
- if (ecmd->eth_tp_mdix_ctrl) {...}
-+#endif /* if LINUX_VERSION_IS_GEQ(3,7,0) */
diff --git a/patches/0042-pci_error_handlers/INFO b/patches/0042-pci_error_handlers/INFO
deleted file mode 100644
index ffb183c1..00000000
--- a/patches/0042-pci_error_handlers/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-In kernel 3.7 struct pci_driver changed pci_error_handlers to const.
-Address this by putting ifdef around the code.
-
-
-commit 494530284f16298050ab99f54b7b12dd7d1418a1
-Author: Stephen Hemminger <shemminger@vyatta.com>
-Date:   Fri Sep 7 09:33:14 2012 -0700
-
-    PCI: Make pci_error_handlers const
-
-git describe --contains 494530284f16298050ab99f54b7b12dd7d1418a1
-v3.7-rc1~177^2~9^2~3
diff --git a/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci b/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
deleted file mode 100644
index 4c8ba748..00000000
--- a/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@@
-identifier s;
-@@
-
-static
-+#if LINUX_VERSION_IS_GEQ(3,7,0)
-const
-+#endif /* LINUX_VERSION_IS_GEQ(3,7,0) */
-struct pci_error_handlers s = { ... };
diff --git a/patches/0043-ndo_set_vf_rate/INFO b/patches/0043-ndo_set_vf_rate/INFO
deleted file mode 100644
index a8f0c49c..00000000
--- a/patches/0043-ndo_set_vf_rate/INFO
+++ /dev/null
@@ -1,17 +0,0 @@
-In kernel 3.16 struct net_device_ops changed and renamed pointer
-ndo_set_vf_tx_rate to ndo_set_vf_rate.
-
-commit ed616689a3d95eb6c9bdbb1ef74b0f50cbdf276a
-Author: Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
-Date:   Thu May 22 09:59:05 2014 -0400
-
-    net-next:v4: Add support to configure SR-IOV VF minimum and maximum Tx rate through ip tool.
-
-commit 5f8444a3fa617076f8da51a3e8ecce01a5d7f738
-Author: Greg Rose <gregory.v.rose@intel.com>
-Date:   Sat Oct 8 03:05:24 2011 +0000
-
-    if_link: Add additional parameter to IFLA_VF_INFO for spoof checking
-
-git describe --contains ed616689a3d95eb6c9bdbb1ef74b0f50cbdf276a
-v3.16-rc1~27^2~151
diff --git a/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci b/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
deleted file mode 100644
index d322185b..00000000
--- a/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
+++ /dev/null
@@ -1,50 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct net_device_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
-.ndo_set_vf_rate = func,
-+#else
-+.ndo_set_vf_tx_rate = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
-};
-
-@r2@
-identifier s, func2;
-@@
-
-struct net_device_ops s = {
-.ndo_get_vf_config = func2,
-};
-
-// ----------------------------------------------------------------------
-
-@@
-identifier r1.func, min_tx_rate, max_tx_rate;
-@@
-
-func(...
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
- ,int min_tx_rate, int max_tx_rate
-+#else
-+,int tx_rate
-+#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
- ) { ... }
-
-@@
-identifier r2.func2, ivi;
-expression assign, assign2;
-@@
-
-func2(...  ,struct ifla_vf_info *ivi)
-{
- <...
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
- ivi->max_tx_rate = assign;
- ivi->min_tx_rate = assign2;
-+#else
-+ivi->tx_rate = assign;
-+#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
- ...>
-}
diff --git a/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci b/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
deleted file mode 100644
index 7a494548..00000000
--- a/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
+++ /dev/null
@@ -1,9 +0,0 @@
-@r1@
-struct page *page;
-expression E1;
-@@
- return E1
-+#if LINUX_VERSION_IS_GEQ(3,6,0)
- || page_is_pfmemalloc(page)
-+#endif /* if LINUX_VERSION_IS_GEQ(3,6,0) */
- ;
diff --git a/patches/0051-no-wakeup_path/ssb.patch b/patches/0051-no-wakeup_path/ssb.patch
deleted file mode 100644
index dcebbcdf..00000000
--- a/patches/0051-no-wakeup_path/ssb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/ssb/pcihost_wrapper.c
-+++ b/drivers/ssb/pcihost_wrapper.c
-@@ -33,7 +33,9 @@ static int ssb_pcihost_suspend(struct de
- 
- 	/* if there is a wakeup enabled child device on ssb bus,
- 	   enable pci wakeup posibility. */
-+#if LINUX_VERSION_IS_GEQ(3,2,0)
- 	device_set_wakeup_enable(d, d->power.wakeup_path);
-+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
- 
- 	pci_prepare_to_sleep(dev);
- 
diff --git a/patches/0052-deactivate-ptp-pin/INFO b/patches/0052-deactivate-ptp-pin/INFO
deleted file mode 100644
index 821794f0..00000000
--- a/patches/0052-deactivate-ptp-pin/INFO
+++ /dev/null
@@ -1,20 +0,0 @@
-Programmable pins were introduced in the ptp subsystem in kernel 3.15 
-and igb makes use of them now. These patches are removing the code 
-accessing these new functions.
-
-These patches are needed for every kernel which does not have this 
-commit:
-commit 6092315dfdec5185881605d15a0e200d6e90eb66
-Author: Richard Cochran <richardcochran@gmail.com>
-Date:   Thu Mar 20 22:21:52 2014 +0100
-
-    ptp: introduce programmable pins.
-    
-    This patch adds a pair of new ioctls to the PTP Hardware Clock device
-    interface. Using the ioctls, user space programs can query each pin to
-    find out its current function and also reprogram a different function
-    if desired.
-    
-    Signed-off-by: Richard Cochran <richardcochran@gmail.com>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
deleted file mode 100644
index a0526786..00000000
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
-@@ -2335,7 +2335,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
- 	}
- 
- 	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
-+#if LINUX_VERSION_IS_GEQ(3,17,0)
- 	ifp->ndev->name_assign_type = name_assign_type;
-+#endif /* >= 3.17.0 */
- 	err = brcmf_net_attach(ifp, true);
- 	if (err) {
- 		bphy_err(drvr, "Registering netdevice failed\n");
diff --git a/patches/0055-netdev-tstats.cocci b/patches/0055-netdev-tstats.cocci
deleted file mode 100644
index d7500b61..00000000
--- a/patches/0055-netdev-tstats.cocci
+++ /dev/null
@@ -1,11 +0,0 @@
-@@
-struct net_device *dev;
-expression E;
-@@
--dev->tstats = E;
-+netdev_assign_tstats(dev, E);
-@@
-struct net_device *dev;
-@@
--dev->tstats
-+netdev_tstats(dev)
diff --git a/patches/0056-ndo_features_check/INFO b/patches/0056-ndo_features_check/INFO
deleted file mode 100644
index 60e461b1..00000000
--- a/patches/0056-ndo_features_check/INFO
+++ /dev/null
@@ -1,12 +0,0 @@
-In kernel 3.19 function pointer ndo_gso_check is changed into
-ndo_features_check in struct net_device_ops.
-Address this by putting ifdef around the code.
-
-commit 5f35227ea34bb616c436d9da47fc325866c428f3
-Author: Jesse Gross <jesse@nicira.com>
-Date:   Tue Dec 23 22:37:26 2014 -0800
-
-    net: Generalize ndo_gso_check to ndo_features_check
-
-git describe --contains 5f35227ea34bb616c436d9da47fc325866c428f3
-v3.19-rc3~16^2~7
diff --git a/patches/0056-ndo_features_check/features_check.cocci b/patches/0056-ndo_features_check/features_check.cocci
deleted file mode 100644
index ca15d3a0..00000000
--- a/patches/0056-ndo_features_check/features_check.cocci
+++ /dev/null
@@ -1,19 +0,0 @@
-@r1@
-identifier s, func;
-@@
-
-struct net_device_ops s = {
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
-.ndo_features_check = func,
-+#endif /* LINUX_VERSION_IS_GEQ(3,19,0) */
-};
-
-// ----------------------------------------------------------------------
-
-@r2@
-identifier r1.func;
-@@
-
-+#if LINUX_VERSION_IS_GEQ(3,19,0)
-func(...) { ... }
-+#endif /* LINUX_VERSION_IS_GEQ(3,19,0) */
diff --git a/patches/0059-skb_xmit_more/INFO b/patches/0059-skb_xmit_more/INFO
deleted file mode 100644
index b4296376..00000000
--- a/patches/0059-skb_xmit_more/INFO
+++ /dev/null
@@ -1,10 +0,0 @@
-In kernel 3.18 __u8 xmit_more is added to struct sk_buff.
-
-commit 0b725a2ca61bedc33a2a63d0451d528b268cf975
-Author: David S. Miller <davem@davemloft.net>
-Date:   Mon Aug 25 15:51:53 2014 -0700
-
-    net: Remove ndo_xmit_flush netdev operation, use signalling instead.
-
-git describe --contains 0b725a2ca61bedc33a2a63d0451d528b268cf975
-v3.18-rc1~52^2~228
diff --git a/patches/0059-uuid-in-mei/INFO b/patches/0059-uuid-in-mei/INFO
deleted file mode 100644
index 4c96bf55..00000000
--- a/patches/0059-uuid-in-mei/INFO
+++ /dev/null
@@ -1,7 +0,0 @@
-The uuid member was added to the struct mei_cl_device_id in this commit:
-commit c93b76b34b4d8dbe8e3443eb27e49ac60034342b
-Author: Tomas Winkler <tomas.winkler@intel.com>
-Date:   Thu May 7 15:54:02 2015 +0300
-
-    mei: bus: report also uuid in module alias
-
diff --git a/patches/0060-trace_field_struct/INFO b/patches/0060-trace_field_struct/INFO
deleted file mode 100644
index bb2d3557..00000000
--- a/patches/0060-trace_field_struct/INFO
+++ /dev/null
@@ -1,11 +0,0 @@
-deactivate struct tracing
-
-__field_struct was added in Linux commit 4d4c9cc83. It is hard to backport
-this feature, so just remove the code using it on kernel version < 3.16.
-
-commit 4d4c9cc839a308be3289a361ccba4447ee140552
-Author: Steven Rostedt <rostedt@goodmis.org>
-Date:   Tue Jun 17 08:59:16 2014 -0400
-
-    tracing: Add __field_struct macro for TRACE_EVENT()
-
diff --git a/patches/0060-trace_field_struct/mt7601u.patch b/patches/0060-trace_field_struct/mt7601u.patch
deleted file mode 100644
index ca9dea53..00000000
--- a/patches/0060-trace_field_struct/mt7601u.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-diff --git a/drivers/net/wireless/mediatek/mt7601u/trace.h b/drivers/net/wireless/mediatek/mt7601u/trace.h
-index 2898973..7fa1b96 100644
---- a/drivers/net/wireless/mediatek/mt7601u/trace.h
-+++ b/drivers/net/wireless/mediatek/mt7601u/trace.h
-@@ -244,6 +244,7 @@ TRACE_EVENT(freq_cal_offset,
- 		  DEV_PR_ARG, __entry->phy_mode, __entry->freq_off)
- );
- 
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
- TRACE_EVENT(mt_rx,
- 	TP_PROTO(struct mt7601u_dev *dev, struct mt7601u_rxwi *rxwi, u32 f),
- 	TP_ARGS(dev, rxwi, f),
-@@ -298,6 +299,20 @@ TRACE_EVENT(mt_tx,
- 		  __entry->h.ack_ctl, __entry->h.wcid,
- 		  le16_to_cpu(__entry->h.len_ctl))
- );
-+#else
-+#ifndef __BACKPORT_MT7601U_TRACE_H_EXTRA
-+#define __BACKPORT_MT7601U_TRACE_H_EXTRA
-+static inline void trace_mt_rx(struct mt7601u_dev *dev,
-+			       struct mt7601u_rxwi *rxwi,
-+			       u32 f)
-+{
-+}
-+static inline void trace_mt_tx(struct mt7601u_dev *dev, struct sk_buff *skb,
-+			       struct mt76_sta *sta, struct mt76_txwi *h)
-+{
-+}
-+#endif /* __BACKPORT_MT7601U_TRACE_H_EXTRA */
-+#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
- 
- TRACE_EVENT(mt_tx_dma_done,
- 	TP_PROTO(struct mt7601u_dev *dev, struct sk_buff *skb),
diff --git a/patches/0061-termios_rwsem/INFO b/patches/0061-termios_rwsem/INFO
deleted file mode 100644
index 296b219a..00000000
--- a/patches/0061-termios_rwsem/INFO
+++ /dev/null
@@ -1,11 +0,0 @@
-use old locking for struct tty_struct
-
-With kernel 3.12 a new locking was added to struct tty_struct. This
-patch makes the code use the old locking.
-
-The new locking was added in this commit:
-commit 6a1c0680cf3ba94356ecd58833e1540c93472a57
-Author: Peter Hurley <peter@hurleysoftware.com>
-Date:   Sat Jun 15 09:14:23 2013 -0400
-
-    tty: Convert termios_mutex to termios_rwsem
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
deleted file mode 100644
index 69969256..00000000
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ /dev/null
@@ -1,75 +0,0 @@
---- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
-+++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
-@@ -2373,12 +2373,23 @@ void iwl_dbgfs_register(struct iwl_priv
- 	 */
- 	if (priv->mac80211_registered) {
- 		char buf[100];
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 		struct dentry *mac80211_dir, *dev_dir;
- 
- 		dev_dir = dbgfs_dir->d_parent;
- 		mac80211_dir = priv->hw->wiphy->debugfsdir;
- 
- 		snprintf(buf, 100, "../../%pd2", dev_dir);
-+#else
-+		struct dentry *mac80211_dir, *dev_dir, *root_dir;
-+
-+		dev_dir = dbgfs_dir->d_parent;
-+		root_dir = dev_dir->d_parent;
-+		mac80211_dir = priv->hw->wiphy->debugfsdir;
-+
-+		snprintf(buf, 100, "../../%s/%s", root_dir->d_name.name,
-+			 dev_dir->d_name.name);
-+#endif
- 
- 		debugfs_create_symlink("iwlwifi", mac80211_dir, buf);
- 	}
---- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -777,8 +777,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
- 
- 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
- 	if (IS_ERR_OR_NULL(mvmvif->dbgfs_dir)) {
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 		IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
- 			dbgfs_dir);
-+#else
-+		IWL_ERR(mvm, "Failed to create debugfs directory under %s\n",
-+			dbgfs_dir->d_name.name);
-+#endif
- 		return;
- 	}
- 
-@@ -807,9 +812,17 @@ void iwl_mvm_vif_dbgfs_register(struct i
- 	 * find
- 	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
- 	 */
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 	snprintf(buf, 100, "../../../%pd3/%pd",
- 		 dbgfs_dir,
- 		 mvmvif->dbgfs_dir);
-+#else
-+	snprintf(buf, 100, "../../../%s/%s/%s/%s",
-+		 dbgfs_dir->d_parent->d_parent->d_name.name,
-+		 dbgfs_dir->d_parent->d_name.name,
-+		 dbgfs_dir->d_name.name,
-+		 mvmvif->dbgfs_dir->d_name.name);
-+#endif
- 
- 	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
- 						     mvm->debugfs_dir, buf);
---- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
-@@ -2092,6 +2092,12 @@ void iwl_mvm_dbgfs_register(struct iwl_m
- 	 * Create a symlink with mac80211. It will be removed when mac80211
- 	 * exists (before the opmode exists which removes the target.)
- 	 */
-+#if LINUX_VERSION_IS_GEQ(3,12,0)
- 	snprintf(buf, 100, "../../%pd2", dbgfs_dir->d_parent);
-+#else
-+	snprintf(buf, 100, "../../%s/%s",
-+		 dbgfs_dir->d_parent->d_parent->d_name.name,
-+		 dbgfs_dir->d_parent->d_name.name);
-+#endif
- 	debugfs_create_symlink("iwlwifi", mvm->hw->wiphy->debugfsdir, buf);
- }
diff --git a/patches/0069-remove-of_irq/bcma.patch b/patches/0069-remove-of_irq/bcma.patch
deleted file mode 100644
index b8a05ae8..00000000
--- a/patches/0069-remove-of_irq/bcma.patch
+++ /dev/null
@@ -1,24 +0,0 @@
---- a/drivers/bcma/main.c
-+++ b/drivers/bcma/main.c
-@@ -156,6 +156,7 @@ static struct device_node *bcma_of_find_
- 	return NULL;
- }
- 
-+#if LINUX_VERSION_IS_GEQ(3,13,0)
- static int bcma_of_irq_parse(struct device *parent,
- 			     struct bcma_device *core,
- 			     struct of_phandle_args *out_irq, int num)
-@@ -195,6 +196,13 @@ static unsigned int bcma_of_get_irq(stru
- 
- 	return irq_create_of_mapping(&out_irq);
- }
-+#else
-+static unsigned int bcma_of_get_irq(struct device *parent,
-+				    struct bcma_device *core, int num)
-+{
-+	return 0;
-+}
-+#endif
- 
- static void bcma_of_fill_device(struct device *parent,
- 				struct bcma_device *core)
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
deleted file mode 100644
index cd48826f..00000000
--- a/patches/0071-skb-head_frag/wireless.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/net/wireless/util.c
-+++ b/net/wireless/util.c
-@@ -753,7 +753,11 @@ void ieee80211_amsdu_to_8023s(struct sk_
- 	u8 *payload;
- 	int offset = 0, remaining;
- 	struct ethhdr eth;
-+#if LINUX_VERSION_IS_LESS(3,5,0)
-+	bool reuse_frag = 0;
-+#else
- 	bool reuse_frag = skb->head_frag && !skb_has_frag_list(skb);
-+#endif
- 	bool reuse_skb = false;
- 	bool last = false;
- 
diff --git a/patches/0074-skb-wifi-acked.cocci b/patches/0074-skb-wifi-acked.cocci
deleted file mode 100644
index 79366df7..00000000
--- a/patches/0074-skb-wifi-acked.cocci
+++ /dev/null
@@ -1,8 +0,0 @@
-@@
-expression SKB;
-expression A, V;
-@@
-+#if LINUX_VERSION_IS_GEQ(3,3,0)
-SKB->wifi_acked_valid = V;
-SKB->wifi_acked = A;
-+#endif
diff --git a/patches/0076-reset-notify.cocci b/patches/0076-reset-notify.cocci
deleted file mode 100644
index e6ad7a02..00000000
--- a/patches/0076-reset-notify.cocci
+++ /dev/null
@@ -1,19 +0,0 @@
-@@
-identifier handlers;
-identifier fn;
-@@
-struct pci_error_handlers handlers = {
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
-.reset_notify = fn,
-+#endif
- };
-
-@@
-identifier handlers;
-identifier fn;
-@@
-struct pci_error_handlers handlers[] = {{
-+#if LINUX_VERSION_IS_GEQ(3,16,0)
-.reset_notify = fn,
-+#endif
- }};
diff --git a/patches/0077-genl-ro-after-init/nl80211.patch b/patches/0077-genl-ro-after-init/nl80211.patch
index 462b1bf3..743d14e1 100644
--- a/patches/0077-genl-ro-after-init/nl80211.patch
+++ b/patches/0077-genl-ro-after-init/nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -15529,7 +15529,7 @@ static const struct genl_small_ops nl802
+@@ -15525,7 +15525,7 @@ static const struct genl_small_ops nl802
  	},
  };
  
diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
deleted file mode 100644
index 4ea9bfc9..00000000
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ /dev/null
@@ -1,22 +0,0 @@
-diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-index f74281508197..3b11bd68f261 100644
---- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -2010,6 +2010,9 @@ static void iwl_trans_pcie_removal_wk(st
- 	struct iwl_trans_pcie_removal *removal =
- 		container_of(wk, struct iwl_trans_pcie_removal, work);
- 	struct pci_dev *pdev = removal->pdev;
-+#if LINUX_VERSION_IS_LESS(3,14,0)
-+	dev_err(&pdev->dev, "Device gone - can't remove on old kernels.\n");
-+#else
- 	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
- 
- 	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -2018,6 +2021,7 @@ static void iwl_trans_pcie_removal_wk(st
- 	pci_dev_put(pdev);
- 	pci_stop_and_remove_bus_device(pdev);
- 	pci_unlock_rescan_remove();
-+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
- 
- 	kfree(removal);
- 	module_put(THIS_MODULE);
diff --git a/patches/0100-revert-small_ops/mac80211.patch b/patches/0100-revert-small_ops/mac80211.patch
index 3335a130..37c2fcff 100644
--- a/patches/0100-revert-small_ops/mac80211.patch
+++ b/patches/0100-revert-small_ops/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -14694,9 +14694,11 @@ static const struct genl_ops nl80211_ops
+@@ -14690,9 +14690,11 @@ static const struct genl_ops nl80211_ops
  		.internal_flags = NL80211_FLAG_NEED_WIPHY |
  				  NL80211_FLAG_NEED_RTNL,
  	},
@@ -12,7 +12,7 @@
  	{
  		.cmd = NL80211_CMD_SET_WIPHY,
  		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-@@ -15558,8 +15560,10 @@ static struct genl_family nl80211_fam __
+@@ -15554,8 +15556,10 @@ static struct genl_family nl80211_fam __
  	.module = THIS_MODULE,
  	.ops = nl80211_ops,
  	.n_ops = ARRAY_SIZE(nl80211_ops),
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
index d28ca4af..e56d52c8 100644
--- a/patches/devcoredump.patch
+++ b/patches/devcoredump.patch
@@ -8,18 +8,7 @@
  
  static struct class devcd_class;
  
-@@ -25,6 +26,10 @@ static bool devcd_disabled;
- /* if data isn't read by userspace after 5 minutes then delete it */
- #define DEVCD_TIMEOUT	(HZ * 60 * 5)
- 
-+#if LINUX_VERSION_IS_LESS(3,11,0)
-+static struct bin_attribute devcd_attr_data;
-+#endif
-+
- struct devcd_entry {
- 	struct device devcd_dev;
- 	void *data;
-@@ -54,8 +59,7 @@ static void devcd_dev_release(struct dev
+@@ -54,8 +55,7 @@ static void devcd_dev_release(struct dev
  	 * a struct device to know when it goes away?
  	 */
  	if (devcd->failing_dev->kobj.sd)
@@ -29,55 +18,7 @@
  
  	put_device(devcd->failing_dev);
  	kfree(devcd);
-@@ -67,6 +71,9 @@ static void devcd_del(struct work_struct
- 
- 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
- 
-+#if LINUX_VERSION_IS_LESS(3,11,0)
-+	device_remove_bin_file(&devcd->devcd_dev, &devcd_attr_data);
-+#endif
- 	device_del(&devcd->devcd_dev);
- 	put_device(&devcd->devcd_dev);
- }
-@@ -100,6 +107,7 @@ static struct bin_attribute devcd_attr_d
- 	.write = devcd_data_write,
- };
- 
-+#if LINUX_VERSION_IS_GEQ(3,11,0)
- static struct bin_attribute *devcd_dev_bin_attrs[] = {
- 	&devcd_attr_data, NULL,
- };
-@@ -111,6 +119,7 @@ static const struct attribute_group devc
- static const struct attribute_group *devcd_dev_groups[] = {
- 	&devcd_dev_group, NULL,
- };
-+#endif /* LINUX_VERSION_IS_GEQ(3,11,0) */
- 
- static int devcd_free(struct device *dev, void *data)
- {
-@@ -157,7 +166,9 @@ static struct class devcd_class = {
- 	.name		= "devcoredump",
- 	.owner		= THIS_MODULE,
- 	.dev_release	= devcd_dev_release,
-+#if LINUX_VERSION_IS_GEQ(3,11,0)
- 	.dev_groups	= devcd_dev_groups,
-+#endif
- 	.class_groups	= devcd_class_groups,
- };
- 
-@@ -292,6 +303,11 @@ void dev_coredumpm(struct device *dev, s
- 	if (device_add(&devcd->devcd_dev))
- 		goto put_device;
- 
-+#if LINUX_VERSION_IS_LESS(3,11,0)
-+	if (device_create_bin_file(&devcd->devcd_dev, &devcd_attr_data))
-+		goto put_device;
-+#endif
-+
- 	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
- 			      "failing_device"))
- 		/* nothing - symlink will be missing */;
-@@ -334,15 +350,13 @@ void dev_coredumpsg(struct device *dev,
+@@ -334,15 +334,13 @@ void dev_coredumpsg(struct device *dev,
  }
  EXPORT_SYMBOL_GPL(dev_coredumpsg);
  
-- 
2.30.2


--
To unsubscribe from this list: send the line "unsubscribe backports" in
