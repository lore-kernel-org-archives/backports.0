Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:50504 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3GSMAY (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 19 Jul 2013 08:00:24 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp1so53583pab.7
        for <backports@vger.kernel.org>; Fri, 19 Jul 2013 05:00:23 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: jani.nikula@intel.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 2/9] backports: fix patches required for next-20130627
Date: Fri, 19 Jul 2013 05:00:02 -0700
Message-Id: <1374235209-19782-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130719_140026_555422_3847298E)
In-Reply-To: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374235209-19782-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/0005-netlink-portid/nl80211.patch      |   60 ++++++++++----------
 .../network/46-use_other_workqueue/INFO            |    4 --
 .../net_bluetooth_hci_core.patch                   |   27 ---------
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +-
 4 files changed, 33 insertions(+), 64 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/46-use_other_workqueue/INFO
 delete mode 100644 patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch

diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
index 5f49cb3..d5a6a12 100644
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
@@ -1,24 +1,24 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1564,7 +1564,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1593,7 +1593,7 @@ static int nl80211_dump_wiphy(struct sk_
  		/* attempt to fit multiple wiphy data chunks into the skb */
  		do {
  			ret = nl80211_send_wiphy(dev, skb,
 -						 NETLINK_CB(cb->skb).portid,
 +						 NETLINK_CB_PORTID(cb->skb),
  						 cb->nlh->nlmsg_seq,
- 						 NLM_F_MULTI,
- 						 split, &cb->args[1],
-@@ -1613,7 +1613,7 @@ static int nl80211_get_wiphy(struct sk_b
+ 						 NLM_F_MULTI, state);
+ 			if (ret < 0) {
+@@ -1646,7 +1646,7 @@ static int nl80211_get_wiphy(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
 -	if (nl80211_send_wiphy(dev, msg, info->snd_portid, info->snd_seq, 0,
 +	if (nl80211_send_wiphy(dev, msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			       false, NULL, NULL, NULL) < 0) {
+ 			       &state) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2183,7 +2183,7 @@ static int nl80211_dump_interface(struct
+@@ -2221,7 +2221,7 @@ static int nl80211_dump_interface(struct
  				if_idx++;
  				continue;
  			}
@@ -27,7 +27,7 @@
  					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					       rdev, wdev) < 0) {
  				goto out;
-@@ -2212,7 +2212,7 @@ static int nl80211_get_interface(struct
+@@ -2250,7 +2250,7 @@ static int nl80211_get_interface(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -36,7 +36,7 @@
  			       dev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2445,7 +2445,7 @@ static int nl80211_new_interface(struct
+@@ -2483,7 +2483,7 @@ static int nl80211_new_interface(struct
  		break;
  	}
  
@@ -45,7 +45,7 @@
  			       rdev, wdev) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -2580,7 +2580,7 @@ static int nl80211_get_key(struct sk_buf
+@@ -2618,7 +2618,7 @@ static int nl80211_get_key(struct sk_buf
  	if (!msg)
  		return -ENOMEM;
  
@@ -54,7 +54,7 @@
  			     NL80211_CMD_NEW_KEY);
  	if (IS_ERR(hdr))
  		return PTR_ERR(hdr);
-@@ -3552,7 +3552,7 @@ static int nl80211_dump_station(struct s
+@@ -3587,7 +3587,7 @@ static int nl80211_dump_station(struct s
  			goto out_err;
  
  		if (nl80211_send_station(skb,
@@ -63,7 +63,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				dev, wdev->netdev, mac_addr,
  				&sinfo) < 0)
-@@ -3598,7 +3598,7 @@ static int nl80211_get_station(struct sk
+@@ -3633,7 +3633,7 @@ static int nl80211_get_station(struct sk
  	if (!msg)
  		return -ENOMEM;
  
@@ -72,7 +72,7 @@
  				 rdev, dev, mac_addr, &sinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4206,7 +4206,7 @@ static int nl80211_dump_mpath(struct sk_
+@@ -4241,7 +4241,7 @@ static int nl80211_dump_mpath(struct sk_
  		if (err)
  			goto out_err;
  
@@ -81,7 +81,7 @@
  				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				       wdev->netdev, dst, next_hop,
  				       &pinfo) < 0)
-@@ -4255,7 +4255,7 @@ static int nl80211_get_mpath(struct sk_b
+@@ -4290,7 +4290,7 @@ static int nl80211_get_mpath(struct sk_b
  	if (!msg)
  		return -ENOMEM;
  
@@ -90,7 +90,7 @@
  				 dev, dst, next_hop, &pinfo) < 0) {
  		nlmsg_free(msg);
  		return -ENOBUFS;
-@@ -4519,7 +4519,7 @@ static int nl80211_get_mesh_config(struc
+@@ -4554,7 +4554,7 @@ static int nl80211_get_mesh_config(struc
  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
  	if (!msg)
  		return -ENOMEM;
@@ -99,7 +99,7 @@
  			     NL80211_CMD_GET_MESH_CONFIG);
  	if (!hdr)
  		goto out;
-@@ -4878,7 +4878,7 @@ static int nl80211_get_reg(struct sk_buf
+@@ -4913,7 +4913,7 @@ static int nl80211_get_reg(struct sk_buf
  	if (!msg)
  		return -ENOBUFS;
  
@@ -108,7 +108,7 @@
  			     NL80211_CMD_GET_REG);
  	if (!hdr)
  		goto put_failure;
-@@ -5557,7 +5557,7 @@ static int nl80211_send_bss(struct sk_bu
+@@ -5592,7 +5592,7 @@ static int nl80211_send_bss(struct sk_bu
  
  	ASSERT_WDEV_LOCK(wdev);
  
@@ -117,7 +117,7 @@
  			     NL80211_CMD_NEW_SCAN_RESULTS);
  	if (!hdr)
  		return -1;
-@@ -5793,7 +5793,7 @@ static int nl80211_dump_survey(struct sk
+@@ -5828,7 +5828,7 @@ static int nl80211_dump_survey(struct sk
  		}
  
  		if (nl80211_send_survey(skb,
@@ -126,7 +126,7 @@
  				cb->nlh->nlmsg_seq, NLM_F_MULTI,
  				wdev->netdev, &survey) < 0)
  			goto out;
-@@ -6460,7 +6460,7 @@ static int nl80211_testmode_dump(struct
+@@ -6500,7 +6500,7 @@ static int nl80211_testmode_dump(struct
  	}
  
  	while (1) {
@@ -135,7 +135,7 @@
  					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
  					   NL80211_CMD_TESTMODE);
  		struct nlattr *tmdata;
-@@ -6539,7 +6539,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+@@ -6579,7 +6579,7 @@ struct sk_buff *cfg80211_testmode_alloc_
  		return NULL;
  
  	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
@@ -144,7 +144,7 @@
  				rdev->testmode_info->snd_seq,
  				GFP_KERNEL);
  }
-@@ -6905,7 +6905,7 @@ static int nl80211_remain_on_channel(str
+@@ -6945,7 +6945,7 @@ static int nl80211_remain_on_channel(str
  	if (!msg)
  		return -ENOMEM;
  
@@ -153,7 +153,7 @@
  			     NL80211_CMD_REMAIN_ON_CHANNEL);
  
  	if (IS_ERR(hdr)) {
-@@ -7124,7 +7124,7 @@ static int nl80211_register_mgmt(struct
+@@ -7164,7 +7164,7 @@ static int nl80211_register_mgmt(struct
  	if (!rdev->ops->mgmt_tx)
  		return -EOPNOTSUPP;
  
@@ -162,7 +162,7 @@
  			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
  			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
  }
-@@ -7205,7 +7205,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+@@ -7245,7 +7245,7 @@ static int nl80211_tx_mgmt(struct sk_buf
  		if (!msg)
  			return -ENOMEM;
  
@@ -171,7 +171,7 @@
  				     NL80211_CMD_FRAME);
  
  		if (IS_ERR(hdr)) {
-@@ -7320,7 +7320,7 @@ static int nl80211_get_power_save(struct
+@@ -7360,7 +7360,7 @@ static int nl80211_get_power_save(struct
  	if (!msg)
  		return -ENOMEM;
  
@@ -180,7 +180,7 @@
  			     NL80211_CMD_GET_POWER_SAVE);
  	if (!hdr) {
  		err = -ENOBUFS;
-@@ -7631,7 +7631,7 @@ static int nl80211_get_wowlan(struct sk_
+@@ -7671,7 +7671,7 @@ static int nl80211_get_wowlan(struct sk_
  	if (!msg)
  		return -ENOMEM;
  
@@ -189,7 +189,7 @@
  			     NL80211_CMD_GET_WOWLAN);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8056,7 +8056,7 @@ static int nl80211_register_unexpected_f
+@@ -8096,7 +8096,7 @@ static int nl80211_register_unexpected_f
  	if (wdev->ap_unexpected_nlportid)
  		return -EBUSY;
  
@@ -198,7 +198,7 @@
  	return 0;
  }
  
-@@ -8086,7 +8086,7 @@ static int nl80211_probe_client(struct s
+@@ -8126,7 +8126,7 @@ static int nl80211_probe_client(struct s
  	if (!msg)
  		return -ENOMEM;
  
@@ -207,7 +207,7 @@
  			     NL80211_CMD_PROBE_CLIENT);
  
  	if (IS_ERR(hdr)) {
-@@ -8130,13 +8130,13 @@ static int nl80211_register_beacons(stru
+@@ -8170,13 +8170,13 @@ static int nl80211_register_beacons(stru
  	/* First, check if already registered. */
  	spin_lock_bh(&rdev->beacon_registrations_lock);
  	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
@@ -223,7 +223,7 @@
  	list_add(&nreg->list, &rdev->beacon_registrations);
  
  	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8203,7 +8203,7 @@ static int nl80211_get_protocol_features
+@@ -8243,7 +8243,7 @@ static int nl80211_get_protocol_features
  	if (!msg)
  		return -ENOMEM;
  
@@ -232,7 +232,7 @@
  			     NL80211_CMD_GET_PROTOCOL_FEATURES);
  	if (!hdr)
  		goto nla_put_failure;
-@@ -8278,7 +8278,7 @@ static int nl80211_crit_protocol_start(s
+@@ -8318,7 +8318,7 @@ static int nl80211_crit_protocol_start(s
  
  	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
  	if (!ret)
@@ -241,7 +241,7 @@
  
  	return ret;
  }
-@@ -10652,12 +10652,12 @@ static int nl80211_netlink_notify(struct
+@@ -10693,12 +10693,12 @@ static int nl80211_netlink_notify(struct
  
  	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
  		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/INFO b/patches/collateral-evolutions/network/46-use_other_workqueue/INFO
deleted file mode 100644
index c9f4f37..0000000
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/INFO
+++ /dev/null
@@ -1,4 +0,0 @@
-Old kernel versions do not support WQ_HIGHPRI and WQ_MEM_RECLAIM so we
-should use create_singlethread_workqueue() which was used at this
-position before.
-
diff --git a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch b/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
deleted file mode 100644
index b9fe51b..0000000
--- a/patches/collateral-evolutions/network/46-use_other_workqueue/net_bluetooth_hci_core.patch
+++ /dev/null
@@ -1,27 +0,0 @@
---- a/net/bluetooth/hci_core.c
-+++ b/net/bluetooth/hci_core.c
-@@ -2161,16 +2161,24 @@ int hci_register_dev(struct hci_dev *hde
- 	list_add(&hdev->list, &hci_dev_list);
- 	write_unlock(&hci_dev_list_lock);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI | WQ_UNBOUND |
- 					  WQ_MEM_RECLAIM, 1);
-+#else
-+	hdev->workqueue = create_singlethread_workqueue(hdev->name);
-+#endif
- 	if (!hdev->workqueue) {
- 		error = -ENOMEM;
- 		goto err;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	hdev->req_workqueue = alloc_workqueue(hdev->name,
- 					      WQ_HIGHPRI | WQ_UNBOUND |
- 					      WQ_MEM_RECLAIM, 1);
-+#else
-+	hdev->req_workqueue = create_singlethread_workqueue(hdev->name);
-+#endif
- 	if (!hdev->req_workqueue) {
- 		destroy_workqueue(hdev->workqueue);
- 		error = -ENOMEM;
diff --git a/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch
index 2425660..919aafa 100644
--- a/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch
+++ b/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch
@@ -1,6 +1,6 @@
---- a/drivers/net/wireless/ti/wlcore/main.c
-+++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -5518,7 +5518,11 @@ static ssize_t wl1271_sysfs_show_hw_pg_v
+--- a/drivers/net/wireless/ti/wlcore/sysfs.c
++++ b/drivers/net/wireless/ti/wlcore/sysfs.c
+@@ -106,7 +106,11 @@ static ssize_t wl1271_sysfs_show_hw_pg_v
  static DEVICE_ATTR(hw_pg_ver, S_IRUGO,
  		   wl1271_sysfs_show_hw_pg_ver, NULL);
  
-- 
1.7.10.4

