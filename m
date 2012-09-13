Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH] compat-drivers: backport netlink pid to portid rename
Date: Thu, 13 Sep 2012 15:36:55 -0700
Message-Id: <1347575815-15939-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The patch:

commit 15e473046cb6e5d18a4d0057e61d76315230382b
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Fri Sep 7 20:12:54 2012 +0000

    netlink: Rename pid to portid to avoid confusion

    It is a frequent mistake to confuse the netlink port identifier with a
    process identifier.  Try to reduce this confusion by renaming fields
    that hold port identifiers portid instead of pid.

    I have carefully avoided changing the structures exported to
    userspace to avoid changing the userspace API.

    I have successfully built an allyesconfig kernel with this change.

    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
    Acked-by: Stephen Hemminger <shemminger@vyatta.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Changed the struct members:

struct netlink_notify->pid    to
struct netlink_notify->portid

struct genl_info->snd_pid     to
struct genl_info->snd_portid

To help backport this and not have to #ifdef around it against
kernel versions compat has introduced two helpers for us to
simply do the backport with three macro helpers:

genl_info_snd_portid()
netlink_notify_portid()
NETLINK_CB_PORTID()

This takes care of the work for us requiring only one
single line change. This patch now goes into its own
new filename following the lead of the other 4-digit
prefixed patches which try to separate collateral
evolutions to be used for spdiff to further backport
uses in other subsystems / drivers.

mcgrof@garbanzo ~/devel/compat-drivers (git::master)$ time ckmake
Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

real    26m46.734s
user    140m26.659s
sys     13m26.194s

Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 patches/network/0005-netlink-portid.patch |  295 +++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)
 create mode 100644 patches/network/0005-netlink-portid.patch

