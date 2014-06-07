Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35221 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407AbaFGT3d (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 42EE37E72
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:32 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] backports: update to next-20140516, add RSI driver
Date: Sat,  7 Jun 2014 21:29:09 +0200
Message-Id: <1402169356-1267-1-git-send-email-hauke@hauke-m.de> (sfid-20140607_212938_010145_D578954C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20140516 and adds the RSI driver.

Hauke Mehrtens (7):
  backports: revert rename of __vlan_find_dev_deep()
  backports: handle changes to vlan_rx_add/kill pointers in cdc_mbim.c
  backports: rename irq_get_trigger_type()
  backports: add ether_addr_copy()
  backports: add mmc_card_hs()
  backports: add RSI driver
  backports: refresh patches on next-20140516

 backport/backport-include/linux/etherdevice.h      | 23 ++++++++++
 backport/backport-include/linux/if_vlan.h          |  4 ++
 backport/backport-include/linux/irq.h              |  1 +
 backport/backport-include/linux/mmc/host.h         | 16 +++++++
 backport/defconfigs/wifi                           |  1 +
 copy-list                                          |  1 +
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0026-ipv6_stub/cdc_mbim.patch          |  6 +--
 .../0030-qdisc_tx_busylock/ieee802154.patch        |  4 +-
 .../network/0033-ndo_vlan_rx_vid/cdc_mbim.patch    | 50 ++++++++++++++++++++++
 10 files changed, 102 insertions(+), 6 deletions(-)
 create mode 100644 backport/backport-include/linux/mmc/host.h
 create mode 100644 patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch

-- 
1.9.1

