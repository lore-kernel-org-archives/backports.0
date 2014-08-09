Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44937 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbaHIOrq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: bring it to next-20140808
Date: Sat,  9 Aug 2014 16:47:33 +0200
Message-Id: <1407595659-10396-1-git-send-email-hauke@hauke-m.de> (sfid-20140809_164750_579081_6EB7224D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds some new stuff nedded for next-20140808.

Hauke Mehrtens (6):
  backports: add ktime_get_raw()
  backports: add devm_kmalloc_array()
  backports: add list_next_entry()
  backports: copy include/linux/platform_data/st21nfcb.h
  backports: refresh patches on next-20140808
  backports: update test kernel versions

 backport/backport-include/linux/device.h             | 11 +++++++++++
 backport/backport-include/linux/ktime.h              | 12 ++++++++++++
 backport/backport-include/linux/list.h               | 10 ++++++++++
 backport/compat/backport-3.17.c                      | 12 ++++++++++++
 copy-list                                            |  1 +
 devel/backports-update-manager                       | 14 +++++++-------
 .../media/0002-no_dmabuf/v4l2.patch                  |  8 ++++----
 .../media/0003-devnode_param_type/rc.patch           |  2 +-
 .../network/0006-ieee802154-6lowpan-namespace.patch  | 19 +++++++++++++++----
 .../network/0007-lowpan-inet_frag_lru_move.patch     |  2 +-
 .../network/0008-net-user-ns.patch                   |  2 +-
 .../network/0009-inet_frag_evictor.patch             | 20 --------------------
 .../network/0025-usb-sg/usbnet.patch                 | 12 ++++++------
 .../0032-sriov_configure/igb_sriov_configure.patch   |  8 ++++----
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch   |  8 ++++----
 .../igb_ndo_set_vf_spoofchk.patch                    |  6 +++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch     |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch           |  8 ++++----
 18 files changed, 97 insertions(+), 60 deletions(-)
 create mode 100644 backport/backport-include/linux/ktime.h
 delete mode 100644 patches/collateral-evolutions/network/0009-inet_frag_evictor.patch

-- 
1.9.1

