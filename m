Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36156 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3JWVhS (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:18 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: refresh patches on next-20130906
Date: Wed, 23 Oct 2013 23:36:49 +0200
Message-Id: <1382564210-15230-8-git-send-email-hauke@hauke-m.de> (sfid-20131023_233720_125726_979F1EC5)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  OK  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0001-netdev_ops/libertas.patch   |    2 +-
 .../network/16-bluetooth/net_bluetooth_hci_sock.patch              |    4 ++--
 patches/collateral-evolutions/network/78-usb-sg/usbnet.patch       |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch b/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch
index b760f99..73b77dc 100644
--- a/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/libertas.patch
@@ -18,5 +18,5 @@
 -	mesh_dev->netdev_ops = &mesh_netdev_ops;
 +	netdev_attach_ops(mesh_dev, &mesh_netdev_ops);
  	mesh_dev->ethtool_ops = &lbs_ethtool_ops;
- 	memcpy(mesh_dev->dev_addr, priv->dev->dev_addr, ETH_ALEN);
+ 	eth_hw_addr_inherit(mesh_dev, priv->dev);
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
index 923c718..4167485 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_sock.c
 +++ b/net/bluetooth/hci_sock.c
-@@ -884,8 +884,13 @@ drop:
+@@ -1000,8 +1000,13 @@ drop:
  	goto done;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct hci_ufilter uf = { .opcode = 0 };
  	struct sock *sk = sock->sk;
-@@ -1059,8 +1064,12 @@ static struct proto hci_sk_proto = {
+@@ -1175,8 +1180,12 @@ static struct proto hci_sk_proto = {
  	.obj_size	= sizeof(struct hci_pinfo)
  };
  
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
index e7c841c..07d9d96 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -41,7 +41,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1767,7 +1778,9 @@ int usbnet_resume (struct usb_interface
+@@ -1773,7 +1784,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
-- 
1.7.10.4

