Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:53514 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbaDQSFH (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 14:05:07 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so629079pbb.31
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 11:05:06 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/8] backports: sync up to next-20140415
Date: Thu, 17 Apr 2014 11:04:48 -0700
Message-Id: <1397757896-32558-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140417_200530_191209_AA99283C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This catches us up to next-20140415. Two new SmPL rules are added,
and the bpcoccinelle library was generalzied as a standard tool to
allow other uses. You can now use pycocci for your own development
on git trees and it will do what you expect with sensible defaults.

Luis R. Rodriguez (8):
  backports: revert unification of cocci files
  backports: transform group attribute backport to SmPL form
  backports: use --use-coccigrep for Coccinelle
  backports: Use Coccinelle --relax-include-path
  backports: add a 120 second timeout rule to Coccinelle
  backports: pycocci - make the Coccinelle wrapper a standalone tool
  backports: formalize struct sock sk_data_ready() backport with SmPL
  backports: refresh patches for next-20140415

 devel/pycocci                                      | 180 +++++++++++++++++++++
 gentree.py                                         |  73 ++++-----
 lib/bpcoccinelle.py                                |  92 -----------
 .../0001-group-attr/0001-group_attr_class.cocci    |  78 +++++++++
 .../0001-group-attr/0002-group_attr_bus.cocci      |  77 +++++++++
 .../generic/0001-group-attr/INFO                   |  40 +++++
 .../generic/0001-sysfs-api/INFO                    |  36 -----
 .../generic/0001-sysfs-api/drivers_bcma.patch      |  35 ----
 .../drivers_media_v4l2-core_v4l2-dev.patch         |  35 ----
 .../generic/0001-sysfs-api/drivers_ssb.patch       |  35 ----
 .../0001-sysfs-api/net_ieee802154_wpan-class.patch |  35 ----
 .../0001-sysfs-api/net_wireless_sysfs.patch        |  35 ----
 .../network/0031-sk_data_ready.cocci               | 117 ++++++++++++++
 .../0001-igb_net_device_ops.patch                  |   6 +-
 .../0002-igb_pci_sriov_configure.patch             |   8 +-
 .../0001-ethernet-igb/0008-igb_no_fcs.patch        |   2 +-
 .../0001-ethernet-igb/0009-igb_vlan_rx_vid.patch   |   6 +-
 .../0012-igb_ndo_set_vf_spoofchk.patch             |   6 +-
 18 files changed, 540 insertions(+), 356 deletions(-)
 create mode 100755 devel/pycocci
 delete mode 100644 lib/bpcoccinelle.py
 create mode 100644 patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
 create mode 100644 patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
 create mode 100644 patches/collateral-evolutions/generic/0001-group-attr/INFO
 delete mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/INFO
 delete mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/drivers_bcma.patch
 delete mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/drivers_media_v4l2-core_v4l2-dev.patch
 delete mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch
 delete mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch
 delete mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch
 create mode 100644 patches/collateral-evolutions/network/0031-sk_data_ready.cocci

-- 
1.9.1

