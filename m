Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755722AbaAHKpA (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 8 Jan 2014 05:45:00 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v3 00/11] backports: add igb driver
Date: Wed,  8 Jan 2014 11:44:03 +0100
Message-Id: <1389177854-24292-1-git-send-email-sassmann@kpanic.de> (sfid-20140108_114501_937331_5DF000C8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a RFC for inclusion of the Intel igb wired ethernet driver.
Patches are split per kernel release that makes it easier to review
the changes and gives a nice history of what was necessary for each
release. Also the igb driver changes have been split up into individual
patches in patches/collateral-evolutions/network/82-ethernet. This and
file names are up for discussion, suggestions welcome.

v2:
Instead of backporting struct ethtool_ops the code in igb has been
wrapped in if LINUX_VERSION_CODE statements. This will result in higher
maintenance because of conflicts with future upstream igb changes but it
seems there's no better solution so far.
The patches in patches/collateral-evolutions/network/82-ethernet have
been kept separate but with a leading number to make sure they get
applied in the correct order.
The code that activates igb has been pushed to the end of the series to
not break any bisecting.
v3:
Use original struct ptp_clock and handle ptp_clock_register() with a
define. Also removed unused function warnings by wrapping the code
in if LINUX_VERSION_CODE statements.


Stefan Assmann (11):
  backports: igb fixes for linux-3.12
  backports: igb fixes for linux-3.9
  backports: igb fixes for linux-3.8
  backports: igb fixes for linux-3.7
  backports: igb fixes for linux-3.6
  backports: igb fixes for linux-3.5
  backports: igb fixes for linux-3.4
  backports: igb fixes for linux-3.3
  backports: igb fixes for linux-3.2
  backports: igb fixes for linux-3.1
  backports: enable igb and add defconfig

 backport/backport-include/linux/ethtool.h          | 79 ++++++++++++++++++++++
 backport/backport-include/linux/gfp.h              | 10 +++
 backport/backport-include/linux/if.h               |  8 +++
 backport/backport-include/linux/mdio.h             | 56 +++++++++++++++
 backport/backport-include/linux/pci.h              | 44 ++++++++++++
 backport/backport-include/linux/pci_regs.h         |  8 +++
 backport/backport-include/linux/ptp_clock_kernel.h | 38 +++++++++++
 backport/backport-include/linux/skbuff.h           | 74 ++++++++++++++++++++
 backport/backport-include/linux/u64_stats_sync.h   | 16 ++++-
 backport/compat/backport-3.10.c                    | 46 +++++++++++++
 backport/compat/compat-3.5.c                       | 11 +++
 backport/compat/compat-3.8.c                       | 34 ++++++++++
 backport/defconfigs/igb                            |  2 +
 copy-list                                          |  4 ++
 .../82-ethernet/0001-igb_net_device_ops.patch      | 56 +++++++++++++++
 .../82-ethernet/0002-igb_pci_sriov_configure.patch | 57 ++++++++++++++++
 .../network/82-ethernet/0004-igb_err_handler.patch | 16 +++++
 .../network/82-ethernet/0005-igb_mdi.patch         | 49 ++++++++++++++
 .../network/82-ethernet/0006-igb_eee.patch         | 31 +++++++++
 .../network/82-ethernet/0007-igb_ethtool_ops.patch | 56 +++++++++++++++
 .../network/82-ethernet/0008-igb_no_fcs.patch      | 16 +++++
 .../network/82-ethernet/0009-igb_vlan_rx_vid.patch | 64 ++++++++++++++++++
 .../network/82-ethernet/0010-igb_ethtool_ops.patch | 48 +++++++++++++
 .../network/82-ethernet/0011-igb_ethtool_ops.patch | 31 +++++++++
 .../82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch | 51 ++++++++++++++
 25 files changed, 903 insertions(+), 2 deletions(-)
 create mode 100644 backport/backport-include/linux/gfp.h
 create mode 100644 backport/backport-include/linux/mdio.h
 create mode 100644 backport/backport-include/linux/ptp_clock_kernel.h
 create mode 100644 backport/defconfigs/igb
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0004-igb_err_handler.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0005-igb_mdi.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0007-igb_ethtool_ops.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0008-igb_no_fcs.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0009-igb_vlan_rx_vid.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0010-igb_ethtool_ops.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0011-igb_ethtool_ops.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/0012-igb_ndo_set_vf_spoofchk.patch

-- 
1.8.4.2