diff --git a/patches/network/0005-netlink-portid.patch b/patches/network/0005-netlink-portid.patch
new file mode 100644
index 0000000..8669001
--- /dev/null
+++ b/patches/network/0005-netlink-portid.patch
@@ -0,0 +1,295 @@
+The patch:
+
+commit 15e473046cb6e5d18a4d0057e61d76315230382b
+Author: Eric W. Biederman <ebiederm@xmission.com>
+Date:   Fri Sep 7 20:12:54 2012 +0000
+
+    netlink: Rename pid to portid to avoid confusion
+    
+    It is a frequent mistake to confuse the netlink port identifier with a
+    process identifier.  Try to reduce this confusion by renaming fields
+    that hold port identifiers portid instead of pid.
+    
+    I have carefully avoided changing the structures exported to
+    userspace to avoid changing the userspace API.
+    
+    I have successfully built an allyesconfig kernel with this change.
+    
+    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
+    Acked-by: Stephen Hemminger <shemminger@vyatta.com>
+    Signed-off-by: David S. Miller <davem@davemloft.net>
+
+Changed the struct members:
+
+struct netlink_notify->pid    to
+struct netlink_notify->portid
+
+struct genl_info->snd_pid     to
+struct genl_info->snd_portid
+
+To help backport this and not have to #ifdef around it against
+kernel versions compat has introduced two helpers for us to
+simply do the backport with two macro helpers:
+
+genl_info_snd_portid()
+netlink_notify_portid()
+
+This takes care of the work for us requiring only one
+single line change. If we get another patch thrown into
+this file then I suspect we can extract SMPL out of it
+and use it to backport further collateral evolutions like
+this one should other drivers / subsystem need this change.
+
+--- a/drivers/net/wireless/mac80211_hwsim.c
++++ b/drivers/net/wireless/mac80211_hwsim.c
+@@ -1632,10 +1632,10 @@ static int hwsim_register_received_nl(st
+ 	if (info == NULL)
+ 		goto out;
+ 
+-	wmediumd_portid = info->snd_portid;
++	wmediumd_portid = genl_info_snd_portid(info);
+ 
+ 	printk(KERN_DEBUG "mac80211_hwsim: received a REGISTER, "
+-	       "switching to wmediumd mode with pid %d\n", info->snd_portid);
++	       "switching to wmediumd mode with pid %d\n", genl_info_snd_portid(info));
+ 
+ 	return 0;
+ out:
+@@ -1672,7 +1672,7 @@ static int mac80211_hwsim_netlink_notify
+ 	if (state != NETLINK_URELEASE)
+ 		return NOTIFY_DONE;
+ 
+-	if (notify->portid == wmediumd_portid) {
++	if (netlink_notify_portid(notify) == wmediumd_portid) {
+ 		printk(KERN_INFO "mac80211_hwsim: wmediumd released netlink"
+ 		       " socket, switching to perfect channel medium\n");
+ 		wmediumd_portid = 0;
+--- a/net/wireless/nl80211.c
++++ b/net/wireless/nl80211.c
+@@ -1267,7 +1267,7 @@ static int nl80211_dump_wiphy(struct sk_
+ 			continue;
+ 		if (++idx <= start)
+ 			continue;
+-		if (nl80211_send_wiphy(skb, NETLINK_CB(cb->skb).portid,
++		if (nl80211_send_wiphy(skb, NETLINK_CB_PORTID(skb),
+ 				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
+ 				       dev) < 0) {
+ 			idx--;
+@@ -1290,7 +1290,7 @@ static int nl80211_get_wiphy(struct sk_b
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	if (nl80211_send_wiphy(msg, info->snd_portid, info->snd_seq, 0, dev) < 0) {
++	if (nl80211_send_wiphy(msg, genl_info_snd_portid(info), info->snd_seq, 0, dev) < 0) {
+ 		nlmsg_free(msg);
+ 		return -ENOBUFS;
+ 	}
+@@ -1807,7 +1807,7 @@ static int nl80211_dump_interface(struct
+ 				if_idx++;
+ 				continue;
+ 			}
+-			if (nl80211_send_iface(skb, NETLINK_CB(cb->skb).portid,
++			if (nl80211_send_iface(skb, NETLINK_CB_PORTID(cb->skb),
+ 					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
+ 					       rdev, wdev) < 0) {
+ 				mutex_unlock(&rdev->devlist_mtx);
+@@ -1838,7 +1838,7 @@ static int nl80211_get_interface(struct
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	if (nl80211_send_iface(msg, info->snd_portid, info->snd_seq, 0,
++	if (nl80211_send_iface(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			       dev, wdev) < 0) {
+ 		nlmsg_free(msg);
+ 		return -ENOBUFS;
+@@ -2056,7 +2056,7 @@ static int nl80211_new_interface(struct
+ 		break;
+ 	}
+ 
+-	if (nl80211_send_iface(msg, info->snd_portid, info->snd_seq, 0,
++	if (nl80211_send_iface(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			       rdev, wdev) < 0) {
+ 		nlmsg_free(msg);
+ 		return -ENOBUFS;
+@@ -2191,7 +2191,7 @@ static int nl80211_get_key(struct sk_buf
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_NEW_KEY);
+ 	if (IS_ERR(hdr))
+ 		return PTR_ERR(hdr);
+@@ -2931,7 +2931,7 @@ static int nl80211_dump_station(struct s
+ 			goto out_err;
+ 
+ 		if (nl80211_send_station(skb,
+-				NETLINK_CB(cb->skb).portid,
++				NETLINK_CB_PORTID(cb->skb),
+ 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
+ 				dev, netdev, mac_addr,
+ 				&sinfo) < 0)
+@@ -2977,7 +2977,7 @@ static int nl80211_get_station(struct sk
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	if (nl80211_send_station(msg, info->snd_portid, info->snd_seq, 0,
++	if (nl80211_send_station(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 				 rdev, dev, mac_addr, &sinfo) < 0) {
+ 		nlmsg_free(msg);
+ 		return -ENOBUFS;
+@@ -3389,7 +3389,7 @@ static int nl80211_dump_mpath(struct sk_
+ 		if (err)
+ 			goto out_err;
+ 
+-		if (nl80211_send_mpath(skb, NETLINK_CB(cb->skb).portid,
++		if (nl80211_send_mpath(skb, NETLINK_CB_PORTID(cb->skb),
+ 				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
+ 				       netdev, dst, next_hop,
+ 				       &pinfo) < 0)
+@@ -3438,7 +3438,7 @@ static int nl80211_get_mpath(struct sk_b
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	if (nl80211_send_mpath(msg, info->snd_portid, info->snd_seq, 0,
++	if (nl80211_send_mpath(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 				 dev, dst, next_hop, &pinfo) < 0) {
+ 		nlmsg_free(msg);
+ 		return -ENOBUFS;
+@@ -3679,7 +3679,7 @@ static int nl80211_get_mesh_config(struc
+ 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+ 	if (!msg)
+ 		return -ENOMEM;
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_GET_MESH_CONFIG);
+ 	if (!hdr)
+ 		goto out;
+@@ -3998,7 +3998,7 @@ static int nl80211_get_reg(struct sk_buf
+ 		goto out;
+ 	}
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_GET_REG);
+ 	if (!hdr)
+ 		goto put_failure;
+@@ -4616,7 +4616,7 @@ static int nl80211_send_bss(struct sk_bu
+ 
+ 	ASSERT_WDEV_LOCK(wdev);
+ 
+-	hdr = nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid, seq, flags,
++	hdr = nl80211hdr_put(msg, NETLINK_CB_PORTID(cb->skb), seq, flags,
+ 			     NL80211_CMD_NEW_SCAN_RESULTS);
+ 	if (!hdr)
+ 		return -1;
+@@ -4838,7 +4838,7 @@ static int nl80211_dump_survey(struct sk
+ 		}
+ 
+ 		if (nl80211_send_survey(skb,
+-				NETLINK_CB(cb->skb).portid,
++				NETLINK_CB_PORTID(cb->skb),
+ 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
+ 				netdev,
+ 				&survey) < 0)
+@@ -5453,7 +5453,7 @@ static int nl80211_testmode_dump(struct
+ 	}
+ 
+ 	while (1) {
+-		void *hdr = nl80211hdr_put(skb, NETLINK_CB(cb->skb).portid,
++		void *hdr = nl80211hdr_put(skb, NETLINK_CB_PORTID(cb->skb),
+ 					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
+ 					   NL80211_CMD_TESTMODE);
+ 		struct nlattr *tmdata;
+@@ -5533,7 +5533,7 @@ struct sk_buff *cfg80211_testmode_alloc_
+ 		return NULL;
+ 
+ 	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
+-				rdev->testmode_info->snd_portid,
++				genl_info_snd_portid(rdev->testmode_info),
+ 				rdev->testmode_info->snd_seq,
+ 				GFP_KERNEL);
+ }
+@@ -5873,7 +5873,7 @@ static int nl80211_remain_on_channel(str
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_REMAIN_ON_CHANNEL);
+ 
+ 	if (IS_ERR(hdr)) {
+@@ -6092,7 +6092,7 @@ static int nl80211_register_mgmt(struct
+ 	if (!rdev->ops->mgmt_tx)
+ 		return -EOPNOTSUPP;
+ 
+-	return cfg80211_mlme_register_mgmt(wdev, info->snd_portid, frame_type,
++	return cfg80211_mlme_register_mgmt(wdev, genl_info_snd_portid(info), frame_type,
+ 			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
+ 			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
+ }
+@@ -6173,7 +6173,7 @@ static int nl80211_tx_mgmt(struct sk_buf
+ 		if (!msg)
+ 			return -ENOMEM;
+ 
+-		hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++		hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 				     NL80211_CMD_FRAME);
+ 
+ 		if (IS_ERR(hdr)) {
+@@ -6290,7 +6290,7 @@ static int nl80211_get_power_save(struct
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_GET_POWER_SAVE);
+ 	if (!hdr) {
+ 		err = -ENOBUFS;
+@@ -6492,7 +6492,7 @@ static int nl80211_get_wowlan(struct sk_
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_GET_WOWLAN);
+ 	if (!hdr)
+ 		goto nla_put_failure;
+@@ -6769,7 +6769,7 @@ static int nl80211_register_unexpected_f
+ 	if (wdev->ap_unexpected_nlportid)
+ 		return -EBUSY;
+ 
+-	wdev->ap_unexpected_nlportid = info->snd_portid;
++	wdev->ap_unexpected_nlportid = genl_info_snd_portid(info);
+ 	return 0;
+ }
+ 
+@@ -6799,7 +6799,7 @@ static int nl80211_probe_client(struct s
+ 	if (!msg)
+ 		return -ENOMEM;
+ 
+-	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
++	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
+ 			     NL80211_CMD_PROBE_CLIENT);
+ 
+ 	if (IS_ERR(hdr)) {
+@@ -6837,7 +6837,7 @@ static int nl80211_register_beacons(stru
+ 	if (rdev->ap_beacons_nlportid)
+ 		return -EBUSY;
+ 
+-	rdev->ap_beacons_nlportid = info->snd_portid;
++	rdev->ap_beacons_nlportid = genl_info_snd_portid(info);
+ 
+ 	return 0;
+ }
+@@ -8859,8 +8859,8 @@ static int nl80211_netlink_notify(struct
+ 
+ 	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
+ 		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
+-			cfg80211_mlme_unregister_socket(wdev, notify->portid);
+-		if (rdev->ap_beacons_nlportid == notify->portid)
++			cfg80211_mlme_unregister_socket(wdev, netlink_notify_portid(notify));
++		if (rdev->ap_beacons_nlportid == netlink_notify_portid(notify))
+ 			rdev->ap_beacons_nlportid = 0;
+ 	}
+ 
-- 
1.7.10.4
