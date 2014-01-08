Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46718 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAfV (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:21 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/17] backports: backport multicast list handling in iwlwifi mvm
Date: Wed,  8 Jan 2014 01:34:27 +0100
Message-Id: <1389141274-2002-11-git-send-email-hauke@hauke-m.de> (sfid-20140108_013522_814812_CCC0432D)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Backport multicast list handling for kernel < 2.6.35 in iwlwifi mvm
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_net_wireless_iwlwifi.patch             |   42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch

diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
new file mode 100644
index 0000000..3404c11
--- /dev/null
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
@@ -0,0 +1,42 @@
+--- a/drivers/net/wireless/iwlwifi/mvm/mac80211.c
++++ b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
+@@ -800,12 +800,21 @@ static void iwl_mvm_recalc_multicast(str
+ }
+ 
+ static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 				     struct netdev_hw_addr_list *mc_list)
++#else
++				     int addr_count,
++				     struct dev_addr_list *mc_list)
++#endif
+ {
+ 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+ 	struct iwl_mcast_filter_cmd *cmd;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 	struct netdev_hw_addr *addr;
+ 	int addr_count = netdev_hw_addr_list_count(mc_list);
++#else
++	struct dev_mc_list *addr;
++#endif
+ 	bool pass_all = false;
+ 	int len;
+ 
+@@ -824,11 +833,15 @@ static u64 iwl_mvm_prepare_multicast(str
+ 		return (u64)(unsigned long)cmd;
+ 	}
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 	netdev_hw_addr_list_for_each(addr, mc_list) {
++#else
++	for (addr = mc_list; addr; addr = addr->next) {
++#endif
+ 		IWL_DEBUG_MAC80211(mvm, "mcast addr (%d): %pM\n",
+-				   cmd->count, addr->addr);
++				   cmd->count, mc_addr(addr));
+ 		memcpy(&cmd->addr_list[cmd->count * ETH_ALEN],
+-		       addr->addr, ETH_ALEN);
++		       mc_addr(addr), ETH_ALEN);
+ 		cmd->count++;
+ 	}
+ 
-- 
1.7.10.4

