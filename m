Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51540 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbcBOPZI (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:08 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/12] backports: update to version next-20160104
Date: Mon, 15 Feb 2016 16:24:47 +0100
Message-Id: <1455549899-14564-1-git-send-email-hauke@hauke-m.de> (sfid-20160215_184440_554224_FAAD8FE4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds some patches to backport the phy dev and mdio changes added
for kernel 4.5 and also some other random changes.

Hauke Mehrtens (12):
  header: add phydev_name()
  header: add mdiobus_is_registered_device()
  backports: add phy_attached_info()
  header: make mdiobus_register() allocate the irqs
  header: add phydev_get_addr()
  backports: add devm_kasprintf()
  dependencies: make BCMA_DRIVER_GPIO depend on kernel >= 4.5
  dependencies: make some NFC drivers depend on kernel >= 3.18
  dependencies: NFC_ST95HF depend on kernel >= 3.18
  backports: fix bool logic in BPAUTO_BUILD_DMA_SHARED_HELPERS
  backports: add BPAUTO_BUILD_CORDIC only for kernel < 3.1
  patches: refresh on next-20160122

 backport/backport-include/linux/device.h           |  8 +++
 backport/backport-include/linux/phy.h              | 64 ++++++++++++++++++++++
 backport/compat/Kconfig                            |  3 +-
 backport/compat/backport-3.17.c                    | 56 +++++++++++++++++++
 backport/compat/backport-4.5.c                     | 30 ++++++++++
 dependencies                                       | 10 +++-
 .../net_wireless_core.patch                        |  4 +-
 .../0013-fix-makefile-includes/st-nci-spi.patch    |  6 +-
 .../network/0055-name_assign_type/brcmfmac.patch   |  2 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |  4 +-
 .../network/0067-mdio-addr.cocci                   |  5 ++
 11 files changed, 181 insertions(+), 11 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0067-mdio-addr.cocci

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
