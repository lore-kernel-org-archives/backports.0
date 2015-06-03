Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48275 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046AbbFCL0O (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 07:26:14 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 0/4] backports: more generic ethernet patches
Date: Wed,  3 Jun 2015 13:25:52 +0200
Message-Id: <1433330756-22733-1-git-send-email-sassmann@kpanic.de> (sfid-20150603_132616_549586_BC255C4E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Some more igb patches generalized as cocci patches.

Stefan Assmann (4):
  backports: replace igb skb->no_fcs patch with semantic patch
  backports: replace igb ethtool_cmd_mdix patch with semantic patch
  backports: replace igb xmit_more patch with semantic patch
  backports: replace igb pfmemalloc patch with semantic patch

 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   | 14 -------
 .../network/0035-skb_no_fcs/skb_no_fcs.cocci       |  7 ++++
 .../0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci   | 14 +++++++
 .../igb_ethtool_cmd_mdix.patch                     | 47 ----------------------
 .../network/0048-no_ndo_xmit_flush/igb.patch       | 14 -------
 .../network/0049-no-pfmemalloc/igb.patch           | 14 -------
 .../network/0049-no-pfmemalloc/no-pfmemalloc.cocci |  9 +++++
 .../network/0059-skb_xmit_more/INFO                | 10 +++++
 .../0059-skb_xmit_more/skb_no_xmit_more.cocci      |  9 +++++
 9 files changed, 49 insertions(+), 89 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
 create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci
 create mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
 delete mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
 delete mode 100644 patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
 delete mode 100644 patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0049-no-pfmemalloc/no-pfmemalloc.cocci
 create mode 100644 patches/collateral-evolutions/network/0059-skb_xmit_more/INFO
 create mode 100644 patches/collateral-evolutions/network/0059-skb_xmit_more/skb_no_xmit_more.cocci

-- 
2.4.2

