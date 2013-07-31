Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:51433 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862Ab3GaIi5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 31 Jul 2013 04:38:57 -0400
Message-ID: <51F8CD1B.8010909@fh-kl.de> (sfid-20130731_103901_425865_415BD9A1)
Date: Wed, 31 Jul 2013 10:38:51 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [RFC v2 0/8] backports: add wwan device drivers
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds wwan drivers for mobile broadband devices.
Patches 1 to 7 add missing stuff required for the wwan drivers.
Patch 8 adds device drivers.

Changes v2: rebased on last RFCs for next-20130729


Patrick Ziegler (8):
  backports: disable PCI functions for kernels without PCI support
  backports: add eth_prepare_mac_addr_change() and
    eth_commit_mac_addr_change()
  backports: define PM_EVENT_AUTO
  backports: add usb_translate_errors()
  backports: add usb_endpoint_maxp()
  backports: include headers directly if math64 header is missing
  backports: define phys_addr_t for ARM on kernel version < 2.6.25
  backports: add wwan device drivers

 backport/Kconfig                                   |  2 ++
 backport/Makefile.kernel                           |  3 ++
 backport/backport-include/linux/etherdevice.h      |  7 +++++
 backport/backport-include/linux/if.h               |  4 +++
 backport/backport-include/linux/math64.h           |  3 ++
 backport/backport-include/linux/pm.h               |  4 +++
 backport/backport-include/linux/types.h            |  4 +--
 backport/backport-include/linux/usb.h              | 17 +++++++++++
 backport/backport-include/linux/usb/ch9.h          | 23 +++++++++++++++
 backport/compat/compat-2.6.25.c                    |  2 ++
 backport/compat/compat-2.6.28.c                    |  4 +++
 backport/compat/compat-3.9.c                       | 33 ++++++++++++++++++++++
 copy-list                                          | 14 +++++++++
 .../network/0001-netdev_ops/qmi_wwan.patch         | 11 ++++++++
 .../network/0001-netdev_ops/sierra_net.patch       | 11 ++++++++
 .../drivers_net_usb_cdc_mbim.patch                 | 12 ++++++++
 .../drivers_net_usb_cdc_ncm.patch                  | 12 ++++++++
 .../drivers_net_usb_qmi_wwan.patch                 | 12 ++++++++
 .../drivers_net_usb_sierra_net.patch               | 12 ++++++++
 .../drivers_usb_class_cdc-wdm.patch                | 12 ++++++++
 20 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 backport/backport-include/linux/usb/ch9.h
 create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
 create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch

-- 
1.8.1.2


-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
