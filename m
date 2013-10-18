Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:48555 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756154Ab3JRP3G (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 18 Oct 2013 11:29:06 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC] backports: replace netlink portid by semantic patch
Date: Fri, 18 Oct 2013 17:28:59 +0200
Message-Id: <1382110139-23344-1-git-send-email-johannes@sipsolutions.net> (sfid-20131018_172919_707520_91D94862)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Introduce the infrastructure to apply semantic patches
and make use of it for the (frequently breaking) portid
patch for netlink.

Unfortunately this is significantly slower:

before:
real    0m14.312s
user    0m12.144s
sys     0m1.784s

after:
real    0m25.932s
user    0m21.768s
sys     0m2.932s

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py                                         |  36 +++
 .../network/0005-netlink-portid.cocci              |  25 ++
 .../network/0005-netlink-portid/INFO               |  42 ----
 .../0005-netlink-portid/mac80211_hwsim.patch       |  24 --
 .../network/0005-netlink-portid/nl80211.patch      | 267 ---------------------
 5 files changed, 61 insertions(+), 333 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0005-netlink-portid.cocci
 delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/INFO
 delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
 delete mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch

diff --git a/gentree.py b/gentree.py
index c480c98..bc407a5 100755
--- a/gentree.py
+++ b/gentree.py
@@ -372,10 +372,13 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     logwrite('Apply patches ...')
     patches = []
+    sempatches = []
     for root, dirs, files in os.walk(os.path.join(source_dir, 'patches')):
         for f in files:
             if f.endswith('.patch'):
                 patches.append(os.path.join(root, f))
+            if f.endswith('.cocci'):
+                sempatches.append(os.path.join(root, f))
     patches.sort()
     prefix_len = len(os.path.join(source_dir, 'patches')) + 1
     for pfile in patches:
@@ -453,6 +456,39 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                     os.unlink(os.path.join(root, f))
         git_debug_snapshot(args, "apply backport patch %s" % print_name)
 
