Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:50690 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3KUQY4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 21 Nov 2013 11:24:56 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: replace netdev ops patch with spatch
Date: Thu, 21 Nov 2013 17:24:50 +0100
Message-Id: <1385051090-19294-1-git-send-email-johannes@sipsolutions.net> (sfid-20131121_172459_276206_4A9BC652)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There's no need to carry a small netdev ops patch for
each driver any more now, we can just write a small
semantic patch. Only the ndo_ioctl() part is easier
to keep as a separate patch.

As some stupid drivers seem to set their ops to NULL
just before freeing the netdev anyway, the attach
function must gracefully handle that (but not doesn't
really need to do anything.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/compat-2.6.29.c                    |  3 +++
 .../{0001-netdev_ops/INFO => 0001-ndo_ioctl.patch} | 13 ++++++++++
 .../network/0001-netdev_ops.cocci                  |  6 +++++
 .../network/0001-netdev_ops/alx.patch              | 11 --------
 .../network/0001-netdev_ops/ath6kl.patch           | 11 --------
 .../network/0001-netdev_ops/atl1c.patch            | 11 --------
 .../network/0001-netdev_ops/atl1e.patch            | 11 --------
 .../network/0001-netdev_ops/atlx.patch             | 22 ----------------
 .../network/0001-netdev_ops/b44.patch              | 11 --------
 .../network/0001-netdev_ops/bluetooth_bnep.patch   | 11 --------
 .../network/0001-netdev_ops/ipw2100.patch          | 11 --------
 .../network/0001-netdev_ops/ipw2200.patch          | 20 ---------------
 .../network/0001-netdev_ops/libertas.patch         | 22 ----------------
 .../network/0001-netdev_ops/mac80211.patch         | 29 ----------------------
 .../network/0001-netdev_ops/mac80211_hwsim.patch   | 11 --------
 .../network/0001-netdev_ops/mwifiex.patch          | 11 --------
 .../network/0001-netdev_ops/orinoco.patch          | 14 -----------
 .../network/0001-netdev_ops/qmi_wwan.patch         | 11 --------
 .../network/0001-netdev_ops/rndis.patch            | 11 --------
 .../network/0001-netdev_ops/rndis_wlan.patch       | 11 --------
 .../network/0001-netdev_ops/sierra_net.patch       | 11 --------
 .../network/0001-netdev_ops/usbnet.patch           | 11 --------
 .../network/0001-netdev_ops/wext.patch             | 13 ----------
 .../network/0001-netdev_ops/wil6210.patch          | 11 --------
 24 files changed, 22 insertions(+), 285 deletions(-)
 rename patches/collateral-evolutions/network/{0001-netdev_ops/INFO => 0001-ndo_ioctl.patch} (78%)
 create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops.cocci
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/b44.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/bluetooth_bnep.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/ipw2200.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/orinoco.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/rndis_wlan.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/wext.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch

diff --git a/backport/compat/compat-2.6.29.c b/backport/compat/compat-2.6.29.c
index d216407..65b45f8 100644
--- a/backport/compat/compat-2.6.29.c
+++ b/backport/compat/compat-2.6.29.c
@@ -21,6 +21,9 @@
 void netdev_attach_ops(struct net_device *dev,
 		       const struct net_device_ops *ops)
 {
+	if (!ops)
+		return;
+
 	dev->open = ops->ndo_open;
 	dev->init = ops->ndo_init;
 	dev->stop = ops->ndo_stop;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/INFO b/patches/collateral-evolutions/network/0001-ndo_ioctl.patch
similarity index 78%
rename from patches/collateral-evolutions/network/0001-netdev_ops/INFO
rename to patches/collateral-evolutions/network/0001-ndo_ioctl.patch
index 31bea51..74763f3 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/INFO
+++ b/patches/collateral-evolutions/network/0001-ndo_ioctl.patch
@@ -36,3 +36,16 @@ Date:   Wed Nov 19 21:32:24 2008 -0800
     Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>
 
+--- a/net/wireless/wext-core.c
++++ b/net/wireless/wext-core.c
+@@ -925,9 +925,7 @@ static int wireless_process_ioctl(struct
+ 			return private(dev, iwr, cmd, info, handler);
+ 	}
+ 	/* Old driver API : call driver ioctl handler */
+-	if (dev->netdev_ops->ndo_do_ioctl)
+-		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
+-	return -EOPNOTSUPP;
++	return ndo_do_ioctl(dev, ifr, cmd);
+ }
+ 
+ /* If command is `set a parameter', or `get the encoding parameters',
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.cocci b/patches/collateral-evolutions/network/0001-netdev_ops.cocci
new file mode 100644
index 0000000..f3d2e63
--- /dev/null
+++ b/patches/collateral-evolutions/network/0001-netdev_ops.cocci
@@ -0,0 +1,6 @@
+@@
+expression dev;
+expression ops;
+@@
+-dev->netdev_ops = ops;
++netdev_attach_ops(dev, ops);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
deleted file mode 100644
index a0eca03..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/alx.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1256,7 +1256,7 @@ static int alx_probe(struct pci_dev *pde
- 		goto out_free_netdev;
- 	}
- 
--	netdev->netdev_ops = &alx_netdev_ops;
-+	netdev_attach_ops(netdev, &alx_netdev_ops);
- 	SET_ETHTOOL_OPS(netdev, &alx_ethtool_ops);
- 	netdev->irq = pdev->irq;
- 	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch b/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch
deleted file mode 100644
index 0057c41..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/ath6kl.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/main.c
-+++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1292,7 +1292,7 @@ static const struct net_device_ops ath6k
- 
- void init_netdev(struct net_device *dev)
- {
--	dev->netdev_ops = &ath6kl_netdev_ops;
-+	netdev_attach_ops(dev, &ath6kl_netdev_ops);
- 	dev->destructor = free_netdev;
- 	dev->watchdog_timeo = ATH6KL_TX_TIMEOUT;
- 
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch
deleted file mode 100644
index 4ac2c5e..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atl1c.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2508,7 +2508,7 @@ static int atl1c_init_netdev(struct net_
- 	SET_NETDEV_DEV(netdev, &pdev->dev);
- 	pci_set_drvdata(pdev, netdev);
- 
--	netdev->netdev_ops = &atl1c_netdev_ops;
-+	netdev_attach_ops(netdev, &atl1c_netdev_ops);
- 	netdev->watchdog_timeo = AT_TX_WATCHDOG;
- 	atl1c_set_ethtool_ops(netdev);
- 
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
deleted file mode 100644
index 15a0180..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atl1e.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -2273,7 +2273,7 @@ static int atl1e_init_netdev(struct net_
- 	SET_NETDEV_DEV(netdev, &pdev->dev);
- 	pci_set_drvdata(pdev, netdev);
- 
--	netdev->netdev_ops = &atl1e_netdev_ops;
-+	netdev_attach_ops(netdev, &atl1e_netdev_ops);
- 
- 	netdev->watchdog_timeo = AT_TX_WATCHDOG;
- 	atl1e_set_ethtool_ops(netdev);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch b/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch
deleted file mode 100644
index 8cab3be..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/atlx.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/drivers/net/ethernet/atheros/atlx/atl1.c
-+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -3004,7 +3004,7 @@ static int atl1_probe(struct pci_dev *pd
- 	adapter->mii.phy_id_mask = 0x1f;
- 	adapter->mii.reg_num_mask = 0x1f;
- 
--	netdev->netdev_ops = &atl1_netdev_ops;
-+	netdev_attach_ops(netdev, &atl1_netdev_ops);
- 	netdev->watchdog_timeo = 5 * HZ;
- 	netif_napi_add(netdev, &adapter->napi, atl1_rings_clean, 64);
- 
---- a/drivers/net/ethernet/atheros/atlx/atl2.c
-+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
-@@ -1396,7 +1396,7 @@ static int atl2_probe(struct pci_dev *pd
- 
- 	atl2_setup_pcicmd(pdev);
- 
--	netdev->netdev_ops = &atl2_netdev_ops;
-+	netdev_attach_ops(netdev, &atl2_netdev_ops);
- 	atl2_set_ethtool_ops(netdev);
- 	netdev->watchdog_timeo = 5 * HZ;
- 	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch b/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch
deleted file mode 100644
index 3c1097c..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/b44.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/ethernet/broadcom/b44.c
-+++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -2180,7 +2180,7 @@ static int b44_init_one(struct ssb_devic
- 	bp->rx_pending = B44_DEF_RX_RING_PENDING;
- 	bp->tx_pending = B44_DEF_TX_RING_PENDING;
- 
--	dev->netdev_ops = &b44_netdev_ops;
-+	netdev_attach_ops(dev, &b44_netdev_ops);
- 	netif_napi_add(dev, &bp->napi, b44_poll, 64);
- 	dev->watchdog_timeo = B44_TX_TIMEOUT;
- 	dev->irq = sdev->irq;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/bluetooth_bnep.patch b/patches/collateral-evolutions/network/0001-netdev_ops/bluetooth_bnep.patch
deleted file mode 100644
index 3460e0c..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/bluetooth_bnep.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/net/bluetooth/bnep/netdev.c
-+++ b/net/bluetooth/bnep/netdev.c
-@@ -223,7 +223,7 @@ void bnep_net_setup(struct net_device *d
- 
- 	ether_setup(dev);
- 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
--	dev->netdev_ops = &bnep_netdev_ops;
-+	netdev_attach_ops(dev, &bnep_netdev_ops);
- 
- 	dev->watchdog_timeo  = HZ * 2;
- }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch b/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch
deleted file mode 100644
index 0d174d3..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/ipw2100.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/ipw2x00/ipw2100.c
-+++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6068,7 +6068,7 @@ static struct net_device *ipw2100_alloc_
- 	priv->ieee->perfect_rssi = -20;
- 	priv->ieee->worst_rssi = -85;
- 
--	dev->netdev_ops = &ipw2100_netdev_ops;
-+	netdev_attach_ops(dev, &ipw2100_netdev_ops);
- 	dev->ethtool_ops = &ipw2100_ethtool_ops;
- 	dev->wireless_handlers = &ipw2100_wx_handler_def;
- 	priv->wireless_data.libipw = priv->ieee;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/ipw2200.patch b/patches/collateral-evolutions/network/0001-netdev_ops/ipw2200.patch
deleted file mode 100644
index b2baafa..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/ipw2200.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/drivers/net/wireless/ipw2x00/ipw2200.c
-+++ b/drivers/net/wireless/ipw2x00/ipw2200.c
-@@ -11681,7 +11681,7 @@ static int ipw_prom_alloc(struct ipw_pri
- 	memcpy(priv->prom_net_dev->dev_addr, priv->mac_addr, ETH_ALEN);
- 
- 	priv->prom_net_dev->type = ARPHRD_IEEE80211_RADIOTAP;
--	priv->prom_net_dev->netdev_ops = &ipw_prom_netdev_ops;
-+	netdev_attach_ops(priv->prom_net_dev, &ipw_prom_netdev_ops);
- 
- 	priv->prom_priv->ieee->iw_mode = IW_MODE_MONITOR;
- 	SET_NETDEV_DEV(priv->prom_net_dev, &priv->pci_dev->dev);
-@@ -11819,7 +11819,7 @@ static int ipw_pci_probe(struct pci_dev
- 	priv->ieee->perfect_rssi = -20;
- 	priv->ieee->worst_rssi = -85;
- 
--	net_dev->netdev_ops = &ipw_netdev_ops;
-+	netdev_attach_ops(net_dev, &ipw_netdev_ops);
- 	priv->wireless_data.spy_data = &priv->ieee->spy_data;
- 	net_dev->wireless_data = &priv->wireless_data;
- 	net_dev->wireless_handlers = &ipw_wx_handler_def;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch b/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch
deleted file mode 100644
index 73b77dc..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/drivers/net/wireless/libertas/main.c
-+++ b/drivers/net/wireless/libertas/main.c
-@@ -993,7 +993,7 @@ struct lbs_private *lbs_add_card(void *c
- 	wdev->netdev = dev;
- 	priv->dev = dev;
- 
-- 	dev->netdev_ops = &lbs_netdev_ops;
-+	netdev_attach_ops(dev, &lbs_netdev_ops);
- 	dev->watchdog_timeo = 5 * HZ;
- 	dev->ethtool_ops = &lbs_ethtool_ops;
- 	dev->flags |= IFF_BROADCAST | IFF_MULTICAST;
---- a/drivers/net/wireless/libertas/mesh.c
-+++ b/drivers/net/wireless/libertas/mesh.c
-@@ -1015,7 +1015,7 @@ static int lbs_add_mesh(struct lbs_priva
- 	mesh_dev->ieee80211_ptr = mesh_wdev;
- 	priv->mesh_dev = mesh_dev;
- 
--	mesh_dev->netdev_ops = &mesh_netdev_ops;
-+	netdev_attach_ops(mesh_dev, &mesh_netdev_ops);
- 	mesh_dev->ethtool_ops = &lbs_ethtool_ops;
- 	eth_hw_addr_inherit(mesh_dev, priv->dev);
- 
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
deleted file mode 100644
index 3e674eb..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/net/mac80211/iface.c
-+++ b/net/mac80211/iface.c
-@@ -1112,7 +1112,7 @@ static void ieee80211_if_setup(struct ne
- {
- 	ether_setup(dev);
- 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
--	dev->netdev_ops = &ieee80211_dataif_ops;
-+	netdev_attach_ops(dev, &ieee80211_dataif_ops);
- 	dev->destructor = free_netdev;
- }
- 
-@@ -1275,7 +1275,7 @@ static void ieee80211_setup_sdata(struct
- 
- 	/* only monitor/p2p-device differ */
- 	if (sdata->dev) {
--		sdata->dev->netdev_ops = &ieee80211_dataif_ops;
-+		netdev_attach_ops(sdata->dev, &ieee80211_dataif_ops);
- 		sdata->dev->type = ARPHRD_ETHER;
- 	}
- 
-@@ -1317,7 +1317,7 @@ static void ieee80211_setup_sdata(struct
- 		break;
- 	case NL80211_IFTYPE_MONITOR:
- 		sdata->dev->type = ARPHRD_IEEE80211_RADIOTAP;
--		sdata->dev->netdev_ops = &ieee80211_monitorif_ops;
-+		netdev_attach_ops(sdata->dev, &ieee80211_monitorif_ops);
- 		sdata->u.mntr_flags = MONITOR_FLAG_CONTROL |
- 				      MONITOR_FLAG_OTHER_BSS;
- 		break;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
deleted file mode 100644
index 9670949..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mac80211_hwsim.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/mac80211_hwsim.c
-+++ b/drivers/net/wireless/mac80211_hwsim.c
-@@ -1761,7 +1761,7 @@ static const struct net_device_ops hwsim
- 
- static void hwsim_mon_setup(struct net_device *dev)
- {
--	dev->netdev_ops = &hwsim_netdev_ops;
-+	netdev_attach_ops(dev, &hwsim_netdev_ops);
- 	dev->destructor = free_netdev;
- 	ether_setup(dev);
- 	dev->tx_queue_len = 0;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch b/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
deleted file mode 100644
index 3b05f25..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/mwifiex.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/mwifiex/main.c
-+++ b/drivers/net/wireless/mwifiex/main.c
-@@ -794,7 +794,7 @@ static const struct net_device_ops mwifi
- void mwifiex_init_priv_params(struct mwifiex_private *priv,
- 						struct net_device *dev)
- {
--	dev->netdev_ops = &mwifiex_netdev_ops;
-+	netdev_attach_ops(dev, &mwifiex_netdev_ops);
- 	dev->destructor = free_netdev;
- 	/* Initialize private structure */
- 	priv->current_key_index = 0;
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/orinoco.patch b/patches/collateral-evolutions/network/0001-netdev_ops/orinoco.patch
deleted file mode 100644
index e093a0b..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/orinoco.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/orinoco/main.c
-+++ b/drivers/net/wireless/orinoco/main.c
-@@ -2272,9 +2272,9 @@ int orinoco_if_add(struct orinoco_privat
- #endif
- 	/* Default to standard ops if not set */
- 	if (ops)
--		dev->netdev_ops = ops;
-+		netdev_attach_ops(dev, ops);
- 	else
--		dev->netdev_ops = &orinoco_netdev_ops;
-+		netdev_attach_ops(dev, &orinoco_netdev_ops);
- 
- 	/* we use the default eth_mac_addr for setting the MAC addr */
- 
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
deleted file mode 100644
index a9c4616..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/usb/qmi_wwan.c
-+++ b/drivers/net/usb/qmi_wwan.c
-@@ -343,7 +343,7 @@ next_desc:
- 		dev->net->dev_addr[0] |= 0x02;	/* set local assignment bit */
- 		dev->net->dev_addr[0] &= 0xbf;	/* clear "IP" bit */
- 	}
--	dev->net->netdev_ops = &qmi_wwan_netdev_ops;
-+	netdev_attach_ops(dev->net, &qmi_wwan_netdev_ops);
- err:
- 	return status;
- }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch b/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch
deleted file mode 100644
index 694e894..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/rndis.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/usb/rndis_host.c
-+++ b/drivers/net/usb/rndis_host.c
-@@ -358,7 +358,7 @@ generic_rndis_bind(struct usbnet *dev, s
- 	dev->rx_urb_size &= ~(dev->maxpacket - 1);
- 	u.init->max_transfer_size = cpu_to_le32(dev->rx_urb_size);
- 
--	net->netdev_ops = &rndis_netdev_ops;
-+	netdev_attach_ops(net, &rndis_netdev_ops);
- 
- 	retval = rndis_command(dev, u.header, CONTROL_BUFFER_SIZE);
- 	if (unlikely(retval < 0)) {
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/rndis_wlan.patch b/patches/collateral-evolutions/network/0001-netdev_ops/rndis_wlan.patch
deleted file mode 100644
index 98facfb..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/rndis_wlan.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/rndis_wlan.c
-+++ b/drivers/net/wireless/rndis_wlan.c
-@@ -3438,7 +3438,7 @@ static int rndis_wlan_bind(struct usbnet
- 	 * rndis_host wants to avoid all OID as much as possible
- 	 * so do promisc/multicast handling in rndis_wlan.
- 	 */
--	usbdev->net->netdev_ops = &rndis_wlan_netdev_ops;
-+	netdev_attach_ops(usbdev->net, &rndis_wlan_netdev_ops);
- 
- 	tmp = cpu_to_le32(RNDIS_PACKET_TYPE_DIRECTED | RNDIS_PACKET_TYPE_BROADCAST);
- 	retval = rndis_set_oid(usbdev,
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch b/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
deleted file mode 100644
index 8120a03..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/usb/sierra_net.c
-+++ b/drivers/net/usb/sierra_net.c
-@@ -695,7 +695,7 @@ static int sierra_net_bind(struct usbnet
- 
- 	priv->usbnet = dev;
- 	priv->ifnum = ifacenum;
--	dev->net->netdev_ops = &sierra_net_device_ops;
-+	netdev_attach_ops(dev->net, &sierra_net_device_ops);
- 
- 	/* change MAC addr to include, ifacenum, and to be unique */
- 	dev->net->dev_addr[ETH_ALEN-2] = atomic_inc_return(&iface_counter);
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch b/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
deleted file mode 100644
index 9ccbc25..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/usbnet.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/usb/usbnet.c
-+++ b/drivers/net/usb/usbnet.c
-@@ -1619,7 +1619,7 @@ usbnet_probe (struct usb_interface *udev
- 		net->features |= NETIF_F_HIGHDMA;
- #endif
- 
--	net->netdev_ops = &usbnet_netdev_ops;
-+	netdev_attach_ops(net, &usbnet_netdev_ops);
- 	net->watchdog_timeo = TX_TIMEOUT_JIFFIES;
- 	net->ethtool_ops = &usbnet_ethtool_ops;
- 
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/wext.patch b/patches/collateral-evolutions/network/0001-netdev_ops/wext.patch
deleted file mode 100644
index 30d7e12..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/wext.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/net/wireless/wext-core.c
-+++ b/net/wireless/wext-core.c
-@@ -925,9 +925,7 @@ static int wireless_process_ioctl(struct
- 			return private(dev, iwr, cmd, info, handler);
- 	}
- 	/* Old driver API : call driver ioctl handler */
--	if (dev->netdev_ops->ndo_do_ioctl)
--		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
--	return -EOPNOTSUPP;
-+	return ndo_do_ioctl(dev, ifr, cmd);
- }
- 
- /* If command is `set a parameter', or `get the encoding parameters',
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch b/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
deleted file mode 100644
index ac8927a..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops/wil6210.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/ath/wil6210/netdev.c
-+++ b/drivers/net/wireless/ath/wil6210/netdev.c
-@@ -125,7 +125,7 @@ void *wil_if_alloc(struct device *dev, v
- 		goto out_priv;
- 	}
- 
--	ndev->netdev_ops = &wil_netdev_ops;
-+	netdev_attach_ops(ndev, &wil_netdev_ops);
- 	ndev->ieee80211_ptr = wdev;
- 	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
- 	ndev->features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
-- 
1.8.4.rc3

