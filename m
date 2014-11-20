Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:64528 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbaKTVQ3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 20 Nov 2014 16:16:29 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so3765356pdb.28
        for <backports@vger.kernel.org>; Thu, 20 Nov 2014 13:16:29 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, oblinger@gmail.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 0/5] backports: move up to next-20141117
Date: Thu, 20 Nov 2014 13:16:18 -0800
Message-Id: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20141120_221631_890575_73E6527A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Here's a few required backport changes to get us up from
next-20141114 to next-20141117. The first two patches are
example *simple* upstream changes we should consider
evaluating the possibility to automatically infer what is
required to do and automatically backport. We'd need to
deduce file renames or file splitting. Consider this as
part of the automation TODO list. It doesn't seem like
we need any special tools for this, but simply some
inference based evaluation of deltas.

Luis R. Rodriguez (5):
  backports: rename wpan-phy.h to cfg802154.h
  backports: address splitting of v4l2-mediabus.h to two files
  backports: bump I2C_SI4713 to v3.13
  backports: backport netdev_rss_key_fill()
  backports: refresh patches for next-20141117

 backport/backport-include/linux/netdevice.h        | 25 ++++++++++++++++++++++
 backport/compat/backport-3.19.c                    | 15 ++++++++++++-
 copy-list                                          |  3 ++-
 dependencies                                       | 17 +++++++++++++++
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 +++----
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 +++----
 .../igb_ndo_set_vf_spoofchk.patch                  |  6 +++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |  8 +++----
 .../network/0048-no_ndo_xmit_flush/igb.patch       |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  4 ++--
 11 files changed, 77 insertions(+), 21 deletions(-)

-- 
2.1.1

