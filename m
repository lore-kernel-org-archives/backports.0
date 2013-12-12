Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab3LLJ24 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:28:56 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 00/10] backports: add igb driver
Date: Thu, 12 Dec 2013 10:27:52 +0100
Message-Id: <1386840482-585-1-git-send-email-sassmann@kpanic.de> (sfid-20131212_102900_853020_2509AC03)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a RFC for inclusion of the Intel igb wired ethernet driver.
Patches are split per kernel release that makes it easier to review
the changes and gives a nice history of what was necessary for each
release. Also the igb driver changes have been split up into individual
patches in patches/collateral-evolutions/network/82-ethernet. This and
file names are up for discussion, suggestions welcome.

Support goes back to kernel 3.0 since current igb relies on ptp support
which got introduced in 3.0. Currently the patches still break for
kernel before 3.0 but I wanted to get the RFC out, this should be fixed
next time.

One thing I'm not sure how to fix is the following HWMON warning.
make KLIB=/lib/modules/3.0.0 defconfig-igb
make[2]: `conf' is up to date.
boolean symbol HWMON tested for 'm'? test forced to 'n'
boolean symbol HWMON tested for 'm'? test forced to 'n'

Patches apply against tag backports-20131206, feedback is very welcome.

Stefan Assmann (10):
  backports: add igb ethernet network driver
  backports: igb fixes for linux-3.9
  backports: igb fixes for linux-3.8
  backports: igb fixes for linux-3.7
  backports: igb fixes for linux-3.6
  backports: igb fixes for linux-3.5
  backports: igb fixes for linux-3.4
  backports: igb fixes for linux-3.3
  backports: igb fixes for linux-3.2
  backports: igb fixes for linux-3.1

 backport/backport-include/linux/ethtool.h          | 192 +++++++++++++++++++++
 backport/backport-include/linux/gfp.h              |  10 ++
 backport/backport-include/linux/if.h               |   8 +
 backport/backport-include/linux/if_link.h          |  17 ++
 backport/backport-include/linux/mdio.h             |  56 ++++++
 backport/backport-include/linux/pci.h              |  36 ++++
 backport/backport-include/linux/pci_regs.h         |   8 +
 backport/backport-include/linux/ptp_clock_kernel.h |  35 ++++
 backport/backport-include/linux/skbuff.h           |  74 ++++++++
 backport/backport-include/linux/u64_stats_sync.h   |  16 +-
 backport/compat/backport-3.10.c                    |  46 +++++
 backport/compat/compat-3.5.c                       |   7 +
 backport/compat/compat-3.8.c                       |  32 ++++
 backport/defconfigs/igb                            |   7 +
 copy-list                                          |   4 +
 .../network/82-ethernet/igb_err_handler.patch      |  16 ++
 .../82-ethernet/igb_ndo_set_vf_spoofchk.patch      |  14 ++
 .../network/82-ethernet/igb_net_device_ops.patch   |  56 ++++++
 .../network/82-ethernet/igb_no_fcs.patch           |  16 ++
 .../82-ethernet/igb_pci_sriov_configure.patch      |  14 ++
 .../network/82-ethernet/igb_ptp.patch              |  17 ++
 .../network/82-ethernet/igb_vlan_rx_vid.patch      |  64 +++++++
 22 files changed, 743 insertions(+), 2 deletions(-)
 create mode 100644 backport/backport-include/linux/gfp.h
 create mode 100644 backport/backport-include/linux/if_link.h
 create mode 100644 backport/backport-include/linux/mdio.h
 create mode 100644 backport/backport-include/linux/ptp_clock_kernel.h
 create mode 100644 backport/defconfigs/igb
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_err_handler.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_ndo_set_vf_spoofchk.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_net_device_ops.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_no_fcs.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_pci_sriov_configure.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_ptp.patch
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_vlan_rx_vid.patch

-- 
1.8.3.1