+    sempatches.sort()
+    prefix_len = len(os.path.join(source_dir, 'patches')) + 1
+    for cocci_file in sempatches:
+        print_name = cocci_file[prefix_len:]
+        if args.verbose:
+            logwrite("Applying patch %s" % print_name)
+
+        process = subprocess.Popen(['spatch', '--sp-file', cocci_file, '--in-place',
+                                    '--backup-suffix', '.cocci_backup', '--dir', '.'],
+                                   stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                                   close_fds=True, universal_newlines=True,
+                                   cwd=args.outdir)
+        output = process.communicate()[0]
+        output = output.split('\n')
+        if output[-1] == '':
+            output = output[:-1]
+        if args.verbose:
+            for line in output:
+                logwrite('> %s' % line)
+        if process.returncode != 0:
+            if not args.verbose:
+                logwrite("Failed to apply changes from %s" % print_name)
+                for line in output:
+                    logwrite('> %s' % line)
+            return 2
+
+        # remove cocci_backup files
+        for root, dirs, files in os.walk(args.outdir):
+            for f in files:
+                if f.endswith('.cocci_backup'):
+                    os.unlink(os.path.join(root, f))
+        git_debug_snapshot(args, "apply backport patch %s" % print_name)
+
     # some post-processing is required
     configtree = kconfig.ConfigTree(os.path.join(args.outdir, 'Kconfig'))
     logwrite('Modify Kconfig tree ...')
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.cocci b/patches/collateral-evolutions/network/0005-netlink-portid.cocci
new file mode 100644
index 0000000..409e926
--- /dev/null
+++ b/patches/collateral-evolutions/network/0005-netlink-portid.cocci
@@ -0,0 +1,25 @@
+@nl1@
+identifier notify;
+@@
+struct netlink_notify *notify;
+@@
+identifier nl1.notify;
+@@
+-notify->portid
++netlink_notify_portid(notify)
+
+// This works because no other struct in the kernel
+// has an snd_portid member.
+@@
+expression info;
+@@
+-info->snd_portid
++genl_info_snd_portid(info)
+
+// skb is an expression since it could be something
+// other than just an identifier, e.g. cb->skb
+@@
+expression skb;
+@@
+-NETLINK_CB(skb).portid
++NETLINK_CB_PORTID(skb)
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/INFO b/patches/collateral-evolutions/network/0005-netlink-portid/INFO
deleted file mode 100644
index e49ac3b..0000000
--- a/patches/collateral-evolutions/network/0005-netlink-portid/INFO
+++ /dev/null
@@ -1,42 +0,0 @@
-The patch:
-
-commit 15e473046cb6e5d18a4d0057e61d76315230382b
-Author: Eric W. Biederman <ebiederm@xmission.com>
-Date:   Fri Sep 7 20:12:54 2012 +0000
-
-    netlink: Rename pid to portid to avoid confusion
-    
-    It is a frequent mistake to confuse the netlink port identifier with a
-    process identifier.  Try to reduce this confusion by renaming fields
-    that hold port identifiers portid instead of pid.
-    
-    I have carefully avoided changing the structures exported to
-    userspace to avoid changing the userspace API.
-    
-    I have successfully built an allyesconfig kernel with this change.
-    
-    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
-    Acked-by: Stephen Hemminger <shemminger@vyatta.com>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
-Changed the struct members:
-
-struct netlink_notify->pid    to
-struct netlink_notify->portid
-
-struct genl_info->snd_pid     to
-struct genl_info->snd_portid
-
-To help backport this and not have to #ifdef around it against
-kernel versions compat has introduced two helpers for us to
-simply do the backport with two macro helpers:
-
-genl_info_snd_portid()
-netlink_notify_portid()
-
-This takes care of the work for us requiring only one
-single line change. If we get another patch thrown into
-this file then I suspect we can extract SMPL out of it
-and use it to backport further collateral evolutions like
-this one should other drivers / subsystem need this change.
-
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
deleted file mode 100644
index e7b9e16..0000000
--- a/patches/collateral-evolutions/network/0005-netlink-portid/mac80211_hwsim.patch
+++ /dev/null
@@ -1,24 +0,0 @@
---- a/drivers/net/wireless/mac80211_hwsim.c
-+++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -2063,10 +2063,10 @@ static int hwsim_register_received_nl(st
- 	if (info == NULL)
- 		goto out;
- 
--	wmediumd_portid = info->snd_portid;
-+	wmediumd_portid = genl_info_snd_portid(info);
- 
- 	printk(KERN_DEBUG "mac80211_hwsim: received a REGISTER, "
--	       "switching to wmediumd mode with pid %d\n", info->snd_portid);
-+	       "switching to wmediumd mode with pid %d\n", genl_info_snd_portid(info));
- 
- 	return 0;
- out:
-@@ -2103,7 +2103,7 @@ static int mac80211_hwsim_netlink_notify
- 	if (state != NETLINK_URELEASE)
- 		return NOTIFY_DONE;
- 
--	if (notify->portid == wmediumd_portid) {
-+	if (netlink_notify_portid(notify) == wmediumd_portid) {
- 		printk(KERN_INFO "mac80211_hwsim: wmediumd released netlink"
- 		       " socket, switching to perfect channel medium\n");
- 		wmediumd_portid = 0;
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch b/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
deleted file mode 100644
index dc8b9b1..0000000
--- a/patches/collateral-evolutions/network/0005-netlink-portid/nl80211.patch
+++ /dev/null
@@ -1,267 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -1628,7 +1628,7 @@ static int nl80211_dump_wiphy(struct sk_
- 		/* attempt to fit multiple wiphy data chunks into the skb */
- 		do {
- 			ret = nl80211_send_wiphy(dev, skb,
--						 NETLINK_CB(cb->skb).portid,
-+						 NETLINK_CB_PORTID(cb->skb),
- 						 cb->nlh->nlmsg_seq,
- 						 NLM_F_MULTI, state);
- 			if (ret < 0) {
-@@ -1681,7 +1681,7 @@ static int nl80211_get_wiphy(struct sk_b
- 	if (!msg)
- 		return -ENOMEM;
- 
--	if (nl80211_send_wiphy(dev, msg, info->snd_portid, info->snd_seq, 0,
-+	if (nl80211_send_wiphy(dev, msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			       &state) < 0) {
- 		nlmsg_free(msg);
- 		return -ENOBUFS;
-@@ -2256,7 +2256,7 @@ static int nl80211_dump_interface(struct
- 				if_idx++;
- 				continue;
- 			}
--			if (nl80211_send_iface(skb, NETLINK_CB(cb->skb).portid,
-+			if (nl80211_send_iface(skb, NETLINK_CB_PORTID(cb->skb),
- 					       cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 					       rdev, wdev) < 0) {
- 				goto out;
-@@ -2285,7 +2285,7 @@ static int nl80211_get_interface(struct
- 	if (!msg)
- 		return -ENOMEM;
- 
--	if (nl80211_send_iface(msg, info->snd_portid, info->snd_seq, 0,
-+	if (nl80211_send_iface(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			       dev, wdev) < 0) {
- 		nlmsg_free(msg);
- 		return -ENOBUFS;
-@@ -2518,7 +2518,7 @@ static int nl80211_new_interface(struct
- 		break;
- 	}
- 
--	if (nl80211_send_iface(msg, info->snd_portid, info->snd_seq, 0,
-+	if (nl80211_send_iface(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			       rdev, wdev) < 0) {
- 		nlmsg_free(msg);
- 		return -ENOBUFS;
-@@ -2653,7 +2653,7 @@ static int nl80211_get_key(struct sk_buf
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_NEW_KEY);
- 	if (IS_ERR(hdr))
- 		return PTR_ERR(hdr);
-@@ -3622,7 +3622,7 @@ static int nl80211_dump_station(struct s
- 			goto out_err;
- 
- 		if (nl80211_send_station(skb,
--				NETLINK_CB(cb->skb).portid,
-+				NETLINK_CB_PORTID(cb->skb),
- 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 				dev, wdev->netdev, mac_addr,
- 				&sinfo) < 0)
-@@ -3668,7 +3668,7 @@ static int nl80211_get_station(struct sk
- 	if (!msg)
- 		return -ENOMEM;
- 
--	if (nl80211_send_station(msg, info->snd_portid, info->snd_seq, 0,
-+	if (nl80211_send_station(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 				 rdev, dev, mac_addr, &sinfo) < 0) {
- 		nlmsg_free(msg);
- 		return -ENOBUFS;
-@@ -4276,7 +4276,7 @@ static int nl80211_dump_mpath(struct sk_
- 		if (err)
- 			goto out_err;
- 
--		if (nl80211_send_mpath(skb, NETLINK_CB(cb->skb).portid,
-+		if (nl80211_send_mpath(skb, NETLINK_CB_PORTID(cb->skb),
- 				       cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 				       wdev->netdev, dst, next_hop,
- 				       &pinfo) < 0)
-@@ -4325,7 +4325,7 @@ static int nl80211_get_mpath(struct sk_b
- 	if (!msg)
- 		return -ENOMEM;
- 
--	if (nl80211_send_mpath(msg, info->snd_portid, info->snd_seq, 0,
-+	if (nl80211_send_mpath(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 				 dev, dst, next_hop, &pinfo) < 0) {
- 		nlmsg_free(msg);
- 		return -ENOBUFS;
-@@ -4589,7 +4589,7 @@ static int nl80211_get_mesh_config(struc
- 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
- 	if (!msg)
- 		return -ENOMEM;
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_GET_MESH_CONFIG);
- 	if (!hdr)
- 		goto out;
-@@ -4948,7 +4948,7 @@ static int nl80211_get_reg(struct sk_buf
- 	if (!msg)
- 		return -ENOBUFS;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_GET_REG);
- 	if (!hdr)
- 		goto put_failure;
-@@ -5627,7 +5627,7 @@ static int nl80211_send_bss(struct sk_bu
- 
- 	ASSERT_WDEV_LOCK(wdev);
- 
--	hdr = nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid, seq, flags,
-+	hdr = nl80211hdr_put(msg, NETLINK_CB_PORTID(cb->skb), seq, flags,
- 			     NL80211_CMD_NEW_SCAN_RESULTS);
- 	if (!hdr)
- 		return -1;
-@@ -5864,7 +5864,7 @@ static int nl80211_dump_survey(struct sk
- 		}
- 
- 		if (nl80211_send_survey(skb,
--				NETLINK_CB(cb->skb).portid,
-+				NETLINK_CB_PORTID(cb->skb),
- 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 				wdev->netdev, &survey) < 0)
- 			goto out;
-@@ -6551,7 +6551,7 @@ static int nl80211_testmode_dump(struct
- 	}
- 
- 	while (1) {
--		void *hdr = nl80211hdr_put(skb, NETLINK_CB(cb->skb).portid,
-+		void *hdr = nl80211hdr_put(skb, NETLINK_CB_PORTID(cb->skb),
- 					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
- 					   NL80211_CMD_TESTMODE);
- 		struct nlattr *tmdata;
-@@ -6630,7 +6630,7 @@ struct sk_buff *cfg80211_testmode_alloc_
- 		return NULL;
- 
- 	return __cfg80211_testmode_alloc_skb(rdev, approxlen,
--				rdev->testmode_info->snd_portid,
-+				genl_info_snd_portid(rdev->testmode_info),
- 				rdev->testmode_info->snd_seq,
- 				GFP_KERNEL);
- }
-@@ -6998,7 +6998,7 @@ static int nl80211_remain_on_channel(str
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_REMAIN_ON_CHANNEL);
- 
- 	if (IS_ERR(hdr)) {
-@@ -7217,7 +7217,7 @@ static int nl80211_register_mgmt(struct
- 	if (!rdev->ops->mgmt_tx)
- 		return -EOPNOTSUPP;
- 
--	return cfg80211_mlme_register_mgmt(wdev, info->snd_portid, frame_type,
-+	return cfg80211_mlme_register_mgmt(wdev, genl_info_snd_portid(info), frame_type,
- 			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
- 			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
- }
-@@ -7298,7 +7298,7 @@ static int nl80211_tx_mgmt(struct sk_buf
- 		if (!msg)
- 			return -ENOMEM;
- 
--		hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+		hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 				     NL80211_CMD_FRAME);
- 
- 		if (IS_ERR(hdr)) {
-@@ -7413,7 +7413,7 @@ static int nl80211_get_power_save(struct
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_GET_POWER_SAVE);
- 	if (!hdr) {
- 		err = -ENOBUFS;
-@@ -7723,7 +7723,7 @@ static int nl80211_get_wowlan(struct sk_
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_GET_WOWLAN);
- 	if (!hdr)
- 		goto nla_put_failure;
-@@ -8152,7 +8152,7 @@ static int nl80211_get_coalesce(struct s
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_GET_COALESCE);
- 	if (!hdr)
- 		goto nla_put_failure;
-@@ -8405,7 +8405,7 @@ static int nl80211_register_unexpected_f
- 	if (wdev->ap_unexpected_nlportid)
- 		return -EBUSY;
- 
--	wdev->ap_unexpected_nlportid = info->snd_portid;
-+	wdev->ap_unexpected_nlportid = genl_info_snd_portid(info);
- 	return 0;
- }
- 
-@@ -8435,7 +8435,7 @@ static int nl80211_probe_client(struct s
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_PROBE_CLIENT);
- 
- 	if (IS_ERR(hdr)) {
-@@ -8479,13 +8479,13 @@ static int nl80211_register_beacons(stru
- 	/* First, check if already registered. */
- 	spin_lock_bh(&rdev->beacon_registrations_lock);
- 	list_for_each_entry(reg, &rdev->beacon_registrations, list) {
--		if (reg->nlportid == info->snd_portid) {
-+		if (reg->nlportid == genl_info_snd_portid(info)) {
- 			rv = -EALREADY;
- 			goto out_err;
- 		}
- 	}
- 	/* Add it to the list */
--	nreg->nlportid = info->snd_portid;
-+	nreg->nlportid = genl_info_snd_portid(info);
- 	list_add(&nreg->list, &rdev->beacon_registrations);
- 
- 	spin_unlock_bh(&rdev->beacon_registrations_lock);
-@@ -8552,7 +8552,7 @@ static int nl80211_get_protocol_features
- 	if (!msg)
- 		return -ENOMEM;
- 
--	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-+	hdr = nl80211hdr_put(msg, genl_info_snd_portid(info), info->snd_seq, 0,
- 			     NL80211_CMD_GET_PROTOCOL_FEATURES);
- 	if (!hdr)
- 		goto nla_put_failure;
-@@ -8627,7 +8627,7 @@ static int nl80211_crit_protocol_start(s
- 
- 	ret = rdev_crit_proto_start(rdev, wdev, proto, duration);
- 	if (!ret)
--		rdev->crit_proto_nlportid = info->snd_portid;
-+		rdev->crit_proto_nlportid = genl_info_snd_portid(info);
- 
- 	return ret;
- }
-@@ -11018,12 +11018,12 @@ static int nl80211_netlink_notify(struct
- 
- 	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
- 		list_for_each_entry_rcu(wdev, &rdev->wdev_list, list)
--			cfg80211_mlme_unregister_socket(wdev, notify->portid);
-+			cfg80211_mlme_unregister_socket(wdev, netlink_notify_portid(notify));
- 
- 		spin_lock_bh(&rdev->beacon_registrations_lock);
- 		list_for_each_entry_safe(reg, tmp, &rdev->beacon_registrations,
- 					 list) {
--			if (reg->nlportid == notify->portid) {
-+			if (reg->nlportid == netlink_notify_portid(notify)) {
- 				list_del(&reg->list);
- 				kfree(reg);
- 				break;
-- 
1.8.4.rc3

