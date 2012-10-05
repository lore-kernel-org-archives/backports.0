Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:14861 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab2JEBfi (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 4 Oct 2012 21:35:38 -0400
From: <xiong@qca.qualcomm.com>
To: <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, <nic-devel@qualcomm.com>,
	xiong <xiong@qca.qualcomm.com>,
	Ren Cloud <cjren@qca.qualcomm.com>
Subject: [PATCH] compat-drivers: update ethernet driver alx in crap dir
Date: Fri, 5 Oct 2012 09:34:52 +0800
Message-ID: <1349400892-25315-1-git-send-email-xiong@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: xiong <xiong@qca.qualcomm.com>

1. support new device id (0x10A0/0x10A1).
2. add DEBUG_FS interface for diag/swoi functions.

Signed-off-by: Ren Cloud <cjren@qca.qualcomm.com>
Signed-off-by: xiong <xiong@qca.qualcomm.com>
---
 ...-QCA-ethernet-driver-which-supercedes-atl.patch | 5846 +++++++++++++-------
 crap/network/0002-backport-alx.patch               |   40 +-
 2 files changed, 3712 insertions(+), 2174 deletions(-)

diff --git a/crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch b/crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
index 73db87d..cc4a968 100644
--- a/crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
+++ b/crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
@@ -1,6 +1,6 @@
-From 4d59bde6ad6120d81f8b8ac6ac0beda718f7fb21 Mon Sep 17 00:00:00 2001
-From: Luis R. Rodriguez <mcgrof@frijolero.org>
-Date: Tue, 28 Feb 2012 11:49:31 -0800
+From 1772c9100b8c4cb6f2115fe8106d85aff04996a5 Mon Sep 17 00:00:00 2001
+From: xiong <xiong@qca.qualcomm.com>
+Date: Fri, 28 Sep 2012 09:53:46 +0800
 Subject: [PATCH] net: add new QCA alx ethernet driver which supercedes atl1c
 
 This driver is intended to replace the atl1c driver and provide
@@ -30,6 +30,8 @@ But alx also supports these two new chipstes:
 
 1969:1091 - AR8161 Gigabit Ethernet
 1969:1090 - AR8162 Fast Ethernet
+1969:10A1 - AR8171 Gigabit Ethernet
+1969:10A0 - AR8172 Fast Ethernet
 
 We leave the atl1c driver in place for now but mark it as
 deprecated in favor for the alx. Linux distributions should
@@ -42,28 +44,31 @@ to atl1c see the new shiny alx driver home page:
 
 https://www.linuxfoundation.org/collaborate/workgroups/networking/alx
 
-Signed-off-by: Stevent Li <steventl@qca.qualcomm.com>
-Signed-off-by: Hao-Ran Liu (Joseph Liu) <hao-ran.liu@canonical.com>
 Signed-off-by: Cloud Ren <cjren@qca.qualcomm.com>
-Signed-off-by: Joe Perches <joe@perches.com>
-Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
+Tested-by: David Liu <dwliu@qca.qualcomm.com>
+Signed-off-by: xiong <xiong@qca.qualcomm.com>
+Signed-off-by: Luis R. Rodriguez <rodrigue@qca.qualcomm.com>
 ---
  MAINTAINERS                                    |   11 +
- drivers/net/ethernet/atheros/Kconfig           |   42 +-
+ drivers/net/ethernet/atheros/Kconfig           |   21 +
  drivers/net/ethernet/atheros/Makefile          |    1 +
- drivers/net/ethernet/atheros/alx/Makefile      |    3 +
- drivers/net/ethernet/atheros/alx/alc_cb.c      |  912 ++++++
- drivers/net/ethernet/atheros/alx/alc_hw.c      | 1087 +++++++
- drivers/net/ethernet/atheros/alx/alc_hw.h      | 1324 ++++++++
- drivers/net/ethernet/atheros/alx/alf_cb.c      | 1187 +++++++
- drivers/net/ethernet/atheros/alx/alf_hw.c      |  918 ++++++
- drivers/net/ethernet/atheros/alx/alf_hw.h      | 2098 +++++++++++++
- drivers/net/ethernet/atheros/alx/alx.h         |  670 ++++
- drivers/net/ethernet/atheros/alx/alx_ethtool.c |  519 ++++
- drivers/net/ethernet/atheros/alx/alx_hwcom.h   |  187 ++
- drivers/net/ethernet/atheros/alx/alx_main.c    | 3899 ++++++++++++++++++++++++
- drivers/net/ethernet/atheros/alx/alx_sw.h      |  493 +++
- 15 files changed, 13350 insertions(+), 1 deletions(-)
+ drivers/net/ethernet/atheros/alx/Makefile      |    7 +
+ drivers/net/ethernet/atheros/alx/alc_cb.c      |  844 +++++
+ drivers/net/ethernet/atheros/alx/alc_hw.c      | 1119 +++++++
+ drivers/net/ethernet/atheros/alx/alc_hw.h      | 1317 ++++++++
+ drivers/net/ethernet/atheros/alx/alf_cb.c      | 1110 +++++++
+ drivers/net/ethernet/atheros/alx/alf_hw.c      | 1028 ++++++
+ drivers/net/ethernet/atheros/alx/alf_hw.h      | 2118 +++++++++++++
+ drivers/net/ethernet/atheros/alx/alx.h         |  739 +++++
+ drivers/net/ethernet/atheros/alx/alx_cifs.c    |  324 ++
+ drivers/net/ethernet/atheros/alx/alx_cifs.h    |   73 +
+ drivers/net/ethernet/atheros/alx/alx_dfs.c     |  937 ++++++
+ drivers/net/ethernet/atheros/alx/alx_dfs.h     |  184 ++
+ drivers/net/ethernet/atheros/alx/alx_ethtool.c |  369 +++
+ drivers/net/ethernet/atheros/alx/alx_hwcom.h   |  127 +
+ drivers/net/ethernet/atheros/alx/alx_main.c    | 3988 ++++++++++++++++++++++++
+ drivers/net/ethernet/atheros/alx/alx_sw.h      |  506 +++
+ 19 files changed, 14823 insertions(+), 0 deletions(-)
  create mode 100644 drivers/net/ethernet/atheros/alx/Makefile
  create mode 100644 drivers/net/ethernet/atheros/alx/alc_cb.c
  create mode 100644 drivers/net/ethernet/atheros/alx/alc_hw.c
@@ -72,20 +77,26 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
  create mode 100644 drivers/net/ethernet/atheros/alx/alf_hw.c
  create mode 100644 drivers/net/ethernet/atheros/alx/alf_hw.h
  create mode 100644 drivers/net/ethernet/atheros/alx/alx.h
+ create mode 100644 drivers/net/ethernet/atheros/alx/alx_cifs.c
+ create mode 100644 drivers/net/ethernet/atheros/alx/alx_cifs.h
+ create mode 100644 drivers/net/ethernet/atheros/alx/alx_dfs.c
+ create mode 100644 drivers/net/ethernet/atheros/alx/alx_dfs.h
  create mode 100644 drivers/net/ethernet/atheros/alx/alx_ethtool.c
  create mode 100644 drivers/net/ethernet/atheros/alx/alx_hwcom.h
  create mode 100644 drivers/net/ethernet/atheros/alx/alx_main.c
  create mode 100644 drivers/net/ethernet/atheros/alx/alx_sw.h
 
+diff --git a/MAINTAINERS b/MAINTAINERS
+index f9d40d1..1a2da20 100644
 --- a/MAINTAINERS
 +++ b/MAINTAINERS
-@@ -1329,6 +1329,17 @@ W:	http://atl1.sourceforge.net
+@@ -1320,6 +1320,17 @@ W:	http://atl1.sourceforge.net
  S:	Maintained
  F:	drivers/net/ethernet/atheros/
  
 +ALX ETHERNET DRIVERS
 +M:	Cloud Ren <cjren@qca.qualcomm.com>
-+M:	Stevent Li <steventl@qca.qualcomm.com>
++M	Stevent Li <steventl@qca.qualcomm.com>
 +M:	Wu Ken <kenw@qca.qualcomm.com>
 +M:	David Liu <dwliu@qca.qualcomm.com>
 +L:	netdev@vger.kernel.org
@@ -97,65 +108,38 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
  ATM
  M:	Chas Williams <chas@cmf.nrl.navy.mil>
  L:	linux-atm-general@lists.sourceforge.net (moderated for non-subscribers)
+diff --git a/drivers/net/ethernet/atheros/Kconfig b/drivers/net/ethernet/atheros/Kconfig
+index 1ed886d..e645c73 100644
 --- a/drivers/net/ethernet/atheros/Kconfig
 +++ b/drivers/net/ethernet/atheros/Kconfig
-@@ -56,15 +56,55 @@ config ATL1E
- 	  will be called atl1e.
- 
- config ATL1C
--	tristate "Atheros L1C Gigabit Ethernet support (EXPERIMENTAL)"
-+	tristate "Atheros L1C Gigabit Ethernet support (DEPRECATED)"
- 	depends on PCI && EXPERIMENTAL
- 	select CRC32
- 	select NET_CORE
- 	select MII
- 	---help---
- 	  This driver supports the Atheros L1C gigabit ethernet adapter.
-+	  This driver is deprecated in favor for the alx (CONFIG_ALX) driver.
-+	  This driver supports the following chipsets:
-+
-+	  1969:1063 - AR8131 Gigabit Ethernet
-+	  1969:1062 - AR8132 Fast Ethernet (10/100 Mbit/s)
-+	  1969:2062 - AR8152 v2.0 Fast Ethernet
-+	  1969:2060 - AR8152 v1.1 Fast Ethernet
-+	  1969:1073 - AR8151 v1.0 Gigabit Ethernet
-+	  1969:1083 - AR8151 v2.0 Gigabit Ethernet
- 
+@@ -67,4 +67,25 @@ config ATL1C
  	  To compile this driver as a module, choose M here.  The module
  	  will be called atl1c.
  
 +config ALX
-+	tristate "Atheros ALX Gigabit Ethernet support"
++	tristate "Qualcomm Atheros L1C/L1D/L1F Gigabit Ethernet support"
 +	depends on PCI
 +	select CRC32
 +	select NET_CORE
 +	select MII
 +	---help---
-+	  This driver supports the Atheros L1C/L1D/L1F gigabit ethernet
-+	  adapter. The alx driver is intended to replace completely the
-+	  atl1c driver with proper support and commitment from Qualcomm
-+	  Atheros (QCA). Both atl1c and alx supports the following chipsets:
-+
-+	  1969:1063 - AR8131 Gigabit Ethernet
-+	  1969:1062 - AR8132 Fast Ethernet (10/100 Mbit/s)
-+	  1969:2062 - AR8152 v2.0 Fast Ethernet
-+	  1969:2060 - AR8152 v1.1 Fast Ethernet
-+	  1969:1073 - AR8151 v1.0 Gigabit Ethernet
-+	  1969:1083 - AR8151 v2.0 Gigabit Ethernet
-+
-+	  Only alx supports the following chipsets:
-+
-+	  1969:1091 - AR8161
-+	  1969:1090 - AR8162
-+
-+	  For more information see:
-+
-+	  https://www.linuxfoundation.org/collaborate/workgroups/networking/alx
++	  This driver supports the Qualcomm Atheros AR813x/AR815x/AR816x
++	  gigabit ethernet adapter.
 +
 +	  To compile this driver as a module, choose M here.  The module
 +	  will be called alx.
 +
++config ALX_DEBUGFS
++	bool "Qualcomm Atheros debugging interface"
++	depends on ALX && DEBUG_FS
++	---help---
++	  This option add ability to debug and test L1C/L1D/L1F. It can
++	  supoort Qualcomm Atheros tools, including diagnostic, memcfg
++	  and SWOI.
++
  endif # NET_VENDOR_ATHEROS
+diff --git a/drivers/net/ethernet/atheros/Makefile b/drivers/net/ethernet/atheros/Makefile
+index e7e76fb..5cf1c65 100644
 --- a/drivers/net/ethernet/atheros/Makefile
 +++ b/drivers/net/ethernet/atheros/Makefile
 @@ -6,3 +6,4 @@ obj-$(CONFIG_ATL1) += atlx/
@@ -163,15 +147,25 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
  obj-$(CONFIG_ATL1E) += atl1e/
  obj-$(CONFIG_ATL1C) += atl1c/
 +obj-$(CONFIG_ALX) += alx/
+diff --git a/drivers/net/ethernet/atheros/alx/Makefile b/drivers/net/ethernet/atheros/alx/Makefile
+new file mode 100644
+index 0000000..c71fa72
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/Makefile
-@@ -0,0 +1,3 @@
+@@ -0,0 +1,7 @@
 +obj-$(CONFIG_ALX) += alx.o
 +alx-objs := alx_main.o alx_ethtool.o alc_cb.o alc_hw.o alf_cb.o alf_hw.o
++ifdef CONFIG_ALX_DEBUGFS
++alx-objs += alx_dfs.o
++alx-objs += alx_cifs.o
++endif
 +ccflags-y += -D__CHECK_ENDIAN__
+diff --git a/drivers/net/ethernet/atheros/alx/alc_cb.c b/drivers/net/ethernet/atheros/alx/alc_cb.c
+new file mode 100644
+index 0000000..3beefec
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alc_cb.c
-@@ -0,0 +1,912 @@
+@@ -0,0 +1,844 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -191,6 +185,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#include <linux/pci_regs.h>
 +#include <linux/mii.h>
++#include <linux/netdevice.h>
++#include <linux/crc32.h>
 +
 +#include "alc_hw.h"
 +
@@ -210,11 +206,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	spin_lock_irqsave(&hw->mdio_lock, flags);
 +
-+	if (l1c_read_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, false, reg_addr,
-+			 phy_data)) {
-+		alx_hw_err(hw, "error when read phy reg\n");
-+		retval = -EINVAL;
-+	}
++	retval = l1c_read_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, hw->link_up,
++			      reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u, when read phy reg\n", retval);
 +
 +	spin_unlock_irqrestore(&hw->mdio_lock, flags);
 +	return retval;
@@ -228,16 +223,51 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	spin_lock_irqsave(&hw->mdio_lock, flags);
 +
-+	if (l1c_write_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, false, reg_addr,
-+			  phy_data)) {
-+		alx_hw_err(hw, "error when write phy reg\n");
-+		retval = -EINVAL;
-+	}
++	retval = l1c_write_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, hw->link_up,
++			       reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u, when write phy reg\n", retval);
++
++	spin_unlock_irqrestore(&hw->mdio_lock, flags);
++	return retval;
++}
++
++#ifdef CONFIG_ALX_DEBUGFS
++
++static int alc_read_ext_phy_reg(struct alx_hw *hw, u8 type, u16 reg_addr,
++				u16 *phy_data)
++{
++	unsigned long  flags;
++	int  retval = 0;
++
++	spin_lock_irqsave(&hw->mdio_lock, flags);
++
++	retval = l1c_read_phy(hw, true, type, false, reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u, when read ext phy reg\n", retval);
++
++	spin_unlock_irqrestore(&hw->mdio_lock, flags);
++	return retval;
++}
++
++
++static int alc_write_ext_phy_reg(struct alx_hw *hw, u8 type, u16 reg_addr,
++				 u16 phy_data)
++{
++	unsigned long  flags;
++	int  retval = 0;
++
++	spin_lock_irqsave(&hw->mdio_lock, flags);
++
++	retval = l1c_write_phy(hw, true, type, false, reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u, when write ext phy reg\n", retval);
 +
 +	spin_unlock_irqrestore(&hw->mdio_lock, flags);
 +	return retval;
 +}
 +
++#endif
 +
 +static int alc_init_phy(struct alx_hw *hw)
 +{
@@ -255,11 +285,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	memcpy(&hw->phy_id, phy_id, sizeof(hw->phy_id));
 +
-+	hw->autoneg_advertised = ALX_LINK_SPEED_1GB_FULL |
-+				 ALX_LINK_SPEED_10_HALF  |
-+				 ALX_LINK_SPEED_10_FULL  |
-+				 ALX_LINK_SPEED_100_HALF |
-+				 ALX_LINK_SPEED_100_FULL;
++	hw->autoneg_advertised = LX_LC_ALL;
++
 +	return retval;
 +}
 +
@@ -302,29 +329,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* LINK */
-+static int alc_setup_phy_link(struct alx_hw *hw, u32 speed, bool autoneg,
++static int alc_setup_phy_link(struct alx_hw *hw, u8 speed, bool autoneg,
 +			      bool fc)
 +{
-+	u8 link_cap = 0;
 +	int retval = 0;
 +
 +	alx_hw_info(hw, "speed = 0x%x, autoneg = %d\n", speed, autoneg);
-+	if (speed & ALX_LINK_SPEED_1GB_FULL)
-+		link_cap |= LX_LC_1000F;
-+
-+	if (speed & ALX_LINK_SPEED_100_FULL)
-+		link_cap |= LX_LC_100F;
-+
-+	if (speed & ALX_LINK_SPEED_100_HALF)
-+		link_cap |= LX_LC_100H;
 +
-+	if (speed & ALX_LINK_SPEED_10_FULL)
-+		link_cap |= LX_LC_10F;
-+
-+	if (speed & ALX_LINK_SPEED_10_HALF)
-+		link_cap |= LX_LC_10H;
-+
-+	if (l1c_init_phy_spdfc(hw, autoneg, link_cap, fc)) {
++	if (l1c_init_phy_spdfc(hw, autoneg, speed, fc)) {
 +		alx_hw_err(hw, "error when init phy speed and fc\n");
 +		retval = -EINVAL;
 +	}
@@ -333,36 +345,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alc_setup_phy_link_speed(struct alx_hw *hw, u32 speed,
-+				    bool autoneg, bool fc)
-+{
-+	/*
-+	 * Clear autoneg_advertised and set new values based on input link
-+	 * speed.
-+	 */
-+	hw->autoneg_advertised = 0;
-+
-+	if (speed & ALX_LINK_SPEED_1GB_FULL)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_1GB_FULL;
-+
-+	if (speed & ALX_LINK_SPEED_100_FULL)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_100_FULL;
-+
-+	if (speed & ALX_LINK_SPEED_100_HALF)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_100_HALF;
-+
-+	if (speed & ALX_LINK_SPEED_10_FULL)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_10_FULL;
-+
-+	if (speed & ALX_LINK_SPEED_10_HALF)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_10_HALF;
-+
-+	return alc_setup_phy_link(hw, hw->autoneg_advertised,
-+				  autoneg, fc);
-+}
-+
-+
-+static int alc_check_phy_link(struct alx_hw *hw, u32 *speed, bool *link_up)
++static int alc_check_phy_link(struct alx_hw *hw, u8 *speed, bool *link_up)
 +{
 +	u16 bmsr, giga;
 +	int retval;
@@ -374,8 +357,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	if (!(bmsr & BMSR_LSTATUS)) {
 +		*link_up = false;
-+		*speed = ALX_LINK_SPEED_UNKNOWN;
-+		return 0;
++		*speed = 0;
++		return retval;
 +	}
 +	*link_up = true;
 +
@@ -393,24 +376,24 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	switch (giga & L1C_GIGA_PSSR_SPEED) {
 +	case L1C_GIGA_PSSR_1000MBS:
 +		if (giga & L1C_GIGA_PSSR_DPLX)
-+			*speed = ALX_LINK_SPEED_1GB_FULL;
++			*speed = LX_LC_1000F;
 +		else
 +			alx_hw_err(hw, "1000M half is invalid\n");
 +		break;
 +	case L1C_GIGA_PSSR_100MBS:
 +		if (giga & L1C_GIGA_PSSR_DPLX)
-+			*speed = ALX_LINK_SPEED_100_FULL;
++			*speed = LX_LC_100F;
 +		else
-+			*speed = ALX_LINK_SPEED_100_HALF;
++			*speed = LX_LC_100H;
 +		break;
 +	case L1C_GIGA_PSSR_10MBS:
 +		if (giga & L1C_GIGA_PSSR_DPLX)
-+			*speed = ALX_LINK_SPEED_10_FULL;
++			*speed = LX_LC_10F;
 +		else
-+			*speed = ALX_LINK_SPEED_10_HALF;
++			*speed = LX_LC_10H;
 +		break;
 +	default:
-+		*speed = ALX_LINK_SPEED_UNKNOWN;
++		*speed = 0;
 +		retval = -EINVAL;
 +		break;
 +	}
@@ -419,6 +402,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
++static int alc_post_phy_link(struct alx_hw *hw, bool az_en,
++			     bool link_up, u8 speed)
++{
++	return l1c_post_phy_link(hw, az_en, link_up, speed);
++}
++
++
 +/*
 + * 1. stop_mac
 + * 2. reset mac & dma by reg1400(MASTER)
@@ -444,11 +434,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	/* set link speed param */
 +	switch (hw->link_speed) {
-+	case ALX_LINK_SPEED_1GB_FULL:
++	case LX_LC_1000F:
 +		en_ctrl |= LX_MACSPEED_1000;
 +		/* fall through */
-+	case ALX_LINK_SPEED_100_FULL:
-+	case ALX_LINK_SPEED_10_FULL:
++	case LX_LC_10F:
++	case LX_LC_100F:
 +		en_ctrl |= LX_MACDUPLEX_FULL;
 +		break;
 +	}
@@ -474,20 +464,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +	en_ctrl |= LX_FLT_DIRECT; /* RX Enable; and TX Always Enable */
-+	en_ctrl |= LX_FLT_BROADCAST; /* RX Broadcast Enable */
 +	en_ctrl |= LX_ADD_FCS;
 +
-+	if (CHK_HW_FLAG(VLANSTRIP_EN))
-+		en_ctrl |= LX_VLAN_STRIP;
-+
-+	if (CHK_HW_FLAG(PROMISC_EN))
-+		en_ctrl |=  LX_FLT_PROMISC;
-+
-+	if (CHK_HW_FLAG(MULTIALL_EN))
-+		en_ctrl |= LX_FLT_MULTI_ALL;
-+
-+	if (CHK_HW_FLAG(LOOPBACK_EN))
-+		en_ctrl |= LX_LOOPBACK;
++	en_ctrl |= hw->flags & ALX_HW_FLAG_LX_MASK;
 +
 +	if (l1c_enable_mac(hw, true, en_ctrl)) {
 +		alx_hw_err(hw, "error when start mac\n");
@@ -513,62 +492,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alc_config_mac(struct alx_hw *hw, u16 rxbuf_sz, u16 rx_qnum,
++static int alc_init_mac(struct alx_hw *hw, u16 rxbuf_sz, u16 rx_qnum,
 +			  u16 rxring_sz, u16 tx_qnum,  u16 txring_sz)
 +{
-+	u8 *addr;
-+
-+	u32 txmem_hi, txmem_lo[4];
-+
-+	u32 rxmem_hi, rfdmem_lo, rrdmem_lo;
-+
-+	u16 smb_timer, mtu_with_eth, int_mod;
-+	bool hash_legacy;
-+
-+	int i;
-+	int retval = 0;
-+
-+	addr = hw->mac_addr;
-+
-+	txmem_hi = ALX_DMA_ADDR_HI(hw->tpdma[0]);
-+	for (i = 0; i < tx_qnum; i++)
-+		txmem_lo[i] = ALX_DMA_ADDR_LO(hw->tpdma[i]);
-+
-+
-+	rxmem_hi = ALX_DMA_ADDR_HI(hw->rfdma[0]);
-+	rfdmem_lo = ALX_DMA_ADDR_LO(hw->rfdma[0]);
-+	rrdmem_lo = ALX_DMA_ADDR_LO(hw->rrdma[0]);
-+
-+
-+	smb_timer = (u16)hw->smb_timer;
-+	mtu_with_eth = hw->mtu + ALX_ETH_LENGTH_OF_HEADER;
-+	int_mod = hw->imt;
-+
-+	hash_legacy = true;
++	int retval;
 +
-+	if (l1c_init_mac(hw, addr, txmem_hi, txmem_lo, tx_qnum, txring_sz,
-+			 rxmem_hi, rfdmem_lo, rrdmem_lo, rxring_sz, rxbuf_sz,
-+			 smb_timer, mtu_with_eth, int_mod, hash_legacy)) {
++	retval = l1c_init_mac(hw, hw->mac_addr, hw->dma.tpdmem_hi[0],
++			      hw->dma.tpdmem_lo, tx_qnum, txring_sz,
++			      hw->dma.rfdmem_hi[0], hw->dma.rfdmem_lo[0],
++			      hw->dma.rrdmem_lo[0], rxring_sz, rxbuf_sz,
++			      hw->smb_timer, hw->mtu + ALX_ETH_LENGTH_OF_HEADER,
++			      hw->imt_mod, true);
++	if (retval)
 +		alx_hw_err(hw, "error when config mac\n");
-+		retval = -EINVAL;
-+	}
-+
-+	return retval;
-+}
-+
-+
-+/**
-+ *  alc_get_mac_addr
-+ *  @hw: pointer to hardware structure
-+ **/
-+static int alc_get_mac_addr(struct alx_hw *hw, u8 *addr)
-+{
-+	int retval = 0;
 +
-+	if (l1c_get_perm_macaddr(hw, addr)) {
-+		alx_hw_err(hw, "error when get permanent mac address\n");
-+		retval = -EINVAL;
-+	}
 +	return retval;
 +}
 +
@@ -660,64 +597,38 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alc_config_mac_ctrl(struct alx_hw *hw)
++static void alc_update_mac_filter(struct alx_hw *hw)
 +{
 +	u32 mac;
++	u32 flg_hw_map[] = {
++		ALX_HW_FLAG_BROADCAST_EN, L1C_MAC_CTRL_BRD_EN,
++		ALX_HW_FLAG_VLANSTRIP_EN, L1C_MAC_CTRL_VLANSTRIP,
++		ALX_HW_FLAG_PROMISC_EN, L1C_MAC_CTRL_PROMISC_EN,
++		ALX_HW_FLAG_MULTIALL_EN, L1C_MAC_CTRL_MULTIALL_EN,
++		ALX_HW_FLAG_LOOPBACK_EN, L1C_MAC_CTRL_LPBACK_EN
++		};
++	int i;
 +
-+	alx_mem_r32(hw, L1C_MAC_CTRL, &mac);
-+
-+	/* enable/disable VLAN tag insert,strip */
-+	if (CHK_HW_FLAG(VLANSTRIP_EN))
-+		mac |= L1C_MAC_CTRL_VLANSTRIP;
-+	else
-+		mac &= ~L1C_MAC_CTRL_VLANSTRIP;
-+
-+	if (CHK_HW_FLAG(PROMISC_EN))
-+		mac |= L1C_MAC_CTRL_PROMISC_EN;
-+	else
-+		mac &= ~L1C_MAC_CTRL_PROMISC_EN;
 +
-+	if (CHK_HW_FLAG(MULTIALL_EN))
-+		mac |= L1C_MAC_CTRL_MULTIALL_EN;
-+	else
-+		mac &= ~L1C_MAC_CTRL_MULTIALL_EN;
++	alx_mem_r32(hw, L1C_MAC_CTRL, &mac);
 +
-+	if (CHK_HW_FLAG(LOOPBACK_EN))
-+		mac |= L1C_MAC_CTRL_LPBACK_EN;
-+	else
-+		mac &= ~L1C_MAC_CTRL_LPBACK_EN;
++	for (i = 0; i < ARRAY_SIZE(flg_hw_map); i += 2) {
++		if (hw->flags & flg_hw_map[i])
++			mac |= flg_hw_map[i + 1];
++		else
++			mac &= ~flg_hw_map[i + 1];
++	}
 +
 +	alx_mem_w32(hw, L1C_MAC_CTRL, mac);
-+	return 0;
 +}
 +
 +
-+static int alc_config_pow_save(struct alx_hw *hw, u32 speed, bool wol_en,
++static int alc_config_pow_save(struct alx_hw *hw, u8 speed, bool wol_en,
 +			       bool tx_en, bool rx_en, bool pws_en)
 +{
-+	u8 wire_spd = LX_LC_10H;
 +	int retval = 0;
 +
-+	switch (speed) {
-+	case ALX_LINK_SPEED_UNKNOWN:
-+	case ALX_LINK_SPEED_10_HALF:
-+		wire_spd = LX_LC_10H;
-+		break;
-+	case ALX_LINK_SPEED_10_FULL:
-+		wire_spd = LX_LC_10F;
-+		break;
-+	case ALX_LINK_SPEED_100_HALF:
-+		wire_spd = LX_LC_100H;
-+		break;
-+	case ALX_LINK_SPEED_100_FULL:
-+		wire_spd = LX_LC_100F;
-+		break;
-+	case ALX_LINK_SPEED_1GB_FULL:
-+		wire_spd = LX_LC_1000F;
-+		break;
-+	}
-+
-+	if (l1c_powersaving(hw, wire_spd, wol_en, tx_en, rx_en, pws_en)) {
++	if (l1c_powersaving(hw, speed, wol_en, tx_en, rx_en, pws_en)) {
 +		alx_hw_err(hw, "error when set power saving\n");
 +		retval = -EINVAL;
 +	}
@@ -726,7 +637,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* RAR, Multicast, VLAN */
-+static int alc_set_mac_addr(struct alx_hw *hw, u8 *addr)
++static void alc_set_mac_addr(struct alx_hw *hw, u8 *addr)
 +{
 +	u32 sta;
 +
@@ -736,14 +647,24 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	 */
 +
 +	/* low dword */
-+	sta = (((u32)addr[2]) << 24) | (((u32)addr[3]) << 16) |
-+	      (((u32)addr[4]) << 8)  | (((u32)addr[5])) ;
++	sta = addr[2] << 24 | addr[3] << 16 | addr[4] << 8  | addr[5];
 +	alx_mem_w32(hw, L1C_STAD0, sta);
 +
 +	/* hight dword */
-+	sta = (((u32)addr[0]) << 8) | (((u32)addr[1])) ;
++	sta = addr[0] << 8 | addr[1];
 +	alx_mem_w32(hw, L1C_STAD1, sta);
-+	return 0;
++}
++
++
++static int alc_get_mac_addr(struct alx_hw *hw, u8 *addr)
++{
++	int retval = 0;
++
++	if (l1c_get_perm_macaddr(hw, addr)) {
++		alx_hw_err(hw, "error when get permanent mac address\n");
++		retval = -EINVAL;
++	}
++	return retval;
 +}
 +
 +
@@ -786,9 +707,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* RTX */
-+static int alc_config_tx(struct alx_hw *hw)
++static void alc_config_tx(struct alx_hw *hw)
 +{
-+	return 0;
 +}
 +
 +
@@ -853,7 +773,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (ectrl1 & L1C_EFUSE_CTRL_FLAG) {
 +		alx_mem_r32(hw, L1C_EFUSE_CTRL, &ectrl1);
 +		alx_mem_r32(hw, L1C_EFUSE_DATA, &edata);
-+		*data = LX_SWAP_DW((ectrl1 << 16) | (edata >> 16));
++		edata = (ectrl1 << 16) | (edata >> 16);
++		*data = be32_to_cpu(*(__be32 *)&edata);
 +		return retval;
 +	}
 +
@@ -959,7 +880,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* ethtool */
-+static int alc_get_ethtool_regs(struct alx_hw *hw, void *buff)
++static void alc_get_ethtool_regs(struct alx_hw *hw, void *buff)
 +{
 +	int i;
 +	u32 *val = buff;
@@ -980,7 +901,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	for (i = 0; i < ARRAY_SIZE(reg); i++)
 +		alx_mem_r32(hw, reg[i], &val[i]);
-+	return 0;
 +}
 +
 +
@@ -1000,6 +920,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		SET_HW_FLAG(GIGA_CAP);
 +
 +	SET_HW_FLAG(PWSAVE_CAP);
++
++	SET_HW_FLAG(BROADCAST_EN);
 +	return 0;
 +}
 +
@@ -1039,7 +961,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	hw->cbs.reset_mac      = &alc_reset_mac;
 +	hw->cbs.start_mac      = &alc_start_mac;
 +	hw->cbs.stop_mac       = &alc_stop_mac;
-+	hw->cbs.config_mac     = &alc_config_mac;
++	hw->cbs.init_mac       = &alc_init_mac;
 +	hw->cbs.get_mac_addr   = &alc_get_mac_addr;
 +	hw->cbs.set_mac_addr   = &alc_set_mac_addr;
 +	hw->cbs.set_mc_addr    = &alc_set_mc_addr;
@@ -1052,7 +974,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	hw->cbs.write_phy_reg     = &alc_write_phy_reg;
 +	hw->cbs.check_phy_link    = &alc_check_phy_link;
 +	hw->cbs.setup_phy_link    = &alc_setup_phy_link;
-+	hw->cbs.setup_phy_link_speed = &alc_setup_phy_link_speed;
++	hw->cbs.post_phy_link     = &alc_post_phy_link;
 +
 +	/* Interrupt */
 +	hw->cbs.ack_phy_intr	= &alc_ack_phy_intr;
@@ -1060,22 +982,27 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	hw->cbs.disable_legacy_intr = &alc_disable_legacy_intr;
 +
 +	/* Configure */
-+	hw->cbs.config_tx	= &alc_config_tx;
-+	hw->cbs.config_fc	= &alc_config_fc;
-+	hw->cbs.config_aspm	= &alc_config_aspm;
-+	hw->cbs.config_wol	= &alc_config_wol;
-+	hw->cbs.config_mac_ctrl	= &alc_config_mac_ctrl;
-+	hw->cbs.config_pow_save	= &alc_config_pow_save;
-+	hw->cbs.reset_pcie	= &alc_reset_pcie;
++	hw->cbs.config_tx         = &alc_config_tx;
++	hw->cbs.config_fc         = &alc_config_fc;
++	hw->cbs.config_aspm       = &alc_config_aspm;
++	hw->cbs.config_wol        = &alc_config_wol;
++	hw->cbs.update_mac_filter = &alc_update_mac_filter;
++	hw->cbs.config_pow_save   = &alc_config_pow_save;
++	hw->cbs.reset_pcie        = &alc_reset_pcie;
 +
 +	/* NVRam */
-+	hw->cbs.check_nvram	= &alc_check_nvram;
-+	hw->cbs.read_nvram	= &alc_read_nvram;
-+	hw->cbs.write_nvram	= &alc_write_nvram;
++	hw->cbs.check_nvram = &alc_check_nvram;
++	hw->cbs.read_nvram  = &alc_read_nvram;
++	hw->cbs.write_nvram = &alc_write_nvram;
 +
 +	/* Others */
 +	hw->cbs.get_ethtool_regs = alc_get_ethtool_regs;
 +
++#ifdef CONFIG_ALX_DEBUGFS
++	hw->cbs.read_ext_phy_reg  = &alc_read_ext_phy_reg;
++	hw->cbs.write_ext_phy_reg = &alc_write_ext_phy_reg;
++#endif
++
 +	/* get hw capabilitites to HW->flags */
 +	alc_get_hw_capabilities(hw);
 +	alc_set_hw_infos(hw);
@@ -1083,10 +1010,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_hw_info(hw, "HW Flags = 0x%x\n", hw->flags);
 +	return 0;
 +}
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alc_hw.c b/drivers/net/ethernet/atheros/alx/alc_hw.c
+new file mode 100644
+index 0000000..bdd7824
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alc_hw.c
-@@ -0,0 +1,1087 @@
+@@ -0,0 +1,1119 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -1105,6 +1034,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#include <linux/pci_regs.h>
 +#include <linux/mii.h>
++#include <linux/netdevice.h>
++#include <linux/etherdevice.h>
 +
 +#include "alc_hw.h"
 +
@@ -1115,7 +1046,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1c_get_perm_macaddr(struct alx_hw *hw, u8 *addr)
++int l1c_get_perm_macaddr(struct alx_hw *hw, u8 *addr)
 +{
 +	u32 val, otp_ctrl, otp_flag, mac0, mac1;
 +	u16 i;
@@ -1125,10 +1056,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_mem_r32(hw, L1C_STAD0, &mac0);
 +	alx_mem_r32(hw, L1C_STAD1, &mac1);
 +
-+	*(u32 *)(addr + 2) = LX_SWAP_DW(mac0);
-+	*(u16 *)addr = (u16)LX_SWAP_W((u16)mac1);
++	/* addr should be big-endian */
++	*(__be32 *)(addr + 2) = cpu_to_be32(mac0);
++	*(__be16 *)addr = cpu_to_be16((u16)mac1);
 +
-+	if (macaddr_valid(addr))
++	if (is_valid_ether_addr(addr))
 +		return 0;
 +
 +	alx_mem_r32(hw, L1C_TWSI_DBG, &val);
@@ -1207,10 +1139,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_mem_r32(hw, L1C_STAD0, &mac0);
 +	alx_mem_r32(hw, L1C_STAD1, &mac1);
 +
-+	*(u32 *)(addr + 2) = LX_SWAP_DW(mac0);
-+	*(u16 *)addr = (u16)LX_SWAP_W((u16)mac1);
++	/* addr should be big-endian */
++	*(__be32 *)(addr + 2) = cpu_to_be32(mac0);
++	*(__be16 *)addr = cpu_to_be16((u16)mac1);
 +
-+	if (macaddr_valid(addr))
++	if (is_valid_ether_addr(addr))
 +		return 0;
 +
 +out:
@@ -1223,11 +1156,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *     0: success
 + *     non-0:fail
 + */
-+u16 l1c_reset_mac(struct alx_hw *hw)
++int l1c_reset_mac(struct alx_hw *hw)
 +{
 +	u32 val, mrst_val;
 +	u16 ret;
-+	u16 i;
++	int i;
 +
 +	/* disable all interrupts, RXQ/TXQ */
 +	alx_mem_w32(hw, L1C_IMR, 0);
@@ -1281,7 +1214,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1c_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en)
++int l1c_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en)
 +{
 +	u32 val;
 +	u16 i, phy_val;
@@ -1458,7 +1391,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0:fail
 + */
-+u16 l1c_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en)
++int l1c_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en)
 +{
 +	u32 val;
 +	u16 val16;
@@ -1466,14 +1399,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	/* Workaround for PCI problem when BIOS sets MMRBC incorrectly. */
 +	alx_cfg_r16(hw, PCI_COMMAND, &val16);
-+	if ((val16 & (PCI_COMMAND_IO |
-+		      PCI_COMMAND_MEMORY |
-+		      PCI_COMMAND_MASTER)) == 0 ||
-+	    (val16 & PCI_COMMAND_INTX_DISABLE) != 0) {
-+		val16 = (u16)((val16 | (PCI_COMMAND_IO |
-+					PCI_COMMAND_MEMORY |
-+					PCI_COMMAND_MASTER))
-+			      & ~PCI_COMMAND_INTX_DISABLE);
++	if (!(val16 & ALX_PCI_CMD) || (val16 & PCI_COMMAND_INTX_DISABLE)) {
++		val16 = (val16 | ALX_PCI_CMD) & ~PCI_COMMAND_INTX_DISABLE;
 +		alx_cfg_w16(hw, PCI_COMMAND, val16);
 +	}
 +
@@ -1552,10 +1479,23 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0-fail
 + */
-+u16 l1c_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl)
++int l1c_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl)
 +{
 +	u32 rxq, txq, mac, val;
 +	u16 i;
++	u32 ctrl_hw_map[] = {
++		LX_MACDUPLEX_FULL, L1C_MAC_CTRL_FULLD,
++		LX_FLT_PROMISC, L1C_MAC_CTRL_PROMISC_EN,
++		LX_FLT_MULTI_ALL, L1C_MAC_CTRL_MULTIALL_EN,
++		LX_FLT_BROADCAST, L1C_MAC_CTRL_BRD_EN,
++		LX_FLT_DIRECT, L1C_MAC_CTRL_RX_EN,
++		LX_FC_TXEN, L1C_MAC_CTRL_TXFC_EN,
++		LX_FC_RXEN, L1C_MAC_CTRL_RXFC_EN,
++		LX_VLAN_STRIP, L1C_MAC_CTRL_VLANSTRIP,
++		LX_LOOPBACK, L1C_MAC_CTRL_LPBACK_EN,
++		LX_SINGLE_PAUSE, L1C_MAC_CTRL_SPAUSE_EN,
++		LX_ADD_FCS, (L1C_MAC_CTRL_PCRCE | L1C_MAC_CTRL_CRCE)
++	};
 +
 +	alx_mem_r32(hw, L1C_RXQ0, &rxq);
 +	alx_mem_r32(hw, L1C_TXQ0, &txq);
@@ -1571,32 +1511,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			FIELD_SETL(mac, L1C_MAC_CTRL_SPEED,
 +				   L1C_MAC_CTRL_SPEED_10_100);
 +		}
-+
-+		test_set_or_clear(mac, en_ctrl, LX_MACDUPLEX_FULL,
-+				  L1C_MAC_CTRL_FULLD);
-+
-+		/* rx filter */
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_PROMISC,
-+				  L1C_MAC_CTRL_PROMISC_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_MULTI_ALL,
-+				  L1C_MAC_CTRL_MULTIALL_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_BROADCAST,
-+				  L1C_MAC_CTRL_BRD_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_DIRECT,
-+				  L1C_MAC_CTRL_RX_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FC_TXEN,
-+				  L1C_MAC_CTRL_TXFC_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FC_RXEN,
-+				  L1C_MAC_CTRL_RXFC_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_VLAN_STRIP,
-+				  L1C_MAC_CTRL_VLANSTRIP);
-+		test_set_or_clear(mac, en_ctrl, LX_LOOPBACK,
-+				  L1C_MAC_CTRL_LPBACK_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_SINGLE_PAUSE,
-+				  L1C_MAC_CTRL_SPAUSE_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_ADD_FCS,
-+				  (L1C_MAC_CTRL_PCRCE | L1C_MAC_CTRL_CRCE));
-+
++		for (i = 0; i < ARRAY_SIZE(ctrl_hw_map); i += 2) {
++			if (en_ctrl & ctrl_hw_map[i])
++				mac |= ctrl_hw_map[i + 1];
++			else
++				mac &= ~ctrl_hw_map[i + 1];
++		}
 +		alx_mem_w32(hw, L1C_MAC_CTRL, mac | L1C_MAC_CTRL_TX_EN);
 +	} else { /* disable mac */
 +		alx_mem_w32(hw, L1C_RXQ0, rxq & ~L1C_RXQ0_EN);
@@ -1634,7 +1554,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* enable/disable aspm support
 + * that will change settings for phy/mac/pcie
 + */
-+u16 l1c_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat)
++int l1c_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat)
 +{
 +	u32 pmctrl;
 +	bool linkon;
@@ -1724,7 +1644,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    if autoNeg, is link capability to tell the peer
 + *    if force mode, is forced speed/duplex
 + */
-+u16 l1c_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
++int l1c_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
 +		       u8 lnk_cap, bool fc_en)
 +{
 +	u16 adv, giga, cr;
@@ -1806,13 +1726,56 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return ret;
 +}
 +
++/* do post setting on phy if link up/down event occur
++ */
++int l1c_post_phy_link(struct alx_hw *hw, bool az_en, bool linkon, u8 wire_spd)
++{
++	u16 phy_val;
++	bool adj_th = (hw->pci_devid == L2CB_DEV_ID ||
++			hw->pci_devid == L2CB2_DEV_ID ||
++			hw->pci_devid == L1D_DEV_ID ||
++			hw->pci_devid == L1D2_DEV_ID) ? true : false;
++
++	if (linkon) {
++		/* az with broadcom, Half-amp */
++		if (hw->pci_devid == L1D2_DEV_ID) {
++			l1c_read_phy(hw, true, L1C_MIIEXT_PCS, true,
++				     L1C_MIIEXT_CLDCTRL6, &phy_val);
++			phy_val = FIELD_GETX(phy_val, L1C_CLDCTRL6_CAB_LEN);
++			l1c_write_phydbg(hw, true, L1C_MIIDBG_AZ_ANADECT,
++				(phy_val > L1C_CLDCTRL6_CAB_LEN_SHORT) ?
++				L1C_AZ_ANADECT_LONG : L1C_AZ_ANADECT_DEF);
++			l1c_write_phy(hw, false, 0, true,
++				      L1C_MII_DBG_ADDR, LX_PHY_INITED);
++		}
++
++		/* threashold adjust */
++		if (adj_th && hw->msi_lnkpatch &&
++		    (wire_spd == LX_LC_100F || wire_spd == LX_LC_100H)) {
++			l1c_write_phydbg(hw, true, L1D_MIIDBG_MSE16DB,
++					 L1D_MSE16DB_UP);
++			l1c_write_phydbg(hw, true, L1D_MIIDBG_SYSMODCTRL,
++					 L1D_SYSMODCTRL_IECHOADJ_DEF);
++		}
++
++	} else {
++		if (adj_th && hw->msi_lnkpatch) {
++			l1c_write_phydbg(hw, true, L1D_MIIDBG_SYSMODCTRL,
++					 L1C_SYSMODCTRL_IECHOADJ_DEF);
++			l1c_write_phydbg(hw, true, L1D_MIIDBG_MSE16DB,
++					 L1D_MSE16DB_DOWN);
++		}
++	}
++
++	return 0;
++}
 +
 +/* do power saving setting befor enter suspend mode
 + * NOTE:
 + *    1. phy link must be established before calling this function
 + *    2. wol option (pattern,magic,link,etc.) is configed before call it.
 + */
-+u16 l1c_powersaving(struct alx_hw *hw, u8 wire_spd, bool wol_en,
++int l1c_powersaving(struct alx_hw *hw, u8 wire_spd, bool wol_en,
 +		    bool mac_txen, bool mac_rxen, bool pws_en)
 +{
 +	u32 master_ctrl, mac_ctrl, phy_ctrl;
@@ -1877,7 +1840,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* read phy register */
-+u16 l1c_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
++int l1c_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
 +		 u16 reg, u16 *data)
 +{
 +	u32 val;
@@ -1922,7 +1885,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +/* write phy register */
-+u16 l1c_write_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
++int l1c_write_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
 +		  u16 reg, u16 data)
 +{
 +	u32 val;
@@ -1964,7 +1927,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return ret;
 +}
 +
-+u16 l1c_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data)
++int l1c_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data)
 +{
 +	u16 ret;
 +
@@ -1974,9 +1937,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return ret;
 +}
 +
-+u16 l1c_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data)
++int l1c_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data)
 +{
-+	u16 ret;
++	int ret;
 +
 +	ret = l1c_write_phy(hw, false, 0, fast, L1C_MII_DBG_ADDR, reg);
 +	ret = l1c_write_phy(hw, false, 0, fast, L1C_MII_DBG_DATA, data);
@@ -1993,7 +1956,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *  int_mod   : micro-second
 + *  disable RSS as default
 + */
-+u16 l1c_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
++int l1c_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
 +		 u32 *tx_mem_lo, u8 tx_qnum, u16 txring_sz,
 +		 u32 rxmem_hi, u32 rfdmem_lo, u32 rrdmem_lo,
 +		 u16 rxring_sz, u16 rxbuf_sz, u16 smb_timer,
@@ -2004,10 +1967,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	u8 dmar_len;
 +
 +	/* set mac-address */
-+	val = *(u32 *)(addr + 2);
-+	alx_mem_w32(hw, L1C_STAD0, LX_SWAP_DW(val));
-+	val = *(u16 *)addr ;
-+	alx_mem_w32(hw, L1C_STAD1, LX_SWAP_W((u16)val));
++	val = be32_to_cpu(*(__be32 *)(addr + 2));
++	alx_mem_w32(hw, L1C_STAD0, val);
++	val = be16_to_cpu(*(__be16 *)addr);
++	alx_mem_w32(hw, L1C_STAD1, val);
 +
 +	/* clear multicast hash table, algrithm */
 +	alx_mem_w32(hw, L1C_HASH_TBL0, 0);
@@ -2126,8 +2089,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* rxq */
 +	val = FIELDL(L1C_RXQ0_NUM_RFD_PREF, L1C_RXQ0_NUM_RFD_PREF_DEF) |
 +	    L1C_RXQ0_IPV6_PARSE_EN;
-+	if (mtu > L1C_MTU_JUMBO_TH)
-+		val |= L1C_RXQ0_CUT_THRU_EN;
++
 +	if ((hw->pci_devid & 1) != 0) {
 +		FIELD_SETL(val, L1C_RXQ0_ASPM_THRESH,
 +			   (hw->pci_devid == L1D2_DEV_ID) ?
@@ -2151,7 +2113,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+u16 l1c_get_phy_config(struct alx_hw *hw)
++int l1c_get_phy_config(struct alx_hw *hw)
 +{
 +	u32 val;
 +	u16 phy_val;
@@ -2173,10 +2135,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	return LX_DRV_PHY_UNKNOWN;
 +}
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alc_hw.h b/drivers/net/ethernet/atheros/alx/alc_hw.h
+new file mode 100644
+index 0000000..d5a37a5
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alc_hw.h
-@@ -0,0 +1,1324 @@
+@@ -0,0 +1,1317 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -2196,17 +2160,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#ifndef L1C_HW_H_
 +#define L1C_HW_H_
 +
-+/*********************************************************************
-+ * some reqs for l1x_sw.h
-+ *
-+ * 1. some basic type must be defined if there are not defined by
-+ *    your compiler:
-+ *    u8, u16, u32, bool
-+ *
-+ * 2. PETHCONTEXT difinition should be in l1x_sw.h and it must contain
-+ *    pci_devid & pci_venid & pci_revid
-+ *
-+ *********************************************************************/
 +
 +#include "alx_hwcom.h"
 +
@@ -2226,32 +2179,32 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1C_PM_CSR                      0x0044  /* 16bit */
 +#define L1C_PM_CSR_PME_STAT             BIT(15)
-+#define L1C_PM_CSR_DSCAL_MASK           ASHFT13(3U)
++#define L1C_PM_CSR_DSCAL_MASK           0x3U
 +#define L1C_PM_CSR_DSCAL_SHIFT          13
-+#define L1C_PM_CSR_DSEL_MASK            ASHFT9(0xFU)
++#define L1C_PM_CSR_DSEL_MASK            0xFU
 +#define L1C_PM_CSR_DSEL_SHIFT           9
 +#define L1C_PM_CSR_PME_EN               BIT(8)
-+#define L1C_PM_CSR_PWST_MASK            ASHFT0(3U)
++#define L1C_PM_CSR_PWST_MASK            0x3U
 +#define L1C_PM_CSR_PWST_SHIFT           0
 +
 +#define L1C_PM_DATA                     0x0047  /* 8bit */
 +
 +#define L1C_DEV_CAP                     0x005C
-+#define L1C_DEV_CAP_SPLSL_MASK          ASHFT26(3UL)
++#define L1C_DEV_CAP_SPLSL_MASK          0x3UL
 +#define L1C_DEV_CAP_SPLSL_SHIFT         26
-+#define L1C_DEV_CAP_SPLV_MASK           ASHFT18(0xFFUL)
++#define L1C_DEV_CAP_SPLV_MASK           0xFFUL
 +#define L1C_DEV_CAP_SPLV_SHIFT          18
 +#define L1C_DEV_CAP_RBER                BIT(15)
 +#define L1C_DEV_CAP_PIPRS               BIT(14)
 +#define L1C_DEV_CAP_AIPRS               BIT(13)
 +#define L1C_DEV_CAP_ABPRS               BIT(12)
-+#define L1C_DEV_CAP_L1ACLAT_MASK        ASHFT9(7UL)
++#define L1C_DEV_CAP_L1ACLAT_MASK        0x7UL
 +#define L1C_DEV_CAP_L1ACLAT_SHIFT       9
-+#define L1C_DEV_CAP_L0SACLAT_MASK       ASHFT6(7UL)
++#define L1C_DEV_CAP_L0SACLAT_MASK       0x7UL
 +#define L1C_DEV_CAP_L0SACLAT_SHIFT      6
 +#define L1C_DEV_CAP_EXTAG               BIT(5)
 +#define L1C_DEV_CAP_PHANTOM             BIT(4)
-+#define L1C_DEV_CAP_MPL_MASK            ASHFT0(7UL)
++#define L1C_DEV_CAP_MPL_MASK            0x7UL
 +#define L1C_DEV_CAP_MPL_SHIFT           0
 +#define L1C_DEV_CAP_MPL_128             1
 +#define L1C_DEV_CAP_MPL_256             2
@@ -2261,14 +2214,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_DEV_CAP_MPL_4096            6
 +
 +#define L1C_DEV_CTRL                    0x0060    /* 16bit */
-+#define L1C_DEV_CTRL_MAXRRS_MASK        ASHFT12(7U)
++#define L1C_DEV_CTRL_MAXRRS_MASK        0x7U
 +#define L1C_DEV_CTRL_MAXRRS_SHIFT       12
 +#define L1C_DEV_CTRL_MAXRRS_MIN         2
 +#define L1C_DEV_CTRL_NOSNP_EN           BIT(11)
 +#define L1C_DEV_CTRL_AUXPWR_EN          BIT(10)
 +#define L1C_DEV_CTRL_PHANTOM_EN         BIT(9)
 +#define L1C_DEV_CTRL_EXTAG_EN           BIT(8)
-+#define L1C_DEV_CTRL_MPL_MASK           ASHFT5(7U)
++#define L1C_DEV_CTRL_MPL_MASK           0x7U
 +#define L1C_DEV_CTRL_MPL_SHIFT          5
 +#define L1C_DEV_CTRL_RELORD_EN          BIT(4)
 +#define L1C_DEV_CTRL_URR_EN             BIT(3)
@@ -2285,20 +2238,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_DEV_STAT_CERR               BIT(0)
 +
 +#define L1C_LNK_CAP                     0x0064
-+#define L1C_LNK_CAP_PRTNUM_MASK         ASHFT24(0xFFUL)
++#define L1C_LNK_CAP_PRTNUM_MASK         0xFFUL
 +#define L1C_LNK_CAP_PRTNUM_SHIFT        24
 +#define L1C_LNK_CAP_CLK_PM              BIT(18)
-+#define L1C_LNK_CAP_L1EXTLAT_MASK       ASHFT15(7UL)
++#define L1C_LNK_CAP_L1EXTLAT_MASK       0x7UL
 +#define L1C_LNK_CAP_L1EXTLAT_SHIFT      15
-+#define L1C_LNK_CAP_L0SEXTLAT_MASK      ASHFT12(7UL)
++#define L1C_LNK_CAP_L0SEXTLAT_MASK      0x7UL
 +#define L1C_LNK_CAP_L0SEXTLAT_SHIFT     12
-+#define L1C_LNK_CAP_ASPM_SUP_MASK       ASHFT10(3UL)
++#define L1C_LNK_CAP_ASPM_SUP_MASK       0x3UL
 +#define L1C_LNK_CAP_ASPM_SUP_SHIFT      10
 +#define L1C_LNK_CAP_ASPM_SUP_L0S        1
 +#define L1C_LNK_CAP_ASPM_SUP_L0SL1      3
-+#define L1C_LNK_CAP_MAX_LWH_MASK        ASHFT4(0x3FUL)
++#define L1C_LNK_CAP_MAX_LWH_MASK        0x3FUL
 +#define L1C_LNK_CAP_MAX_LWH_SHIFT       4
-+#define L1C_LNK_CAP_MAX_LSPD_MASH       ASHFT0(0xFUL)
++#define L1C_LNK_CAP_MAX_LSPD_MASH       0xFUL
 +#define L1C_LNK_CAP_MAX_LSPD_SHIFT      0
 +
 +#define L1C_LNK_CTRL                    0x0068  /* 16bit */
@@ -2306,7 +2259,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_LNK_CTRL_EXTSYNC            BIT(7)
 +#define L1C_LNK_CTRL_CMNCLK_CFG         BIT(6)
 +#define L1C_LNK_CTRL_RCB_128B           BIT(3)  /* 0:64b,1:128b */
-+#define L1C_LNK_CTRL_ASPM_MASK          ASHFT0(3U)
++#define L1C_LNK_CTRL_ASPM_MASK          0x3U
 +#define L1C_LNK_CTRL_ASPM_SHIFT         0
 +#define L1C_LNK_CTRL_ASPM_DIS           0
 +#define L1C_LNK_CTRL_ASPM_ENL0S         1
@@ -2317,9 +2270,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_LNK_STAT_SCLKCFG            BIT(12)
 +#define L1C_LNK_STAT_LNKTRAIN           BIT(11)
 +#define L1C_LNK_STAT_TRNERR             BIT(10)
-+#define L1C_LNK_STAT_LNKSPD_MASK        ASHFT0(0xFU)
++#define L1C_LNK_STAT_LNKSPD_MASK        0xFU
 +#define L1C_LNK_STAT_LNKSPD_SHIFT       0
-+#define L1C_LNK_STAT_NEGLW_MASK         ASHFT4(0x3FU)
++#define L1C_LNK_STAT_NEGLW_MASK         0x3FU
 +#define L1C_LNK_STAT_NEGLW_SHIFT        4
 +
 +#define L1C_UE_SVRT                     0x010C
@@ -2336,40 +2289,40 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_UE_SVRT_TRNERR              BIT(0)
 +
 +#define L1C_SLD                         0x0218  /* efuse load */
-+#define L1C_SLD_FREQ_MASK               ASHFT24(3UL)
++#define L1C_SLD_FREQ_MASK               0x3UL
 +#define L1C_SLD_FREQ_SHIFT              24
 +#define L1C_SLD_FREQ_100K               0
 +#define L1C_SLD_FREQ_200K               1
 +#define L1C_SLD_FREQ_300K               2
 +#define L1C_SLD_FREQ_400K               3
 +#define L1C_SLD_EXIST                   BIT(23)
-+#define L1C_SLD_SLVADDR_MASK            ASHFT16(0x7FUL)
++#define L1C_SLD_SLVADDR_MASK            0x7FUL
 +#define L1C_SLD_SLVADDR_SHIFT           16
 +#define L1C_SLD_IDLE                    BIT(13)
 +#define L1C_SLD_STAT                    BIT(12)  /* 0:finish,1:in progress */
 +#define L1C_SLD_START                   BIT(11)
-+#define L1C_SLD_STARTADDR_MASK          ASHFT0(0xFFUL)
++#define L1C_SLD_STARTADDR_MASK          0xFFUL
 +#define L1C_SLD_STARTADDR_SHIFT         0
 +#define L1C_SLD_MAX_TO                  100
 +
 +#define L1C_PPHY_MISC1                  0x1000
 +#define L1C_PPHY_MISC1_RCVDET           BIT(2)
-+#define L1C_PPHY_MISC1_NFTS_MASK        ASHFT16(0xFFUL)
++#define L1C_PPHY_MISC1_NFTS_MASK        0xFFUL
 +#define L1C_PPHY_MISC1_NFTS_SHIFT       16
 +#define L1C_PPHY_MISC1_NFTS_HIPERF      0xA0    /* ???? */
 +
 +#define L1C_PPHY_MISC2                  0x1004
-+#define L1C_PPHY_MISC2_L0S_TH_MASK      ASHFT18(0x3UL)
++#define L1C_PPHY_MISC2_L0S_TH_MASK      0x3UL
 +#define L1C_PPHY_MISC2_L0S_TH_SHIFT     18
 +#define L1C_PPHY_MISC2_L0S_TH_L2CB1     3
-+#define L1C_PPHY_MISC2_CDR_BW_MASK      ASHFT16(0x3UL)
++#define L1C_PPHY_MISC2_CDR_BW_MASK      0x3UL
 +#define L1C_PPHY_MISC2_CDR_BW_SHIFT     16
 +#define L1C_PPHY_MISC2_CDR_BW_L2CB1     3
 +
 +#define L1C_PDLL_TRNS1                  0x1104
 +#define L1C_PDLL_TRNS1_D3PLLOFF_EN      BIT(11)
 +#define L1C_PDLL_TRNS1_REGCLK_SEL_NORM  BIT(10)
-+#define L1C_PDLL_TRNS1_REPLY_TO_MASK    ASHFT0(0x3FFUL)
++#define L1C_PDLL_TRNS1_REPLY_TO_MASK    0x3FFUL
 +#define L1C_PDLL_TRNS1_REPLY_TO_SHIFT   0
 +
 +#define L1C_TWSI_DBG                    0x1108
@@ -2379,15 +2332,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_DMA_DBG_VENDOR_MSG          BIT(0)
 +
 +#define L1C_TLEXTN_STATS                0x1204  /* diff with l1f */
-+#define L1C_TLEXTN_STATS_DEVNO_MASK     ASHFT16(0x1FUL)
++#define L1C_TLEXTN_STATS_DEVNO_MASK     0x1FUL
 +#define L1C_TLEXTN_STATS_DEVNO_SHIFT    16
-+#define L1C_TLEXTN_STATS_BUSNO_MASK     ASHFT8(0xFFUL)
++#define L1C_TLEXTN_STATS_BUSNO_MASK     0xFFUL
 +#define L1C_TLEXTN_STATS_BUSNO_SHIFT    8
 +
 +#define L1C_EFUSE_CTRL                  0x12C0
 +#define L1C_EFUSE_CTRL_FLAG             BIT(31)  /* 0:read,1:write */
 +#define L1C_EUFSE_CTRL_ACK              BIT(30)
-+#define L1C_EFUSE_CTRL_ADDR_MASK        ASHFT16(0x3FFUL)
++#define L1C_EFUSE_CTRL_ADDR_MASK        0x3FFUL
 +#define L1C_EFUSE_CTRL_ADDR_SHIFT       16
 +
 +#define L1C_EFUSE_DATA                  0x12C4
@@ -2403,15 +2356,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +						 * thrghput(setting in 15A0) */
 +#define L1C_PMCTRL_SADLY_EN             BIT(29)
 +#define L1C_PMCTRL_L0S_BUFSRX_EN        BIT(28)
-+#define L1C_PMCTRL_LCKDET_TIMER_MASK    ASHFT24(0xFUL)
++#define L1C_PMCTRL_LCKDET_TIMER_MASK    0xFUL
 +#define L1C_PMCTRL_LCKDET_TIMER_SHIFT   24
 +#define L1C_PMCTRL_LCKDET_TIMER_DEF     0xC
-+#define L1C_PMCTRL_L1REQ_TO_MASK        ASHFT20(0xFUL)
++#define L1C_PMCTRL_L1REQ_TO_MASK        0xFUL
 +#define L1C_PMCTRL_L1REQ_TO_SHIFT       20      /* pm_request_l1 time > @
 +						 * ->L0s not L1 */
-+#define L1C_PMCTRL_L1REG_TO_DEF         0xC
++#define L1C_PMCTRL_L1REG_TO_DEF         0xF
 +#define L1D_PMCTRL_TXL1_AFTER_L0S       BIT(19)  /* l1dv2.0+ */
-+#define L1D_PMCTRL_L1_TIMER_MASK        ASHFT16(7UL)
++#define L1D_PMCTRL_L1_TIMER_MASK        0x7UL
 +#define L1D_PMCTRL_L1_TIMER_SHIFT       16
 +#define L1D_PMCTRL_L1_TIMER_DIS         0
 +#define L1D_PMCTRL_L1_TIMER_2US         1
@@ -2421,7 +2374,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1D_PMCTRL_L1_TIMER_24US        5
 +#define L1D_PMCTRL_L1_TIMER_32US        6
 +#define L1D_PMCTRL_L1_TIMER_63US        7
-+#define L1C_PMCTRL_L1_TIMER_MASK        ASHFT16(0xFUL)
++#define L1C_PMCTRL_L1_TIMER_MASK        0xFUL
 +#define L1C_PMCTRL_L1_TIMER_SHIFT       16
 +#define L1C_PMCTRL_L1_TIMER_L2CB1       7
 +#define L1C_PMCTRL_L1_TIMER_DEF         0xF
@@ -2430,9 +2383,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_PMCTRL_L1_CLKSW_EN          BIT(13)  /* en pcie clk sw in L1 */
 +#define L1C_PMCTRL_L0S_EN               BIT(12)
 +#define L1D_PMCTRL_RXL1_AFTER_L0S       BIT(11)  /* l1dv2.0+ */
-+#define L1D_PMCTRL_L0S_TIMER_MASK       ASHFT8(7UL)
++#define L1D_PMCTRL_L0S_TIMER_MASK       0x7UL
 +#define L1D_PMCTRL_L0S_TIMER_SHIFT      8
-+#define L1C_PMCTRL_L0S_TIMER_MASK       ASHFT8(0xFUL)
++#define L1C_PMCTRL_L0S_TIMER_MASK       0xFUL
 +#define L1C_PMCTRL_L0S_TIMER_SHIFT      8
 +#define L1C_PMCTRL_L1_BUFSRX_EN         BIT(7)
 +#define L1C_PMCTRL_L1_SRDSRX_PWD        BIT(6)   /* power down serdes rx */
@@ -2449,9 +2402,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1C_MASTER                      0x1400
 +#define L1C_MASTER_OTP_FLG              BIT(31)
-+#define L1C_MASTER_DEV_NUM_MASK         ASHFT24(0x7FUL)
++#define L1C_MASTER_DEV_NUM_MASK         0x7FUL
 +#define L1C_MASTER_DEV_NUM_SHIFT        24
-+#define L1C_MASTER_REV_NUM_MASK         ASHFT16(0xFFUL)
++#define L1C_MASTER_REV_NUM_MASK         0xFFUL
 +#define L1C_MASTER_REV_NUM_SHIFT        16
 +#define L1C_MASTER_RDCLR_INT            BIT(14)
 +#define L1C_MASTER_CLKSW_L2EV1          BIT(13)      /* 0:l2ev2.0,1:l2ev1.0 */
@@ -2465,7 +2418,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MASTER_OOB_DIS              BIT(6)       /* OUT OF BOX DIS */
 +#define L1C_MASTER_WAKEN_25M            BIT(5)       /* WAKE WO. PCIE CLK */
 +#define L1C_MASTER_BERT_START           BIT(4)
-+#define L1C_MASTER_PCIE_TSTMOD_MASK     ASHFT2(3UL)
++#define L1C_MASTER_PCIE_TSTMOD_MASK     0x3UL
 +#define L1C_MASTER_PCIE_TSTMOD_SHIFT    2
 +#define L1C_MASTER_PCIE_RST             BIT(1)
 +#define L1C_MASTER_DMA_MAC_RST          BIT(0)       /* RST MAC & DMA */
@@ -2474,13 +2427,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MANU_TIMER                  0x1404
 +
 +#define L1C_IRQ_MODU_TIMER              0x1408
-+#define L1C_IRQ_MODU_TIMER2_MASK        ASHFT16(0xFFFFUL)
++#define L1C_IRQ_MODU_TIMER2_MASK        0xFFFFUL
 +#define L1C_IRQ_MODU_TIMER2_SHIFT       16          /* ONLY FOR RX */
-+#define L1C_IRQ_MODU_TIMER1_MASK        ASHFT0(0xFFFFUL)
++#define L1C_IRQ_MODU_TIMER1_MASK        0xFFFFUL
 +#define L1C_IRQ_MODU_TIMER1_SHIFT       0
 +
 +#define L1C_PHY_CTRL                    0x140C
-+#define L1C_PHY_CTRL_ADDR_MASK          ASHFT19(0x1FUL)
++#define L1C_PHY_CTRL_ADDR_MASK          0x1FUL
 +#define L1C_PHY_CTRL_ADDR_SHIFT         19
 +#define L1C_PHY_CTRL_BP_VLTGSW          BIT(18)
 +#define L1C_PHY_CTRL_100AB_EN           BIT(17)
@@ -2512,12 +2465,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +#define L1C_MAC_STS                     0x1410
-+#define L1C_MAC_STS_SFORCE_MASK         ASHFT14(0xFUL)
++#define L1C_MAC_STS_SFORCE_MASK         0xFUL
 +#define L1C_MAC_STS_SFORCE_SHIFT        14
 +#define L1C_MAC_STS_CALIB_DONE          BIT13
-+#define L1C_MAC_STS_CALIB_RES_MASK      ASHFT8(0x1FUL)
++#define L1C_MAC_STS_CALIB_RES_MASK      0x1FUL
 +#define L1C_MAC_STS_CALIB_RES_SHIFT     8
-+#define L1C_MAC_STS_CALIBERR_MASK       ASHFT4(0xFUL)
++#define L1C_MAC_STS_CALIBERR_MASK       0xFUL
 +#define L1C_MAC_STS_CALIBERR_SHIFT      4
 +#define L1C_MAC_STS_TXQ_BUSY            BIT(3)
 +#define L1C_MAC_STS_RXQ_BUSY            BIT(2)
@@ -2534,7 +2487,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MDIO_POST_READ              BIT(29)
 +#define L1C_MDIO_AUTO_POLLING           BIT(28)
 +#define L1C_MDIO_BUSY                   BIT(27)
-+#define L1C_MDIO_CLK_SEL_MASK           ASHFT24(7UL)
++#define L1C_MDIO_CLK_SEL_MASK           0x7UL
 +#define L1C_MDIO_CLK_SEL_SHIFT          24
 +#define L1C_MDIO_CLK_SEL_25MD4          0           /* 25M DIV 4 */
 +#define L1C_MDIO_CLK_SEL_25MD6          2
@@ -2546,29 +2499,29 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MDIO_START                  BIT(23)
 +#define L1C_MDIO_SPRES_PRMBL            BIT(22)
 +#define L1C_MDIO_OP_READ                BIT(21)      /* 1:read,0:write */
-+#define L1C_MDIO_REG_MASK               ASHFT16(0x1FUL)
++#define L1C_MDIO_REG_MASK               0x1FUL
 +#define L1C_MDIO_REG_SHIFT              16
-+#define L1C_MDIO_DATA_MASK              ASHFT0(0xFFFFUL)
++#define L1C_MDIO_DATA_MASK              0xFFFFUL
 +#define L1C_MDIO_DATA_SHIFT             0
 +#define L1C_MDIO_MAX_AC_TO              120
 +
 +#define L1C_MDIO_EXTN                   0x1448
-+#define L1C_MDIO_EXTN_PORTAD_MASK       ASHFT21(0x1FUL)
++#define L1C_MDIO_EXTN_PORTAD_MASK       0x1FUL
 +#define L1C_MDIO_EXTN_PORTAD_SHIFT      21
-+#define L1C_MDIO_EXTN_DEVAD_MASK        ASHFT16(0x1FUL)
++#define L1C_MDIO_EXTN_DEVAD_MASK        0x1FUL
 +#define L1C_MDIO_EXTN_DEVAD_SHIFT       16
-+#define L1C_MDIO_EXTN_REG_MASK          ASHFT0(0xFFFFUL)
++#define L1C_MDIO_EXTN_REG_MASK          0xFFFFUL
 +#define L1C_MDIO_EXTN_REG_SHIFT         0
 +
 +#define L1C_PHY_STS                     0x1418
 +#define L1C_PHY_STS_LPW                 BIT(31)
 +#define L1C_PHY_STS_LPI                 BIT(30)
-+#define L1C_PHY_STS_PWON_STRIP_MASK     ASHFT16(0xFFFUL)
++#define L1C_PHY_STS_PWON_STRIP_MASK     0xFFFUL
 +#define L1C_PHY_STS_PWON_STRIP_SHIFT    16
 +
 +#define L1C_PHY_STS_DUPLEX              BIT(3)
 +#define L1C_PHY_STS_LINKUP              BIT(2)
-+#define L1C_PHY_STS_SPEED_MASK          ASHFT0(3UL)
++#define L1C_PHY_STS_SPEED_MASK          0x3UL
 +#define L1C_PHY_STS_SPEED_SHIFT         0
 +#define L1C_PHY_STS_SPEED_SHIFT         0
 +#define L1C_PHY_STS_SPEED_1000M         2
@@ -2576,13 +2529,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_PHY_STS_SPEED_10M           0
 +
 +#define L1C_BIST0                       0x141C
-+#define L1C_BIST0_COL_MASK              ASHFT24(0x3FUL)
++#define L1C_BIST0_COL_MASK              0x3FUL
 +#define L1C_BIST0_COL_SHIFT             24
-+#define L1C_BIST0_ROW_MASK              ASHFT12(0xFFFUL)
++#define L1C_BIST0_ROW_MASK              0xFFFUL
 +#define L1C_BIST0_ROW_SHIFT             12
-+#define L1C_BIST0_STEP_MASK             ASHFT8(0xFUL)
++#define L1C_BIST0_STEP_MASK             0xFUL
 +#define L1C_BIST0_STEP_SHIFT            8
-+#define L1C_BIST0_PATTERN_MASK          ASHFT4(7UL)
++#define L1C_BIST0_PATTERN_MASK          0x7UL
 +#define L1C_BIST0_PATTERN_SHIFT         4
 +#define L1C_BIST0_CRIT                  BIT(3)
 +#define L1C_BIST0_FIXED                 BIT(2)
@@ -2590,13 +2543,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_BIST0_START                 BIT(0)
 +
 +#define L1C_BIST1                       0x1420
-+#define L1C_BIST1_COL_MASK              ASHFT24(0x3FUL)
++#define L1C_BIST1_COL_MASK              0x3FUL
 +#define L1C_BIST1_COL_SHIFT             24
-+#define L1C_BIST1_ROW_MASK              ASHFT12(0xFFFUL)
++#define L1C_BIST1_ROW_MASK              0xFFFUL
 +#define L1C_BIST1_ROW_SHIFT             12
-+#define L1C_BIST1_STEP_MASK             ASHFT8(0xFUL)
++#define L1C_BIST1_STEP_MASK             0xFUL
 +#define L1C_BIST1_STEP_SHIFT            8
-+#define L1C_BIST1_PATTERN_MASK          ASHFT4(7UL)
++#define L1C_BIST1_PATTERN_MASK          0x7UL
 +#define L1C_BIST1_PATTERN_SHIFT         4
 +#define L1C_BIST1_CRIT                  BIT(3)
 +#define L1C_BIST1_FIXED                 BIT(2)
@@ -2606,7 +2559,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_SERDES                      0x1424
 +#define L1C_SERDES_PHYCLK_SLWDWN        BIT(18)
 +#define L1C_SERDES_MACCLK_SLWDWN        BIT(17)
-+#define L1C_SERDES_SELFB_PLL_MASK       ASHFT14(3UL)
++#define L1C_SERDES_SELFB_PLL_MASK       0x3UL
 +#define L1C_SERDES_SELFB_PLL_SHIFT      14
 +#define L1C_SERDES_PHYCLK_SEL_GTX       BIT(13)          /* 1:gtx_clk, 0:25M */
 +#define L1C_SERDES_PCIECLK_SEL_SRDS     BIT(12)          /* 1:serdes,0:25M */
@@ -2615,7 +2568,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_SERDES_PLL_EN               BIT(9)
 +#define L1C_SERDES_EN                   BIT(8)
 +#define L1C_SERDES_SELFB_PLL_SEL_CSR    BIT(6)       /* 0:state-machine,1:csr */
-+#define L1C_SERDES_SELFB_PLL_CSR_MASK   ASHFT4(3UL)
++#define L1C_SERDES_SELFB_PLL_CSR_MASK   0x3UL
 +#define L1C_SERDES_SELFB_PLL_CSR_SHIFT  4
 +#define L1C_SERDES_SELFB_PLL_CSR_4      3           /* 4-12% OV-CLK */
 +#define L1C_SERDES_SELFB_PLL_CSR_0      2           /* 0-4% OV-CLK */
@@ -2627,19 +2580,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_SERDES_LOCKDCTED            BIT(0)
 +
 +#define L1C_LED_CTRL                    0x1428
-+#define L1C_LED_CTRL_PATMAP2_MASK       ASHFT8(3UL)
++#define L1C_LED_CTRL_PATMAP2_MASK       0x3UL
 +#define L1C_LED_CTRL_PATMAP2_SHIFT      8
-+#define L1C_LED_CTRL_PATMAP1_MASK       ASHFT6(3UL)
++#define L1C_LED_CTRL_PATMAP1_MASK       0x3UL
 +#define L1C_LED_CTRL_PATMAP1_SHIFT      6
-+#define L1C_LED_CTRL_PATMAP0_MASK       ASHFT4(3UL)
++#define L1C_LED_CTRL_PATMAP0_MASK       0x3UL
 +#define L1C_LED_CTRL_PATMAP0_SHIFT      4
-+#define L1C_LED_CTRL_D3_MODE_MASK       ASHFT2(3UL)
++#define L1C_LED_CTRL_D3_MODE_MASK       0x3UL
 +#define L1C_LED_CTRL_D3_MODE_SHIFT      2
 +#define L1C_LED_CTRL_D3_MODE_NORMAL     0
 +#define L1C_LED_CTRL_D3_MODE_WOL_DIS    1
 +#define L1C_LED_CTRL_D3_MODE_WOL_ANY    2
 +#define L1C_LED_CTRL_D3_MODE_WOL_EN     3
-+#define L1C_LED_CTRL_DUTY_CYCL_MASK     ASHFT0(3UL)
++#define L1C_LED_CTRL_DUTY_CYCL_MASK     0x3UL
 +#define L1C_LED_CTRL_DUTY_CYCL_SHIFT    0
 +#define L1C_LED_CTRL_DUTY_CYCL_50       0           /* 50% */
 +#define L1C_LED_CTRL_DUTY_CYCL_125      1           /* 12.5% */
@@ -2647,22 +2600,22 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_LED_CTRL_DUTY_CYCL_75       3           /* 75% */
 +
 +#define L1C_LED_PATN                    0x142C
-+#define L1C_LED_PATN1_MASK              ASHFT16(0xFFFFUL)
++#define L1C_LED_PATN1_MASK              0xFFFFUL
 +#define L1C_LED_PATN1_SHIFT             16
-+#define L1C_LED_PATN0_MASK              ASHFT0(0xFFFFUL)
++#define L1C_LED_PATN0_MASK              0xFFFFUL
 +#define L1C_LED_PATN0_SHIFT             0
 +
 +#define L1C_LED_PATN2                   0x1430
-+#define L1C_LED_PATN2_MASK              ASHFT0(0xFFFFUL)
++#define L1C_LED_PATN2_MASK              0xFFFFUL
 +#define L1C_LED_PATN2_SHIFT             0
 +
 +#define L1C_SYSALV                      0x1434
 +#define L1C_SYSALV_FLAG                 BIT(0)
 +
 +#define L1C_PCIERR_INST                 0x1438
-+#define L1C_PCIERR_INST_TX_RATE_MASK    ASHFT4(0xFUL)
++#define L1C_PCIERR_INST_TX_RATE_MASK    0xFUL
 +#define L1C_PCIERR_INST_TX_RATE_SHIFT   4
-+#define L1C_PCIERR_INST_RX_RATE_MASK    ASHFT0(0xFUL)
++#define L1C_PCIERR_INST_RX_RATE_MASK    0xFUL
 +#define L1C_PCIERR_INST_RX_RATE_SHIFT   0
 +
 +#define L1C_LPI_DECISN_TIMER            0x143C
@@ -2670,9 +2623,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1C_LPI_CTRL                    0x1440
 +#define L1C_LPI_CTRL_CHK_DA             BIT(31)
-+#define L1C_LPI_CTRL_ENH_TO_MASK        ASHFT12(0x1FFFUL)
++#define L1C_LPI_CTRL_ENH_TO_MASK        0x1FFFUL
 +#define L1C_LPI_CTRL_ENH_TO_SHIFT       12
-+#define L1C_LPI_CTRL_ENH_TH_MASK        ASHFT6(0x1FUL)
++#define L1C_LPI_CTRL_ENH_TH_MASK        0x1FUL
 +#define L1C_LPI_CTRL_ENH_TH_SHIFT       6
 +#define L1C_LPI_CTRL_ENH_EN             BIT(5)
 +#define L1C_LPI_CTRL_CHK_RX             BIT(4)
@@ -2682,7 +2635,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_LPI_CTRL_EN                 BIT(0)
 +
 +#define L1C_LPI_WAIT                    0x1444
-+#define L1C_LPI_WAIT_TIMER_MASK         ASHFT0(0xFFFFUL)
++#define L1C_LPI_WAIT_TIMER_MASK         0xFFFFUL
 +#define L1C_LPI_WAIT_TIMER_SHIFT        0
 +
 +#define L1C_MAC_CTRL                    0x1480
@@ -2695,7 +2648,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MAC_CTRL_RX_XSUM_EN         BIT(24)
 +#define L1C_MAC_CTRL_THUGE              BIT(23)
 +#define L1C_MAC_CTRL_MBOF               BIT(22)
-+#define L1C_MAC_CTRL_SPEED_MASK         ASHFT20(3UL)
++#define L1C_MAC_CTRL_SPEED_MASK         0x3UL
 +#define L1C_MAC_CTRL_SPEED_SHIFT        20
 +#define L1C_MAC_CTRL_SPEED_10_100       1
 +#define L1C_MAC_CTRL_SPEED_1000         2
@@ -2704,7 +2657,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MAC_CTRL_TPAUSE             BIT(16)
 +#define L1C_MAC_CTRL_PROMISC_EN         BIT(15)
 +#define L1C_MAC_CTRL_VLANSTRIP          BIT(14)
-+#define L1C_MAC_CTRL_PRMBLEN_MASK       ASHFT10(0xFUL)
++#define L1C_MAC_CTRL_PRMBLEN_MASK       0xFUL
 +#define L1C_MAC_CTRL_PRMBLEN_SHIFT      10
 +#define L1C_MAC_CTRL_RHUGE_EN           BIT(9)
 +#define L1C_MAC_CTRL_FLCHK              BIT(8)
@@ -2718,13 +2671,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MAC_CTRL_TX_EN              BIT(0)
 +
 +#define L1C_GAP                         0x1484
-+#define L1C_GAP_IPGR2_MASK              ASHFT24(0x7FUL)
++#define L1C_GAP_IPGR2_MASK              0x7FUL
 +#define L1C_GAP_IPGR2_SHIFT             24
-+#define L1C_GAP_IPGR1_MASK              ASHFT16(0x7FUL)
++#define L1C_GAP_IPGR1_MASK              0x7FUL
 +#define L1C_GAP_IPGR1_SHIFT             16
-+#define L1C_GAP_MIN_IFG_MASK            ASHFT8(0xFFUL)
++#define L1C_GAP_MIN_IFG_MASK            0xFFUL
 +#define L1C_GAP_MIN_IFG_SHIFT           8
-+#define L1C_GAP_IPGT_MASK               ASHFT0(0x7FUL)
++#define L1C_GAP_IPGT_MASK               0x7FUL
 +#define L1C_GAP_IPGT_SHIFT              0
 +
 +#define L1C_STAD0                       0x1488
@@ -2734,17 +2687,17 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_HASH_TBL1                   0x1494
 +
 +#define L1C_HALFD                       0x1498
-+#define L1C_HALFD_JAM_IPG_MASK          ASHFT24(0xFUL)
++#define L1C_HALFD_JAM_IPG_MASK          0xFUL
 +#define L1C_HALFD_JAM_IPG_SHIFT         24
-+#define L1C_HALFD_ABEBT_MASK            ASHFT20(0xFUL)
++#define L1C_HALFD_ABEBT_MASK            0xFUL
 +#define L1C_HALFD_ABEBT_SHIFT           20
 +#define L1C_HALFD_ABEBE                 BIT(19)
 +#define L1C_HALFD_BPNB                  BIT(18)
 +#define L1C_HALFD_NOBO                  BIT(17)
 +#define L1C_HALFD_EDXSDFR               BIT(16)
-+#define L1C_HALFD_RETRY_MASK            ASHFT12(0xFUL)
++#define L1C_HALFD_RETRY_MASK            0xFUL
 +#define L1C_HALFD_RETRY_SHIFT           12
-+#define L1C_HALFD_LCOL_MASK             ASHFT0(0x3FFUL)
++#define L1C_HALFD_LCOL_MASK             0x3FFUL
 +#define L1C_HALFD_LCOL_SHIFT            0
 +
 +#define L1C_MTU                         0x149C
@@ -2783,76 +2736,76 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_WOL0_PATTERN_EN             BIT(0)
 +
 +#define L1C_WOL1                        0x14A4
-+#define L1C_WOL1_PT3_LEN_MASK           ASHFT24(0xFFUL)
++#define L1C_WOL1_PT3_LEN_MASK           0xFFUL
 +#define L1C_WOL1_PT3_LEN_SHIFT          24
-+#define L1C_WOL1_PT2_LEN_MASK           ASHFT16(0xFFUL)
++#define L1C_WOL1_PT2_LEN_MASK           0xFFUL
 +#define L1C_WOL1_PT2_LEN_SHIFT          16
-+#define L1C_WOL1_PT1_LEN_MASK           ASHFT8(0xFFUL)
++#define L1C_WOL1_PT1_LEN_MASK           0xFFUL
 +#define L1C_WOL1_PT1_LEN_SHIFT          8
-+#define L1C_WOL1_PT0_LEN_MASK           ASHFT0(0xFFUL)
++#define L1C_WOL1_PT0_LEN_MASK           0xFFUL
 +#define L1C_WOL1_PT0_LEN_SHIFT          0
 +
 +#define L1C_WOL2                        0x14A8
-+#define L1C_WOL2_PT7_LEN_MASK           ASHFT24(0xFFUL)
++#define L1C_WOL2_PT7_LEN_MASK           0xFFUL
 +#define L1C_WOL2_PT7_LEN_SHIFT          24
-+#define L1C_WOL2_PT6_LEN_MASK           ASHFT16(0xFFUL)
++#define L1C_WOL2_PT6_LEN_MASK           0xFFUL
 +#define L1C_WOL2_PT6_LEN_SHIFT          16
-+#define L1C_WOL2_PT5_LEN_MASK           ASHFT8(0xFFUL)
++#define L1C_WOL2_PT5_LEN_MASK           0xFFUL
 +#define L1C_WOL2_PT5_LEN_SHIFT          8
-+#define L1C_WOL2_PT4_LEN_MASK           ASHFT0(0xFFUL)
++#define L1C_WOL2_PT4_LEN_MASK           0xFFUL
 +#define L1C_WOL2_PT4_LEN_SHIFT          0
 +
 +#define L1C_SRAM0                       0x1500
-+#define L1C_SRAM_RFD_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1C_SRAM_RFD_TAIL_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_RFD_TAIL_ADDR_SHIFT    16
-+#define L1C_SRAM_RFD_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1C_SRAM_RFD_HEAD_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_RFD_HEAD_ADDR_SHIFT    0
 +#define L1C_SRAM_RFD_HT_L2CB1           0x02bf02a0L
 +
 +#define L1C_SRAM1                       0x1510
-+#define L1C_SRAM_RFD_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1C_SRAM_RFD_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1C_SRAM_RFD_LEN_SHIFT          0
 +
 +#define L1C_SRAM2                       0x1518
-+#define L1C_SRAM_TRD_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1C_SRAM_TRD_TAIL_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_TRD_TAIL_ADDR_SHIFT    16
-+#define L1C_SRMA_TRD_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1C_SRMA_TRD_HEAD_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_TRD_HEAD_ADDR_SHIFT    0
 +#define L1C_SRAM_TRD_HT_L2CB1           0x03df03c0L
 +
 +#define L1C_SRAM3                       0x151C
-+#define L1C_SRAM_TRD_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1C_SRAM_TRD_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1C_SRAM_TRD_LEN_SHIFT          0
 +
 +#define L1C_SRAM4                       0x1520
-+#define L1C_SRAM_RXF_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1C_SRAM_RXF_TAIL_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_RXF_TAIL_ADDR_SHIFT    16
-+#define L1C_SRAM_RXF_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1C_SRAM_RXF_HEAD_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_RXF_HEAD_ADDR_SHIFT    0
 +#define L1C_SRAM_RXF_HT_L2CB1           0x029f0000L
 +
 +#define L1C_SRAM5                       0x1524
-+#define L1C_SRAM_RXF_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1C_SRAM_RXF_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1C_SRAM_RXF_LEN_SHIFT          0
 +#define L1C_SRAM_RXF_LEN_8K             (8*1024)
 +#define L1C_SRAM_RXF_LEN_L2CB1          0x02a0L
 +
 +#define L1C_SRAM6                       0x1528
-+#define L1C_SRAM_TXF_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1C_SRAM_TXF_TAIL_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_TXF_TAIL_ADDR_SHIFT    16
-+#define L1C_SRAM_TXF_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1C_SRAM_TXF_HEAD_ADDR_MASK     0xFFFUL
 +#define L1C_SRAM_TXF_HEAD_ADDR_SHIFT    0
 +#define L1C_SRAM_TXF_HT_L2CB1           0x03bf02c0L
 +
 +#define L1C_SRAM7                       0x152C
-+#define L1C_SRAM_TXF_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1C_SRAM_TXF_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1C_SRAM_TXF_LEN_SHIFT          0
 +#define L1C_SRAM_TXF_LEN_L2CB1          0x0100L
 +
 +#define L1C_SRAM8                       0x1530
-+#define L1C_SRAM_PATTERN_ADDR_MASK      ASHFT16(0xFFFUL)
++#define L1C_SRAM_PATTERN_ADDR_MASK      0xFFFUL
 +#define L1C_SRAM_PATTERN_ADDR_SHIFT     16
-+#define L1C_SRAM_TSO_ADDR_MASK          ASHFT0(0xFFFUL)
++#define L1C_SRAM_TSO_ADDR_MASK          0xFFFUL
 +#define L1C_SRAM_TSO_ADDR_SHIFT         0
 +
 +#define L1C_SRAM9                       0x1534
@@ -2865,12 +2818,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_RFD_ADDR_LO                 0x1550
 +#define L1C_RFD_RING_SZ                 0x1560
 +#define L1C_RFD_BUF_SZ                  0x1564
-+#define L1C_RFD_BUF_SZ_MASK             ASHFT0(0xFFFFUL)
++#define L1C_RFD_BUF_SZ_MASK             0xFFFFUL
 +#define L1C_RFD_BUF_SZ_SHIFT            0
 +
 +#define L1C_RRD_ADDR_LO                 0x1568
 +#define L1C_RRD_RING_SZ                 0x1578
-+#define L1C_RRD_RING_SZ_MASK            ASHFT0(0xFFFUL)
++#define L1C_RRD_RING_SZ_MASK            0xFFFUL
 +#define L1C_RRD_RING_SZ_SHIFT           0
 +
 +#define L1C_TPD_PRI1_ADDR_LO            0x157C
@@ -2883,11 +2836,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_TPD_PRI0_CIDX               0x15F6      /* 16BIT */
 +
 +#define L1C_TPD_RING_SZ                 0x1584
-+#define L1C_TPD_RING_SZ_MASK            ASHFT0(0xFFFFUL)
++#define L1C_TPD_RING_SZ_MASK            0xFFFFUL
 +#define L1C_TPD_RING_SZ_SHIFT           0
 +
 +#define L1C_TXQ0                        0x1590
-+#define L1C_TXQ0_TXF_BURST_PREF_MASK    ASHFT16(0xFFFFUL)
++#define L1C_TXQ0_TXF_BURST_PREF_MASK    0xFFFFUL
 +#define L1C_TXQ0_TXF_BURST_PREF_SHIFT   16
 +#define L1C_TXQ0_TXF_BURST_PREF_DEF     0x200
 +#define L1C_TXQ0_TXF_BURST_PREF_L2CB    0x40
@@ -2896,28 +2849,28 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_TXQ0_MODE_ENHANCE           BIT(6)
 +#define L1C_TXQ0_EN                     BIT(5)
 +#define L1C_TXQ0_SUPT_IPOPT             BIT(4)
-+#define L1C_TXQ0_TPD_BURSTPREF_MASK     ASHFT0(0xFUL)
++#define L1C_TXQ0_TPD_BURSTPREF_MASK     0xFUL
 +#define L1C_TXQ0_TPD_BURSTPREF_SHIFT    0
 +#define L1C_TXQ0_TPD_BURSTPREF_DEF      5
 +
 +#define L1C_TXQ1                        0x1594
-+#define L1C_TXQ1_JUMBO_TSOTHR_MASK      ASHFT0(0x7FFUL) /* 8BYTES UNIT */
++#define L1C_TXQ1_JUMBO_TSOTHR_MASK      0x7FFUL /* 8BYTES UNIT */
 +#define L1C_TXQ1_JUMBO_TSOTHR_SHIFT     0
 +#define L1C_TXQ1_JUMBO_TSO_TH           (7*1024)    /* byte */
 +
 +#define L1C_TXQ2                        0x1598          /* ENTER L1 CONTROL */
 +#define L1C_TXQ2_BURST_EN               BIT(31)
-+#define L1C_TXQ2_BURST_HI_WM_MASK       ASHFT16(0xFFFUL)
++#define L1C_TXQ2_BURST_HI_WM_MASK       0xFFFUL
 +#define L1C_TXQ2_BURST_HI_WM_SHIFT      16
-+#define L1C_TXQ2_BURST_LO_WM_MASK       ASHFT0(0xFFFUL)
++#define L1C_TXQ2_BURST_LO_WM_MASK       0xFFFUL
 +#define L1C_TXQ2_BURST_LO_WM_SHIFT      0
 +
 +#define L1C_RFD_PIDX                    0x15E0
-+#define L1C_RFD_PIDX_MASK               ASHFT0(0xFFFUL)
++#define L1C_RFD_PIDX_MASK               0xFFFUL
 +#define L1C_RFD_PIDX_SHIFT              0
 +
 +#define L1C_RFD_CIDX                    0x15F8
-+#define L1C_RFD_CIDX_MASK               ASHFT0(0xFFFUL)
++#define L1C_RFD_CIDX_MASK               0xFFFUL
 +#define L1C_RFD_CIDX_SHIFT              0
 +
 +#define L1C_RXQ0                        0x15A0
@@ -2925,13 +2878,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_RXQ0_CUT_THRU_EN            BIT(30)
 +#define L1C_RXQ0_RSS_HASH_EN            BIT(29)
 +#define L1C_RXQ0_NON_IP_QTBL            BIT(28)  /* 0:q0,1:table */
-+#define L1C_RXQ0_RSS_MODE_MASK          ASHFT26(3UL)
++#define L1C_RXQ0_RSS_MODE_MASK          0x3UL
 +#define L1C_RXQ0_RSS_MODE_SHIFT         26
 +#define L1C_RXQ0_RSS_MODE_DIS           0
 +#define L1C_RXQ0_RSS_MODE_SQSI          1
 +#define L1C_RXQ0_RSS_MODE_MQSI          2
 +#define L1C_RXQ0_RSS_MODE_MQMI          3
-+#define L1C_RXQ0_NUM_RFD_PREF_MASK      ASHFT20(0x3FUL)
++#define L1C_RXQ0_NUM_RFD_PREF_MASK      0x3FUL
 +#define L1C_RXQ0_NUM_RFD_PREF_SHIFT     20
 +#define L1C_RXQ0_NUM_RFD_PREF_DEF       8
 +#define L1C_RXQ0_RSS_HSTYP_IPV6_TCP_EN  BIT(19)
@@ -2943,11 +2896,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	L1C_RXQ0_RSS_HSTYP_IPV4_TCP_EN  |\
 +	L1C_RXQ0_RSS_HSTYP_IPV6_EN      |\
 +	L1C_RXQ0_RSS_HSTYP_IPV4_EN)
-+#define L1C_RXQ0_IDT_TBL_SIZE_MASK      ASHFT8(0xFFUL)
++#define L1C_RXQ0_IDT_TBL_SIZE_MASK      0xFFUL
 +#define L1C_RXQ0_IDT_TBL_SIZE_SHIFT     8
 +#define L1C_RXQ0_IDT_TBL_SIZE_DEF       0x80
 +#define L1C_RXQ0_IPV6_PARSE_EN          BIT(7)
-+#define L1C_RXQ0_ASPM_THRESH_MASK       ASHFT0(3UL)
++#define L1C_RXQ0_ASPM_THRESH_MASK       0x3UL
 +#define L1C_RXQ0_ASPM_THRESH_SHIFT      0
 +#define L1C_RXQ0_ASPM_THRESH_NO         0
 +#define L1C_RXQ0_ASPM_THRESH_1M         1
@@ -2955,40 +2908,46 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_RXQ0_ASPM_THRESH_100M       3
 +
 +#define L1C_RXQ1                        0x15A4
-+#define L1C_RXQ1_RFD_PREF_DOWN_MASK     ASHFT6(0x3FUL)
++#define L1C_RXQ1_RFD_PREF_DOWN_MASK     0x3FUL
 +#define L1C_RXQ1_RFD_PREF_DOWN_SHIFT    6
-+#define L1C_RXQ1_RFD_PREF_UP_MASK       ASHFT0(0x3FUL)
++#define L1C_RXQ1_RFD_PREF_UP_MASK       0x3FUL
 +#define L1C_RXQ1_RFD_PREF_UP_SHIFT      0
 +
 +#define L1C_RXQ2                        0x15A8
 +/* XOFF: USED SRAM LOWER THAN IT, THEN NOTIFY THE PEER TO SEND AGAIN */
-+#define L1C_RXQ2_RXF_XOFF_THRESH_MASK   ASHFT16(0xFFFUL)
++#define L1C_RXQ2_RXF_XOFF_THRESH_MASK   0xFFFUL
 +#define L1C_RXQ2_RXF_XOFF_THRESH_SHIFT  16
-+#define L1C_RXQ2_RXF_XON_THRESH_MASK    ASHFT0(0xFFFUL)
++#define L1C_RXQ2_RXF_XON_THRESH_MASK    0xFFFUL
 +#define L1C_RXQ2_RXF_XON_THRESH_SHIFT   0
++/*
++* Size = tx-packet(1522) + IPG(12) + SOF(8) + 64(Pause) + IPG(12) + SOF(8) +
++*        rx-packet(1522) + delay-of-link(64)
++*      = 3212.
++*/
++#define L1C_RXQ2_RXF_FLOW_CTRL_RSVD		3212
 +
 +#define L1C_RXQ3                        0x15AC
-+#define L1C_RXQ3_RXD_TIMER_MASK         ASHFT16(0xFFFFUL)
++#define L1C_RXQ3_RXD_TIMER_MASK         0xFFFFUL
 +#define L1C_RXQ3_RXD_TIMER_SHIFT        16
-+#define L1C_RXQ3_RXD_THRESH_MASK        ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1C_RXQ3_RXD_THRESH_MASK        0xFFFUL /* 8BYTES UNIT */
 +#define L1C_RXQ3_RXD_THRESH_SHIFT       0
 +
 +#define L1C_DMA                         0x15C0
 +#define L1C_DMA_WPEND_CLR               BIT(30)
 +#define L1C_DMA_RPEND_CLR               BIT(29)
-+#define L1C_DMA_WDLY_CNT_MASK           ASHFT16(0xFUL)
++#define L1C_DMA_WDLY_CNT_MASK           0xFUL
 +#define L1C_DMA_WDLY_CNT_SHIFT          16
 +#define L1C_DMA_WDLY_CNT_DEF            4
-+#define L1C_DMA_RDLY_CNT_MASK           ASHFT11(0x1FUL)
++#define L1C_DMA_RDLY_CNT_MASK           0x1FUL
 +#define L1C_DMA_RDLY_CNT_SHIFT          11
 +#define L1C_DMA_RDLY_CNT_DEF            15
 +#define L1C_DMA_RREQ_PRI_DATA           BIT(10)      /* 0:tpd, 1:data */
-+#define L1C_DMA_WREQ_BLEN_MASK          ASHFT7(7UL)
++#define L1C_DMA_WREQ_BLEN_MASK          0x7UL
 +#define L1C_DMA_WREQ_BLEN_SHIFT         7
-+#define L1C_DMA_RREQ_BLEN_MASK          ASHFT4(7UL)
++#define L1C_DMA_RREQ_BLEN_MASK          0x7UL
 +#define L1C_DMA_RREQ_BLEN_SHIFT         4
 +#define L1C_DMA_RCB_LEN128              BIT(3)   /* 0:64bytes,1:128bytes */
-+#define L1C_DMA_RORDER_MODE_MASK        ASHFT0(7UL)
++#define L1C_DMA_RORDER_MODE_MASK        0x7UL
 +#define L1C_DMA_RORDER_MODE_SHIFT       0
 +#define L1C_DMA_RORDER_MODE_OUT         4
 +#define L1C_DMA_RORDER_MODE_ENHANCE     2
@@ -3141,13 +3100,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* Cable-Detect-Test Control Register */
 +#define L1C_MII_CDTC                        0x16
 +#define L1C_CDTC_EN                         1       /* sc */
-+#define L1C_CDTC_PAIR_MASK                  ASHFT8(3U)
++#define L1C_CDTC_PAIR_MASK                  0x3U
 +#define L1C_CDTC_PAIR_SHIFT                 8
 +
 +
 +/* Cable-Detect-Test Status Register */
 +#define L1C_MII_CDTS                        0x1C
-+#define L1C_CDTS_STATUS_MASK                ASHFT8(3U)
++#define L1C_CDTS_STATUS_MASK                0x3U
 +#define L1C_CDTS_STATUS_SHIFT               8
 +#define L1C_CDTS_STATUS_NORMAL              0
 +#define L1C_CDTS_STATUS_SHORT               1
@@ -3160,114 +3119,113 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/***************************** debug port *************************************/
 +
 +#define L1C_MIIDBG_ANACTRL                  0x00
-+#define L1C_ANACTRL_CLK125M_DELAY_EN        BIT(15)
-+#define L1C_ANACTRL_VCO_FAST                BIT(14)
-+#define L1C_ANACTRL_VCO_SLOW                BIT(13)
-+#define L1C_ANACTRL_AFE_MODE_EN             BIT(12)
-+#define L1C_ANACTRL_LCKDET_PHY              BIT(11)
-+#define L1C_ANACTRL_LCKDET_EN               BIT(10)
-+#define L1C_ANACTRL_OEN_125M                BIT(9)
-+#define L1C_ANACTRL_HBIAS_EN                BIT(8)
-+#define L1C_ANACTRL_HB_EN                   BIT(7)
-+#define L1C_ANACTRL_SEL_HSP                 BIT(6)
-+#define L1C_ANACTRL_CLASSA_EN               BIT(5)
-+#define L1C_ANACTRL_MANUSWON_SWR_MASK       ASHFT2(3U)
++#define L1C_ANACTRL_CLK125M_DELAY_EN        0x8000
++#define L1C_ANACTRL_VCO_FAST                0x4000
++#define L1C_ANACTRL_VCO_SLOW                0x2000
++#define L1C_ANACTRL_AFE_MODE_EN             0x1000
++#define L1C_ANACTRL_LCKDET_PHY              0x0800
++#define L1C_ANACTRL_LCKDET_EN               0x0400
++#define L1C_ANACTRL_OEN_125M                0x0200
++#define L1C_ANACTRL_HBIAS_EN                0x0100
++#define L1C_ANACTRL_HB_EN                   0x0080
++#define L1C_ANACTRL_SEL_HSP                 0x0040
++#define L1C_ANACTRL_CLASSA_EN               0x0020
++#define L1C_ANACTRL_MANUSWON_SWR_MASK       0x3U
 +#define L1C_ANACTRL_MANUSWON_SWR_SHIFT      2
 +#define L1C_ANACTRL_MANUSWON_SWR_2V         0
 +#define L1C_ANACTRL_MANUSWON_SWR_1P9V       1
 +#define L1C_ANACTRL_MANUSWON_SWR_1P8V       2
 +#define L1C_ANACTRL_MANUSWON_SWR_1P7V       3
-+#define L1C_ANACTRL_MANUSWON_BW3_4M         BIT(1)
-+#define L1C_ANACTRL_RESTART_CAL             BIT(0)
++#define L1C_ANACTRL_MANUSWON_BW3_4M         0x0002
++#define L1C_ANACTRL_RESTART_CAL             0x0001
 +#define L1C_ANACTRL_DEF                     0x02EF
 +
 +
 +#define L1C_MIIDBG_SYSMODCTRL               0x04
-+#define L1C_SYSMODCTRL_IECHOADJ_PFMH_PHY    BIT(15)
-+#define L1C_SYSMODCTRL_IECHOADJ_BIASGEN     BIT(14)
-+#define L1C_SYSMODCTRL_IECHOADJ_PFML_PHY    BIT(13)
-+#define L1C_SYSMODCTRL_IECHOADJ_PS_MASK     ASHFT10(3U)
++#define L1C_SYSMODCTRL_IECHOADJ_PFMH_PHY    0x8000
++#define L1C_SYSMODCTRL_IECHOADJ_BIASGEN     0x4000
++#define L1C_SYSMODCTRL_IECHOADJ_PFML_PHY    0x2000
++#define L1C_SYSMODCTRL_IECHOADJ_PS_MASK     0x3U
 +#define L1C_SYSMODCTRL_IECHOADJ_PS_SHIFT    10
 +#define L1C_SYSMODCTRL_IECHOADJ_PS_40       3
 +#define L1C_SYSMODCTRL_IECHOADJ_PS_20       2
 +#define L1C_SYSMODCTRL_IECHOADJ_PS_0        1
-+#define L1C_SYSMODCTRL_IECHOADJ_10BT_100MV  BIT(6) /* 1:100mv, 0:200mv */
-+#define L1C_SYSMODCTRL_IECHOADJ_HLFAP_MASK  ASHFT4(3U)
++#define L1C_SYSMODCTRL_IECHOADJ_10BT_100MV  0x0040 /* 1:100mv, 0:200mv */
++#define L1C_SYSMODCTRL_IECHOADJ_HLFAP_MASK  0x3U
 +#define L1C_SYSMODCTRL_IECHOADJ_HLFAP_SHIFT 4
-+#define L1C_SYSMODCTRL_IECHOADJ_VDFULBW     BIT(3)
-+#define L1C_SYSMODCTRL_IECHOADJ_VDBIASHLF   BIT(2)
-+#define L1C_SYSMODCTRL_IECHOADJ_VDAMPHLF    BIT(1)
-+#define L1C_SYSMODCTRL_IECHOADJ_VDLANSW     BIT(0)
-+#define L1C_SYSMODCTRL_IECHOADJ_DEF         0x88BB /* ???? */
-+
++#define L1C_SYSMODCTRL_IECHOADJ_VDFULBW     0x0008
++#define L1C_SYSMODCTRL_IECHOADJ_VDBIASHLF   0x0004
++#define L1C_SYSMODCTRL_IECHOADJ_VDAMPHLF    0x0002
++#define L1C_SYSMODCTRL_IECHOADJ_VDLANSW     0x0001
++#define L1C_SYSMODCTRL_IECHOADJ_DEF         0xBB8B /* en half bias */
 +
 +
 +#define L1D_MIIDBG_SYSMODCTRL               0x04    /* l1d & l2cb */
-+#define L1D_SYSMODCTRL_IECHOADJ_CUR_ADD     BIT(15)
-+#define L1D_SYSMODCTRL_IECHOADJ_CUR_MASK    ASHFT12(7U)
++#define L1D_SYSMODCTRL_IECHOADJ_CUR_ADD     0x8000
++#define L1D_SYSMODCTRL_IECHOADJ_CUR_MASK    0x7U
 +#define L1D_SYSMODCTRL_IECHOADJ_CUR_SHIFT   12
-+#define L1D_SYSMODCTRL_IECHOADJ_VOL_MASK    ASHFT8(0xFU)
++#define L1D_SYSMODCTRL_IECHOADJ_VOL_MASK    0xFU
 +#define L1D_SYSMODCTRL_IECHOADJ_VOL_SHIFT   8
 +#define L1D_SYSMODCTRL_IECHOADJ_VOL_17ALL   3
 +#define L1D_SYSMODCTRL_IECHOADJ_VOL_100M15  1
 +#define L1D_SYSMODCTRL_IECHOADJ_VOL_10M17   0
-+#define L1D_SYSMODCTRL_IECHOADJ_BIAS1_MASK  ASHFT4(0xFU)
++#define L1D_SYSMODCTRL_IECHOADJ_BIAS1_MASK  0xFU
 +#define L1D_SYSMODCTRL_IECHOADJ_BIAS1_SHIFT 4
-+#define L1D_SYSMODCTRL_IECHOADJ_BIAS2_MASK  ASHFT0(0xFU)
++#define L1D_SYSMODCTRL_IECHOADJ_BIAS2_MASK  0xFU
 +#define L1D_SYSMODCTRL_IECHOADJ_BIAS2_SHIFT 0
 +#define L1D_SYSMODCTRL_IECHOADJ_DEF         0x4FBB
 +
 +
 +#define L1C_MIIDBG_SRDSYSMOD                0x05
-+#define L1C_SRDSYSMOD_LCKDET_EN             BIT(13)
-+#define L1C_SRDSYSMOD_PLL_EN                BIT(11)
-+#define L1C_SRDSYSMOD_SEL_HSP               BIT(10)
-+#define L1C_SRDSYSMOD_HLFTXDR               BIT(9)
-+#define L1C_SRDSYSMOD_TXCLK_DELAY_EN        BIT(8)
-+#define L1C_SRDSYSMOD_TXELECIDLE            BIT(7)
-+#define L1C_SRDSYSMOD_DEEMP_EN              BIT(6)
-+#define L1C_SRDSYSMOD_MS_PAD                BIT(2)
-+#define L1C_SRDSYSMOD_CDR_ADC_VLTG          BIT(1)
-+#define L1C_SRDSYSMOD_CDR_DAC_1MA           BIT(0)
++#define L1C_SRDSYSMOD_LCKDET_EN             0x2000
++#define L1C_SRDSYSMOD_PLL_EN                0x0800
++#define L1C_SRDSYSMOD_SEL_HSP               0x0400
++#define L1C_SRDSYSMOD_HLFTXDR               0x0200
++#define L1C_SRDSYSMOD_TXCLK_DELAY_EN        0x0100
++#define L1C_SRDSYSMOD_TXELECIDLE            0x0080
++#define L1C_SRDSYSMOD_DEEMP_EN              0x0040
++#define L1C_SRDSYSMOD_MS_PAD                0x0004
++#define L1C_SRDSYSMOD_CDR_ADC_VLTG          0x0002
++#define L1C_SRDSYSMOD_CDR_DAC_1MA           0x0001
 +#define L1C_SRDSYSMOD_DEF                   0x2C46
 +
 +#define L1C_MIIDBG_CFGLPSPD                 0x0A
-+#define L1C_CFGLPSPD_RSTCNT_MASK            ASHFT(3U)
++#define L1C_CFGLPSPD_RSTCNT_MASK            0x3U
 +#define L1C_CFGLPSPD_RSTCNT_SHIFT           14
-+#define L1C_CFGLPSPD_RSTCNT_CLK125SW        BIT(13)
++#define L1C_CFGLPSPD_RSTCNT_CLK125SW        0x2000
 +
 +#define L1C_MIIDBG_HIBNEG                   0x0B
-+#define L1C_HIBNEG_PSHIB_EN                 BIT(15)
-+#define L1C_HIBNEG_WAKE_BOTH                BIT(14)
-+#define L1C_HIBNEG_ONOFF_ANACHG_SUDEN       BIT(13)
-+#define L1C_HIBNEG_HIB_PULSE                BIT(12)
-+#define L1C_HIBNEG_GATE_25M_EN              BIT(11)
-+#define L1C_HIBNEG_RST_80U                  BIT(10)
-+#define L1C_HIBNEG_RST_TIMER_MASK           ASHFT8(3U)
++#define L1C_HIBNEG_PSHIB_EN                 0x8000
++#define L1C_HIBNEG_WAKE_BOTH                0x4000
++#define L1C_HIBNEG_ONOFF_ANACHG_SUDEN       0x2000
++#define L1C_HIBNEG_HIB_PULSE                0x1000
++#define L1C_HIBNEG_GATE_25M_EN              0x0800
++#define L1C_HIBNEG_RST_80U                  0x0400
++#define L1C_HIBNEG_RST_TIMER_MASK           0x3U
 +#define L1C_HIBNEG_RST_TIMER_SHIFT          8
-+#define L1C_HIBNEG_GTX_CLK_DELAY_MASK       ASHFT5(3U)
++#define L1C_HIBNEG_GTX_CLK_DELAY_MASK       0x3U
 +#define L1C_HIBNEG_GTX_CLK_DELAY_SHIFT      5
-+#define L1C_HIBNEG_BYPSS_BRKTIMER           BIT(4)
++#define L1C_HIBNEG_BYPSS_BRKTIMER           0x0010
 +#define L1C_HIBNEG_DEF                      0xBC40
 +
 +#define L1C_MIIDBG_TST10BTCFG               0x12
-+#define L1C_TST10BTCFG_INTV_TIMER_MASK      ASHFT14(3U)
++#define L1C_TST10BTCFG_INTV_TIMER_MASK      0x3U
 +#define L1C_TST10BTCFG_INTV_TIMER_SHIFT     14
-+#define L1C_TST10BTCFG_TRIGER_TIMER_MASK    ASHFT12(3U)
++#define L1C_TST10BTCFG_TRIGER_TIMER_MASK    0x3U
 +#define L1C_TST10BTCFG_TRIGER_TIMER_SHIFT   12
-+#define L1C_TST10BTCFG_DIV_MAN_MLT3_EN      BIT(11)
-+#define L1C_TST10BTCFG_OFF_DAC_IDLE         BIT(10)
-+#define L1C_TST10BTCFG_LPBK_DEEP            BIT(2) /* 1:deep,0:shallow */
++#define L1C_TST10BTCFG_DIV_MAN_MLT3_EN      0x0800
++#define L1C_TST10BTCFG_OFF_DAC_IDLE         0x0400
++#define L1C_TST10BTCFG_LPBK_DEEP            0x0004 /* 1:deep,0:shallow */
 +#define L1C_TST10BTCFG_DEF                  0x4C04
 +
 +#define L1C_MIIDBG_AZ_ANADECT               0x15
-+#define L1C_AZ_ANADECT_10BTRX_TH            BIT(15)
-+#define L1C_AZ_ANADECT_BOTH_01CHNL          BIT(14)
-+#define L1C_AZ_ANADECT_INTV_MASK            ASHFT8(0x3FU)
++#define L1C_AZ_ANADECT_10BTRX_TH            0x8000
++#define L1C_AZ_ANADECT_BOTH_01CHNL          0x4000
++#define L1C_AZ_ANADECT_INTV_MASK            0x3FU
 +#define L1C_AZ_ANADECT_INTV_SHIFT           8
-+#define L1C_AZ_ANADECT_THRESH_MASK          ASHFT4(0xFU)
++#define L1C_AZ_ANADECT_THRESH_MASK          0xFU
 +#define L1C_AZ_ANADECT_THRESH_SHIFT         4
-+#define L1C_AZ_ANADECT_CHNL_MASK            ASHFT0(0xFU)
++#define L1C_AZ_ANADECT_CHNL_MASK            0xFU
 +#define L1C_AZ_ANADECT_CHNL_SHIFT           0
 +#define L1C_AZ_ANADECT_DEF                  0x3220
 +#define L1C_AZ_ANADECT_LONG                 0xb210
@@ -3278,43 +3236,43 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +#define L1C_MIIDBG_LEGCYPS                  0x29
-+#define L1C_LEGCYPS_EN                      BIT(15)
-+#define L1C_LEGCYPS_DAC_AMP1000_MASK        ASHFT12(7U)
++#define L1C_LEGCYPS_EN                      0x8000
++#define L1C_LEGCYPS_DAC_AMP1000_MASK        0x7U
 +#define L1C_LEGCYPS_DAC_AMP1000_SHIFT       12
-+#define L1C_LEGCYPS_DAC_AMP100_MASK         ASHFT9(7U)
++#define L1C_LEGCYPS_DAC_AMP100_MASK         0x7U
 +#define L1C_LEGCYPS_DAC_AMP100_SHIFT        9
-+#define L1C_LEGCYPS_DAC_AMP10_MASK          ASHFT6(7U)
++#define L1C_LEGCYPS_DAC_AMP10_MASK          0x7U
 +#define L1C_LEGCYPS_DAC_AMP10_SHIFT         6
-+#define L1C_LEGCYPS_UNPLUG_TIMER_MASK       ASHFT3(7U)
++#define L1C_LEGCYPS_UNPLUG_TIMER_MASK       0x7U
 +#define L1C_LEGCYPS_UNPLUG_TIMER_SHIFT      3
-+#define L1C_LEGCYPS_UNPLUG_DECT_EN          BIT(2)
-+#define L1C_LEGCYPS_ECNC_PS_EN              BIT(0)
++#define L1C_LEGCYPS_UNPLUG_DECT_EN          0x0004
++#define L1C_LEGCYPS_ECNC_PS_EN              0x0001
 +#define L1D_LEGCYPS_DEF                     0x129D
 +#define L1C_LEGCYPS_DEF                     0x36DD
 +
 +#define L1C_MIIDBG_TST100BTCFG              0x36
-+#define L1C_TST100BTCFG_NORMAL_BW_EN        BIT(15)
-+#define L1C_TST100BTCFG_BADLNK_BYPASS       BIT(14)
-+#define L1C_TST100BTCFG_SHORTCABL_TH_MASK   ASHFT8(0x3FU)
++#define L1C_TST100BTCFG_NORMAL_BW_EN        0x8000
++#define L1C_TST100BTCFG_BADLNK_BYPASS       0x4000
++#define L1C_TST100BTCFG_SHORTCABL_TH_MASK   0x3FU
 +#define L1C_TST100BTCFG_SHORTCABL_TH_SHIFT  8
-+#define L1C_TST100BTCFG_LITCH_EN            BIT(7)
-+#define L1C_TST100BTCFG_VLT_SW              BIT(6)
-+#define L1C_TST100BTCFG_LONGCABL_TH_MASK    ASHFT0(0x3FU)
++#define L1C_TST100BTCFG_LITCH_EN            0x0080
++#define L1C_TST100BTCFG_VLT_SW              0x0040
++#define L1C_TST100BTCFG_LONGCABL_TH_MASK    0x3FU
 +#define L1C_TST100BTCFG_LONGCABL_TH_SHIFT   0
 +#define L1C_TST100BTCFG_DEF                 0xE12C
 +
 +#define L1C_MIIDBG_VOLT_CTRL                0x3B
-+#define L1C_VOLT_CTRL_CABLE1TH_MASK         ASHFT7(0x1FFU)
++#define L1C_VOLT_CTRL_CABLE1TH_MASK         0x1FFU
 +#define L1C_VOLT_CTRL_CABLE1TH_SHIFT        7
-+#define L1C_VOLT_CTRL_AMPCTRL_MASK          ASHFT5(3U)
++#define L1C_VOLT_CTRL_AMPCTRL_MASK          0x3U
 +#define L1C_VOLT_CTRL_AMPCTRL_SHIFT         5
-+#define L1C_VOLT_CTRL_SW_BYPASS             BIT(4)
-+#define L1C_VOLT_CTRL_SWLOWEST              BIT(3)
-+#define L1C_VOLT_CTRL_DACAMP10_MASK         ASHFT0(7U)
++#define L1C_VOLT_CTRL_SW_BYPASS             0x0010
++#define L1C_VOLT_CTRL_SWLOWEST              0x0008
++#define L1C_VOLT_CTRL_DACAMP10_MASK         0x7U
 +#define L1C_VOLT_CTRL_DACAMP10_SHIFT        0
 +
 +#define L1C_MIIDBG_CABLE1TH_DET             0x3E
-+#define L1C_CABLE1TH_DET_EN                 BIT(15)
++#define L1C_CABLE1TH_DET_EN                 0x8000
 +
 +/***************************** extension **************************************/
 +
@@ -3322,46 +3280,46 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MIIEXT_PCS                      3
 +
 +#define L1C_MIIEXT_CLDCTRL3                 0x8003
-+#define L1C_CLDCTRL3_BP_CABLE1TH_DET_GT     BIT(15)
-+#define L1C_CLDCTRL3_AZ_DISAMP              BIT(12)
++#define L1C_CLDCTRL3_BP_CABLE1TH_DET_GT     0x8000
++#define L1C_CLDCTRL3_AZ_DISAMP              0x1000
 +#define L1C_CLDCTRL3_L2CB                   0x4D19
 +#define L1C_CLDCTRL3_L1D                    0xDD19
 +
 +#define L1C_MIIEXT_CLDCTRL6                 0x8006
-+#define L1C_CLDCTRL6_CAB_LEN_MASK           ASHFT0(0x1FFU)
++#define L1C_CLDCTRL6_CAB_LEN_MASK           0x1FFU
 +#define L1C_CLDCTRL6_CAB_LEN_SHIFT          0
 +#define L1C_CLDCTRL6_CAB_LEN_SHORT          0x50
 +
 +#define L1C_MIIEXT_CLDCTRL7                 0x8007
-+#define L1C_CLDCTRL7_VDHLF_BIAS_TH_MASK     ASHFT9(0x7FU)
++#define L1C_CLDCTRL7_VDHLF_BIAS_TH_MASK     0x7FU
 +#define L1C_CLDCTRL7_VDHLF_BIAS_TH_SHIFT    9
-+#define L1C_CLDCTRL7_AFE_AZ_MASK            ASHFT4(0x1FU)
++#define L1C_CLDCTRL7_AFE_AZ_MASK            0x1FU
 +#define L1C_CLDCTRL7_AFE_AZ_SHIFT           4
-+#define L1C_CLDCTRL7_SIDE_PEAK_TH_MASK      ASHFT0(0xFU)
++#define L1C_CLDCTRL7_SIDE_PEAK_TH_MASK      0xFU
 +#define L1C_CLDCTRL7_SIDE_PEAK_TH_SHIFT     0
 +#define L1C_CLDCTRL7_DEF                    0x6BF6 /* ???? */
 +#define L1C_CLDCTRL7_FPGA_DEF               0x0005
 +#define L1C_CLDCTRL7_L2CB                   0x0175
 +
 +#define L1C_MIIEXT_AZCTRL                   0x8008
-+#define L1C_AZCTRL_SHORT_TH_MASK            ASHFT8(0xFFU)
++#define L1C_AZCTRL_SHORT_TH_MASK            0xFFU
 +#define L1C_AZCTRL_SHORT_TH_SHIFT           8
-+#define L1C_AZCTRL_LONG_TH_MASK             ASHFT0(0xFFU)
++#define L1C_AZCTRL_LONG_TH_MASK             0xFFU
 +#define L1C_AZCTRL_LONG_TH_SHIFT            0
 +#define L1C_AZCTRL_DEF                      0x1629
 +#define L1C_AZCTRL_FPGA_DEF                 0x101D
 +#define L1C_AZCTRL_L1D                      0x2034
 +
 +#define L1C_MIIEXT_AZCTRL2                  0x8009
-+#define L1C_AZCTRL2_WAKETRNING_MASK         ASHFT8(0xFFU)
++#define L1C_AZCTRL2_WAKETRNING_MASK         0xFFU
 +#define L1C_AZCTRL2_WAKETRNING_SHIFT        8
-+#define L1C_AZCTRL2_QUIET_TIMER_MASH        ASHFT6(3U)
++#define L1C_AZCTRL2_QUIET_TIMER_MASH        0x3U
 +#define L1C_AZCTRL2_QUIET_TIMER_SHIFT       6
-+#define L1C_AZCTRL2_PHAS_JMP2               BIT(4)
-+#define L1C_AZCTRL2_CLKTRCV_125MD16         BIT(3)
-+#define L1C_AZCTRL2_GATE1000_EN             BIT(2)
-+#define L1C_AZCTRL2_AVRG_FREQ               BIT(1)
-+#define L1C_AZCTRL2_PHAS_JMP4               BIT(0)
++#define L1C_AZCTRL2_PHAS_JMP2               0x0010
++#define L1C_AZCTRL2_CLKTRCV_125MD16         0x0008
++#define L1C_AZCTRL2_GATE1000_EN             0x0004
++#define L1C_AZCTRL2_AVRG_FREQ               0x0002
++#define L1C_AZCTRL2_PHAS_JMP4               0x0001
 +#define L1C_AZCTRL2_DEF                     0x32C0
 +#define L1C_AZCTRL2_FPGA_DEF                0x40C8
 +#define L1C_AZCTRL2_L2CB                    0xE003
@@ -3383,16 +3341,16 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1C_MIIEXT_ANEG                     7
 +
 +#define L1C_MIIEXT_LOCAL_EEEADV             0x3C
-+#define L1C_LOCAL_EEEADV_1000BT             BIT(2)
-+#define L1C_LOCAL_EEEADV_100BT              BIT(1)
++#define L1C_LOCAL_EEEADV_1000BT             0x0004
++#define L1C_LOCAL_EEEADV_100BT              0x0002
 +
 +#define L1C_MIIEXT_REMOTE_EEEADV            0x3D
-+#define L1C_REMOTE_EEEADV_1000BT            BIT(2)
-+#define L1C_REMOTE_EEEADV_100BT             BIT(1)
++#define L1C_REMOTE_EEEADV_1000BT            0x0004
++#define L1C_REMOTE_EEEADV_100BT             0x0002
 +
 +#define L1C_MIIEXT_EEE_ANEG                 0x8000
-+#define L1C_EEE_ANEG_1000M                  BIT(2)
-+#define L1C_EEE_ANEG_100M                   BIT(1)
++#define L1C_EEE_ANEG_1000M                  0x0004
++#define L1C_EEE_ANEG_100M                   0x0002
 +
 +
 +
@@ -3406,7 +3364,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1c_get_perm_macaddr(struct alx_hw *hw, u8 *addr);
++int l1c_get_perm_macaddr(struct alx_hw *hw, u8 *addr);
 +
 +
 +/* reset mac & dma
@@ -3414,14 +3372,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *     0: success
 + *     non-0:fail
 + */
-+u16 l1c_reset_mac(struct alx_hw *hw);
++int l1c_reset_mac(struct alx_hw *hw);
 +
 +/* reset phy
 + * return
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1c_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en);
++int l1c_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en);
 +
 +
 +/* reset pcie
@@ -3430,7 +3388,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0:fail
 + */
-+u16 l1c_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en);
++int l1c_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en);
 +
 +
 +/* disable/enable MAC/RXQ/TXQ
@@ -3441,12 +3399,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0-fail
 + */
-+u16 l1c_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl);
++int l1c_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl);
 +
 +/* enable/disable aspm support
 + * that will change settings for phy/mac/pcie
 + */
-+u16 l1c_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat);
++int l1c_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat);
 +
 +
 +/* initialize phy for speed / flow control
@@ -3454,12 +3412,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    if autoNeg, is link capability to tell the peer
 + *    if force mode, is forced speed/duplex
 + */
-+u16 l1c_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
++int l1c_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
 +		       u8 lnk_cap, bool fc_en);
 +
 +/* do post setting on phy if link up/down event occur
 + */
-+u16 l1c_post_phy_link(struct alx_hw *hw, bool linkon, u8 wire_spd);
++int l1c_post_phy_link(struct alx_hw *hw, bool az_en, bool linkon, u8 wire_spd);
 +
 +
 +/* do power saving setting befor enter suspend mode
@@ -3467,31 +3425,31 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    1. phy link must be established before calling this function
 + *    2. wol option (pattern,magic,link,etc.) is configed before call it.
 + */
-+u16 l1c_powersaving(struct alx_hw *hw, u8 wire_spd, bool wol_en,
++int l1c_powersaving(struct alx_hw *hw, u8 wire_spd, bool wol_en,
 +		    bool mac_txen, bool mac_rxen, bool pws_en);
 +
 +
 +/* read phy register */
-+u16 l1c_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast, u16 reg,
++int l1c_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast, u16 reg,
 +		 u16 *data);
 +
 +/* write phy register */
-+u16 l1c_write_phy(struct alx_hw *hw, bool ext, u8 dev,  bool fast, u16 reg,
++int l1c_write_phy(struct alx_hw *hw, bool ext, u8 dev,  bool fast, u16 reg,
 +		  u16 data);
 +
 +/* phy debug port */
-+u16 l1c_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data);
-+u16 l1c_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data);
++int l1c_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data);
++int l1c_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data);
 +
 +/* check the configuration of the PHY */
-+u16 l1c_get_phy_config(struct alx_hw *hw);
++int l1c_get_phy_config(struct alx_hw *hw);
 +
 +/*
 + * initialize mac basically
 + *  most of hi-feature no init
 + *      MAC/PHY should be reset before call this function
 + */
-+u16 l1c_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
++int l1c_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
 +		 u32 *tx_mem_lo, u8 tx_qnum, u16 txring_sz,
 +		 u32 rxmem_hi, u32 rfdmem_lo, u32 rrdmem_lo,
 +		 u16 rxring_sz, u16 rxbuf_sz, u16 smb_timer,
@@ -3500,10 +3458,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +#endif/*L1C_HW_H_*/
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alf_cb.c b/drivers/net/ethernet/atheros/alx/alf_cb.c
+new file mode 100644
+index 0000000..119dc94
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alf_cb.c
-@@ -0,0 +1,1187 @@
+@@ -0,0 +1,1110 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -3519,12 +3479,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 + */
++
 +#include <linux/pci_regs.h>
 +#include <linux/mii.h>
++#include <linux/netdevice.h>
++#include <linux/crc32.h>
 +
 +#include "alf_hw.h"
 +
-+
 +#define ALF_REV_ID_AR8161_B0            0x10
 +
 +/* definition for MSIX */
@@ -3598,11 +3560,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	spin_lock_irqsave(&hw->mdio_lock, flags);
 +
-+	if (l1f_read_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, false, reg_addr,
-+			 phy_data)) {
-+		alx_hw_err(hw, "error when read phy reg\n");
-+		retval = -EINVAL;
-+	}
++	retval = l1f_read_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, hw->link_up,
++			      reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u when read phy reg\n", retval);
 +
 +	spin_unlock_irqrestore(&hw->mdio_lock, flags);
 +	return retval;
@@ -3616,11 +3577,45 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	spin_lock_irqsave(&hw->mdio_lock, flags);
 +
-+	if (l1f_write_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, false, reg_addr,
-+			  phy_data)) {
-+		alx_hw_err(hw, "error when write phy reg\n");
-+		retval = -EINVAL;
-+	}
++	retval = l1f_write_phy(hw, false, ALX_MDIO_DEV_TYPE_NORM, hw->link_up,
++			       reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error;%u, when write phy reg\n", retval);
++
++	spin_unlock_irqrestore(&hw->mdio_lock, flags);
++	return retval;
++}
++
++
++static int alf_read_ext_phy_reg(struct alx_hw *hw, u8 type, u16 reg_addr,
++				u16 *phy_data)
++{
++	unsigned long  flags;
++	int  retval = 0;
++
++	spin_lock_irqsave(&hw->mdio_lock, flags);
++
++	retval = l1f_read_phy(hw, true, type, false, reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u, when read ext phy reg\n", retval);
++
++	spin_unlock_irqrestore(&hw->mdio_lock, flags);
++	return retval;
++}
++
++
++static int alf_write_ext_phy_reg(struct alx_hw *hw, u8 type, u16 reg_addr,
++				 u16 phy_data)
++{
++	unsigned long  flags;
++	int  retval = 0;
++
++	spin_lock_irqsave(&hw->mdio_lock, flags);
++
++	retval = l1f_write_phy(hw, true, type, false, reg_addr, phy_data);
++	if (retval)
++		alx_hw_err(hw, "error:%u, when write ext phy reg\n", retval);
++
 +
 +	spin_unlock_irqrestore(&hw->mdio_lock, flags);
 +	return retval;
@@ -3642,11 +3637,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		return retval;
 +	memcpy(&hw->phy_id, phy_id, sizeof(hw->phy_id));
 +
-+	hw->autoneg_advertised = ALX_LINK_SPEED_1GB_FULL |
-+				 ALX_LINK_SPEED_10_HALF  |
-+				 ALX_LINK_SPEED_10_FULL  |
-+				 ALX_LINK_SPEED_100_HALF |
-+				 ALX_LINK_SPEED_100_FULL;
++	hw->autoneg_advertised = LX_LC_ALL;
++
 +	return retval;
 +}
 +
@@ -3654,62 +3646,39 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +static int alf_reset_phy(struct alx_hw *hw)
 +{
 +	int retval = 0;
-+	bool pws_en, az_en, ptp_en;
 +
-+	pws_en = az_en = ptp_en = false;
 +	CLI_HW_FLAG(PWSAVE_EN);
 +	CLI_HW_FLAG(AZ_EN);
 +	CLI_HW_FLAG(PTP_EN);
 +
-+	if (CHK_HW_FLAG(PWSAVE_CAP)) {
-+		pws_en = true;
++	if (CHK_HW_FLAG(PWSAVE_CAP))
 +		SET_HW_FLAG(PWSAVE_EN);
-+	}
 +
-+	if (CHK_HW_FLAG(AZ_CAP)) {
-+		az_en = true;
++	if (CHK_HW_FLAG(AZ_CAP))
 +		SET_HW_FLAG(AZ_EN);
-+	}
 +
-+	if (CHK_HW_FLAG(PTP_CAP)) {
-+		ptp_en = true;
++	if (CHK_HW_FLAG(PTP_CAP))
 +		SET_HW_FLAG(PTP_EN);
-+	}
 +
-+	alx_hw_info(hw, "reset PHY, pws = %d, az = %d, ptp = %d\n",
-+		    pws_en, az_en, ptp_en);
-+	if (l1f_reset_phy(hw, pws_en, az_en, ptp_en)) {
++	retval = l1f_reset_phy(hw, CHK_HW_FLAG(PWSAVE_EN), CHK_HW_FLAG(AZ_EN),
++			       CHK_HW_FLAG(PTP_EN));
++	if (retval)
 +		alx_hw_err(hw, "error when reset phy\n");
-+		retval = -EINVAL;
-+	}
++
 +	return retval;
 +}
 +
 +
 +/* LINK */
-+static int alf_setup_phy_link(struct alx_hw *hw, u32 speed, bool autoneg,
++static int alf_setup_phy_link(struct alx_hw *hw, u8 speed, bool autoneg,
 +			      bool fc)
 +{
-+	u8 link_cap = 0;
 +	int retval = 0;
 +
-+	alx_hw_info(hw, "speed = 0x%x, autoneg = %d\n", speed, autoneg);
-+	if (speed & ALX_LINK_SPEED_1GB_FULL)
-+		link_cap |= LX_LC_1000F;
-+
-+	if (speed & ALX_LINK_SPEED_100_FULL)
-+		link_cap |= LX_LC_100F;
-+
-+	if (speed & ALX_LINK_SPEED_100_HALF)
-+		link_cap |= LX_LC_100H;
++	if (!CHK_HW_FLAG(GIGA_CAP))
++		speed &= ~LX_LC_1000F;
 +
-+	if (speed & ALX_LINK_SPEED_10_FULL)
-+		link_cap |= LX_LC_10F;
-+
-+	if (speed & ALX_LINK_SPEED_10_HALF)
-+		link_cap |= LX_LC_10H;
-+
-+	if (l1f_init_phy_spdfc(hw, autoneg, link_cap, fc)) {
++	if (l1f_init_phy_spdfc(hw, autoneg, speed, fc)) {
 +		alx_hw_err(hw, "error when init phy speed and fc\n");
 +		retval = -EINVAL;
 +	}
@@ -3718,36 +3687,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alf_setup_phy_link_speed(struct alx_hw *hw, u32 speed,
-+				    bool autoneg, bool fc)
-+{
-+	/*
-+	 * Clear autoneg_advertised and set new values based on input link
-+	 * speed.
-+	 */
-+	hw->autoneg_advertised = 0;
-+
-+	if (speed & ALX_LINK_SPEED_1GB_FULL)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_1GB_FULL;
-+
-+	if (speed & ALX_LINK_SPEED_100_FULL)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_100_FULL;
-+
-+	if (speed & ALX_LINK_SPEED_100_HALF)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_100_HALF;
-+
-+	if (speed & ALX_LINK_SPEED_10_FULL)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_10_FULL;
-+
-+	if (speed & ALX_LINK_SPEED_10_HALF)
-+		hw->autoneg_advertised |= ALX_LINK_SPEED_10_HALF;
-+
-+	return alf_setup_phy_link(hw, hw->autoneg_advertised,
-+				  autoneg, fc);
-+}
-+
-+
-+static int alf_check_phy_link(struct alx_hw *hw, u32 *speed, bool *link_up)
++static int alf_check_phy_link(struct alx_hw *hw, u8 *speed, bool *link_up)
 +{
 +	u16 bmsr, giga;
 +	int retval;
@@ -3759,8 +3699,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	if (!(bmsr & BMSR_LSTATUS)) {
 +		*link_up = false;
-+		*speed = ALX_LINK_SPEED_UNKNOWN;
-+		return 0;
++		*speed = 0;
++		return retval;
 +	}
 +	*link_up = true;
 +
@@ -3778,30 +3718,35 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	switch (giga & L1F_GIGA_PSSR_SPEED) {
 +	case L1F_GIGA_PSSR_1000MBS:
 +		if (giga & L1F_GIGA_PSSR_DPLX)
-+			*speed = ALX_LINK_SPEED_1GB_FULL;
++			*speed = LX_LC_1000F;
 +		else
-+			alx_hw_err(hw, "1000M half is invalid");
++			alx_hw_err(hw, "1000M half is invalid\n");
 +		break;
 +	case L1F_GIGA_PSSR_100MBS:
 +		if (giga & L1F_GIGA_PSSR_DPLX)
-+			*speed = ALX_LINK_SPEED_100_FULL;
++			*speed = LX_LC_100F;
 +		else
-+			*speed = ALX_LINK_SPEED_100_HALF;
++			*speed = LX_LC_100H;
 +		break;
 +	case L1F_GIGA_PSSR_10MBS:
 +		if (giga & L1F_GIGA_PSSR_DPLX)
-+			*speed = ALX_LINK_SPEED_10_FULL;
++			*speed = LX_LC_10F;
 +		else
-+			*speed = ALX_LINK_SPEED_10_HALF;
++			*speed = LX_LC_10H;
 +		break;
 +	default:
-+		*speed = ALX_LINK_SPEED_UNKNOWN;
++		*speed = 0;
 +		retval = -EINVAL;
 +		break;
 +	}
 +	return retval;
 +}
 +
++static int alf_post_phy_link(struct alx_hw *hw, bool az_en,
++			     bool link_up, u8 speed)
++{
++	return l1f_post_phy_link(hw, az_en, link_up, speed);
++}
 +
 +/*
 + * 1. stop_mac
@@ -3813,10 +3758,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	int retval = 0;
 +
-+	if (l1f_reset_mac(hw)) {
-+		alx_hw_err(hw, "error when reset mac\n");
-+		retval = -EINVAL;
-+	}
++	retval = l1f_reset_mac(hw);
++	if (retval)
++		alx_hw_err(hw, "error(%d) when reset mac\n", retval);
++
 +	return retval;
 +}
 +
@@ -3828,11 +3773,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	/* set link speed param */
 +	switch (hw->link_speed) {
-+	case ALX_LINK_SPEED_1GB_FULL:
++	case LX_LC_1000F:
 +		en_ctrl |= LX_MACSPEED_1000;
 +		/* fall through */
-+	case ALX_LINK_SPEED_100_FULL:
-+	case ALX_LINK_SPEED_10_FULL:
++	case LX_LC_100F:
++	case LX_LC_10F:
 +		en_ctrl |= LX_MACDUPLEX_FULL;
 +		break;
 +	}
@@ -3857,20 +3802,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		en_ctrl |= LX_SINGLE_PAUSE;
 +
 +	en_ctrl |= LX_FLT_DIRECT;    /* RX Enable; and TX Always Enable */
-+	en_ctrl |= LX_FLT_BROADCAST; /* RX Broadcast Enable */
 +	en_ctrl |= LX_ADD_FCS;
 +
-+	if (CHK_HW_FLAG(VLANSTRIP_EN))
-+		en_ctrl |= LX_VLAN_STRIP;
-+
-+	if (CHK_HW_FLAG(PROMISC_EN))
-+		en_ctrl |=  LX_FLT_PROMISC;
-+
-+	if (CHK_HW_FLAG(MULTIALL_EN))
-+		en_ctrl |= LX_FLT_MULTI_ALL;
-+
-+	if (CHK_HW_FLAG(LOOPBACK_EN))
-+		en_ctrl |= LX_LOOPBACK;
++	en_ctrl |= hw->flags & ALX_HW_FLAG_LX_MASK;
 +
 +	if (l1f_enable_mac(hw, true, en_ctrl)) {
 +		alx_hw_err(hw, "error when start mac\n");
@@ -3886,67 +3820,28 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + */
 +static int alf_stop_mac(struct alx_hw *hw)
 +{
-+	int retval = 0;
-+
 +	if (l1f_enable_mac(hw, false, 0)) {
 +		alx_hw_err(hw, "error when stop mac\n");
-+		retval = -EINVAL;
++		return -EINVAL;
 +	}
-+	return retval;
++	return 0;
 +}
 +
 +
-+static int alf_config_mac(struct alx_hw *hw, u16 rxbuf_sz, u16 rx_qnum,
++static int alf_init_mac(struct alx_hw *hw, u16 rxbuf_sz, u16 rx_qnum,
 +			  u16 rxring_sz, u16 tx_qnum,  u16 txring_sz)
 +{
-+	u8 *addr;
-+	u32 txmem_hi, txmem_lo[4];
-+	u32 rxmem_hi, rfdmem_lo, rrdmem_lo;
-+	u16 smb_timer, mtu_with_eth, int_mod;
-+	bool hash_legacy;
-+	int i;
-+	int retval = 0;
-+
-+	addr = hw->mac_addr;
-+
-+	txmem_hi = ALX_DMA_ADDR_HI(hw->tpdma[0]);
-+	for (i = 0; i < tx_qnum; i++)
-+		txmem_lo[i] = ALX_DMA_ADDR_LO(hw->tpdma[i]);
-+
-+
-+	rxmem_hi  = ALX_DMA_ADDR_HI(hw->rfdma[0]);
-+	rfdmem_lo = ALX_DMA_ADDR_LO(hw->rfdma[0]);
-+	rrdmem_lo = ALX_DMA_ADDR_LO(hw->rrdma[0]);
-+
-+	smb_timer = (u16)hw->smb_timer;
-+	mtu_with_eth = hw->mtu + ALX_ETH_LENGTH_OF_HEADER;
-+	int_mod = hw->imt;
-+
-+	hash_legacy = true;
++	int retval;
 +
-+	if (l1f_init_mac(hw, addr, txmem_hi, txmem_lo, tx_qnum, txring_sz,
-+			 rxmem_hi, rfdmem_lo, rrdmem_lo, rxring_sz, rxbuf_sz,
-+			 smb_timer, mtu_with_eth, int_mod, hash_legacy)) {
++	retval = l1f_init_mac(hw, hw->mac_addr, hw->dma.tpdmem_hi[0],
++			      hw->dma.tpdmem_lo, tx_qnum, txring_sz,
++			      hw->dma.rfdmem_hi[0], hw->dma.rfdmem_lo[0],
++			      hw->dma.rrdmem_lo[0], rxring_sz, rxbuf_sz,
++			      hw->smb_timer, hw->mtu + ALX_ETH_LENGTH_OF_HEADER,
++			      hw->imt_mod, true);
++	if (retval)
 +		alx_hw_err(hw, "error when config mac\n");
-+		retval = -EINVAL;
-+	}
-+
-+	return retval;
-+}
-+
-+
-+/**
-+ *  alf_get_mac_addr
-+ *  @hw: pointer to hardware structure
-+ **/
-+static int alf_get_mac_addr(struct alx_hw *hw, u8 *addr)
-+{
-+	int retval = 0;
 +
-+	if (l1f_get_perm_macaddr(hw, addr)) {
-+		alx_hw_err(hw, "error when get permanent mac address\n");
-+		retval = -EINVAL;
-+	}
 +	return retval;
 +}
 +
@@ -4032,64 +3927,38 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alf_config_mac_ctrl(struct alx_hw *hw)
++static void alf_update_mac_filter(struct alx_hw *hw)
 +{
 +	u32 mac;
++	u32 flg_hw_map[] = {
++		ALX_HW_FLAG_BROADCAST_EN, L1F_MAC_CTRL_BRD_EN,
++		ALX_HW_FLAG_VLANSTRIP_EN, L1F_MAC_CTRL_VLANSTRIP,
++		ALX_HW_FLAG_PROMISC_EN, L1F_MAC_CTRL_PROMISC_EN,
++		ALX_HW_FLAG_MULTIALL_EN, L1F_MAC_CTRL_MULTIALL_EN,
++		ALX_HW_FLAG_LOOPBACK_EN, L1F_MAC_CTRL_LPBACK_EN
++		};
++	int i;
 +
-+	alx_mem_r32(hw, L1F_MAC_CTRL, &mac);
-+
-+	/* enable/disable VLAN tag insert,strip */
-+	if (CHK_HW_FLAG(VLANSTRIP_EN))
-+		mac |= L1F_MAC_CTRL_VLANSTRIP;
-+	else
-+		mac &= ~L1F_MAC_CTRL_VLANSTRIP;
-+
-+	if (CHK_HW_FLAG(PROMISC_EN))
-+		mac |= L1F_MAC_CTRL_PROMISC_EN;
-+	else
-+		mac &= ~L1F_MAC_CTRL_PROMISC_EN;
 +
-+	if (CHK_HW_FLAG(MULTIALL_EN))
-+		mac |= L1F_MAC_CTRL_MULTIALL_EN;
-+	else
-+		mac &= ~L1F_MAC_CTRL_MULTIALL_EN;
++	alx_mem_r32(hw, L1F_MAC_CTRL, &mac);
 +
-+	if (CHK_HW_FLAG(LOOPBACK_EN))
-+		mac |= L1F_MAC_CTRL_LPBACK_EN;
-+	else
-+		mac &= ~L1F_MAC_CTRL_LPBACK_EN;
++	for (i = 0; i < ARRAY_SIZE(flg_hw_map); i += 2) {
++		if (hw->flags & flg_hw_map[i])
++			mac |= flg_hw_map[i + 1];
++		else
++			mac &= ~flg_hw_map[i + 1];
++	}
 +
 +	alx_mem_w32(hw, L1F_MAC_CTRL, mac);
-+	return 0;
 +}
 +
 +
-+static int alf_config_pow_save(struct alx_hw *hw, u32 speed, bool wol_en,
++static int alf_config_pow_save(struct alx_hw *hw, u8 speed, bool wol_en,
 +			       bool tx_en, bool rx_en, bool pws_en)
 +{
-+	u8 wire_spd = LX_LC_10H;
 +	int retval = 0;
 +
-+	switch (speed) {
-+	case ALX_LINK_SPEED_UNKNOWN:
-+	case ALX_LINK_SPEED_10_HALF:
-+		wire_spd = LX_LC_10H;
-+		break;
-+	case ALX_LINK_SPEED_10_FULL:
-+		wire_spd = LX_LC_10F;
-+		break;
-+	case ALX_LINK_SPEED_100_HALF:
-+		wire_spd = LX_LC_100H;
-+		break;
-+	case ALX_LINK_SPEED_100_FULL:
-+		wire_spd = LX_LC_100F;
-+		break;
-+	case ALX_LINK_SPEED_1GB_FULL:
-+		wire_spd = LX_LC_1000F;
-+		break;
-+	}
-+
-+	if (l1f_powersaving(hw, wire_spd, wol_en, tx_en, rx_en, pws_en)) {
++	if (l1f_powersaving(hw, speed, wol_en, tx_en, rx_en, pws_en)) {
 +		alx_hw_err(hw, "error when set power saving\n");
 +		retval = -EINVAL;
 +	}
@@ -4098,7 +3967,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* RAR, Multicast, VLAN */
-+static int alf_set_mac_addr(struct alx_hw *hw, u8 *addr)
++static void alf_set_mac_addr(struct alx_hw *hw, u8 *addr)
 +{
 +	u32 sta;
 +
@@ -4108,14 +3977,24 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	 */
 +
 +	/* low dword */
-+	sta = (((u32)addr[2]) << 24) | (((u32)addr[3]) << 16) |
-+	      (((u32)addr[4]) << 8)  | (((u32)addr[5])) ;
++	sta = addr[2] << 24 | addr[3] << 16 | addr[4] << 8  | addr[5];
 +	alx_mem_w32(hw, L1F_STAD0, sta);
 +
 +	/* hight dword */
-+	sta = (((u32)addr[0]) << 8) | (((u32)addr[1])) ;
++	sta = addr[0] << 8 | addr[1];
 +	alx_mem_w32(hw, L1F_STAD1, sta);
-+	return 0;
++}
++
++
++static int alf_get_mac_addr(struct alx_hw *hw, u8 *addr)
++{
++	int retval = 0;
++
++	if (l1f_get_perm_macaddr(hw, addr)) {
++		alx_hw_err(hw, "error when get permanent mac address\n");
++		retval = -EINVAL;
++	}
++	return retval;
 +}
 +
 +
@@ -4158,7 +4037,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* RTX, IRQ */
-+static int alf_config_tx(struct alx_hw *hw)
++static void alf_config_tx(struct alx_hw *hw)
 +{
 +	u32 wrr;
 +
@@ -4182,7 +4061,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	FIELD_SETL(wrr, L1F_WRR_PRI2, hw->wrr_prio2);
 +	FIELD_SETL(wrr, L1F_WRR_PRI3, hw->wrr_prio3);
 +	alx_mem_w32(hw, L1F_WRR, wrr);
-+	return 0;
 +}
 +
 +
@@ -4513,7 +4391,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* ethtool */
-+static int alf_get_ethtool_regs(struct alx_hw *hw, void *buff)
++static void alf_get_ethtool_regs(struct alx_hw *hw, void *buff)
 +{
 +	int i;
 +	u32 *val = buff;
@@ -4588,7 +4466,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* MIB */
 +	for (i = 0; i < 48; i++)
 +		alx_mem_r32(hw, ALF_MIB(i, u32), &val[170 + i]);
-+	return 0;
 +}
 +
 +
@@ -4598,11 +4475,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	SET_HW_FLAG(L0S_CAP);
 +	SET_HW_FLAG(L1_CAP);
 +
-+	if (hw->mac_type == alx_mac_l1f)
++	if (hw->mac_type == alx_mac_l1f || hw->mac_type == alx_mac_l1h)
 +		SET_HW_FLAG(GIGA_CAP);
 +
 +	/* set flags of alx_phy_info */
 +	SET_HW_FLAG(PWSAVE_CAP);
++
++	SET_HW_FLAG(BROADCAST_EN);
 +	return 0;
 +}
 +
@@ -4645,55 +4524,62 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	hw->cbs.reset_mac      = &alf_reset_mac;
 +	hw->cbs.start_mac      = &alf_start_mac;
 +	hw->cbs.stop_mac       = &alf_stop_mac;
-+	hw->cbs.config_mac     = &alf_config_mac;
++	hw->cbs.init_mac       = &alf_init_mac;
 +	hw->cbs.get_mac_addr   = &alf_get_mac_addr;
 +	hw->cbs.set_mac_addr   = &alf_set_mac_addr;
 +	hw->cbs.set_mc_addr    = &alf_set_mc_addr;
 +	hw->cbs.clear_mc_addr  = &alf_clear_mc_addr;
 +
 +	/* PHY */
-+	hw->cbs.init_phy          = &alf_init_phy;
-+	hw->cbs.reset_phy         = &alf_reset_phy;
-+	hw->cbs.read_phy_reg      = &alf_read_phy_reg;
-+	hw->cbs.write_phy_reg     = &alf_write_phy_reg;
-+	hw->cbs.check_phy_link    = &alf_check_phy_link;
-+	hw->cbs.setup_phy_link    = &alf_setup_phy_link;
-+	hw->cbs.setup_phy_link_speed = &alf_setup_phy_link_speed;
++	hw->cbs.init_phy       = &alf_init_phy;
++	hw->cbs.reset_phy      = &alf_reset_phy;
++	hw->cbs.read_phy_reg   = &alf_read_phy_reg;
++	hw->cbs.write_phy_reg  = &alf_write_phy_reg;
++	hw->cbs.check_phy_link = &alf_check_phy_link;
++	hw->cbs.setup_phy_link = &alf_setup_phy_link;
++	hw->cbs.post_phy_link  = &alf_post_phy_link;
 +
 +	/* Interrupt */
-+	hw->cbs.ack_phy_intr		= &alf_ack_phy_intr;
-+	hw->cbs.enable_legacy_intr	= &alf_enable_legacy_intr;
-+	hw->cbs.disable_legacy_intr	= &alf_disable_legacy_intr;
-+	hw->cbs.enable_msix_intr	= &alf_enable_msix_intr;
-+	hw->cbs.disable_msix_intr	= &alf_disable_msix_intr;
++	hw->cbs.ack_phy_intr        = &alf_ack_phy_intr;
++	hw->cbs.enable_legacy_intr  = &alf_enable_legacy_intr;
++	hw->cbs.disable_legacy_intr = &alf_disable_legacy_intr;
++	hw->cbs.enable_msix_intr    = &alf_enable_msix_intr;
++	hw->cbs.disable_msix_intr   = &alf_disable_msix_intr;
 +
 +	/* Configure */
-+	hw->cbs.config_tx	= &alf_config_tx;
-+	hw->cbs.config_fc	= &alf_config_fc;
-+	hw->cbs.config_rss	= &alf_config_rss;
-+	hw->cbs.config_msix	= &alf_config_msix;
-+	hw->cbs.config_wol	= &alf_config_wol;
-+	hw->cbs.config_aspm	= &alf_config_aspm;
-+	hw->cbs.config_mac_ctrl	= &alf_config_mac_ctrl;
-+	hw->cbs.config_pow_save	= &alf_config_pow_save;
-+	hw->cbs.reset_pcie	= &alf_reset_pcie;
++	hw->cbs.config_tx         = &alf_config_tx;
++	hw->cbs.config_fc         = &alf_config_fc;
++	hw->cbs.config_rss        = &alf_config_rss;
++	hw->cbs.config_msix       = &alf_config_msix;
++	hw->cbs.config_wol        = &alf_config_wol;
++	hw->cbs.config_aspm       = &alf_config_aspm;
++	hw->cbs.update_mac_filter = &alf_update_mac_filter;
++	hw->cbs.config_pow_save	  = &alf_config_pow_save;
++	hw->cbs.reset_pcie	  = &alf_reset_pcie;
 +
 +	/* NVRam */
-+	hw->cbs.check_nvram	= &alf_check_nvram;
++	hw->cbs.check_nvram = &alf_check_nvram;
 +
 +	/* Others */
 +	hw->cbs.get_ethtool_regs = alf_get_ethtool_regs;
 +
++#ifdef CONFIG_ALX_DEBUGFS
++	hw->cbs.read_ext_phy_reg  = &alf_read_ext_phy_reg;
++	hw->cbs.write_ext_phy_reg = &alf_write_ext_phy_reg;
++#endif
++
 +	alf_set_hw_capabilities(hw);
 +	alf_set_hw_infos(hw);
 +
 +	alx_hw_info(hw, "HW Flags = 0x%x\n", hw->flags);
 +	return 0;
 +}
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alf_hw.c b/drivers/net/ethernet/atheros/alx/alf_hw.c
+new file mode 100644
+index 0000000..2e178f0
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alf_hw.c
-@@ -0,0 +1,918 @@
+@@ -0,0 +1,1028 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -4712,6 +4598,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#include <linux/pci_regs.h>
 +#include <linux/mii.h>
++#include <linux/netdevice.h>
++#include <linux/etherdevice.h>
 +
 +#include "alf_hw.h"
 +
@@ -4720,7 +4608,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1f_get_perm_macaddr(struct alx_hw *hw, u8 *addr)
++int l1f_get_perm_macaddr(struct alx_hw *hw, u8 *addr)
 +{
 +	u32 val, mac0, mac1;
 +	u16 flag, i;
@@ -4737,10 +4625,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_mem_r32(hw, L1F_STAD0, &mac0);
 +	alx_mem_r32(hw, L1F_STAD1, &mac1);
 +
-+	*(u32 *)(addr + 2) = LX_SWAP_DW(mac0);
-+	*(u16 *)addr = (u16)LX_SWAP_W((u16)mac1);
++	/* addr should be big-endian */
++	*(__be32 *)(addr + 2) = cpu_to_be32(mac0);
++	*(__be16 *)addr = cpu_to_be16((u16)mac1);
 +
-+	if (macaddr_valid(addr))
++	if (is_valid_ether_addr(addr))
 +		return 0;
 +
 +	if ((flag & INTN_LOADED) == 0) {
@@ -4804,10 +4693,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *     0: success
 + *     non-0:fail
 + */
-+u16 l1f_reset_mac(struct alx_hw *hw)
++int l1f_reset_mac(struct alx_hw *hw)
 +{
 +	u32 val, pmctrl = 0;
-+	u16 ret;
++	int ret;
 +	u16 i;
 +	u8 rev = (u8)(FIELD_GETX(hw->pci_revid, L1F_PCI_REVID));
 +
@@ -4895,9 +4784,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1f_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en)
++int l1f_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en)
 +{
-+	u32 val;
++	int val;
 +	u16 i, phy_val;
 +
 +	az_en = az_en;
@@ -4936,13 +4825,32 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* rtl8139c, 120m */
 +	l1f_write_phy(hw, true, L1F_MIIEXT_ANEG, true,
 +		      L1F_MIIEXT_NLP78, L1F_MIIEXT_NLP78_120M_DEF);
++	l1f_write_phy(hw, true, L1F_MIIEXT_ANEG, true,
++		      L1F_MIIEXT_S3DIG10, L1F_MIIEXT_S3DIG10_DEF);
++
++	if (hw->msi_lnkpatch) {
++		/* Turn off half amplitude */
++		l1f_read_phy(hw, true, L1F_MIIEXT_PCS, true,
++			     L1F_MIIEXT_CLDCTRL3, &phy_val);
++		l1f_write_phy(hw, true, L1F_MIIEXT_PCS, true,
++			      L1F_MIIEXT_CLDCTRL3,
++			      phy_val | L1F_CLDCTRL3_BP_CABLE1TH_DET_GT);
++		/* Turn off Green feature */
++		l1f_read_phydbg(hw, true, L1F_MIIDBG_GREENCFG2, &phy_val);
++		l1f_write_phydbg(hw, true, L1F_MIIDBG_GREENCFG2,
++				 phy_val | L1F_GREENCFG2_BP_GREEN);
++		/* Turn off half Bias */
++		l1f_read_phy(hw, true, L1F_MIIEXT_PCS, true,
++			     L1F_MIIEXT_CLDCTRL5, &phy_val);
++		l1f_write_phy(hw, true, L1F_MIIEXT_PCS, true,
++			      L1F_MIIEXT_CLDCTRL5,
++			      phy_val | L1F_CLDCTRL5_BP_VD_HLFBIAS);
++	}
 +
 +	/* set phy interrupt mask */
 +	l1f_write_phy(hw, false, 0, true,
 +		      L1F_MII_IER, L1F_IER_LINK_UP | L1F_IER_LINK_DOWN);
 +
-+
-+	/* TODO *****???? */
 +	return 0;
 +}
 +
@@ -4953,23 +4861,17 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0:fail
 + */
-+u16 l1f_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en)
++int l1f_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en)
 +{
 +	u32 val;
 +	u16 val16;
-+	u16 ret;
++	int ret;
 +	u8 rev = (u8)(FIELD_GETX(hw->pci_revid, L1F_PCI_REVID));
 +
 +	/* Workaround for PCI problem when BIOS sets MMRBC incorrectly. */
 +	alx_cfg_r16(hw, PCI_COMMAND, &val16);
-+	if ((val16 & (PCI_COMMAND_IO |
-+		      PCI_COMMAND_MEMORY |
-+		      PCI_COMMAND_MASTER)) == 0 ||
-+	    (val16 & PCI_COMMAND_INTX_DISABLE) != 0) {
-+		val16 = (u16)((val16 | (PCI_COMMAND_IO |
-+					PCI_COMMAND_MEMORY |
-+					PCI_COMMAND_MASTER))
-+			      & ~PCI_COMMAND_INTX_DISABLE);
++	if (!(val16 & ALX_PCI_CMD) || (val16 & PCI_COMMAND_INTX_DISABLE)) {
++		val16 = (val16 | ALX_PCI_CMD) & ~PCI_COMMAND_INTX_DISABLE;
 +		alx_cfg_w16(hw, PCI_COMMAND, val16);
 +	}
 +
@@ -5021,10 +4923,23 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0-fail
 + */
-+u16 l1f_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl)
++int l1f_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl)
 +{
 +	u32 rxq, txq, mac, val;
 +	u16 i;
++	u32 ctrl_hw_map[] = {
++		LX_MACDUPLEX_FULL, L1F_MAC_CTRL_FULLD,
++		LX_FLT_PROMISC, L1F_MAC_CTRL_PROMISC_EN,
++		LX_FLT_MULTI_ALL, L1F_MAC_CTRL_MULTIALL_EN,
++		LX_FLT_BROADCAST, L1F_MAC_CTRL_BRD_EN,
++		LX_FLT_DIRECT, L1F_MAC_CTRL_RX_EN,
++		LX_FC_TXEN, L1F_MAC_CTRL_TXFC_EN,
++		LX_FC_RXEN, L1F_MAC_CTRL_RXFC_EN,
++		LX_VLAN_STRIP, L1F_MAC_CTRL_VLANSTRIP,
++		LX_LOOPBACK, L1F_MAC_CTRL_LPBACK_EN,
++		LX_SINGLE_PAUSE, L1F_MAC_CTRL_SPAUSE_EN,
++		LX_ADD_FCS, (L1F_MAC_CTRL_PCRCE | L1F_MAC_CTRL_CRCE)
++	};
 +
 +	alx_mem_r32(hw, L1F_RXQ0, &rxq);
 +	alx_mem_r32(hw, L1F_TXQ0, &txq);
@@ -5040,31 +4955,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			FIELD_SETL(mac, L1F_MAC_CTRL_SPEED,
 +				   L1F_MAC_CTRL_SPEED_10_100);
 +		}
-+
-+		test_set_or_clear(mac, en_ctrl, LX_MACDUPLEX_FULL,
-+				  L1F_MAC_CTRL_FULLD);
-+		/* rx filter */
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_PROMISC,
-+				  L1F_MAC_CTRL_PROMISC_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_MULTI_ALL,
-+				  L1F_MAC_CTRL_MULTIALL_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_BROADCAST,
-+				  L1F_MAC_CTRL_BRD_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FLT_DIRECT,
-+				  L1F_MAC_CTRL_RX_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FC_TXEN,
-+				  L1F_MAC_CTRL_TXFC_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_FC_RXEN,
-+				  L1F_MAC_CTRL_RXFC_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_VLAN_STRIP,
-+				  L1F_MAC_CTRL_VLANSTRIP);
-+		test_set_or_clear(mac, en_ctrl, LX_LOOPBACK,
-+				  L1F_MAC_CTRL_LPBACK_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_SINGLE_PAUSE,
-+				  L1F_MAC_CTRL_SPAUSE_EN);
-+		test_set_or_clear(mac, en_ctrl, LX_ADD_FCS,
-+				  (L1F_MAC_CTRL_PCRCE | L1F_MAC_CTRL_CRCE));
-+
++		for (i = 0; i < ARRAY_SIZE(ctrl_hw_map); i += 2) {
++			if (en_ctrl & ctrl_hw_map[i])
++				mac |= ctrl_hw_map[i + 1];
++			else
++				mac &= ~ctrl_hw_map[i + 1];
++		}
 +		alx_mem_w32(hw, L1F_MAC_CTRL, mac | L1F_MAC_CTRL_TX_EN);
 +	} else { /* disable mac */
 +		alx_mem_w32(hw, L1F_RXQ0, rxq & ~L1F_RXQ0_EN);
@@ -5093,7 +4989,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* enable/disable aspm support
 + * that will change settings for phy/mac/pcie
 + */
-+u16 l1f_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat)
++int l1f_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat)
 +{
 +	u32 pmctrl;
 +	u8 rev = (u8)(FIELD_GETX(hw->pci_revid, L1F_PCI_REVID));
@@ -5146,12 +5042,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    if autoNeg, is link capability to tell the peer
 + *    if force mode, is forced speed/duplex
 + */
-+u16 l1f_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
++int l1f_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
 +		       u8 lnk_cap, bool fc_en)
 +{
 +	u16 adv, giga, cr;
 +	u32 val;
-+	u16 ret;
++	int ret;
 +
 +	/* clear flag */
 +	l1f_write_phy(hw, false, 0, false, L1F_MII_DBG_ADDR, 0);
@@ -5229,12 +5125,112 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
++/*
++ * do post setting on phy if link up/down event occur
++ */
++int l1f_post_phy_link(struct alx_hw *hw, bool az_en, bool linkon, u8 wire_spd)
++{
++	u16 phy_val, len, agc;
++	u8 revid = FIELD_GETX(hw->pci_revid, L1F_PCI_REVID);
++	bool adj_th;
++
++
++	if (revid != L1F_REV_B0 &&
++	    revid != L1F_REV_A1 &&
++	    revid != L1F_REV_A0) {
++		return 0;
++	}
++	adj_th = (revid == L1F_REV_B0) ? true : false;
++
++	/* 1000BT/AZ, wrong cable length */
++	if (linkon) {
++		l1f_read_phy(hw, true, L1F_MIIEXT_PCS, true,
++			     L1F_MIIEXT_CLDCTRL6, &phy_val);
++		len = FIELD_GETX(phy_val, L1F_CLDCTRL6_CAB_LEN);
++		l1f_read_phydbg(hw, true, L1F_MIIDBG_AGC, &phy_val);
++		agc = FIELD_GETX(phy_val, L1F_AGC_2_VGA);
++
++		if ((wire_spd == LX_LC_1000F &&
++		    (len > L1F_CLDCTRL6_CAB_LEN_SHORT1G ||
++		    (0 == len && agc > L1F_AGC_LONG1G_LIMT))) ||
++		    ((wire_spd == LX_LC_100F || wire_spd == LX_LC_100H) &&
++		    (len > L1F_CLDCTRL6_CAB_LEN_SHORT100M ||
++		    (0 == len && agc > L1F_AGC_LONG100M_LIMT)))) {
++			l1f_write_phydbg(hw, true,
++					 L1F_MIIDBG_AZ_ANADECT,
++					 L1F_AZ_ANADECT_LONG);
++			l1f_read_phy(hw, true,
++				     L1F_MIIEXT_ANEG, true,
++				     L1F_MIIEXT_AFE, &phy_val);
++			l1f_write_phy(hw, true,
++				      L1F_MIIEXT_ANEG, true, L1F_MIIEXT_AFE,
++				      phy_val | L1F_AFE_10BT_100M_TH);
++		} else {
++			l1f_write_phydbg(hw, true,
++					 L1F_MIIDBG_AZ_ANADECT,
++					 L1F_AZ_ANADECT_DEF);
++			l1f_read_phy(hw, true,
++				     L1F_MIIEXT_ANEG, true,
++				     L1F_MIIEXT_AFE, &phy_val);
++			l1f_write_phy(hw, true,
++				      L1F_MIIEXT_ANEG, true, L1F_MIIEXT_AFE,
++				      phy_val & ~L1F_AFE_10BT_100M_TH);
++		}
++
++		/* threashold adjust */
++		if (adj_th && hw->msi_lnkpatch) {
++			if (wire_spd == LX_LC_100F || wire_spd == LX_LC_100H) {
++				l1f_write_phydbg(hw, true, L1F_MIIDBG_MSE16DB,
++						 L1F_MSE16DB_UP);
++			} else if (wire_spd == LX_LC_1000F) {
++				/*
++				 * Giga link threshold, raise the tolerance of
++				 * noise 50%
++				 */
++				l1f_read_phydbg(hw, true, L1F_MIIDBG_MSE20DB,
++						&phy_val);
++				FIELD_SETS(phy_val, L1F_MSE20DB_TH,
++					   L1F_MSE20DB_TH_HI);
++				l1f_write_phydbg(hw, true, L1F_MIIDBG_MSE20DB,
++						 phy_val);
++			}
++		}
++		/* phy link-down in 1000BT/AZ mode */
++		if (az_en && revid == L1F_REV_B0 && wire_spd == LX_LC_1000F) {
++			l1f_write_phydbg(hw, true, L1F_MIIDBG_SRDSYSMOD,
++					 L1F_SRDSYSMOD_DEF &
++					 ~L1F_SRDSYSMOD_DEEMP_EN);
++		}
++	} else {
++		l1f_read_phy(hw, true,
++			     L1F_MIIEXT_ANEG, false, L1F_MIIEXT_AFE, &phy_val);
++		l1f_write_phy(hw, true,
++			      L1F_MIIEXT_ANEG, false, L1F_MIIEXT_AFE,
++			      phy_val & ~L1F_AFE_10BT_100M_TH);
++
++		if (adj_th && hw->msi_lnkpatch) {
++			l1f_write_phydbg(hw, true, L1F_MIIDBG_MSE16DB,
++					 L1F_MSE16DB_DOWN);
++			l1f_read_phydbg(hw, true, L1F_MIIDBG_MSE20DB, &phy_val);
++			FIELD_SETS(phy_val, L1F_MSE20DB_TH, L1F_MSE20DB_TH_DEF);
++			l1f_write_phydbg(hw, true, L1F_MIIDBG_MSE20DB, phy_val);
++		}
++		if (az_en && revid == L1F_REV_B0) {
++			l1f_write_phydbg(hw, true, L1F_MIIDBG_SRDSYSMOD,
++					 L1F_SRDSYSMOD_DEF);
++		}
++	}
++
++	return 0;
++}
++
++
 +/* do power saving setting befor enter suspend mode
 + * NOTE:
 + *    1. phy link must be established before calling this function
 + *    2. wol option (pattern,magic,link,etc.) is configed before call it.
 + */
-+u16 l1f_powersaving(struct alx_hw *hw,
++int l1f_powersaving(struct alx_hw *hw,
 +		    u8 wire_spd,
 +		    bool wol_en,
 +		    bool mactx_en,
@@ -5242,7 +5238,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		    bool pws_en)
 +{
 +	u32 master_ctrl, mac_ctrl, phy_ctrl, val;
-+	u16 pm_ctrl, ret = 0;
++	u16 pm_ctrl;
++	int ret = 0;
 +
 +	master_ctrl = 0;
 +	mac_ctrl = 0;
@@ -5283,6 +5280,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		phy_ctrl |= L1F_PHY_CTRL_DSPRST_OUT;
 +		ret = l1f_write_phy(hw, false, 0, false, L1F_MII_IER,
 +				    L1F_IER_LINK_UP);
++		ret = l1f_write_phy(hw, true, L1F_MIIEXT_ANEG, false,
++				    L1F_MIIEXT_S3DIG10, L1F_MIIEXT_S3DIG10_SL);
 +	} else {
 +		ret = l1f_write_phy(hw, false, 0, false, L1F_MII_IER, 0);
 +		phy_ctrl |= (L1F_PHY_CTRL_IDDQ | L1F_PHY_CTRL_POWER_DOWN);
@@ -5307,11 +5306,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* read phy register */
-+u16 l1f_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
++int l1f_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
 +		 u16 reg, u16 *data)
 +{
 +	u32 val;
-+	u16 clk_sel, i, ret = 0;
++	u16 clk_sel, i;
++	int ret = 0;
 +
 +	*data = 0;
 +	clk_sel = fast ?
@@ -5353,11 +5353,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +/* write phy register */
-+u16 l1f_write_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
++int l1f_write_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast,
 +		  u16 reg, u16 data)
 +{
 +	u32 val;
-+	u16 clk_sel, i, ret = 0;
++	u16 clk_sel, i;
++	int ret = 0;
 +
 +	clk_sel = fast ?
 +	    (u16)L1F_MDIO_CLK_SEL_25MD4 : (u16)L1F_MDIO_CLK_SEL_25MD128;
@@ -5395,9 +5396,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return ret;
 +}
 +
-+u16 l1f_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data)
++int l1f_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data)
 +{
-+	u16 ret;
++	int ret;
 +
 +	ret = l1f_write_phy(hw, false, 0, fast, L1F_MII_DBG_ADDR, reg);
 +	ret = l1f_read_phy(hw, false, 0, fast, L1F_MII_DBG_DATA, data);
@@ -5405,9 +5406,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return ret;
 +}
 +
-+u16 l1f_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data)
++int l1f_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data)
 +{
-+	u16 ret;
++	int ret;
 +
 +	ret = l1f_write_phy(hw, false, 0, fast, L1F_MII_DBG_ADDR, reg);
 +	ret = l1f_write_phy(hw, false, 0, fast, L1F_MII_DBG_DATA, data);
@@ -5423,7 +5424,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *  int_mod   : micro-second
 + *  disable RSS as default
 + */
-+u16 l1f_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
++int l1f_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
 +		 u32 *tx_mem_lo, u8 tx_qnum, u16 txring_sz,
 +		 u32 rxmem_hi, u32 rfdmem_lo, u32 rrdmem_lo,
 +		 u16 rxring_sz, u16 rxbuf_sz, u16 smb_timer,
@@ -5436,10 +5437,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_cfg_r16(hw, PCI_DEVICE_ID, &devid);
 +
 +	/* set mac-address */
-+	val = *(u32 *)(addr + 2);
-+	alx_mem_w32(hw, L1F_STAD0, LX_SWAP_DW(val));
-+	val = *(u16 *)addr ;
-+	alx_mem_w32(hw, L1F_STAD1, LX_SWAP_W((u16)val));
++	val = be32_to_cpu(*(__be32 *)(addr + 2));
++	alx_mem_w32(hw, L1F_STAD0, val);
++	val = be16_to_cpu(*(__be16 *)addr) ;
++	alx_mem_w32(hw, L1F_STAD1, val);
 +
 +	/* clear multicast hash table, algrithm */
 +	alx_mem_w32(hw, L1F_HASH_TBL0, 0);
@@ -5548,7 +5549,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	val = FIELD_GETX(val, L1F_SRAM_RXF_LEN) << 3; /* bytes */
 +	if (val > L1F_SRAM_RXF_LEN_8K) {
 +		val16 = L1F_MTU_STD_ALGN >> 3;
-+		val = (val - (2 * L1F_MTU_STD_ALGN + L1F_MTU_MIN)) >> 3;
++		val = (val - L1F_RXQ2_RXF_FLOW_CTRL_RSVD) >> 3;
 +	} else {
 +		val16 = L1F_MTU_STD_ALGN >> 3;
 +		val = (val - L1F_MTU_STD_ALGN) >> 3;
@@ -5562,8 +5563,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	      L1F_RXQ0_RSS_HSTYP_ALL |
 +	      L1F_RXQ0_RSS_HASH_EN |
 +	      L1F_RXQ0_IPV6_PARSE_EN;
-+	if (mtu > L1F_MTU_JUMBO_TH)
-+		val |= L1F_RXQ0_CUT_THRU_EN;
++
 +	if ((devid & 1) != 0) {
 +		FIELD_SETL(val, L1F_RXQ0_ASPM_THRESH,
 +			   L1F_RXQ0_ASPM_THRESH_100M);
@@ -5587,34 +5587,33 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+u16 l1f_get_phy_config(struct alx_hw *hw)
++int l1f_get_phy_config(struct alx_hw *hw)
 +{
 +	u32 val;
 +	u16 phy_val;
 +
 +	alx_mem_r32(hw, L1F_PHY_CTRL, &val);
-+
 +	/* phy in rst */
 +	if ((val & L1F_PHY_CTRL_DSPRST_OUT) == 0)
 +		return LX_DRV_PHY_UNKNOWN;
 +
 +	alx_mem_r32(hw, L1F_DRV, &val);
 +	val = FIELD_GETX(val, LX_DRV_PHY);
-+
 +	if (LX_DRV_PHY_UNKNOWN == val)
 +		return LX_DRV_PHY_UNKNOWN;
 +
 +	l1f_read_phy(hw, false, 0, false, L1F_MII_DBG_ADDR, &phy_val);
-+
 +	if (LX_PHY_INITED == phy_val)
 +		return (u16) val;
 +
 +	return LX_DRV_PHY_UNKNOWN;
 +}
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alf_hw.h b/drivers/net/ethernet/atheros/alx/alf_hw.h
+new file mode 100644
+index 0000000..bcf2b6c
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alf_hw.h
-@@ -0,0 +1,2098 @@
+@@ -0,0 +1,2118 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -5634,62 +5633,53 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#ifndef L1F_HW_H_
 +#define L1F_HW_H_
 +
-+/*********************************************************************
-+ * some reqs for l1f_sw.h
-+ *
-+ * 1. some basic type must be defined if there are not defined by
-+ *    your compiler:
-+ *    u8, u16, u32, bool
-+ *
-+ * 2. PETHCONTEXT difinition should be in l1x_sw.h and it must contain
-+ *    pci_devid & pci_venid
-+ *
-+ *********************************************************************/
-+
 +#include "alx_hwcom.h"
 +
 +/******************************************************************************/
 +#define L1F_DEV_ID                      0x1091
 +#define L2F_DEV_ID                      0x1090
-+
++#define L1F_DEV_AR71ID                  0x10A1
++#define L2F_DEV_AR71ID                  0x10A0
++#define L1F_DEV_BFID                    0xE091  /* for bigfoot */
 +
 +#define L1F_PCI_REVID_WTH_CR            BIT(1)
 +#define L1F_PCI_REVID_WTH_XD            BIT(0)
-+#define L1F_PCI_REVID_MASK              ASHFT3(0x1FU)
++#define L1F_PCI_REVID_MASK              0x1FU
 +#define L1F_PCI_REVID_SHIFT             3
 +#define L1F_REV_A0                      0
 +#define L1F_REV_A1                      1
 +#define L1F_REV_B0                      2
++#define L1F_REV_C0                      3
 +
 +#define L1F_PM_CSR                      0x0044  /* 16bit */
 +#define L1F_PM_CSR_PME_STAT             BIT(15)
-+#define L1F_PM_CSR_DSCAL_MASK           ASHFT13(3U)
++#define L1F_PM_CSR_DSCAL_MASK           0x3U
 +#define L1F_PM_CSR_DSCAL_SHIFT          13
-+#define L1F_PM_CSR_DSEL_MASK            ASHFT9(0xFU)
++#define L1F_PM_CSR_DSEL_MASK            0xFU
 +#define L1F_PM_CSR_DSEL_SHIFT           9
 +#define L1F_PM_CSR_PME_EN               BIT(8)
-+#define L1F_PM_CSR_PWST_MASK            ASHFT0(3U)
++#define L1F_PM_CSR_PWST_MASK            0x3U
 +#define L1F_PM_CSR_PWST_SHIFT           0
 +
 +#define L1F_PM_DATA                     0x0047  /* 8bit */
 +
 +
 +#define L1F_DEV_CAP                     0x005C
-+#define L1F_DEV_CAP_SPLSL_MASK          ASHFT26(3UL)
++#define L1F_DEV_CAP_SPLSL_MASK          0x3UL
 +#define L1F_DEV_CAP_SPLSL_SHIFT         26
-+#define L1F_DEV_CAP_SPLV_MASK           ASHFT18(0xFFUL)
++#define L1F_DEV_CAP_SPLV_MASK           0xFFUL
 +#define L1F_DEV_CAP_SPLV_SHIFT          18
 +#define L1F_DEV_CAP_RBER                BIT(15)
 +#define L1F_DEV_CAP_PIPRS               BIT(14)
 +#define L1F_DEV_CAP_AIPRS               BIT(13)
 +#define L1F_DEV_CAP_ABPRS               BIT(12)
-+#define L1F_DEV_CAP_L1ACLAT_MASK        ASHFT9(7UL)
++#define L1F_DEV_CAP_L1ACLAT_MASK        0x7UL
 +#define L1F_DEV_CAP_L1ACLAT_SHIFT       9
-+#define L1F_DEV_CAP_L0SACLAT_MASK       ASHFT6(7UL)
++#define L1F_DEV_CAP_L0SACLAT_MASK       0x7UL
 +#define L1F_DEV_CAP_L0SACLAT_SHIFT      6
 +#define L1F_DEV_CAP_EXTAG               BIT(5)
 +#define L1F_DEV_CAP_PHANTOM             BIT(4)
-+#define L1F_DEV_CAP_MPL_MASK            ASHFT0(7UL)
++#define L1F_DEV_CAP_MPL_MASK            0x7UL
 +#define L1F_DEV_CAP_MPL_SHIFT           0
 +#define L1F_DEV_CAP_MPL_128             1
 +#define L1F_DEV_CAP_MPL_256             2
@@ -5699,14 +5689,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_DEV_CAP_MPL_4096            6
 +
 +#define L1F_DEV_CTRL                    0x0060    /* 16bit */
-+#define L1F_DEV_CTRL_MAXRRS_MASK        ASHFT12(7U)
++#define L1F_DEV_CTRL_MAXRRS_MASK        0x7U
 +#define L1F_DEV_CTRL_MAXRRS_SHIFT       12
 +#define L1F_DEV_CTRL_MAXRRS_MIN         2
 +#define L1F_DEV_CTRL_NOSNP_EN           BIT(11)
 +#define L1F_DEV_CTRL_AUXPWR_EN          BIT(10)
 +#define L1F_DEV_CTRL_PHANTOM_EN         BIT(9)
 +#define L1F_DEV_CTRL_EXTAG_EN           BIT(8)
-+#define L1F_DEV_CTRL_MPL_MASK           ASHFT5(7U)
++#define L1F_DEV_CTRL_MPL_MASK           0x7U
 +#define L1F_DEV_CTRL_MPL_SHIFT          5
 +#define L1F_DEV_CTRL_RELORD_EN          BIT(4)
 +#define L1F_DEV_CTRL_URR_EN             BIT(3)
@@ -5724,20 +5714,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_DEV_STAT_CERR               BIT(0)
 +
 +#define L1F_LNK_CAP                     0x0064
-+#define L1F_LNK_CAP_PRTNUM_MASK         ASHFT24(0xFFUL)
++#define L1F_LNK_CAP_PRTNUM_MASK         0xFFUL
 +#define L1F_LNK_CAP_PRTNUM_SHIFT        24
 +#define L1F_LNK_CAP_CLK_PM              BIT(18)
-+#define L1F_LNK_CAP_L1EXTLAT_MASK       ASHFT15(7UL)
++#define L1F_LNK_CAP_L1EXTLAT_MASK       0x7UL
 +#define L1F_LNK_CAP_L1EXTLAT_SHIFT      15
-+#define L1F_LNK_CAP_L0SEXTLAT_MASK      ASHFT12(7UL)
++#define L1F_LNK_CAP_L0SEXTLAT_MASK      0x7UL
 +#define L1F_LNK_CAP_L0SEXTLAT_SHIFT     12
-+#define L1F_LNK_CAP_ASPM_SUP_MASK       ASHFT10(3UL)
++#define L1F_LNK_CAP_ASPM_SUP_MASK       0x3UL
 +#define L1F_LNK_CAP_ASPM_SUP_SHIFT      10
 +#define L1F_LNK_CAP_ASPM_SUP_L0S        1
 +#define L1F_LNK_CAP_ASPM_SUP_L0SL1      3
-+#define L1F_LNK_CAP_MAX_LWH_MASK        ASHFT4(0x3FUL)
++#define L1F_LNK_CAP_MAX_LWH_MASK        0x3FUL
 +#define L1F_LNK_CAP_MAX_LWH_SHIFT       4
-+#define L1F_LNK_CAP_MAX_LSPD_MASH       ASHFT0(0xFUL)
++#define L1F_LNK_CAP_MAX_LSPD_MASK       0xFUL
 +#define L1F_LNK_CAP_MAX_LSPD_SHIFT      0
 +
 +#define L1F_LNK_CTRL                    0x0068  /* 16bit */
@@ -5745,7 +5735,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_LNK_CTRL_EXTSYNC            BIT(7)
 +#define L1F_LNK_CTRL_CMNCLK_CFG         BIT(6)
 +#define L1F_LNK_CTRL_RCB_128B           BIT(3)  /* 0:64b,1:128b */
-+#define L1F_LNK_CTRL_ASPM_MASK          ASHFT0(3U)
++#define L1F_LNK_CTRL_ASPM_MASK          0x3U
 +#define L1F_LNK_CTRL_ASPM_SHIFT         0
 +#define L1F_LNK_CTRL_ASPM_DIS           0
 +#define L1F_LNK_CTRL_ASPM_ENL0S         1
@@ -5756,9 +5746,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_LNK_STAT_SCLKCFG            BIT(12)
 +#define L1F_LNK_STAT_LNKTRAIN           BIT(11)
 +#define L1F_LNK_STAT_TRNERR             BIT(10)
-+#define L1F_LNK_STAT_LNKSPD_MASK        ASHFT0(0xFU)
++#define L1F_LNK_STAT_LNKSPD_MASK        0xFU
 +#define L1F_LNK_STAT_LNKSPD_SHIFT       0
-+#define L1F_LNK_STAT_NEGLW_MASK         ASHFT4(0x3FU)
++#define L1F_LNK_STAT_NEGLW_MASK         0x3FU
 +#define L1F_LNK_STAT_NEGLW_SHIFT        4
 +
 +#define L1F_MSIX_MASK                   0x0090
@@ -5778,7 +5768,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_UE_SVRT_TRNERR              BIT(0)
 +
 +#define L1F_EFLD                        0x0204  /* eeprom/flash load */
-+#define L1F_EFLD_F_ENDADDR_MASK         ASHFT16(0x3FFUL)
++#define L1F_EFLD_F_ENDADDR_MASK         0x3FFUL
 +#define L1F_EFLD_F_ENDADDR_SHIFT        16
 +#define L1F_EFLD_F_EXIST                BIT(10)
 +#define L1F_EFLD_E_EXIST                BIT(9)
@@ -5788,19 +5778,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_EFLD_START                  BIT(0)
 +
 +#define L1F_SLD                         0x0218  /* efuse load */
-+#define L1F_SLD_FREQ_MASK               ASHFT24(3UL)
++#define L1F_SLD_FREQ_MASK               0x3UL
 +#define L1F_SLD_FREQ_SHIFT              24
 +#define L1F_SLD_FREQ_100K               0
 +#define L1F_SLD_FREQ_200K               1
 +#define L1F_SLD_FREQ_300K               2
 +#define L1F_SLD_FREQ_400K               3
 +#define L1F_SLD_EXIST                   BIT(23)
-+#define L1F_SLD_SLVADDR_MASK            ASHFT16(0x7FUL)
++#define L1F_SLD_SLVADDR_MASK            0x7FUL
 +#define L1F_SLD_SLVADDR_SHIFT           16
 +#define L1F_SLD_IDLE                    BIT(13)
 +#define L1F_SLD_STAT                    BIT(12)  /* 0:finish,1:in progress */
 +#define L1F_SLD_START                   BIT(11)
-+#define L1F_SLD_STARTADDR_MASK          ASHFT0(0xFFUL)
++#define L1F_SLD_STARTADDR_MASK          0xFFUL
 +#define L1F_SLD_STARTADDR_SHIFT         0
 +#define L1F_SLD_MAX_TO                  100
 +
@@ -5810,67 +5800,67 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1F_PPHY_MISC1                  0x1000
 +#define L1F_PPHY_MISC1_RCVDET           BIT(2)
-+#define L1F_PPHY_MISC1_NFTS_MASK        ASHFT16(0xFFUL)
++#define L1F_PPHY_MISC1_NFTS_MASK        0xFFUL
 +#define L1F_PPHY_MISC1_NFTS_SHIFT       16
 +#define L1F_PPHY_MISC1_NFTS_HIPERF      0xA0    /* ???? */
 +
 +#define L1F_PPHY_MISC2                  0x1004
-+#define L1F_PPHY_MISC2_L0S_TH_MASK      ASHFT18(0x3UL)
++#define L1F_PPHY_MISC2_L0S_TH_MASK      0x3UL
 +#define L1F_PPHY_MISC2_L0S_TH_SHIFT     18
-+#define L1F_PPHY_MISC2_CDR_BW_MASK      ASHFT16(0x3UL)
++#define L1F_PPHY_MISC2_CDR_BW_MASK      0x3UL
 +#define L1F_PPHY_MISC2_CDR_BW_SHIFT     16
 +
 +#define L1F_PDLL_TRNS1                  0x1104
 +#define L1F_PDLL_TRNS1_D3PLLOFF_EN      BIT(11)
 +#define L1F_PDLL_TRNS1_REGCLK_SEL_NORM  BIT(10)
-+#define L1F_PDLL_TRNS1_REPLY_TO_MASK    ASHFT0(0x3FFUL)
++#define L1F_PDLL_TRNS1_REPLY_TO_MASK    0x3FFUL
 +#define L1F_PDLL_TRNS1_REPLY_TO_SHIFT   0
 +
 +
 +#define L1F_TLEXTN_STATS                0x1208
-+#define L1F_TLEXTN_STATS_DEVNO_MASK     ASHFT16(0x1FUL)
++#define L1F_TLEXTN_STATS_DEVNO_MASK     0x1FUL
 +#define L1F_TLEXTN_STATS_DEVNO_SHIFT    16
-+#define L1F_TLEXTN_STATS_BUSNO_MASK     ASHFT8(0xFFUL)
++#define L1F_TLEXTN_STATS_BUSNO_MASK     0xFFUL
 +#define L1F_TLEXTN_STATS_BUSNO_SHIFT    8
 +
 +#define L1F_EFUSE_CTRL                  0x12C0
 +#define L1F_EFUSE_CTRL_FLAG             BIT(31)          /* 0:read,1:write */
 +#define L1F_EUFSE_CTRL_ACK              BIT(30)
-+#define L1F_EFUSE_CTRL_ADDR_MASK        ASHFT16(0x3FFUL)
++#define L1F_EFUSE_CTRL_ADDR_MASK        0x3FFUL
 +#define L1F_EFUSE_CTRL_ADDR_SHIFT       16
 +
 +#define L1F_EFUSE_DATA                  0x12C4
 +
 +#define L1F_SPI_OP1                     0x12C8
-+#define L1F_SPI_OP1_RDID_MASK           ASHFT24(0xFFUL)
++#define L1F_SPI_OP1_RDID_MASK           0xFFUL
 +#define L1F_SPI_OP1_RDID_SHIFT          24
-+#define L1F_SPI_OP1_CE_MASK             ASHFT16(0xFFUL)
++#define L1F_SPI_OP1_CE_MASK             0xFFUL
 +#define L1F_SPI_OP1_CE_SHIFT            16
-+#define L1F_SPI_OP1_SE_MASK             ASHFT8(0xFFUL)
++#define L1F_SPI_OP1_SE_MASK             0xFFUL
 +#define L1F_SPI_OP1_SE_SHIFT            8
-+#define L1F_SPI_OP1_PRGRM_MASK          ASHFT0(0xFFUL)
++#define L1F_SPI_OP1_PRGRM_MASK          0xFFUL
 +#define L1F_SPI_OP1_PRGRM_SHIFT         0
 +
 +#define L1F_SPI_OP2                     0x12CC
-+#define L1F_SPI_OP2_READ_MASK           ASHFT24(0xFFUL)
++#define L1F_SPI_OP2_READ_MASK           0xFFUL
 +#define L1F_SPI_OP2_READ_SHIFT          24
-+#define L1F_SPI_OP2_WRSR_MASK           ASHFT16(0xFFUL)
++#define L1F_SPI_OP2_WRSR_MASK           0xFFUL
 +#define L1F_SPI_OP2_WRSR_SHIFT          16
-+#define L1F_SPI_OP2_RDSR_MASK           ASHFT8(0xFFUL)
++#define L1F_SPI_OP2_RDSR_MASK           0xFFUL
 +#define L1F_SPI_OP2_RDSR_SHIFT          8
-+#define L1F_SPI_OP2_WREN_MASK           ASHFT0(0xFFUL)
++#define L1F_SPI_OP2_WREN_MASK           0xFFUL
 +#define L1F_SPI_OP2_WREN_SHIFT          0
 +
 +#define L1F_SPI_OP3                     0x12E4
-+#define L1F_SPI_OP3_WRDI_MASK           ASHFT8(0xFFUL)
++#define L1F_SPI_OP3_WRDI_MASK           0xFFUL
 +#define L1F_SPI_OP3_WRDI_SHIFT          8
-+#define L1F_SPI_OP3_EWSR_MASK           ASHFT0(0xFFUL)
++#define L1F_SPI_OP3_EWSR_MASK           0xFFUL
 +#define L1F_SPI_OP3_EWSR_SHIFT          0
 +
 +#define L1F_EF_CTRL                     0x12D0
-+#define L1F_EF_CTRL_FSTS_MASK           ASHFT20(0xFFUL)
++#define L1F_EF_CTRL_FSTS_MASK           0xFFUL
 +#define L1F_EF_CTRL_FSTS_SHIFT          20
-+#define L1F_EF_CTRL_CLASS_MASK          ASHFT16(7UL)
++#define L1F_EF_CTRL_CLASS_MASK          0x7UL
 +#define L1F_EF_CTRL_CLASS_SHIFT         16
 +#define L1F_EF_CTRL_CLASS_F_UNKNOWN     0
 +#define L1F_EF_CTRL_CLASS_F_STD         1
@@ -5879,14 +5869,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_EF_CTRL_CLASS_E_1K          1
 +#define L1F_EF_CTRL_CLASS_E_4K          2
 +#define L1F_EF_CTRL_FRET                BIT(15)          /* 0:OK,1:fail */
-+#define L1F_EF_CTRL_TYP_MASK            ASHFT12(3UL)
++#define L1F_EF_CTRL_TYP_MASK            0x3UL
 +#define L1F_EF_CTRL_TYP_SHIFT           12
 +#define L1F_EF_CTRL_TYP_NONE            0
 +#define L1F_EF_CTRL_TYP_F               1
 +#define L1F_EF_CTRL_TYP_E               2
 +#define L1F_EF_CTRL_TYP_UNKNOWN         3
 +#define L1F_EF_CTRL_ONE_CLK             BIT(10)
-+#define L1F_EF_CTRL_ECLK_MASK           ASHFT8(3UL)
++#define L1F_EF_CTRL_ECLK_MASK           0x3UL
 +#define L1F_EF_CTRL_ECLK_SHIFT          8
 +#define L1F_EF_CTRL_ECLK_125K           0
 +#define L1F_EF_CTRL_ECLK_250K           1
@@ -5896,7 +5886,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_EF_CTRL_ACTION              BIT(6)           /* 1:start,0:stop */
 +#define L1F_EF_CTRL_AUTO_OP             BIT(5)
 +#define L1F_EF_CTRL_SST_MODE            BIT(4)           /* force using sst */
-+#define L1F_EF_CTRL_INST_MASK           ASHFT0(0xFUL)
++#define L1F_EF_CTRL_INST_MASK           0xFUL
 +#define L1F_EF_CTRL_INST_SHIFT          0
 +#define L1F_EF_CTRL_INST_NONE           0
 +#define L1F_EF_CTRL_INST_READ           1               /* for flash & eeprom */
@@ -5923,15 +5913,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +						 * thrghput(setting in 15A0) */
 +#define L1F_PMCTRL_SADLY_EN             BIT(29)
 +#define L1F_PMCTRL_L0S_BUFSRX_EN        BIT(28)
-+#define L1F_PMCTRL_LCKDET_TIMER_MASK    ASHFT24(0xFUL)
++#define L1F_PMCTRL_LCKDET_TIMER_MASK    0xFUL
 +#define L1F_PMCTRL_LCKDET_TIMER_SHIFT   24
 +#define L1F_PMCTRL_LCKDET_TIMER_DEF     0xC
-+#define L1F_PMCTRL_L1REQ_TO_MASK        ASHFT20(0xFUL)
++#define L1F_PMCTRL_L1REQ_TO_MASK        0xFUL
 +#define L1F_PMCTRL_L1REQ_TO_SHIFT       20      /* pm_request_l1 time > @
 +						 * ->L0s not L1 */
-+#define L1F_PMCTRL_L1REG_TO_DEF         0xC
++#define L1F_PMCTRL_L1REG_TO_DEF         0xF
 +#define L1F_PMCTRL_TXL1_AFTER_L0S       BIT(19)
-+#define L1F_PMCTRL_L1_TIMER_MASK        ASHFT16(7UL)
++#define L1F_PMCTRL_L1_TIMER_MASK        0x7UL
 +#define L1F_PMCTRL_L1_TIMER_SHIFT       16
 +#define L1F_PMCTRL_L1_TIMER_DIS         0
 +#define L1F_PMCTRL_L1_TIMER_2US         1
@@ -5946,7 +5936,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_PMCTRL_L1_CLKSW_EN          BIT(13)  /* en pcie clk sw in L1 */
 +#define L1F_PMCTRL_L0S_EN               BIT(12)
 +#define L1F_PMCTRL_RXL1_AFTER_L0S       BIT(11)
-+#define L1F_PMCTRL_L0S_TIMER_MASK       ASHFT8(7UL)
++#define L1F_PMCTRL_L0S_TIMER_MASK       0x7UL
 +#define L1F_PMCTRL_L0S_TIMER_SHIFT      8
 +#define L1F_PMCTRL_L1_BUFSRX_EN         BIT(7)
 +#define L1F_PMCTRL_L1_SRDSRX_PWD        BIT(6)   /* power down serdes rx */
@@ -5965,9 +5955,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1F_MASTER                      0x1400
 +#define L1F_MASTER_OTP_FLG              BIT(31)
-+#define L1F_MASTER_DEV_NUM_MASK         ASHFT24(0x7FUL)
++#define L1F_MASTER_DEV_NUM_MASK         0x7FUL
 +#define L1F_MASTER_DEV_NUM_SHIFT        24
-+#define L1F_MASTER_REV_NUM_MASK         ASHFT16(0xFFUL)
++#define L1F_MASTER_REV_NUM_MASK         0xFFUL
 +#define L1F_MASTER_REV_NUM_SHIFT        16
 +#define L1F_MASTER_DEASSRT              BIT(15)      /*ISSUE DE-ASSERT MSG */
 +#define L1F_MASTER_RDCLR_INT            BIT(14)
@@ -5982,7 +5972,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MASTER_OOB_DIS              BIT(6)       /* OUT OF BOX DIS */
 +#define L1F_MASTER_WAKEN_25M            BIT(5)       /* WAKE WO. PCIE CLK */
 +#define L1F_MASTER_BERT_START           BIT(4)
-+#define L1F_MASTER_PCIE_TSTMOD_MASK     ASHFT2(3UL)
++#define L1F_MASTER_PCIE_TSTMOD_MASK     0x3UL
 +#define L1F_MASTER_PCIE_TSTMOD_SHIFT    2
 +#define L1F_MASTER_PCIE_RST             BIT(1)
 +#define L1F_MASTER_DMA_MAC_RST          BIT(0)       /* RST MAC & DMA */
@@ -5991,13 +5981,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MANU_TIMER                  0x1404
 +
 +#define L1F_IRQ_MODU_TIMER              0x1408
-+#define L1F_IRQ_MODU_TIMER2_MASK        ASHFT16(0xFFFFUL)
++#define L1F_IRQ_MODU_TIMER2_MASK        0xFFFFUL
 +#define L1F_IRQ_MODU_TIMER2_SHIFT       16          /* ONLY FOR RX */
-+#define L1F_IRQ_MODU_TIMER1_MASK        ASHFT0(0xFFFFUL)
++#define L1F_IRQ_MODU_TIMER1_MASK        0xFFFFUL
 +#define L1F_IRQ_MODU_TIMER1_SHIFT       0
 +
 +#define L1F_PHY_CTRL                    0x140C
-+#define L1F_PHY_CTRL_ADDR_MASK          ASHFT19(0x1FUL)
++#define L1F_PHY_CTRL_ADDR_MASK          0x1FUL
 +#define L1F_PHY_CTRL_ADDR_SHIFT         19
 +#define L1F_PHY_CTRL_BP_VLTGSW          BIT(18)
 +#define L1F_PHY_CTRL_100AB_EN           BIT(17)
@@ -6028,12 +6018,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	L1F_PHY_CTRL_PLL_ON)
 +
 +#define L1F_MAC_STS                     0x1410
-+#define L1F_MAC_STS_SFORCE_MASK         ASHFT14(0xFUL)
++#define L1F_MAC_STS_SFORCE_MASK         0xFUL
 +#define L1F_MAC_STS_SFORCE_SHIFT        14
 +#define L1F_MAC_STS_CALIB_DONE          BIT13
-+#define L1F_MAC_STS_CALIB_RES_MASK      ASHFT8(0x1FUL)
++#define L1F_MAC_STS_CALIB_RES_MASK      0x1FUL
 +#define L1F_MAC_STS_CALIB_RES_SHIFT     8
-+#define L1F_MAC_STS_CALIBERR_MASK       ASHFT4(0xFUL)
++#define L1F_MAC_STS_CALIBERR_MASK       0xFUL
 +#define L1F_MAC_STS_CALIBERR_SHIFT      4
 +#define L1F_MAC_STS_TXQ_BUSY            BIT(3)
 +#define L1F_MAC_STS_RXQ_BUSY            BIT(2)
@@ -6050,7 +6040,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MDIO_POST_READ              BIT(29)
 +#define L1F_MDIO_AUTO_POLLING           BIT(28)
 +#define L1F_MDIO_BUSY                   BIT(27)
-+#define L1F_MDIO_CLK_SEL_MASK           ASHFT24(7UL)
++#define L1F_MDIO_CLK_SEL_MASK           0x7UL
 +#define L1F_MDIO_CLK_SEL_SHIFT          24
 +#define L1F_MDIO_CLK_SEL_25MD4          0           /* 25M DIV 4 */
 +#define L1F_MDIO_CLK_SEL_25MD6          2
@@ -6062,42 +6052,42 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MDIO_START                  BIT(23)
 +#define L1F_MDIO_SPRES_PRMBL            BIT(22)
 +#define L1F_MDIO_OP_READ                BIT(21)      /* 1:read,0:write */
-+#define L1F_MDIO_REG_MASK               ASHFT16(0x1FUL)
++#define L1F_MDIO_REG_MASK               0x1FUL
 +#define L1F_MDIO_REG_SHIFT              16
-+#define L1F_MDIO_DATA_MASK              ASHFT0(0xFFFFUL)
++#define L1F_MDIO_DATA_MASK              0xFFFFUL
 +#define L1F_MDIO_DATA_SHIFT             0
 +#define L1F_MDIO_MAX_AC_TO              120
 +
 +#define L1F_MDIO_EXTN                   0x1448
-+#define L1F_MDIO_EXTN_PORTAD_MASK       ASHFT21(0x1FUL)
++#define L1F_MDIO_EXTN_PORTAD_MASK       0x1FUL
 +#define L1F_MDIO_EXTN_PORTAD_SHIFT      21
-+#define L1F_MDIO_EXTN_DEVAD_MASK        ASHFT16(0x1FUL)
++#define L1F_MDIO_EXTN_DEVAD_MASK        0x1FUL
 +#define L1F_MDIO_EXTN_DEVAD_SHIFT       16
-+#define L1F_MDIO_EXTN_REG_MASK          ASHFT0(0xFFFFUL)
++#define L1F_MDIO_EXTN_REG_MASK          0xFFFFUL
 +#define L1F_MDIO_EXTN_REG_SHIFT         0
 +
 +#define L1F_PHY_STS                     0x1418
 +#define L1F_PHY_STS_LPW                 BIT(31)
 +#define L1F_PHY_STS_LPI                 BIT(30)
-+#define L1F_PHY_STS_PWON_STRIP_MASK     ASHFT16(0xFFFUL)
++#define L1F_PHY_STS_PWON_STRIP_MASK     0xFFFUL
 +#define L1F_PHY_STS_PWON_STRIP_SHIFT    16
 +
 +#define L1F_PHY_STS_DUPLEX              BIT(3)
 +#define L1F_PHY_STS_LINKUP              BIT(2)
-+#define L1F_PHY_STS_SPEED_MASK          ASHFT0(3UL)
++#define L1F_PHY_STS_SPEED_MASK          0x3UL
 +#define L1F_PHY_STS_SPEED_SHIFT         0
 +#define L1F_PHY_STS_SPEED_1000M         2
 +#define L1F_PHY_STS_SPEED_100M          1
 +#define L1F_PHY_STS_SPEED_10M           0
 +
 +#define L1F_BIST0                       0x141C
-+#define L1F_BIST0_COL_MASK              ASHFT24(0x3FUL)
++#define L1F_BIST0_COL_MASK              0x3FUL
 +#define L1F_BIST0_COL_SHIFT             24
-+#define L1F_BIST0_ROW_MASK              ASHFT12(0xFFFUL)
++#define L1F_BIST0_ROW_MASK              0xFFFUL
 +#define L1F_BIST0_ROW_SHIFT             12
-+#define L1F_BIST0_STEP_MASK             ASHFT8(0xFUL)
++#define L1F_BIST0_STEP_MASK             0xFUL
 +#define L1F_BIST0_STEP_SHIFT            8
-+#define L1F_BIST0_PATTERN_MASK          ASHFT4(7UL)
++#define L1F_BIST0_PATTERN_MASK          0x7UL
 +#define L1F_BIST0_PATTERN_SHIFT         4
 +#define L1F_BIST0_CRIT                  BIT(3)
 +#define L1F_BIST0_FIXED                 BIT(2)
@@ -6105,13 +6095,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_BIST0_START                 BIT(0)
 +
 +#define L1F_BIST1                       0x1420
-+#define L1F_BIST1_COL_MASK              ASHFT24(0x3FUL)
++#define L1F_BIST1_COL_MASK              0x3FUL
 +#define L1F_BIST1_COL_SHIFT             24
-+#define L1F_BIST1_ROW_MASK              ASHFT12(0xFFFUL)
++#define L1F_BIST1_ROW_MASK              0xFFFUL
 +#define L1F_BIST1_ROW_SHIFT             12
-+#define L1F_BIST1_STEP_MASK             ASHFT8(0xFUL)
++#define L1F_BIST1_STEP_MASK             0xFUL
 +#define L1F_BIST1_STEP_SHIFT            8
-+#define L1F_BIST1_PATTERN_MASK          ASHFT4(7UL)
++#define L1F_BIST1_PATTERN_MASK          0x7UL
 +#define L1F_BIST1_PATTERN_SHIFT         4
 +#define L1F_BIST1_CRIT                  BIT(3)
 +#define L1F_BIST1_FIXED                 BIT(2)
@@ -6121,7 +6111,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_SERDES                      0x1424
 +#define L1F_SERDES_PHYCLK_SLWDWN        BIT(18)
 +#define L1F_SERDES_MACCLK_SLWDWN        BIT(17)
-+#define L1F_SERDES_SELFB_PLL_MASK       ASHFT14(3UL)
++#define L1F_SERDES_SELFB_PLL_MASK       0x3UL
 +#define L1F_SERDES_SELFB_PLL_SHIFT      14
 +#define L1F_SERDES_PHYCLK_SEL_GTX       BIT(13)          /* 1:gtx_clk, 0:25M */
 +#define L1F_SERDES_PCIECLK_SEL_SRDS     BIT(12)          /* 1:serdes,0:25M */
@@ -6130,7 +6120,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_SERDES_PLL_EN               BIT(9)
 +#define L1F_SERDES_EN                   BIT(8)
 +#define L1F_SERDES_SELFB_PLL_SEL_CSR    BIT(6)       /* 0:state-machine,1:csr */
-+#define L1F_SERDES_SELFB_PLL_CSR_MASK   ASHFT4(3UL)
++#define L1F_SERDES_SELFB_PLL_CSR_MASK   0x3UL
 +#define L1F_SERDES_SELFB_PLL_CSR_SHIFT  4
 +#define L1F_SERDES_SELFB_PLL_CSR_4      3           /* 4-12% OV-CLK */
 +#define L1F_SERDES_SELFB_PLL_CSR_0      2           /* 0-4% OV-CLK */
@@ -6142,19 +6132,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_SERDES_LOCKDCTED            BIT(0)
 +
 +#define L1F_LED_CTRL                    0x1428
-+#define L1F_LED_CTRL_PATMAP2_MASK       ASHFT8(3UL)
++#define L1F_LED_CTRL_PATMAP2_MASK       0x3UL
 +#define L1F_LED_CTRL_PATMAP2_SHIFT      8
-+#define L1F_LED_CTRL_PATMAP1_MASK       ASHFT6(3UL)
++#define L1F_LED_CTRL_PATMAP1_MASK       0x3UL
 +#define L1F_LED_CTRL_PATMAP1_SHIFT      6
-+#define L1F_LED_CTRL_PATMAP0_MASK       ASHFT4(3UL)
++#define L1F_LED_CTRL_PATMAP0_MASK       0x3UL
 +#define L1F_LED_CTRL_PATMAP0_SHIFT      4
-+#define L1F_LED_CTRL_D3_MODE_MASK       ASHFT2(3UL)
++#define L1F_LED_CTRL_D3_MODE_MASK       0x3UL
 +#define L1F_LED_CTRL_D3_MODE_SHIFT      2
 +#define L1F_LED_CTRL_D3_MODE_NORMAL     0
 +#define L1F_LED_CTRL_D3_MODE_WOL_DIS    1
 +#define L1F_LED_CTRL_D3_MODE_WOL_ANY    2
 +#define L1F_LED_CTRL_D3_MODE_WOL_EN     3
-+#define L1F_LED_CTRL_DUTY_CYCL_MASK     ASHFT0(3UL)
++#define L1F_LED_CTRL_DUTY_CYCL_MASK     0x3UL
 +#define L1F_LED_CTRL_DUTY_CYCL_SHIFT    0
 +#define L1F_LED_CTRL_DUTY_CYCL_50       0           /* 50% */
 +#define L1F_LED_CTRL_DUTY_CYCL_125      1           /* 12.5% */
@@ -6162,31 +6152,31 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_LED_CTRL_DUTY_CYCL_75       3           /* 75% */
 +
 +#define L1F_LED_PATN                    0x142C
-+#define L1F_LED_PATN1_MASK              ASHFT16(0xFFFFUL)
++#define L1F_LED_PATN1_MASK              0xFFFFUL
 +#define L1F_LED_PATN1_SHIFT             16
-+#define L1F_LED_PATN0_MASK              ASHFT0(0xFFFFUL)
++#define L1F_LED_PATN0_MASK              0xFFFFUL
 +#define L1F_LED_PATN0_SHIFT             0
 +
 +#define L1F_LED_PATN2                   0x1430
-+#define L1F_LED_PATN2_MASK              ASHFT0(0xFFFFUL)
++#define L1F_LED_PATN2_MASK              0xFFFFUL
 +#define L1F_LED_PATN2_SHIFT             0
 +
 +#define L1F_SYSALV                      0x1434
 +#define L1F_SYSALV_FLAG                 BIT(0)
 +
 +#define L1F_PCIERR_INST                 0x1438
-+#define L1F_PCIERR_INST_TX_RATE_MASK    ASHFT4(0xFUL)
++#define L1F_PCIERR_INST_TX_RATE_MASK    0xFUL
 +#define L1F_PCIERR_INST_TX_RATE_SHIFT   4
-+#define L1F_PCIERR_INST_RX_RATE_MASK    ASHFT0(0xFUL)
++#define L1F_PCIERR_INST_RX_RATE_MASK    0xFUL
 +#define L1F_PCIERR_INST_RX_RATE_SHIFT   0
 +
 +#define L1F_LPI_DECISN_TIMER            0x143C
 +
 +#define L1F_LPI_CTRL                    0x1440
 +#define L1F_LPI_CTRL_CHK_DA             BIT(31)
-+#define L1F_LPI_CTRL_ENH_TO_MASK        ASHFT12(0x1FFFUL)
++#define L1F_LPI_CTRL_ENH_TO_MASK        0x1FFFUL
 +#define L1F_LPI_CTRL_ENH_TO_SHIFT       12
-+#define L1F_LPI_CTRL_ENH_TH_MASK        ASHFT6(0x1FUL)
++#define L1F_LPI_CTRL_ENH_TH_MASK        0x1FUL
 +#define L1F_LPI_CTRL_ENH_TH_SHIFT       6
 +#define L1F_LPI_CTRL_ENH_EN             BIT(5)
 +#define L1F_LPI_CTRL_CHK_RX             BIT(4)
@@ -6196,29 +6186,29 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_LPI_CTRL_EN                 BIT(0)
 +
 +#define L1F_LPI_WAIT                    0x1444
-+#define L1F_LPI_WAIT_TIMER_MASK         ASHFT0(0xFFFFUL)
++#define L1F_LPI_WAIT_TIMER_MASK         0xFFFFUL
 +#define L1F_LPI_WAIT_TIMER_SHIFT        0
 +
 +#define L1F_HRTBT_VLAN                  0x1450      /* HEARTBEAT, FOR CIFS */
-+#define L1F_HRTBT_VLANID_MASK           ASHFT0(0xFFFFUL) /* OR CLOUD */
++#define L1F_HRTBT_VLANID_MASK           0xFFFFUL /* OR CLOUD */
 +#define L1F_HRRBT_VLANID_SHIFT          0
 +
 +#define L1F_HRTBT_CTRL                  0x1454
 +#define L1F_HRTBT_CTRL_EN               BIT(31)
-+#define L1F_HRTBT_CTRL_PERIOD_MASK      ASHFT25(0x3FUL)
++#define L1F_HRTBT_CTRL_PERIOD_MASK      0x3FUL
 +#define L1F_HRTBT_CTRL_PERIOD_SHIFT     25
 +#define L1F_HRTBT_CTRL_HASVLAN          BIT(24)
-+#define L1F_HRTBT_CTRL_HDRADDR_MASK     ASHFT12(0xFFFUL)    /* A0 */
++#define L1F_HRTBT_CTRL_HDRADDR_MASK     0xFFFUL    /* A0 */
 +#define L1F_HRTBT_CTRL_HDRADDR_SHIFT    12
-+#define L1F_HRTBT_CTRL_HDRADDRB0_MASK   ASHFT13(0x7FFUL)    /* B0 */
++#define L1F_HRTBT_CTRL_HDRADDRB0_MASK   0x7FFUL    /* B0 */
 +#define L1F_HRTBT_CTRL_HDRADDRB0_SHIFT  13
 +#define L1F_HRTBT_CTRL_PKT_FRAG         BIT(12)              /* B0 */
-+#define L1F_HRTBT_CTRL_PKTLEN_MASK      ASHFT0(0xFFFUL)
++#define L1F_HRTBT_CTRL_PKTLEN_MASK      0xFFFUL
 +#define L1F_HRTBT_CTRL_PKTLEN_SHIFT     0
 +
 +#define L1F_HRTBT_EXT_CTRL                  0x1AD0      /* B0 */
 +#define L1F_HRTBT_EXT_CTRL_NS_EN            BIT(12)
-+#define L1F_HRTBT_EXT_CTRL_FRAG_LEN_MASK    ASHFT4(0xFFUL)
++#define L1F_HRTBT_EXT_CTRL_FRAG_LEN_MASK    0xFFUL
 +#define L1F_HRTBT_EXT_CTRL_FRAG_LEN_SHIFT   4
 +#define L1F_HRTBT_EXT_CTRL_IS_8023          BIT(3)
 +#define L1F_HRTBT_EXT_CTRL_IS_IPV6          BIT(2)
@@ -6233,9 +6223,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_HRTBT_REM_IPV6_ADDR0            0x1AE4
 +/*SWOI_HOST_IPV6_ADDR reuse reg1a60-1a6c, 1a70-1a7c, 1aa0-1aac, 1ab0-1abc.*/
 +#define L1F_HRTBT_WAKEUP_PORT               0x1AE8
-+#define L1F_HRTBT_WAKEUP_PORT_SRC_MASK      ASHFT16(0xFFFFUL)
++#define L1F_HRTBT_WAKEUP_PORT_SRC_MASK      0xFFFFUL
 +#define L1F_HRTBT_WAKEUP_PORT_SRC_SHIFT     16
-+#define L1F_HRTBT_WAKEUP_PORT_DEST_MASK     ASHFT0(0xFFFFUL)
++#define L1F_HRTBT_WAKEUP_PORT_DEST_MASK     0xFFFFUL
 +#define L1F_HRTBT_WAKEUP_PORT_DEST_SHIFT    0
 +
 +#define L1F_HRTBT_WAKEUP_DATA7              0x1AEC
@@ -6248,29 +6238,29 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_HRTBT_WAKEUP_DATA0              0x1B88
 +
 +#define L1F_RXPARSE                     0x1458
-+#define L1F_RXPARSE_FLT6_L4_MASK        ASHFT30(3UL)
++#define L1F_RXPARSE_FLT6_L4_MASK        0x3UL
 +#define L1F_RXPARSE_FLT6_L4_SHIFT       30
-+#define L1F_RXPARSE_FLT6_L3_MASK        ASHFT28(3UL)
++#define L1F_RXPARSE_FLT6_L3_MASK        0x3UL
 +#define L1F_RXPARSE_FLT6_L3_SHIFT       28
-+#define L1F_RXPARSE_FLT5_L4_MASK        ASHFT26(3UL)
++#define L1F_RXPARSE_FLT5_L4_MASK        0x3UL
 +#define L1F_RXPARSE_FLT5_L4_SHIFT       26
-+#define L1F_RXPARSE_FLT5_L3_MASK        ASHFT24(3UL)
++#define L1F_RXPARSE_FLT5_L3_MASK        0x3UL
 +#define L1F_RXPARSE_FLT5_L3_SHIFT       24
-+#define L1F_RXPARSE_FLT4_L4_MASK        ASHFT22(3UL)
++#define L1F_RXPARSE_FLT4_L4_MASK        0x3UL
 +#define L1F_RXPARSE_FLT4_L4_SHIFT       22
-+#define L1F_RXPARSE_FLT4_L3_MASK        ASHFT20(3UL)
++#define L1F_RXPARSE_FLT4_L3_MASK        0x3UL
 +#define L1F_RXPARSE_FLT4_L3_SHIFT       20
-+#define L1F_RXPARSE_FLT3_L4_MASK        ASHFT18(3UL)
++#define L1F_RXPARSE_FLT3_L4_MASK        0x3UL
 +#define L1F_RXPARSE_FLT3_L4_SHIFT       18
-+#define L1F_RXPARSE_FLT3_L3_MASK        ASHFT16(3UL)
++#define L1F_RXPARSE_FLT3_L3_MASK        0x3UL
 +#define L1F_RXPARSE_FLT3_L3_SHIFT       16
-+#define L1F_RXPARSE_FLT2_L4_MASK        ASHFT14(3UL)
++#define L1F_RXPARSE_FLT2_L4_MASK        0x3UL
 +#define L1F_RXPARSE_FLT2_L4_SHIFT       14
-+#define L1F_RXPARSE_FLT2_L3_MASK        ASHFT12(3UL)
++#define L1F_RXPARSE_FLT2_L3_MASK        0x3UL
 +#define L1F_RXPARSE_FLT2_L3_SHIFT       12
-+#define L1F_RXPARSE_FLT1_L4_MASK        ASHFT10(3UL)
++#define L1F_RXPARSE_FLT1_L4_MASK        0x3UL
 +#define L1F_RXPARSE_FLT1_L4_SHIFT       10
-+#define L1F_RXPARSE_FLT1_L3_MASK        ASHFT8(3UL)
++#define L1F_RXPARSE_FLT1_L3_MASK        0x3UL
 +#define L1F_RXPARSE_FLT1_L3_SHIFT       8
 +#define L1F_RXPARSE_FLT6_EN             BIT(5)
 +#define L1F_RXPARSE_FLT5_EN             BIT(4)
@@ -6291,19 +6281,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_TRD_CTRL_EN                 BIT(31)
 +#define L1F_TRD_CTRL_BUBBLE_WAKE_EN     BIT(30)
 +#define L1F_TRD_CTRL_PREFIX_CMP_HW      BIT(28)
-+#define L1F_TRD_CTRL_RSHDR_ADDR_MASK    ASHFT16(0xFFFUL)
++#define L1F_TRD_CTRL_RSHDR_ADDR_MASK    0xFFFUL
 +#define L1F_TRD_CTRL_RSHDR_ADDR_SHIFT   16
-+#define L1F_TRD_CTRL_SINTV_MAX_MASK     ASHFT8(0xFFUL)
++#define L1F_TRD_CTRL_SINTV_MAX_MASK     0xFFUL
 +#define L1F_TRD_CTRL_SINTV_MAX_SHIFT    8
-+#define L1F_TRD_CTRL_SINTV_MIN_MASK     ASHFT0(0xFFUL)
++#define L1F_TRD_CTRL_SINTV_MIN_MASK     0xFFUL
 +#define L1F_TRD_CTRL_SINTV_MIN_SHIFT    0
 +
 +#define L1F_TRD_RS                      0x1460
-+#define L1F_TRD_RS_SZ_MASK              ASHFT20(0xFFFUL)
++#define L1F_TRD_RS_SZ_MASK              0xFFFUL
 +#define L1F_TRD_RS_SZ_SHIFT             20
-+#define L1F_TRD_RS_NONCE_OFS_MASK       ASHFT8(0xFFFUL)
++#define L1F_TRD_RS_NONCE_OFS_MASK       0xFFFUL
 +#define L1F_TRD_RS_NONCE_OFS_SHIFT      8
-+#define L1F_TRD_RS_SEQ_OFS_MASK         ASHFT0(0xFFUL)
++#define L1F_TRD_RS_SEQ_OFS_MASK         0xFFUL
 +#define L1F_TRD_RS_SEQ_OFS_SHIFT        0
 +
 +#define L1F_TRD_SRV_IP4                 0x1464
@@ -6311,9 +6301,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_TRD_CLNT_EXTNL_IP4          0x1468
 +
 +#define L1F_TRD_PORT                    0x146C
-+#define L1F_TRD_PORT_CLNT_EXTNL_MASK    ASHFT16(0xFFFFUL)
++#define L1F_TRD_PORT_CLNT_EXTNL_MASK    0xFFFFUL
 +#define L1F_TRD_PORT_CLNT_EXTNL_SHIFT   16
-+#define L1F_TRD_PORT_SRV_MASK           ASHFT0(0xFFFFUL)
++#define L1F_TRD_PORT_SRV_MASK           0xFFFFUL
 +#define L1F_TRD_PORT_SRV_SHIFT          0
 +
 +#define L1F_TRD_PREFIX                  0x1470
@@ -6338,7 +6328,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MAC_CTRL_RX_XSUM_EN         BIT(24)
 +#define L1F_MAC_CTRL_THUGE              BIT(23)
 +#define L1F_MAC_CTRL_MBOF               BIT(22)
-+#define L1F_MAC_CTRL_SPEED_MASK         ASHFT20(3UL)
++#define L1F_MAC_CTRL_SPEED_MASK         0x3UL
 +#define L1F_MAC_CTRL_SPEED_SHIFT        20
 +#define L1F_MAC_CTRL_SPEED_10_100       1
 +#define L1F_MAC_CTRL_SPEED_1000         2
@@ -6347,7 +6337,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MAC_CTRL_TPAUSE             BIT(16)
 +#define L1F_MAC_CTRL_PROMISC_EN         BIT(15)
 +#define L1F_MAC_CTRL_VLANSTRIP          BIT(14)
-+#define L1F_MAC_CTRL_PRMBLEN_MASK       ASHFT10(0xFUL)
++#define L1F_MAC_CTRL_PRMBLEN_MASK       0xFUL
 +#define L1F_MAC_CTRL_PRMBLEN_SHIFT      10
 +#define L1F_MAC_CTRL_RHUGE_EN           BIT(9)
 +#define L1F_MAC_CTRL_FLCHK              BIT(8)
@@ -6361,13 +6351,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MAC_CTRL_TX_EN              BIT(0)
 +
 +#define L1F_GAP                         0x1484
-+#define L1F_GAP_IPGR2_MASK              ASHFT24(0x7FUL)
++#define L1F_GAP_IPGR2_MASK              0x7FUL
 +#define L1F_GAP_IPGR2_SHIFT             24
-+#define L1F_GAP_IPGR1_MASK              ASHFT16(0x7FUL)
++#define L1F_GAP_IPGR1_MASK              0x7FUL
 +#define L1F_GAP_IPGR1_SHIFT             16
-+#define L1F_GAP_MIN_IFG_MASK            ASHFT8(0xFFUL)
++#define L1F_GAP_MIN_IFG_MASK            0xFFUL
 +#define L1F_GAP_MIN_IFG_SHIFT           8
-+#define L1F_GAP_IPGT_MASK               ASHFT0(0x7FUL)  /* A0 diff with B0 */
++#define L1F_GAP_IPGT_MASK               0x7FUL  /* A0 diff with B0 */
 +#define L1F_GAP_IPGT_SHIFT              0
 +
 +#define L1F_STAD0                       0x1488
@@ -6377,17 +6367,17 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_HASH_TBL1                   0x1494
 +
 +#define L1F_HALFD                       0x1498
-+#define L1F_HALFD_JAM_IPG_MASK          ASHFT24(0xFUL)
++#define L1F_HALFD_JAM_IPG_MASK          0xFUL
 +#define L1F_HALFD_JAM_IPG_SHIFT         24
-+#define L1F_HALFD_ABEBT_MASK            ASHFT20(0xFUL)
++#define L1F_HALFD_ABEBT_MASK            0xFUL
 +#define L1F_HALFD_ABEBT_SHIFT           20
 +#define L1F_HALFD_ABEBE                 BIT(19)
 +#define L1F_HALFD_BPNB                  BIT(18)
 +#define L1F_HALFD_NOBO                  BIT(17)
 +#define L1F_HALFD_EDXSDFR               BIT(16)
-+#define L1F_HALFD_RETRY_MASK            ASHFT12(0xFUL)
++#define L1F_HALFD_RETRY_MASK            0xFUL
 +#define L1F_HALFD_RETRY_SHIFT           12
-+#define L1F_HALFD_LCOL_MASK             ASHFT0(0x3FFUL)
++#define L1F_HALFD_LCOL_MASK             0x3FFUL
 +#define L1F_HALFD_LCOL_SHIFT            0
 +
 +#define L1F_MTU                         0x149C
@@ -6396,50 +6386,50 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MTU_MIN                     64
 +
 +#define L1F_SRAM0                       0x1500
-+#define L1F_SRAM_RFD_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1F_SRAM_RFD_TAIL_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_RFD_TAIL_ADDR_SHIFT    16
-+#define L1F_SRAM_RFD_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1F_SRAM_RFD_HEAD_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_RFD_HEAD_ADDR_SHIFT    0
 +
 +#define L1F_SRAM1                       0x1510
-+#define L1F_SRAM_RFD_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1F_SRAM_RFD_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1F_SRAM_RFD_LEN_SHIFT          0
 +
 +#define L1F_SRAM2                       0x1518
-+#define L1F_SRAM_TRD_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1F_SRAM_TRD_TAIL_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_TRD_TAIL_ADDR_SHIFT    16
-+#define L1F_SRMA_TRD_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1F_SRMA_TRD_HEAD_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_TRD_HEAD_ADDR_SHIFT    0
 +
 +#define L1F_SRAM3                       0x151C
-+#define L1F_SRAM_TRD_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1F_SRAM_TRD_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1F_SRAM_TRD_LEN_SHIFT          0
 +
 +#define L1F_SRAM4                       0x1520
-+#define L1F_SRAM_RXF_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1F_SRAM_RXF_TAIL_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_RXF_TAIL_ADDR_SHIFT    16
-+#define L1F_SRAM_RXF_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1F_SRAM_RXF_HEAD_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_RXF_HEAD_ADDR_SHIFT    0
 +
 +#define L1F_SRAM5                       0x1524
-+#define L1F_SRAM_RXF_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1F_SRAM_RXF_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1F_SRAM_RXF_LEN_SHIFT          0
 +#define L1F_SRAM_RXF_LEN_8K             (8*1024)
 +
 +#define L1F_SRAM6                       0x1528
-+#define L1F_SRAM_TXF_TAIL_ADDR_MASK     ASHFT16(0xFFFUL)
++#define L1F_SRAM_TXF_TAIL_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_TXF_TAIL_ADDR_SHIFT    16
-+#define L1F_SRAM_TXF_HEAD_ADDR_MASK     ASHFT0(0xFFFUL)
++#define L1F_SRAM_TXF_HEAD_ADDR_MASK     0xFFFUL
 +#define L1F_SRAM_TXF_HEAD_ADDR_SHIFT    0
 +
 +#define L1F_SRAM7                       0x152C
-+#define L1F_SRAM_TXF_LEN_MASK           ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1F_SRAM_TXF_LEN_MASK           0xFFFUL /* 8BYTES UNIT */
 +#define L1F_SRAM_TXF_LEN_SHIFT          0
 +
 +#define L1F_SRAM8                       0x1530
-+#define L1F_SRAM_PATTERN_ADDR_MASK      ASHFT16(0xFFFUL)
++#define L1F_SRAM_PATTERN_ADDR_MASK      0xFFFUL
 +#define L1F_SRAM_PATTERN_ADDR_SHIFT     16
-+#define L1F_SRAM_TSO_ADDR_MASK          ASHFT0(0xFFFUL)
++#define L1F_SRAM_TSO_ADDR_MASK          0xFFFUL
 +#define L1F_SRAM_TSO_ADDR_SHIFT         0
 +
 +#define L1F_SRAM9                       0x1534
@@ -6452,12 +6442,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_RFD_ADDR_LO                 0x1550
 +#define L1F_RFD_RING_SZ                 0x1560
 +#define L1F_RFD_BUF_SZ                  0x1564
-+#define L1F_RFD_BUF_SZ_MASK             ASHFT0(0xFFFFUL)
++#define L1F_RFD_BUF_SZ_MASK             0xFFFFUL
 +#define L1F_RFD_BUF_SZ_SHIFT            0
 +
 +#define L1F_RRD_ADDR_LO                 0x1568
 +#define L1F_RRD_RING_SZ                 0x1578
-+#define L1F_RRD_RING_SZ_MASK            ASHFT0(0xFFFUL)
++#define L1F_RRD_RING_SZ_MASK            0xFFFUL
 +#define L1F_RRD_RING_SZ_SHIFT           0
 +
 +#define L1F_TPD_PRI3_ADDR_LO            0x14E4      /* HIGHEST PRIORITY */
@@ -6476,13 +6466,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_TPD_PRI0_CIDX               0x15F6      /* 16BIT */
 +
 +#define L1F_TPD_RING_SZ                 0x1584
-+#define L1F_TPD_RING_SZ_MASK            ASHFT0(0xFFFFUL)
++#define L1F_TPD_RING_SZ_MASK            0xFFFFUL
 +#define L1F_TPD_RING_SZ_SHIFT           0
 +
 +#define L1F_CMB_ADDR_LO                 0x1588      /* NOT USED */
 +
 +#define L1F_TXQ0                        0x1590
-+#define L1F_TXQ0_TXF_BURST_PREF_MASK    ASHFT16(0xFFFFUL)
++#define L1F_TXQ0_TXF_BURST_PREF_MASK    0xFFFFUL
 +#define L1F_TXQ0_TXF_BURST_PREF_SHIFT   16
 +#define L1F_TXQ_TXF_BURST_PREF_DEF      0x200
 +#define L1F_TXQ0_PEDING_CLR             BIT(8)
@@ -6490,22 +6480,22 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_TXQ0_MODE_ENHANCE           BIT(6)
 +#define L1F_TXQ0_EN                     BIT(5)
 +#define L1F_TXQ0_SUPT_IPOPT             BIT(4)
-+#define L1F_TXQ0_TPD_BURSTPREF_MASK     ASHFT0(0xFUL)
++#define L1F_TXQ0_TPD_BURSTPREF_MASK     0xFUL
 +#define L1F_TXQ0_TPD_BURSTPREF_SHIFT    0
 +#define L1F_TXQ_TPD_BURSTPREF_DEF       5
 +
 +#define L1F_TXQ1                        0x1594
 +#define L1F_TXQ1_ERRLGPKT_DROP_EN       BIT(11)          /* drop error large
 +							 * (>rfd buf) packet */
-+#define L1F_TXQ1_JUMBO_TSOTHR_MASK      ASHFT0(0x7FFUL) /* 8BYTES UNIT */
++#define L1F_TXQ1_JUMBO_TSOTHR_MASK      0x7FFUL /* 8BYTES UNIT */
 +#define L1F_TXQ1_JUMBO_TSOTHR_SHIFT     0
 +#define L1F_TXQ1_JUMBO_TSO_TH           (7*1024)    /* byte */
 +
 +#define L1F_TXQ2                        0x1598          /* ENTER L1 CONTROL */
 +#define L1F_TXQ2_BURST_EN               BIT(31)
-+#define L1F_TXQ2_BURST_HI_WM_MASK       ASHFT16(0xFFFUL)
++#define L1F_TXQ2_BURST_HI_WM_MASK       0xFFFUL
 +#define L1F_TXQ2_BURST_HI_WM_SHIFT      16
-+#define L1F_TXQ2_BURST_LO_WM_MASK       ASHFT0(0xFFFUL)
++#define L1F_TXQ2_BURST_LO_WM_MASK       0xFFFUL
 +#define L1F_TXQ2_BURST_LO_WM_SHIFT      0
 +
 +#define L1F_RXQ0                        0x15A0
@@ -6513,16 +6503,16 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_RXQ0_CUT_THRU_EN            BIT(30)
 +#define L1F_RXQ0_RSS_HASH_EN            BIT(29)
 +#define L1F_RXQ0_NON_IP_QTBL            BIT(28)  /* 0:q0,1:table */
-+#define L1F_RXQ0_RSS_MODE_MASK          ASHFT26(3UL)
++#define L1F_RXQ0_RSS_MODE_MASK          0x3UL
 +#define L1F_RXQ0_RSS_MODE_SHIFT         26
 +#define L1F_RXQ0_RSS_MODE_DIS           0
 +#define L1F_RXQ0_RSS_MODE_SQSI          1
 +#define L1F_RXQ0_RSS_MODE_MQSI          2
 +#define L1F_RXQ0_RSS_MODE_MQMI          3
-+#define L1F_RXQ0_NUM_RFD_PREF_MASK      ASHFT20(0x3FUL)
++#define L1F_RXQ0_NUM_RFD_PREF_MASK      0x3FUL
 +#define L1F_RXQ0_NUM_RFD_PREF_SHIFT     20
 +#define L1F_RXQ0_NUM_RFD_PREF_DEF       8
-+#define L1F_RXQ0_IDT_TBL_SIZE_MASK      ASHFT8(0x1FFUL)
++#define L1F_RXQ0_IDT_TBL_SIZE_MASK      0x1FFUL
 +#define L1F_RXQ0_IDT_TBL_SIZE_SHIFT     8
 +#define L1F_RXQ0_IDT_TBL_SIZE_DEF       0x100
 +#define L1F_RXQ0_IPV6_PARSE_EN          BIT(7)
@@ -6535,7 +6525,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	L1F_RXQ0_RSS_HSTYP_IPV4_TCP_EN  |\
 +	L1F_RXQ0_RSS_HSTYP_IPV6_EN      |\
 +	L1F_RXQ0_RSS_HSTYP_IPV4_EN)
-+#define L1F_RXQ0_ASPM_THRESH_MASK       ASHFT0(3UL)
++#define L1F_RXQ0_ASPM_THRESH_MASK       0x3UL
 +#define L1F_RXQ0_ASPM_THRESH_SHIFT      0
 +#define L1F_RXQ0_ASPM_THRESH_NO         0
 +#define L1F_RXQ0_ASPM_THRESH_1M         1
@@ -6543,24 +6533,30 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_RXQ0_ASPM_THRESH_100M       3
 +
 +#define L1F_RXQ1                        0x15A4
-+#define L1F_RXQ1_JUMBO_LKAH_MASK        ASHFT12(0xFUL)      /* 32BYTES UNIT */
++#define L1F_RXQ1_JUMBO_LKAH_MASK        0xFUL      /* 32BYTES UNIT */
 +#define L1F_RXQ1_JUMBO_LKAH_SHIFT       12
-+#define L1F_RXQ1_RFD_PREF_DOWN_MASK     ASHFT6(0x3FUL)
++#define L1F_RXQ1_RFD_PREF_DOWN_MASK     0x3FUL
 +#define L1F_RXQ1_RFD_PREF_DOWN_SHIFT    6
-+#define L1F_RXQ1_RFD_PREF_UP_MASK       ASHFT0(0x3FUL)
++#define L1F_RXQ1_RFD_PREF_UP_MASK       0x3FUL
 +#define L1F_RXQ1_RFD_PREF_UP_SHIFT      0
 +
 +#define L1F_RXQ2                        0x15A8
 +/* XOFF: USED SRAM LOWER THAN IT, THEN NOTIFY THE PEER TO SEND AGAIN */
-+#define L1F_RXQ2_RXF_XOFF_THRESH_MASK   ASHFT16(0xFFFUL)
++#define L1F_RXQ2_RXF_XOFF_THRESH_MASK   0xFFFUL
 +#define L1F_RXQ2_RXF_XOFF_THRESH_SHIFT  16
-+#define L1F_RXQ2_RXF_XON_THRESH_MASK    ASHFT0(0xFFFUL)
++#define L1F_RXQ2_RXF_XON_THRESH_MASK    0xFFFUL
 +#define L1F_RXQ2_RXF_XON_THRESH_SHIFT   0
++/*
++ * Size = tx-packet(1522) + IPG(12) + SOF(8) + 64(Pause) + IPG(12) + SOF(8) +
++ *        rx-packet(1522) + delay-of-link(64)
++ *      = 3212.
++ */
++#define L1F_RXQ2_RXF_FLOW_CTRL_RSVD     3212
 +
 +#define L1F_RXQ3                        0x15AC
-+#define L1F_RXQ3_RXD_TIMER_MASK         ASHFT16(0x7FFFUL)
++#define L1F_RXQ3_RXD_TIMER_MASK         0x7FFFUL
 +#define L1F_RXQ3_RXD_TIMER_SHIFT        16
-+#define L1F_RXQ3_RXD_THRESH_MASK        ASHFT0(0xFFFUL) /* 8BYTES UNIT */
++#define L1F_RXQ3_RXD_THRESH_MASK        0xFFFUL /* 8BYTES UNIT */
 +#define L1F_RXQ3_RXD_THRESH_SHIFT       0
 +
 +#define L1F_DMA                         0x15C0
@@ -6568,26 +6564,26 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_DMA_WPEND_CLR               BIT(30)
 +#define L1F_DMA_RPEND_CLR               BIT(29)
 +#define L1F_DMA_WSRAM_RDCTRL            BIT(28)
-+#define L1F_DMA_RCHNL_SEL_MASK          ASHFT26(3UL)
++#define L1F_DMA_RCHNL_SEL_MASK          0x3UL
 +#define L1F_DMA_RCHNL_SEL_SHIFT         26
 +#define L1F_DMA_RCHNL_SEL_1             0
 +#define L1F_DMA_RCHNL_SEL_2             1
 +#define L1F_DMA_RCHNL_SEL_3             2
 +#define L1F_DMA_RCHNL_SEL_4             3
 +#define L1F_DMA_SMB_EN                  BIT(21)      /* smb dma enable */
-+#define L1F_DMA_WDLY_CNT_MASK           ASHFT16(0xFUL)
++#define L1F_DMA_WDLY_CNT_MASK           0xFUL
 +#define L1F_DMA_WDLY_CNT_SHIFT          16
 +#define L1F_DMA_WDLY_CNT_DEF            4
-+#define L1F_DMA_RDLY_CNT_MASK           ASHFT11(0x1FUL)
++#define L1F_DMA_RDLY_CNT_MASK           0x1FUL
 +#define L1F_DMA_RDLY_CNT_SHIFT          11
 +#define L1F_DMA_RDLY_CNT_DEF            15
 +#define L1F_DMA_RREQ_PRI_DATA           BIT(10)      /* 0:tpd, 1:data */
-+#define L1F_DMA_WREQ_BLEN_MASK          ASHFT7(7UL)
++#define L1F_DMA_WREQ_BLEN_MASK          0x7UL
 +#define L1F_DMA_WREQ_BLEN_SHIFT         7
-+#define L1F_DMA_RREQ_BLEN_MASK          ASHFT4(7UL)
++#define L1F_DMA_RREQ_BLEN_MASK          0x7UL
 +#define L1F_DMA_RREQ_BLEN_SHIFT         4
 +#define L1F_DMA_PENDING_AUTO_RST        BIT(3)
-+#define L1F_DMA_RORDER_MODE_MASK        ASHFT0(7UL)
++#define L1F_DMA_RORDER_MODE_MASK        0x7UL
 +#define L1F_DMA_RORDER_MODE_SHIFT       0
 +#define L1F_DMA_RORDER_MODE_OUT         4
 +#define L1F_DMA_RORDER_MODE_ENHANCE     2
@@ -6615,6 +6611,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_WOL0_LINK_EVT               BIT(10)
 +#define L1F_WOL0_MAGIC_EVT              BIT(9)
 +#define L1F_WOL0_PATTERN_EVT            BIT(8)
++#define L1F_WOL0_SWOI_EVT               BIT(7)
 +#define L1F_WOL0_OOB_EN                 BIT(6)
 +#define L1F_WOL0_PME_LINK               BIT(5)
 +#define L1F_WOL0_LINK_EN                BIT(4)
@@ -6624,31 +6621,31 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_WOL0_PATTERN_EN             BIT(0)
 +
 +#define L1F_WOL1                        0x14A4
-+#define L1F_WOL1_PT3_LEN_MASK           ASHFT24(0xFFUL)
++#define L1F_WOL1_PT3_LEN_MASK           0xFFUL
 +#define L1F_WOL1_PT3_LEN_SHIFT          24
-+#define L1F_WOL1_PT2_LEN_MASK           ASHFT16(0xFFUL)
++#define L1F_WOL1_PT2_LEN_MASK           0xFFUL
 +#define L1F_WOL1_PT2_LEN_SHIFT          16
-+#define L1F_WOL1_PT1_LEN_MASK           ASHFT8(0xFFUL)
++#define L1F_WOL1_PT1_LEN_MASK           0xFFUL
 +#define L1F_WOL1_PT1_LEN_SHIFT          8
-+#define L1F_WOL1_PT0_LEN_MASK           ASHFT0(0xFFUL)
++#define L1F_WOL1_PT0_LEN_MASK           0xFFUL
 +#define L1F_WOL1_PT0_LEN_SHIFT          0
 +
 +#define L1F_WOL2                        0x14A8
-+#define L1F_WOL2_PT7_LEN_MASK           ASHFT24(0xFFUL)
++#define L1F_WOL2_PT7_LEN_MASK           0xFFUL
 +#define L1F_WOL2_PT7_LEN_SHIFT          24
-+#define L1F_WOL2_PT6_LEN_MASK           ASHFT16(0xFFUL)
++#define L1F_WOL2_PT6_LEN_MASK           0xFFUL
 +#define L1F_WOL2_PT6_LEN_SHIFT          16
-+#define L1F_WOL2_PT5_LEN_MASK           ASHFT8(0xFFUL)
++#define L1F_WOL2_PT5_LEN_MASK           0xFFUL
 +#define L1F_WOL2_PT5_LEN_SHIFT          8
-+#define L1F_WOL2_PT4_LEN_MASK           ASHFT0(0xFFUL)
++#define L1F_WOL2_PT4_LEN_MASK           0xFFUL
 +#define L1F_WOL2_PT4_LEN_SHIFT          0
 +
 +#define L1F_RFD_PIDX                    0x15E0
-+#define L1F_RFD_PIDX_MASK               ASHFT0(0xFFFUL)
++#define L1F_RFD_PIDX_MASK               0xFFFUL
 +#define L1F_RFD_PIDX_SHIFT              0
 +
 +#define L1F_RFD_CIDX                    0x15F8
-+#define L1F_RFD_CIDX_MASK               ASHFT0(0xFFFUL)
++#define L1F_RFD_CIDX_MASK               0xFFFUL
 +#define L1F_RFD_CIDX_SHIFT              0
 +
 +/* MIB */
@@ -6744,7 +6741,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1F_INT_RETRIG                  0x1608  /* re-send deassrt/assert
 +						 * if sw no reflect */
-+#define L1F_INT_RETRIG_TIMER_MASK       ASHFT0(0xFFFFUL)
++#define L1F_INT_RETRIG_TIMER_MASK       0xFFFFUL
 +#define L1F_INT_RETRIG_TIMER_SHIFT      0
 +#define L1F_INT_RETRIG_TO               20000   /* 40ms */
 +
@@ -6764,9 +6761,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLT1_DST_IP2                0x1A18
 +#define L1F_FLT1_DST_IP3                0x1A1C
 +#define L1F_FLT1_PORT                   0x1A20
-+#define L1F_FLT1_PORT_DST_MASK          ASHFT16(0xFFFFUL)
++#define L1F_FLT1_PORT_DST_MASK          0xFFFFUL
 +#define L1F_FLT1_PORT_DST_SHIFT         16
-+#define L1F_FLT1_PORT_SRC_MASK          ASHFT0(0xFFFFUL)
++#define L1F_FLT1_PORT_SRC_MASK          0xFFFFUL
 +#define L1F_FLT1_PORT_SRC_SHIFT         0
 +
 +#define L1F_FLT2_SRC_IP0                0x1A24
@@ -6778,9 +6775,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLT2_DST_IP2                0x1A40
 +#define L1F_FLT2_DST_IP3                0x1A44
 +#define L1F_FLT2_PORT                   0x1A48
-+#define L1F_FLT2_PORT_DST_MASK          ASHFT16(0xFFFFUL)
++#define L1F_FLT2_PORT_DST_MASK          0xFFFFUL
 +#define L1F_FLT2_PORT_DST_SHIFT         16
-+#define L1F_FLT2_PORT_SRC_MASK          ASHFT0(0xFFFFUL)
++#define L1F_FLT2_PORT_SRC_MASK          0xFFFFUL
 +#define L1F_FLT2_PORT_SRC_SHIFT         0
 +
 +#define L1F_FLT3_SRC_IP0                0x1A4C
@@ -6792,9 +6789,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLT3_DST_IP2                0x1A64
 +#define L1F_FLT3_DST_IP3                0x1A68
 +#define L1F_FLT3_PORT                   0x1A6C
-+#define L1F_FLT3_PORT_DST_MASK          ASHFT16(0xFFFFUL)
++#define L1F_FLT3_PORT_DST_MASK          0xFFFFUL
 +#define L1F_FLT3_PORT_DST_SHIFT         16
-+#define L1F_FLT3_PORT_SRC_MASK          ASHFT0(0xFFFFUL)
++#define L1F_FLT3_PORT_SRC_MASK          0xFFFFUL
 +#define L1F_FLT3_PORT_SRC_SHIFT         0
 +
 +#define L1F_FLT4_SRC_IP0                0x1A70
@@ -6806,9 +6803,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLT4_DST_IP2                0x1A88
 +#define L1F_FLT4_DST_IP3                0x1A8C
 +#define L1F_FLT4_PORT                   0x1A90
-+#define L1F_FLT4_PORT_DST_MASK          ASHFT16(0xFFFFUL)
++#define L1F_FLT4_PORT_DST_MASK          0xFFFFUL
 +#define L1F_FLT4_PORT_DST_SHIFT         16
-+#define L1F_FLT4_PORT_SRC_MASK          ASHFT0(0xFFFFUL)
++#define L1F_FLT4_PORT_SRC_MASK          0xFFFFUL
 +#define L1F_FLT4_PORT_SRC_SHIFT         0
 +
 +#define L1F_FLT5_SRC_IP0                0x1A94
@@ -6820,9 +6817,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLT5_DST_IP2                0x1AAC
 +#define L1F_FLT5_DST_IP3                0x1AB0
 +#define L1F_FLT5_PORT                   0x1AB4
-+#define L1F_FLT5_PORT_DST_MASK          ASHFT16(0xFFFFUL)
++#define L1F_FLT5_PORT_DST_MASK          0xFFFFUL
 +#define L1F_FLT5_PORT_DST_SHIFT         16
-+#define L1F_FLT5_PORT_SRC_MASK          ASHFT0(0xFFFFUL)
++#define L1F_FLT5_PORT_SRC_MASK          0xFFFFUL
 +#define L1F_FLT5_PORT_SRC_SHIFT         0
 +
 +#define L1F_FLT6_SRC_IP0                0x1AB8
@@ -6834,13 +6831,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLT6_DST_IP2                0x1628
 +#define L1F_FLT6_DST_IP3                0x162C
 +#define L1F_FLT6_PORT                   0x1630
-+#define L1F_FLT6_PORT_DST_MASK          ASHFT16(0xFFFFUL)
++#define L1F_FLT6_PORT_DST_MASK          0xFFFFUL
 +#define L1F_FLT6_PORT_DST_SHIFT         16
-+#define L1F_FLT6_PORT_SRC_MASK          ASHFT0(0xFFFFUL)
++#define L1F_FLT6_PORT_SRC_MASK          0xFFFFUL
 +#define L1F_FLT6_PORT_SRC_SHIFT         0
 +
 +#define L1F_FLTCTRL                     0x1634
-+#define L1F_FLTCTRL_PSTHR_TIMER_MASK    ASHFT24(0xFFUL)
++#define L1F_FLTCTRL_PSTHR_TIMER_MASK    0xFFUL
 +#define L1F_FLTCTRL_PSTHR_TIMER_SHIFT   24
 +#define L1F_FLTCTRL_CHK_DSTPRT6         BIT(23)
 +#define L1F_FLTCTRL_CHK_SRCPRT6         BIT(22)
@@ -6868,26 +6865,26 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_FLTCTRL_CHK_SRCIP1          BIT(0)
 +
 +#define L1F_DROP_ALG1                   0x1638
-+#define L1F_DROP_ALG1_BWCHGVAL_MASK     ASHFT12(0xFFFFFUL)
++#define L1F_DROP_ALG1_BWCHGVAL_MASK     0xFFFFFUL
 +#define L1F_DROP_ALG1_BWCHGVAL_SHIFT    12
 +#define L1F_DROP_ALG1_BWCHGSCL_6        BIT(11)      /* 0:3.125%, 1:6.25% */
 +#define L1F_DROP_ALG1_ASUR_LWQ_EN       BIT(10)
 +#define L1F_DROP_ALG1_BWCHGVAL_EN       BIT(9)
 +#define L1F_DROP_ALG1_BWCHGSCL_EN       BIT(8)
 +#define L1F_DROP_ALG1_PSTHR_AUTO        BIT(7)       /* 0:manual, 1:auto */
-+#define L1F_DROP_ALG1_MIN_PSTHR_MASK    ASHFT5(3UL)
++#define L1F_DROP_ALG1_MIN_PSTHR_MASK    0x3UL
 +#define L1F_DROP_ALG1_MIN_PSTHR_SHIFT   5
 +#define L1F_DROP_ALG1_MIN_PSTHR_1_16    0
 +#define L1F_DROP_ALG1_MIN_PSTHR_1_8     1
 +#define L1F_DROP_ALG1_MIN_PSTHR_1_4     2
 +#define L1F_DROP_ALG1_MIN_PSTHR_1_2     3
-+#define L1F_DROP_ALG1_PSCL_MASK         ASHFT3(3UL)
++#define L1F_DROP_ALG1_PSCL_MASK         0x3UL
 +#define L1F_DROP_ALG1_PSCL_SHIFT        3
 +#define L1F_DROP_ALG1_PSCL_1_4          0
 +#define L1F_DROP_ALG1_PSCL_1_8          1
 +#define L1F_DROP_ALG1_PSCL_1_16         2
 +#define L1F_DROP_ALG1_PSCL_1_32         3
-+#define L1F_DROP_ALG1_TIMESLOT_MASK     ASHFT0(7UL)
++#define L1F_DROP_ALG1_TIMESLOT_MASK     0x7UL
 +#define L1F_DROP_ALG1_TIMESLOT_SHIFT    0
 +#define L1F_DROP_ALG1_TIMESLOT_4MS      0
 +#define L1F_DROP_ALG1_TIMESLOT_8MS      1
@@ -6899,9 +6896,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_DROP_ALG1_TIMESLOT_512MS    7
 +
 +#define L1F_DROP_ALG2                   0x163C
-+#define L1F_DROP_ALG2_SMPLTIME_MASK     ASHFT24(0xFUL)
++#define L1F_DROP_ALG2_SMPLTIME_MASK     0xFUL
 +#define L1F_DROP_ALG2_SMPLTIME_SHIFT    24
-+#define L1F_DROP_ALG2_LWQBW_MASK        ASHFT0(0xFFFFFFUL)
++#define L1F_DROP_ALG2_LWQBW_MASK        0xFFFFFFUL
 +#define L1F_DROP_ALG2_LWQBW_SHIFT       0
 +
 +#define L1F_SMB_TIMER                   0x15C4
@@ -6928,9 +6925,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	L1F_CLK_GATE_DMAR           |\
 +	L1F_CLK_GATE_DMAW)
 +#define L1F_CLK_GATE_ALL_B0         (\
-+	L1F_CLK_GATE_ALL_A0         |\
-+	L1F_CLK_GATE_125M_SW_AZ     |\
-+	L1F_CLK_GATE_125M_SW_IDLE)
++	L1F_CLK_GATE_ALL_A0)
 +
 +
 +
@@ -6966,9 +6961,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_SYNC_IPV4_DA                0x1A04
 +
 +#define L1F_SYNC_V4PORT                 0x1A08
-+#define L1F_SYNC_V4PORT_DST_MASK        ASHFT16(0xFFFFUL)
++#define L1F_SYNC_V4PORT_DST_MASK        0xFFFFUL
 +#define L1F_SYNC_V4PORT_DST_SHIFT       16
-+#define L1F_SYNC_V4PORT_SRC_MASK        ASHFT0(0xFFFFUL)
++#define L1F_SYNC_V4PORT_SRC_MASK        0xFFFFUL
 +#define L1F_SYNC_V4PORT_SRC_SHIFT       0
 +
 +#define L1F_SYNC_IPV6_SA0               0x1A0C
@@ -6981,9 +6976,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_SYNC_IPV6_DA3               0x1A28
 +
 +#define L1F_SYNC_V6PORT                 0x1A2C
-+#define L1F_SYNC_V6PORT_DST_MASK        ASHFT16(0xFFFFUL)
++#define L1F_SYNC_V6PORT_DST_MASK        0xFFFFUL
 +#define L1F_SYNC_V6PORT_DST_SHIFT       16
-+#define L1F_SYNC_V6PORT_SRC_MASK        ASHFT0(0xFFFFUL)
++#define L1F_SYNC_V6PORT_SRC_MASK        0xFFFFUL
 +#define L1F_SYNC_V6PORT_SRC_SHIFT       0
 +
 +#define L1F_ARP_REMOTE_IPV4             0x1A30
@@ -7099,39 +7094,39 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_RSS_BASE_CPU_NUM            0x15B8
 +
 +#define L1F_MSI_MAP_TBL1                0x15D0
-+#define L1F_MSI_MAP_TBL1_ALERT_MASK     ASHFT28(0xFUL)
++#define L1F_MSI_MAP_TBL1_ALERT_MASK     0xFUL
 +#define L1F_MSI_MAP_TBL1_ALERT_SHIFT    28
-+#define L1F_MSI_MAP_TBL1_TIMER_MASK     ASHFT24(0xFUL)
++#define L1F_MSI_MAP_TBL1_TIMER_MASK     0xFUL
 +#define L1F_MSI_MAP_TBL1_TIMER_SHIFT    24
-+#define L1F_MSI_MAP_TBL1_TXQ1_MASK      ASHFT20(0xFUL)
++#define L1F_MSI_MAP_TBL1_TXQ1_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL1_TXQ1_SHIFT     20
-+#define L1F_MSI_MAP_TBL1_TXQ0_MASK      ASHFT16(0xFUL)
++#define L1F_MSI_MAP_TBL1_TXQ0_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL1_TXQ0_SHIFT     16
-+#define L1F_MSI_MAP_TBL1_RXQ3_MASK      ASHFT12(0xFUL)
++#define L1F_MSI_MAP_TBL1_RXQ3_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL1_RXQ3_SHIFT     12
-+#define L1F_MSI_MAP_TBL1_RXQ2_MASK      ASHFT8(0xFUL)
++#define L1F_MSI_MAP_TBL1_RXQ2_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL1_RXQ2_SHIFT     8
-+#define L1F_MSI_MAP_TBL1_RXQ1_MASK      ASHFT4(0xFUL)
++#define L1F_MSI_MAP_TBL1_RXQ1_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL1_RXQ1_SHIFT     4
-+#define L1F_MSI_MAP_TBL1_RXQ0_MASK      ASHFT0(0xFUL)
++#define L1F_MSI_MAP_TBL1_RXQ0_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL1_RXQ0_SHIFT     0
 +
 +#define L1F_MSI_MAP_TBL2                0x15D8
-+#define L1F_MSI_MAP_TBL2_PHY_MASK       ASHFT28(0xFUL)
++#define L1F_MSI_MAP_TBL2_PHY_MASK       0xFUL
 +#define L1F_MSI_MAP_TBL2_PHY_SHIFT      28
-+#define L1F_MSI_MAP_TBL2_SMB_MASK       ASHFT24(0xFUL)
++#define L1F_MSI_MAP_TBL2_SMB_MASK       0xFUL
 +#define L1F_MSI_MAP_TBL2_SMB_SHIFT      24
-+#define L1F_MSI_MAP_TBL2_TXQ3_MASK      ASHFT20(0xFUL)
++#define L1F_MSI_MAP_TBL2_TXQ3_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL2_TXQ3_SHIFT     20
-+#define L1F_MSI_MAP_TBL2_TXQ2_MASK      ASHFT16(0xFUL)
++#define L1F_MSI_MAP_TBL2_TXQ2_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL2_TXQ2_SHIFT     16
-+#define L1F_MSI_MAP_TBL2_RXQ7_MASK      ASHFT12(0xFUL)
++#define L1F_MSI_MAP_TBL2_RXQ7_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL2_RXQ7_SHIFT     12
-+#define L1F_MSI_MAP_TBL2_RXQ6_MASK      ASHFT8(0xFUL)
++#define L1F_MSI_MAP_TBL2_RXQ6_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL2_RXQ6_SHIFT     8
-+#define L1F_MSI_MAP_TBL2_RXQ5_MASK      ASHFT4(0xFUL)
++#define L1F_MSI_MAP_TBL2_RXQ5_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL2_RXQ5_SHIFT     4
-+#define L1F_MSI_MAP_TBL2_RXQ4_MASK      ASHFT0(0xFUL)
++#define L1F_MSI_MAP_TBL2_RXQ4_MASK      0xFUL
 +#define L1F_MSI_MAP_TBL2_RXQ4_SHIFT     0
 +
 +#define L1F_MSI_ID_MAP                  0x15D4
@@ -7169,20 +7164,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define L1F_MSI_RETRANS_TIMER           0x1920
 +#define L1F_MSI_MASK_SEL_LINE           BIT(16)  /* 1:line,0:standard*/
-+#define L1F_MSI_RETRANS_TM_MASK         ASHFT0(0xFFFFUL)
++#define L1F_MSI_RETRANS_TM_MASK         0xFFFFUL
 +#define L1F_MSI_RETRANS_TM_SHIFT        0
 +
 +#define L1F_CR_DMA_CTRL                 0x1930
 +#define L1F_CR_DMA_CTRL_PRI             BIT(22)
 +#define L1F_CR_DMA_CTRL_RRDRXD_JOINT    BIT(21)
-+#define L1F_CR_DMA_CTRL_BWCREDIT_MASK   ASHFT19(0x3UL)
++#define L1F_CR_DMA_CTRL_BWCREDIT_MASK   0x3UL
 +#define L1F_CR_DMA_CTRL_BWCREDIT_SHIFT  19
 +#define L1F_CR_DMA_CTRL_BWCREDIT_2KB    0
 +#define L1F_CR_DMA_CTRL_BWCREDIT_1KB    1
 +#define L1F_CR_DMA_CTRL_BWCREDIT_4KB    2
 +#define L1F_CR_DMA_CTRL_BWCREDIT_8KB    3
 +#define L1F_CR_DMA_CTRL_BW_EN           BIT(18)
-+#define L1F_CR_DMA_CTRL_BW_RATIO_MASK   ASHFT16(0x3UL)
++#define L1F_CR_DMA_CTRL_BW_RATIO_MASK   0x3UL
 +#define L1F_CR_DMA_CTRL_BW_RATIO_1_2    0
 +#define L1F_CR_DMA_CTRL_BW_RATIO_1_4    1
 +#define L1F_CR_DMA_CTRL_BW_RATIO_1_8    2
@@ -7191,18 +7186,18 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_CR_DMA_CTRL_TXEARLY_EN      BIT(10)
 +#define L1F_CR_DMA_CTRL_RXEARLY_EN      BIT(9)
 +#define L1F_CR_DMA_CTRL_WEARLY_EN       BIT(8)
-+#define L1F_CR_DMA_CTRL_RXTH_MASK       ASHFT4(0xFUL)
-+#define L1F_CR_DMA_CTRL_WTH_MASK        ASHFT0(0xFUL)
++#define L1F_CR_DMA_CTRL_RXTH_MASK       0xFUL
++#define L1F_CR_DMA_CTRL_WTH_MASK        0xFUL
 +
 +
 +#define L1F_EFUSE_BIST                  0x1934
-+#define L1F_EFUSE_BIST_COL_MASK         ASHFT24(0x3FUL)
++#define L1F_EFUSE_BIST_COL_MASK         0x3FUL
 +#define L1F_EFUSE_BIST_COL_SHIFT        24
-+#define L1F_EFUSE_BIST_ROW_MASK         ASHFT12(0x7FUL)
++#define L1F_EFUSE_BIST_ROW_MASK         0x7FUL
 +#define L1F_EFUSE_BIST_ROW_SHIFT        12
-+#define L1F_EFUSE_BIST_STEP_MASK        ASHFT8(0xFUL)
++#define L1F_EFUSE_BIST_STEP_MASK        0xFUL
 +#define L1F_EFUSE_BIST_STEP_SHIFT       8
-+#define L1F_EFUSE_BIST_PAT_MASK         ASHFT4(0x7UL)
++#define L1F_EFUSE_BIST_PAT_MASK         0x7UL
 +#define L1F_EFUSE_BIST_PAT_SHIFT        4
 +#define L1F_EFUSE_BIST_CRITICAL         BIT(3)
 +#define L1F_EFUSE_BIST_FIXED            BIT(2)
@@ -7213,76 +7208,77 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +/* TX QoS */
 +#define L1F_WRR                         0x1938
-+#define L1F_WRR_PRI_MASK                ASHFT29(3UL)
++#define L1F_WRR_PRI_MASK                0x3UL
 +#define L1F_WRR_PRI_SHIFT               29
 +#define L1F_WRR_PRI_RESTRICT_ALL        0
 +#define L1F_WRR_PRI_RESTRICT_HI         1
 +#define L1F_WRR_PRI_RESTRICT_HI2        2
 +#define L1F_WRR_PRI_RESTRICT_NONE       3
-+#define L1F_WRR_PRI3_MASK               ASHFT24(0x1FUL)
++#define L1F_WRR_PRI3_MASK               0x1FUL
 +#define L1F_WRR_PRI3_SHIFT              24
-+#define L1F_WRR_PRI2_MASK               ASHFT16(0x1FUL)
++#define L1F_WRR_PRI2_MASK               0x1FUL
 +#define L1F_WRR_PRI2_SHIFT              16
-+#define L1F_WRR_PRI1_MASK               ASHFT8(0x1FUL)
++#define L1F_WRR_PRI1_MASK               0x1FUL
 +#define L1F_WRR_PRI1_SHIFT              8
-+#define L1F_WRR_PRI0_MASK               ASHFT0(0x1FUL)
++#define L1F_WRR_PRI0_MASK               0x1FUL
 +#define L1F_WRR_PRI0_SHIFT              0
 +
 +#define L1F_HQTPD                       0x193C
 +#define L1F_HQTPD_BURST_EN              BIT(31)
-+#define L1F_HQTPD_Q3_NUMPREF_MASK       ASHFT8(0xFUL)
++#define L1F_HQTPD_Q3_NUMPREF_MASK       0xFUL
 +#define L1F_HQTPD_Q3_NUMPREF_SHIFT      8
-+#define L1F_HQTPD_Q2_NUMPREF_MASK       ASHFT4(0xFUL)
++#define L1F_HQTPD_Q2_NUMPREF_MASK       0xFUL
 +#define L1F_HQTPD_Q2_NUMPREF_SHIFT      4
-+#define L1F_HQTPD_Q1_NUMPREF_MASK       ASHFT0(0xFUL)
++#define L1F_HQTPD_Q1_NUMPREF_MASK       0xFUL
 +#define L1F_HQTPD_Q1_NUMPREF_SHIFT      0
 +
 +#define L1F_CPUMAP1                     0x19A0
-+#define L1F_CPUMAP1_VCT7_MASK           ASHFT28(0xFUL)
++#define L1F_CPUMAP1_VCT7_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT7_SHIFT          28
-+#define L1F_CPUMAP1_VCT6_MASK           ASHFT24(0xFUL)
++#define L1F_CPUMAP1_VCT6_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT6_SHIFT          24
-+#define L1F_CPUMAP1_VCT5_MASK           ASHFT20(0xFUL)
++#define L1F_CPUMAP1_VCT5_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT5_SHIFT          20
-+#define L1F_CPUMAP1_VCT4_MASK           ASHFT16(0xFUL)
++#define L1F_CPUMAP1_VCT4_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT4_SHIFT          16
-+#define L1F_CPUMAP1_VCT3_MASK           ASHFT12(0xFUL)
++#define L1F_CPUMAP1_VCT3_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT3_SHIFT          12
-+#define L1F_CPUMAP1_VCT2_MASK           ASHFT8(0xFUL)
++#define L1F_CPUMAP1_VCT2_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT2_SHIFT          8
-+#define L1F_CPUMAP1_VCT1_MASK           ASHFT4(0xFUL)
++#define L1F_CPUMAP1_VCT1_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT1_SHIFT          4
-+#define L1F_CPUMAP1_VCT0_MASK           ASHFT0(0xFUL)
++#define L1F_CPUMAP1_VCT0_MASK           0xFUL
 +#define L1F_CPUMAP1_VCT0_SHIFT          0
 +
 +#define L1F_CPUMAP2                     0x19A4
-+#define L1F_CPUMAP2_VCT15_MASK          ASHFT28(0xFUL)
++#define L1F_CPUMAP2_VCT15_MASK          0xFUL
 +#define L1F_CPUMAP2_VCT15_SHIFT         28
-+#define L1F_CPUMAP2_VCT14_MASK          ASHFT24(0xFUL)
++#define L1F_CPUMAP2_VCT14_MASK          0xFUL
 +#define L1F_CPUMAP2_VCT14_SHIFT         24
-+#define L1F_CPUMAP2_VCT13_MASK          ASHFT20(0xFUL)
++#define L1F_CPUMAP2_VCT13_MASK          0xFUL
 +#define L1F_CPUMAP2_VCT13_SHIFT         20
-+#define L1F_CPUMAP2_VCT12_MASK          ASHFT16(0xFUL)
++#define L1F_CPUMAP2_VCT12_MASK          0xFUL
 +#define L1F_CPUMAP2_VCT12_SHIFT         16
-+#define L1F_CPUMAP2_VCT11_MASK          ASHFT12(0xFUL)
++#define L1F_CPUMAP2_VCT11_MASK          0xFUL
 +#define L1F_CPUMAP2_VCT11_SHIFT         12
-+#define L1F_CPUMAP2_VCT10_MASK          ASHFT8(0xFUL)
++#define L1F_CPUMAP2_VCT10_MASK          0xFUL
 +#define L1F_CPUMAP2_VCT10_SHIFT         8
-+#define L1F_CPUMAP2_VCT9_MASK           ASHFT4(0xFUL)
++#define L1F_CPUMAP2_VCT9_MASK           0xFUL
 +#define L1F_CPUMAP2_VCT9_SHIFT          4
-+#define L1F_CPUMAP2_VCT8_MASK           ASHFT0(0xFUL)
++#define L1F_CPUMAP2_VCT8_MASK           0xFUL
 +#define L1F_CPUMAP2_VCT8_SHIFT          0
 +
 +#define L1F_MISC                        0x19C0
 +#define L1F_MISC_MODU                   BIT(31)  /* 0:vector,1:cpu */
 +#define L1F_MISC_OVERCUR                BIT(29)
 +#define L1F_MISC_PSWR_EN                BIT(28)
-+#define L1F_MISC_PSW_CTRL_MASK          ASHFT24(0xFUL)
++#define L1F_MISC_PSW_CTRL_MASK          0xFUL
 +#define L1F_MISC_PSW_CTRL_SHIFT         24
-+#define L1F_MISC_PSW_OCP_MASK           ASHFT21(7UL)
++#define L1F_MISC_PSW_OCP_MASK           0x7UL
 +#define L1F_MISC_PSW_OCP_SHIFT          21
++#define L1F_MISC_PSW_OCP_DEF            0x7
 +#define L1F_MISC_V18_HIGH               BIT(20)
-+#define L1F_MISC_LPO_CTRL_MASK          ASHFT16(0xFUL)
++#define L1F_MISC_LPO_CTRL_MASK          0xFUL
 +#define L1F_MISC_LPO_CTRL_SHIFT         16
 +#define L1F_MISC_ISO_EN                 BIT(12)
 +#define L1F_MISC_XSTANA_ALWAYS_ON       BIT(11)
@@ -7296,7 +7292,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MISC_EXTN25M_SEL            BIT(4)   /* 0:chipset,1:cystle */
 +#define L1F_MISC_INTNLOSC_OPEN          BIT(3)
 +#define L1F_MISC_SMBUS_AT_LED           BIT(2)
-+#define L1F_MISC_PPS_AT_LED_MASK        ASHFT0(3UL)
++#define L1F_MISC_PPS_AT_LED_MASK        0x3UL
 +#define L1F_MISC_PPS_AT_LED_SHIFT       0
 +#define L1F_MISC_PPS_AT_LED_ACT         1
 +#define L1F_MISC_PPS_AT_LED_10_100      2
@@ -7305,6 +7301,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MISC1                       0x19C4
 +#define L1F_MSC1_BLK_CRASPM_REQ         BIT(15)
 +
++#define L1F_MSIC2                       0x19C8
++#define L1F_MSIC2_CALB_START            BIT(0)
++
 +#define L1F_MISC3                       0x19CC
 +#define L1F_MISC3_25M_BY_SW             BIT(1)   /* 1:Software control 25M */
 +#define L1F_MISC3_25M_NOTO_INTNL        BIT(0)   /* 0:25M switch to intnl OSC */
@@ -7378,13 +7377,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* Cable-Detect-Test Control Register */
 +#define L1F_MII_CDTC                        0x16
 +#define L1F_CDTC_EN                         1       /* sc */
-+#define L1F_CDTC_PAIR_MASK                  ASHFT8(3U)
++#define L1F_CDTC_PAIR_MASK                  0x3U
 +#define L1F_CDTC_PAIR_SHIFT                 8
 +
 +
 +/* Cable-Detect-Test Status Register */
 +#define L1F_MII_CDTS                        0x1C
-+#define L1F_CDTS_STATUS_MASK                ASHFT8(3U)
++#define L1F_CDTS_STATUS_MASK                0x3U
 +#define L1F_CDTS_STATUS_SHIFT               8
 +#define L1F_CDTS_STATUS_NORMAL              0
 +#define L1F_CDTS_STATUS_SHORT               1
@@ -7397,137 +7396,148 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/***************************** debug port *************************************/
 +
 +#define L1F_MIIDBG_ANACTRL                  0x00
-+#define L1F_ANACTRL_CLK125M_DELAY_EN        BIT(15)
-+#define L1F_ANACTRL_VCO_FAST                BIT(14)
-+#define L1F_ANACTRL_VCO_SLOW                BIT(13)
-+#define L1F_ANACTRL_AFE_MODE_EN             BIT(12)
-+#define L1F_ANACTRL_LCKDET_PHY              BIT(11)
-+#define L1F_ANACTRL_LCKDET_EN               BIT(10)
-+#define L1F_ANACTRL_OEN_125M                BIT(9)
-+#define L1F_ANACTRL_HBIAS_EN                BIT(8)
-+#define L1F_ANACTRL_HB_EN                   BIT(7)
-+#define L1F_ANACTRL_SEL_HSP                 BIT(6)
-+#define L1F_ANACTRL_CLASSA_EN               BIT(5)
-+#define L1F_ANACTRL_MANUSWON_SWR_MASK       ASHFT2(3U)
++#define L1F_ANACTRL_CLK125M_DELAY_EN        0x8000
++#define L1F_ANACTRL_VCO_FAST                0x4000
++#define L1F_ANACTRL_VCO_SLOW                0x2000
++#define L1F_ANACTRL_AFE_MODE_EN             0x1000
++#define L1F_ANACTRL_LCKDET_PHY              0x0800
++#define L1F_ANACTRL_LCKDET_EN               0x0400
++#define L1F_ANACTRL_OEN_125M                0x0200
++#define L1F_ANACTRL_HBIAS_EN                0x0100
++#define L1F_ANACTRL_HB_EN                   0x0080
++#define L1F_ANACTRL_SEL_HSP                 0x0040
++#define L1F_ANACTRL_CLASSA_EN               0x0020
++#define L1F_ANACTRL_MANUSWON_SWR_MASK       0x3U
 +#define L1F_ANACTRL_MANUSWON_SWR_SHIFT      2
 +#define L1F_ANACTRL_MANUSWON_SWR_2V         0
 +#define L1F_ANACTRL_MANUSWON_SWR_1P9V       1
 +#define L1F_ANACTRL_MANUSWON_SWR_1P8V       2
 +#define L1F_ANACTRL_MANUSWON_SWR_1P7V       3
-+#define L1F_ANACTRL_MANUSWON_BW3_4M         BIT(1)
-+#define L1F_ANACTRL_RESTART_CAL             BIT(0)
++#define L1F_ANACTRL_MANUSWON_BW3_4M         0x0002
++#define L1F_ANACTRL_RESTART_CAL             0x0001
 +#define L1F_ANACTRL_DEF                     0x02EF
 +
 +
 +#define L1F_MIIDBG_SYSMODCTRL               0x04
-+#define L1F_SYSMODCTRL_IECHOADJ_PFMH_PHY    BIT(15)
-+#define L1F_SYSMODCTRL_IECHOADJ_BIASGEN     BIT(14)
-+#define L1F_SYSMODCTRL_IECHOADJ_PFML_PHY    BIT(13)
-+#define L1F_SYSMODCTRL_IECHOADJ_PS_MASK     ASHFT10(3U)
++#define L1F_SYSMODCTRL_IECHOADJ_PFMH_PHY    0x8000
++#define L1F_SYSMODCTRL_IECHOADJ_BIASGEN     0x4000
++#define L1F_SYSMODCTRL_IECHOADJ_PFML_PHY    0x2000
++#define L1F_SYSMODCTRL_IECHOADJ_PS_MASK     0x3U
 +#define L1F_SYSMODCTRL_IECHOADJ_PS_SHIFT    10
 +#define L1F_SYSMODCTRL_IECHOADJ_PS_40       3
 +#define L1F_SYSMODCTRL_IECHOADJ_PS_20       2
 +#define L1F_SYSMODCTRL_IECHOADJ_PS_0        1
-+#define L1F_SYSMODCTRL_IECHOADJ_10BT_100MV  BIT(6) /* 1:100mv, 0:200mv */
-+#define L1F_SYSMODCTRL_IECHOADJ_HLFAP_MASK  ASHFT4(3U)
++#define L1F_SYSMODCTRL_IECHOADJ_10BT_100MV  0x0040 /* 1:100mv, 0:200mv */
++#define L1F_SYSMODCTRL_IECHOADJ_HLFAP_MASK  0x3U
 +#define L1F_SYSMODCTRL_IECHOADJ_HLFAP_SHIFT 4
-+#define L1F_SYSMODCTRL_IECHOADJ_VDFULBW     BIT(3)
-+#define L1F_SYSMODCTRL_IECHOADJ_VDBIASHLF   BIT(2)
-+#define L1F_SYSMODCTRL_IECHOADJ_VDAMPHLF    BIT(1)
-+#define L1F_SYSMODCTRL_IECHOADJ_VDLANSW     BIT(0)
++#define L1F_SYSMODCTRL_IECHOADJ_VDFULBW     0x0008
++#define L1F_SYSMODCTRL_IECHOADJ_VDBIASHLF   0x0004
++#define L1F_SYSMODCTRL_IECHOADJ_VDAMPHLF    0x0002
++#define L1F_SYSMODCTRL_IECHOADJ_VDLANSW     0x0001
 +#define L1F_SYSMODCTRL_IECHOADJ_DEF         0xBB8B /* en half bias */
 +
 +
 +#define L1F_MIIDBG_SRDSYSMOD                0x05
-+#define L1F_SRDSYSMOD_LCKDET_EN             BIT(13)
-+#define L1F_SRDSYSMOD_PLL_EN                BIT(11)
-+#define L1F_SRDSYSMOD_SEL_HSP               BIT(10)
-+#define L1F_SRDSYSMOD_HLFTXDR               BIT(9)
-+#define L1F_SRDSYSMOD_TXCLK_DELAY_EN        BIT(8)
-+#define L1F_SRDSYSMOD_TXELECIDLE            BIT(7)
-+#define L1F_SRDSYSMOD_DEEMP_EN              BIT(6)
-+#define L1F_SRDSYSMOD_MS_PAD                BIT(2)
-+#define L1F_SRDSYSMOD_CDR_ADC_VLTG          BIT(1)
-+#define L1F_SRDSYSMOD_CDR_DAC_1MA           BIT(0)
++#define L1F_SRDSYSMOD_LCKDET_EN             0x2000
++#define L1F_SRDSYSMOD_PLL_EN                0x0800
++#define L1F_SRDSYSMOD_SEL_HSP               0x0400
++#define L1F_SRDSYSMOD_HLFTXDR               0x0200
++#define L1F_SRDSYSMOD_TXCLK_DELAY_EN        0x0100
++#define L1F_SRDSYSMOD_TXELECIDLE            0x0080
++#define L1F_SRDSYSMOD_DEEMP_EN              0x0040
++#define L1F_SRDSYSMOD_MS_PAD                0x0004
++#define L1F_SRDSYSMOD_CDR_ADC_VLTG          0x0002
++#define L1F_SRDSYSMOD_CDR_DAC_1MA           0x0001
 +#define L1F_SRDSYSMOD_DEF                   0x2C46
 +
 +
 +#define L1F_MIIDBG_HIBNEG                   0x0B
-+#define L1F_HIBNEG_PSHIB_EN                 BIT(15)
-+#define L1F_HIBNEG_WAKE_BOTH                BIT(14)
-+#define L1F_HIBNEG_ONOFF_ANACHG_SUDEN       BIT(13)
-+#define L1F_HIBNEG_HIB_PULSE                BIT(12)
-+#define L1F_HIBNEG_GATE_25M_EN              BIT(11)
-+#define L1F_HIBNEG_RST_80U                  BIT(10)
-+#define L1F_HIBNEG_RST_TIMER_MASK           ASHFT8(3U)
++#define L1F_HIBNEG_PSHIB_EN                 0x8000
++#define L1F_HIBNEG_WAKE_BOTH                0x4000
++#define L1F_HIBNEG_ONOFF_ANACHG_SUDEN       0x2000
++#define L1F_HIBNEG_HIB_PULSE                0x1000
++#define L1F_HIBNEG_GATE_25M_EN              0x0800
++#define L1F_HIBNEG_RST_80U                  0x0400
++#define L1F_HIBNEG_RST_TIMER_MASK           0x3U
 +#define L1F_HIBNEG_RST_TIMER_SHIFT          8
-+#define L1F_HIBNEG_GTX_CLK_DELAY_MASK       ASHFT5(3U)
++#define L1F_HIBNEG_GTX_CLK_DELAY_MASK       0x3U
 +#define L1F_HIBNEG_GTX_CLK_DELAY_SHIFT      5
-+#define L1F_HIBNEG_BYPSS_BRKTIMER           BIT(4)
++#define L1F_HIBNEG_BYPSS_BRKTIMER           0x0010
 +#define L1F_HIBNEG_DEF                      0xBC40
 +
 +#define L1F_MIIDBG_TST10BTCFG               0x12
-+#define L1F_TST10BTCFG_INTV_TIMER_MASK      ASHFT14(3U)
++#define L1F_TST10BTCFG_INTV_TIMER_MASK      0x3U
 +#define L1F_TST10BTCFG_INTV_TIMER_SHIFT     14
-+#define L1F_TST10BTCFG_TRIGER_TIMER_MASK    ASHFT12(3U)
++#define L1F_TST10BTCFG_TRIGER_TIMER_MASK    0x3U
 +#define L1F_TST10BTCFG_TRIGER_TIMER_SHIFT   12
-+#define L1F_TST10BTCFG_DIV_MAN_MLT3_EN      BIT(11)
-+#define L1F_TST10BTCFG_OFF_DAC_IDLE         BIT(10)
-+#define L1F_TST10BTCFG_LPBK_DEEP            BIT(2) /* 1:deep,0:shallow */
++#define L1F_TST10BTCFG_DIV_MAN_MLT3_EN      0x0800
++#define L1F_TST10BTCFG_OFF_DAC_IDLE         0x0400
++#define L1F_TST10BTCFG_LPBK_DEEP            0x0004 /* 1:deep,0:shallow */
 +#define L1F_TST10BTCFG_DEF                  0x4C04
 +
 +#define L1F_MIIDBG_AZ_ANADECT               0x15
-+#define L1F_AZ_ANADECT_10BTRX_TH            BIT(15)
-+#define L1F_AZ_ANADECT_BOTH_01CHNL          BIT(14)
-+#define L1F_AZ_ANADECT_INTV_MASK            ASHFT8(0x3FU)
++#define L1F_AZ_ANADECT_10BTRX_TH            0x8000
++#define L1F_AZ_ANADECT_BOTH_01CHNL          0x4000
++#define L1F_AZ_ANADECT_INTV_MASK            0x3FU
 +#define L1F_AZ_ANADECT_INTV_SHIFT           8
-+#define L1F_AZ_ANADECT_THRESH_MASK          ASHFT4(0xFU)
++#define L1F_AZ_ANADECT_THRESH_MASK          0xFU
 +#define L1F_AZ_ANADECT_THRESH_SHIFT         4
-+#define L1F_AZ_ANADECT_CHNL_MASK            ASHFT0(0xFU)
++#define L1F_AZ_ANADECT_CHNL_MASK            0xFU
 +#define L1F_AZ_ANADECT_CHNL_SHIFT           0
 +#define L1F_AZ_ANADECT_DEF                  0x3220
 +#define L1F_AZ_ANADECT_LONG                 0x3210
 +
++#define L1F_MIIDBG_MSE16DB                  0x18
++#define L1F_MSE16DB_UP                      0x05EA
++#define L1F_MSE16DB_DOWN                    0x02EA
++
++#define L1F_MIIDBG_MSE20DB                  0x1C
++#define L1F_MSE20DB_TH_MASK                 0x7F
++#define L1F_MSE20DB_TH_SHIFT                2
++#define L1F_MSE20DB_TH_DEF                  0x2E
++#define L1F_MSE20DB_TH_HI                   0x54
++
 +#define L1F_MIIDBG_AGC                      0x23
-+#define L1F_AGC_2_VGA_MASK                  ASHFT8(0x3FU)
++#define L1F_AGC_2_VGA_MASK                  0x3FU
 +#define L1F_AGC_2_VGA_SHIFT                 8
 +#define L1F_AGC_LONG1G_LIMT                 40
 +#define L1F_AGC_LONG100M_LIMT               44
 +
 +#define L1F_MIIDBG_LEGCYPS                  0x29
-+#define L1F_LEGCYPS_EN                      BIT(15)
-+#define L1F_LEGCYPS_DAC_AMP1000_MASK        ASHFT12(7U)
++#define L1F_LEGCYPS_EN                      0x8000
++#define L1F_LEGCYPS_DAC_AMP1000_MASK        0x7U
 +#define L1F_LEGCYPS_DAC_AMP1000_SHIFT       12
-+#define L1F_LEGCYPS_DAC_AMP100_MASK         ASHFT9(7U)
++#define L1F_LEGCYPS_DAC_AMP100_MASK         0x7U
 +#define L1F_LEGCYPS_DAC_AMP100_SHIFT        9
-+#define L1F_LEGCYPS_DAC_AMP10_MASK          ASHFT6(7U)
++#define L1F_LEGCYPS_DAC_AMP10_MASK          0x7U
 +#define L1F_LEGCYPS_DAC_AMP10_SHIFT         6
-+#define L1F_LEGCYPS_UNPLUG_TIMER_MASK       ASHFT3(7U)
++#define L1F_LEGCYPS_UNPLUG_TIMER_MASK       0x7U
 +#define L1F_LEGCYPS_UNPLUG_TIMER_SHIFT      3
-+#define L1F_LEGCYPS_UNPLUG_DECT_EN          BIT(2)
-+#define L1F_LEGCYPS_ECNC_PS_EN              BIT(0)
++#define L1F_LEGCYPS_UNPLUG_DECT_EN          0x0004
++#define L1F_LEGCYPS_ECNC_PS_EN              0x0001
 +#define L1F_LEGCYPS_DEF                     0x129D
 +
 +#define L1F_MIIDBG_TST100BTCFG              0x36
-+#define L1F_TST100BTCFG_NORMAL_BW_EN        BIT(15)
-+#define L1F_TST100BTCFG_BADLNK_BYPASS       BIT(14)
-+#define L1F_TST100BTCFG_SHORTCABL_TH_MASK   ASHFT8(0x3FU)
++#define L1F_TST100BTCFG_NORMAL_BW_EN        0x8000
++#define L1F_TST100BTCFG_BADLNK_BYPASS       0x4000
++#define L1F_TST100BTCFG_SHORTCABL_TH_MASK   0x3FU
 +#define L1F_TST100BTCFG_SHORTCABL_TH_SHIFT  8
-+#define L1F_TST100BTCFG_LITCH_EN            BIT(7)
-+#define L1F_TST100BTCFG_VLT_SW              BIT(6)
-+#define L1F_TST100BTCFG_LONGCABL_TH_MASK    ASHFT0(0x3FU)
++#define L1F_TST100BTCFG_LITCH_EN            0x0080
++#define L1F_TST100BTCFG_VLT_SW              0x0040
++#define L1F_TST100BTCFG_LONGCABL_TH_MASK    0x3FU
 +#define L1F_TST100BTCFG_LONGCABL_TH_SHIFT   0
 +#define L1F_TST100BTCFG_DEF                 0xE12C
 +
 +#define L1F_MIIDBG_GREENCFG                 0x3B
-+#define L1F_GREENCFG_MSTPS_MSETH2_MASK      ASHFT8(0xFFU)
++#define L1F_GREENCFG_MSTPS_MSETH2_MASK      0xFFU
 +#define L1F_GREENCFG_MSTPS_MSETH2_SHIFT     8
-+#define L1F_GREENCFG_MSTPS_MSETH1_MASK      ASHFT0(0xFFU)
++#define L1F_GREENCFG_MSTPS_MSETH1_MASK      0xFFU
 +#define L1F_GREENCFG_MSTPS_MSETH1_SHIFT     0
 +#define L1F_GREENCFG_DEF                    0x7078
 +
 +#define L1F_MIIDBG_GREENCFG2                0x3D
-+#define L1F_GREENCFG2_GATE_DFSE_EN          BIT(7)
++#define L1F_GREENCFG2_BP_GREEN              0x8000
++#define L1F_GREENCFG2_GATE_DFSE_EN          0x0080
 +
 +
 +/***************************** extension **************************************/
@@ -7535,44 +7545,51 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/******* dev 3 *********/
 +#define L1F_MIIEXT_PCS                      3
 +
++#define L1F_MIIEXT_CLDCTRL3                 0x8003
++#define L1F_CLDCTRL3_BP_CABLE1TH_DET_GT     0x8000
++#define L1F_CLDCTRL3_AZ_DISAMP              0x1000
++
++#define L1F_MIIEXT_CLDCTRL5                 0x8005
++#define L1F_CLDCTRL5_BP_VD_HLFBIAS          0x4000
++
 +#define L1F_MIIEXT_CLDCTRL6                 0x8006
-+#define L1F_CLDCTRL6_CAB_LEN_MASK           ASHFT0(0xFFU)
++#define L1F_CLDCTRL6_CAB_LEN_MASK           0xFFU
 +#define L1F_CLDCTRL6_CAB_LEN_SHIFT          0
 +#define L1F_CLDCTRL6_CAB_LEN_SHORT1G        116
 +#define L1F_CLDCTRL6_CAB_LEN_SHORT100M      152
 +
 +#define L1F_MIIEXT_CLDCTRL7                 0x8007
-+#define L1F_CLDCTRL7_VDHLF_BIAS_TH_MASK     ASHFT9(0x7FU)
++#define L1F_CLDCTRL7_VDHLF_BIAS_TH_MASK     0x7FU
 +#define L1F_CLDCTRL7_VDHLF_BIAS_TH_SHIFT    9
-+#define L1F_CLDCTRL7_AFE_AZ_MASK            ASHFT4(0x1FU)
++#define L1F_CLDCTRL7_AFE_AZ_MASK            0x1FU
 +#define L1F_CLDCTRL7_AFE_AZ_SHIFT           4
-+#define L1F_CLDCTRL7_SIDE_PEAK_TH_MASK      ASHFT0(0xFU)
++#define L1F_CLDCTRL7_SIDE_PEAK_TH_MASK      0xFU
 +#define L1F_CLDCTRL7_SIDE_PEAK_TH_SHIFT     0
 +#define L1F_CLDCTRL7_DEF                    0x6BF6 /* ???? */
 +
 +#define L1F_MIIEXT_AZCTRL                   0x8008
-+#define L1F_AZCTRL_SHORT_TH_MASK            ASHFT8(0xFFU)
++#define L1F_AZCTRL_SHORT_TH_MASK            0xFFU
 +#define L1F_AZCTRL_SHORT_TH_SHIFT           8
-+#define L1F_AZCTRL_LONG_TH_MASK             ASHFT0(0xFFU)
++#define L1F_AZCTRL_LONG_TH_MASK             0xFFU
 +#define L1F_AZCTRL_LONG_TH_SHIFT            0
 +#define L1F_AZCTRL_DEF                      0x1629
 +
 +#define L1F_MIIEXT_AZCTRL2                  0x8009
-+#define L1F_AZCTRL2_WAKETRNING_MASK         ASHFT8(0xFFU)
++#define L1F_AZCTRL2_WAKETRNING_MASK         0xFFU
 +#define L1F_AZCTRL2_WAKETRNING_SHIFT        8
-+#define L1F_AZCTRL2_QUIET_TIMER_MASH        ASHFT6(3U)
++#define L1F_AZCTRL2_QUIET_TIMER_MASK        0x3U
 +#define L1F_AZCTRL2_QUIET_TIMER_SHIFT       6
-+#define L1F_AZCTRL2_PHAS_JMP2               BIT(4)
-+#define L1F_AZCTRL2_CLKTRCV_125MD16         BIT(3)
-+#define L1F_AZCTRL2_GATE1000_EN             BIT(2)
-+#define L1F_AZCTRL2_AVRG_FREQ               BIT(1)
-+#define L1F_AZCTRL2_PHAS_JMP4               BIT(0)
++#define L1F_AZCTRL2_PHAS_JMP2               0x0010
++#define L1F_AZCTRL2_CLKTRCV_125MD16         0x0008
++#define L1F_AZCTRL2_GATE1000_EN             0x0004
++#define L1F_AZCTRL2_AVRG_FREQ               0x0002
++#define L1F_AZCTRL2_PHAS_JMP4               0x0001
 +#define L1F_AZCTRL2_DEF                     0x32C0
 +
 +#define L1F_MIIEXT_AZCTRL6                  0x800D
 +
 +#define L1F_MIIEXT_VDRVBIAS                 0x8062
-+#define L1F_VDRVBIAS_SEL_MASK               ASHFT0(0x3U)
++#define L1F_VDRVBIAS_SEL_MASK               0x3U
 +#define L1F_VDRVBIAS_SEL_SHIFT              0
 +#define L1F_VDRVBIAS_DEF                    0x3
 +
@@ -7580,20 +7597,23 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define L1F_MIIEXT_ANEG                     7
 +
 +#define L1F_MIIEXT_LOCAL_EEEADV             0x3C
-+#define L1F_LOCAL_EEEADV_1000BT             BIT(2)
-+#define L1F_LOCAL_EEEADV_100BT              BIT(1)
++#define L1F_LOCAL_EEEADV_1000BT             0x0004
++#define L1F_LOCAL_EEEADV_100BT              0x0002
 +
 +#define L1F_MIIEXT_REMOTE_EEEADV            0x3D
-+#define L1F_REMOTE_EEEADV_1000BT            BIT(2)
-+#define L1F_REMOTE_EEEADV_100BT             BIT(1)
++#define L1F_REMOTE_EEEADV_1000BT            0x0004
++#define L1F_REMOTE_EEEADV_100BT             0x0002
 +
 +#define L1F_MIIEXT_EEE_ANEG                 0x8000
-+#define L1F_EEE_ANEG_1000M                  BIT(2)
-+#define L1F_EEE_ANEG_100M                   BIT(1)
++#define L1F_EEE_ANEG_1000M                  0x0004
++#define L1F_EEE_ANEG_100M                   0x0002
 +
 +#define L1F_MIIEXT_AFE                      0x801A
-+#define L1F_AFE_10BT_100M_TH                BIT(6)
++#define L1F_AFE_10BT_100M_TH                0x0040
 +
++#define L1F_MIIEXT_S3DIG10                  0x8023
++#define L1F_MIIEXT_S3DIG10_SL               0x0001  /* 1=bypass 10BT rx fifo */
++#define L1F_MIIEXT_S3DIG10_DEF              0       /* 0= original 10BT rx */
 +
 +#define L1F_MIIEXT_NLP34                    0x8025
 +#define L1F_MIIEXT_NLP34_DEF                0x1010  /* for 160m */
@@ -7617,7 +7637,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1f_get_perm_macaddr(struct alx_hw *hw, u8 *addr);
++int l1f_get_perm_macaddr(struct alx_hw *hw, u8 *addr);
 +
 +
 +/* reset mac & dma
@@ -7625,14 +7645,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *     0: success
 + *     non-0:fail
 + */
-+u16 l1f_reset_mac(struct alx_hw *hw);
++int l1f_reset_mac(struct alx_hw *hw);
 +
 +/* reset phy
 + * return
 + *    0: success
 + *    non-0:fail
 + */
-+u16 l1f_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en);
++int l1f_reset_phy(struct alx_hw *hw, bool pws_en, bool az_en, bool ptp_en);
 +
 +
 +/* reset pcie
@@ -7641,7 +7661,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0:fail
 + */
-+u16 l1f_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en);
++int l1f_reset_pcie(struct alx_hw *hw, bool l0s_en, bool l1_en);
 +
 +
 +/* disable/enable MAC/RXQ/TXQ
@@ -7652,13 +7672,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    0:success
 + *    non-0-fail
 + */
-+u16 l1f_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl);
++int l1f_enable_mac(struct alx_hw *hw, bool en, u16 en_ctrl);
 +
 +
 +/* enable/disable aspm support
 + * that will change settings for phy/mac/pcie
 + */
-+u16 l1f_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat);
++int l1f_enable_aspm(struct alx_hw *hw, bool l0s_en, bool l1_en, u8 lnk_stat);
 +
 +
 +/* initialize phy for speed / flow control
@@ -7666,12 +7686,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    if autoNeg, is link capability to tell the peer
 + *    if force mode, is forced speed/duplex
 + */
-+u16 l1f_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
++int l1f_init_phy_spdfc(struct alx_hw *hw, bool auto_neg,
 +		       u8 lnk_cap, bool fc_en);
 +
 +/* do post setting on phy if link up/down event occur
 + */
-+u16 l1f_post_phy_link(struct alx_hw *hw, bool linkon, u8 wire_spd);
++int l1f_post_phy_link(struct alx_hw *hw, bool az_en, bool linkon, u8 wire_spd);
 +
 +
 +/* do power saving setting befor enter suspend mode
@@ -7679,31 +7699,31 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + *    1. phy link must be established before calling this function
 + *    2. wol option (pattern,magic,link,etc.) is configed before call it.
 + */
-+u16 l1f_powersaving(struct alx_hw *hw, u8 wire_spd, bool wol_en,
++int l1f_powersaving(struct alx_hw *hw, u8 wire_spd, bool wol_en,
 +		    bool mahw_en, bool macrx_en, bool pws_en);
 +
 +/* read phy register */
-+u16 l1f_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast, u16 reg,
++int l1f_read_phy(struct alx_hw *hw, bool ext, u8 dev, bool fast, u16 reg,
 +		 u16 *data);
 +
 +/* write phy register */
-+u16 l1f_write_phy(struct alx_hw *hw, bool ext, u8 dev,  bool fast, u16 reg,
++int l1f_write_phy(struct alx_hw *hw, bool ext, u8 dev,  bool fast, u16 reg,
 +		  u16 data);
 +
 +/* phy debug port */
-+u16 l1f_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data);
-+u16 l1f_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data);
++int l1f_read_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 *data);
++int l1f_write_phydbg(struct alx_hw *hw, bool fast, u16 reg, u16 data);
 +
 +
 +/* check the configuration of the PHY */
-+u16 l1f_get_phy_config(struct alx_hw *hw);
++int l1f_get_phy_config(struct alx_hw *hw);
 +
 +/*
 + * initialize mac basically
 + *  most of hi-feature no init
 + *      MAC/PHY should be reset before call this function
 + */
-+u16 l1f_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
++int l1f_init_mac(struct alx_hw *hw, u8 *addr, u32 txmem_hi,
 +		 u32 *tx_mem_lo, u8 tx_qnum, u16 txring_sz,
 +		 u32 rxmem_hi, u32 rfdmem_lo, u32 rrdmem_lo,
 +		 u16 rxring_sz, u16 rxbuf_sz, u16 smb_timer,
@@ -7712,10 +7732,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +#endif/*L1F_HW_H_*/
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alx.h b/drivers/net/ethernet/atheros/alx/alx.h
+new file mode 100644
+index 0000000..389b4af
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alx.h
-@@ -0,0 +1,670 @@
+@@ -0,0 +1,739 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -7735,29 +7757,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#ifndef _ALX_H_
 +#define _ALX_H_
 +
-+#include <linux/types.h>
-+#include <linux/module.h>
-+#include <linux/pci.h>
 +#include <linux/netdevice.h>
-+#include <linux/vmalloc.h>
-+#include <linux/string.h>
-+#include <linux/in.h>
-+#include <linux/interrupt.h>
-+#include <linux/ip.h>
-+#include <linux/tcp.h>
-+#include <linux/sctp.h>
-+#include <linux/pkt_sched.h>
-+#include <linux/ipv6.h>
-+#include <linux/slab.h>
-+#include <net/checksum.h>
-+#include <net/ip6_checksum.h>
-+#include <linux/ethtool.h>
-+#include <linux/if_vlan.h>
-+#include <linux/mii.h>
-+#include <linux/cpumask.h>
-+#include <linux/aer.h>
 +
 +#include "alx_sw.h"
++#ifdef CONFIG_ALX_DEBUGFS
++#include "alx_dfs.h"
++#endif
 +
 +/*
 + * Definition to enable some features
@@ -7775,7 +7780,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define CONFIG_ALX_RSS
 +#endif
 +
-+#define ALX_MSG_DEFAULT         0
++#define ALX_MSG_DEFAULT         0x0
 +
 +/* Logging functions and macros */
 +#define alx_err(adpt, fmt, ...)	\
@@ -7783,21 +7788,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define ALX_VLAN_TO_TAG(_vlan, _tag) \
 +	do { \
-+		_tag =  ((((_vlan) >> 8) & 0xFF) | (((_vlan) & 0xFF) << 8)); \
++		_tag = ((((_vlan) >> 8) & 0xFF) | (((_vlan) & 0xFF) << 8)); \
 +	} while (0)
 +
 +#define ALX_TAG_TO_VLAN(_tag, _vlan) \
 +	do { \
-+		_vlan = ((((_tag) >> 8) & 0xFF) | (((_tag) & 0xFF) << 8)) ; \
++		_vlan = ((((_tag) >> 8) & 0xFF) | (((_tag) & 0xFF) << 8)); \
 +	} while (0)
 +
-+/* Coalescing Message Block */
-+struct coals_msg_block {
-+	int test;
-+};
-+
 +
 +#define BAR_0   0
++#define BAR_1   1
++#define BAR_5   5
++
 +
 +#define ALX_DEF_RX_BUF_SIZE	1536
 +#define ALX_MAX_JUMBO_PKT_SIZE	(9*1024)
@@ -7813,31 +7816,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define ALX_WATCHDOG_TIME   (5 * HZ)
 +
-+struct alx_cmb {
-+	char name[IFNAMSIZ + 9];
-+	void *cmb;
-+	dma_addr_t dma;
-+};
-+struct alx_smb {
-+	char name[IFNAMSIZ + 9];
-+	void *smb;
-+	dma_addr_t dma;
-+};
-+
-+
 +/*
 + * RRD : definition
 + */
 +
 +/* general parameter format of rrd */
-+struct alx_rrdes_general {
-+	u32 xsum:16;
-+	u32 nor:4;  /* number of RFD */
-+	u32 si:12;  /* start index of rfd-ring */
-+
++struct alx_sw_rrdes_general {
++#if defined(__LITTLE_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  xsum:16;
++	u32  nor:4;  /* number of RFD */
++	u32  si:12;  /* start index of rfd-ring */
++	/* dword 1 */
 +	u32 hash;
-+
-+	/* dword 3 */
++	/* dword 2 */
 +	u32 vlan_tag:16; /* vlan-tag */
 +	u32 pid:8;       /* Header Length of Header-Data Split. WORD unit */
 +	u32 reserve0:1;
@@ -7845,32 +7837,62 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	u32 rss_flag:4;  /* rss_flag 0, TCP(IPv6) flag for RSS hash algrithm
 +			  * rss_flag 1, IPv6 flag for RSS hash algrithm
 +			  * rss_flag 2, TCP(IPv4) flag for RSS hash algrithm
-+			  * rss_flag 3, IPv4 flag for RSS hash algrithm
-+			  */
-+
++			  * rss_flag 3, IPv4 flag for RSS hash algrithm */
 +	/* dword 3 */
-+	u32 pkt_len:14; /* length of the packet */
-+	u32 l4f:1;      /* L4(TCP/UDP) checksum failed */
-+	u32 ipf:1;      /* IP checksum failed */
-+	u32 vlan_flag:1;/* vlan tag */
++	u32 pkt_len:14;  /* length of the packet */
++	u32 l4f:1;       /* L4(TCP/UDP) checksum failed */
++	u32 ipf:1;       /* IP checksum failed */
++	u32 vlan_flag:1; /* vlan tag */
 +	u32 reserve:3;
-+	u32 res:1;      /* received error summary */
-+	u32 crc:1;      /* crc error */
-+	u32 fae:1;      /* frame alignment error */
-+	u32 trunc:1;    /* truncated packet, larger than MTU */
-+	u32 runt:1;     /* runt packet */
-+	u32 icmp:1;     /* incomplete packet,
-+			 * due to insufficient rx-descriptor
-+			 */
-+	u32 bar:1;      /* broadcast address received */
-+	u32 mar:1;      /* multicast address received */
-+	u32 type:1;     /* ethernet type */
-+	u32 fov:1;      /* fifo overflow*/
-+	u32 lene:1;     /* length error */
-+	u32 update:1;   /* update*/
++	u32 res:1;       /* received error summary */
++	u32 crc:1;       /* crc error */
++	u32 fae:1;       /* frame alignment error */
++	u32 trunc:1;     /* truncated packet, larger than MTU */
++	u32 runt:1;      /* runt packet */
++	u32 icmp:1;      /* incomplete packet due to insufficient rx-desc*/
++	u32 bar:1;       /* broadcast address received */
++	u32 mar:1;       /* multicast address received */
++	u32 type:1;      /* ethernet type */
++	u32 fov:1;       /* fifo overflow*/
++	u32 lene:1;      /* length error */
++	u32 update:1;    /* update*/
++#elif defined(__BIG_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  si:12;
++	u32  nor:4;
++	u32  xsum:16;
++	/* dword 1 */
++	u32 hash;
++	/* dword 2 */
++	u32 rss_flag:4;
++	u32 rss_cpu:3;
++	u32 reserve0:1;
++	u32 pid:8;
++	u32 vlan_tag:16;
++	/* dword 3 */
++	u32 update:1;
++	u32 lene:1;
++	u32 fov:1;
++	u32 type:1;
++	u32 mar:1;
++	u32 bar:1;
++	u32 icmp:1;
++	u32 runt:1;
++	u32 trunc:1;
++	u32 fae:1;
++	u32 crc:1;
++	u32 res:1;
++	u32 reserve1:3;
++	u32 vlan_flag:1;
++	u32 ipf:1;
++	u32 l4f:1;
++	u32 pkt_len:14;
++#else
++#error	"Please fix <asm/byteorder.h>"
++#endif
 +};
 +
-+union alx_rrdesc {
++union alx_hw_rrdesc {
 +	/* dword flat format */
 +	struct {
 +		__le32 dw0;
@@ -7891,7 +7913,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * do all le32_to_cpu() conversions on the spot.
 + */
 +union alx_sw_rrdesc {
-+	struct alx_rrdes_general genr;
++	struct alx_sw_rrdes_general genr;
 +
 +	/* dword flat format */
 +	struct {
@@ -7913,11 +7935,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + */
 +
 +/* general parameter format of rfd */
-+struct alx_rfdes_general {
++struct alx_sw_rfdes_general {
 +	u64   addr;
 +};
 +
-+union alx_rfdesc {
++union alx_hw_rfdesc {
 +	/* dword flat format */
 +	struct {
 +		__le32 dw0;
@@ -7935,7 +7957,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * do all le32_to_cpu() conversions on the spot.
 + */
 +union alx_sw_rfdesc {
-+	struct alx_rfdes_general genr;
++	struct alx_sw_rfdes_general genr;
 +
 +	/* dword flat format */
 +	struct {
@@ -7954,87 +7976,157 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + */
 +
 +/* general parameter format of tpd */
-+struct alx_tpdes_general {
++struct alx_sw_tpdes_general {
++#if defined(__LITTLE_ENDIAN_BITFIELD)
++	/* dword 0 */
 +	u32  buffer_len:16; /* include 4-byte CRC */
 +	u32  vlan_tag:16;
-+
-+	u32  l4hdr_offset:8; /* tcp/udp header offset to the 1st byte of
-+			      * the packet */
-+	u32  c_csum:1;   /* must be 0 in this format */
-+	u32  ip_csum:1;  /* do ip(v4) header checksum offload */
-+	u32  tcp_csum:1; /* do tcp checksum offload, both ipv4 and ipv6 */
-+	u32  udp_csum:1; /* do udp checksum offlaod, both ipv4 and ipv6 */
++	/* dword 1 */
++	u32  l4hdr_offset:8; /* l4 header offset to the 1st byte of packet */
++	u32  c_csum:1;
++	u32  ip_csum:1;
++	u32  tcp_csum:1;
++	u32  udp_csum:1;
 +	u32  lso:1;
-+	u32  lso_v2:1;  /* must be 0 in this format */
-+	u32  vtagged:1; /* vlan-id tagged already */
-+	u32  instag:1;  /* insert vlan tag */
++	u32  lso_v2:1;
++	u32  vtagged:1;   /* vlan-id tagged already */
++	u32  instag:1;    /* insert vlan tag */
 +
-+	u32  ipv4:1;    /* ipv4 packet */
-+	u32  type:1;    /* type of packet (ethernet_ii(1) or snap(0)) */
-+	u32  reserve:12; /* reserved, must be 0 */
-+	u32  epad:1;     /* even byte padding when this packet */
++	u32  ipv4:1;      /* ipv4 packet */
++	u32  type:1;      /* type of packet (ethernet_ii(0) or snap(1)) */
++	u32  reserve:12;
++	u32  epad:1;      /* even byte padding when this packet */
 +	u32  last_frag:1; /* last fragment(buffer) of the packet */
 +
 +	u64  addr;
++#elif defined(__BIG_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  vlan_tag:16;
++	u32  buffer_len:16;
++	/* dword 1 */
++	u32  last_frag:1;
++	u32  epad:1;
++	u32  reserve:12;
++	u32  type:1;
++	u32  ipv4:1;
++	u32  instag:1;
++	u32  vtagged:1;
++	u32  lso_v2:1;
++	u32  lso:1;
++	u32  udp_csum:1;
++	u32  tcp_csum:1;
++	u32  ip_csum:1;
++	u32  c_csum:1;
++	u32  l4hdr_offset:8;
++
++	u64  addr;
++#else
++#error	"Please fix <asm/byteorder.h>"
++#endif
 +};
 +
 +/* custom checksum parameter format of tpd */
-+struct alx_tpdes_checksum {
-+	u32 buffer_len:16; /* include 4-byte CRC */
-+	u32 vlan_tag:16;
-+
-+	u32 payld_offset:8; /* payload offset to the 1st byte of
-+			     *  the packet
-+			     */
-+	u32 c_sum:1;  /* do custom chekcusm offload,
-+		       * must be 1 in this format
-+		       */
-+	u32 ip_sum:1;   /* must be 0 in thhis format */
-+	u32 tcp_sum:1;  /* must be 0 in this format */
-+	u32 udp_sum:1;  /* must be 0 in this format */
-+	u32 lso:1;      /* must be 0 in this format */
-+	u32 lso_v2:1;   /* must be 0 in this format */
-+	u32 vtagged:1;  /* vlan-id tagged already */
-+	u32 instag:1;   /* insert vlan tag */
-+
-+	u32 ipv4:1;     /* ipv4 packet */
-+	u32 type:1;     /* type of packet (ethernet_ii(1) or snap(0)) */
-+	u32 cxsum_offset:8;  /* checksum offset to the 1st byte of
-+			      * the packet
-+			      */
-+	u32 reserve:4;  /* reserved, must be 0 */
-+	u32 epad:1;     /* even byte padding when this packet */
-+	u32 last_frag:1; /* last fragment(buffer) of the packet */
++struct alx_sw_tpdes_checksum {
++#if defined(__LITTLE_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  buffer_len:16;
++	u32  vlan_tag:16;
++	/* dword 1 */
++	u32  payld_offset:8; /* payload offset to the 1st byte of packet */
++	u32  c_csum:1;    /* do custom checksum offload */
++	u32  ip_csum:1;   /* do ip(v4) header checksum offload */
++	u32  tcp_csum:1;  /* do tcp checksum offload, both ipv4 and ipv6 */
++	u32  udp_csum:1;  /* do udp checksum offlaod, both ipv4 and ipv6 */
++	u32  lso:1;
++	u32  lso_v2:1;
++	u32  vtagged:1;   /* vlan-id tagged already */
++	u32  instag:1;    /* insert vlan tag */
++	u32  ipv4:1;      /* ipv4 packet */
++	u32  type:1;      /* type of packet (ethernet_ii(0) or snap(1)) */
++	u32  cxsum_offset:8;  /* checksum offset to the 1st byte of packet */
++	u32  reserve:4;
++	u32  epad:1;      /* even byte padding when this packet */
++	u32  last_frag:1; /* last fragment(buffer) of the packet */
 +
 +	u64 addr;
++#elif defined(__BIG_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  vlan_tag:16;
++	u32  buffer_len:16;
++	/* dword 1 */
++	u32  last_frag:1;
++	u32  epad:1;
++	u32  reserve:4;
++	u32  cxsum_offset:8;
++	u32  type:1;
++	u32  ipv4:1;
++	u32  instag:1;
++	u32  vtagged:1;
++	u32  lso_v2:1;
++	u32  lso:1;
++	u32  udp_csum:1;
++	u32  tcp_csum:1;
++	u32  ip_csum:1;
++	u32  c_csum:1;
++	u32  payld_offset:8;
++
++	u64  addr;
++#else
++#error	"Please fix <asm/byteorder.h>"
++#endif
 +};
 +
 +
 +/* tcp large send format (v1/v2) of tpd */
-+struct alx_tpdes_tso {
-+	u32 buffer_len:16; /* include 4-byte CRC */
-+	u32 vlan_tag:16;
-+
-+	u32 tcphdr_offset:8; /* tcp hdr offset to the 1st byte of packet */
-+	u32 c_sum:1;   /* must be 0 in this format */
-+	u32 ip_sum:1;  /* must be 0 in thhis format */
-+	u32 tcp_sum:1; /* must be 0 in this format */
-+	u32 udp_sum:1; /* must be 0 in this format */
-+	u32 lso:1;     /* do tcp large send (ipv4 only) */
-+	u32 lso_v2:1;  /* must be 0 in this format */
-+	u32 vtagged:1; /* vlan-id tagged already */
-+	u32 instag:1;  /* insert vlan tag */
++struct alx_sw_tpdes_tso {
++#if defined(__LITTLE_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  buffer_len:16; /* include 4-byte CRC */
++	u32  vlan_tag:16;
++	/* dword 1 */
++	u32  tcphdr_offset:8; /* tcp hdr offset to the 1st byte of packet */
++	u32  c_csum:1;
++	u32  ip_csum:1;
++	u32  tcp_csum:1;
++	u32  udp_csum:1;
++	u32  lso:1;       /* do tcp large send (ipv4 only) */
++	u32  lso_v2:1;    /* must be 0 in this format */
++	u32  vtagged:1;   /* vlan-id tagged already */
++	u32  instag:1;    /* insert vlan tag */
++	u32  ipv4:1;      /* ipv4 packet */
++	u32  type:1;      /* type of packet (ethernet_ii(1) or snap(0)) */
++	u32  mss:13;      /* mss if do tcp large send */
++	u32  last_frag:1; /* last fragment(buffer) of the packet */
 +
-+	u32 ipv4:1;    /* ipv4 packet */
-+	u32 type:1;    /* type of packet (ethernet_ii(1) or snap(0)) */
-+	u32 mss:13;    /* MSS if do tcp large send */
-+	u32 last_frag:1; /* last fragment(buffer) of the packet */
++	u32  pkt_len;     /* packet length in ext tpd */
++	u32  reserve;
++#elif defined(__BIG_ENDIAN_BITFIELD)
++	/* dword 0 */
++	u32  vlan_tag:16;
++	u32  buffer_len:16;
++	/* dword 1 */
++	u32  last_frag:1;
++	u32  mss:13;
++	u32  type:1;
++	u32  ipv4:1;
++	u32  instag:1;
++	u32  vtagged:1;
++	u32  lso_v2:1;
++	u32  lso:1;
++	u32  udp_csum:1;
++	u32  tcp_csum:1;
++	u32  ip_csum:1;
++	u32  c_csum:1;
++	u32  tcphdr_offset:8;
 +
-+	u32 addr_lo;
-+	u32 addr_hi;
++	u32  pkt_len;
++	u32  reserve;
++#else
++#error	"Please fix <asm/byteorder.h>"
++#endif
 +};
 +
-+union alx_tpdesc {
++union alx_hw_tpdesc {
 +	/* dword flat format */
 +	struct {
 +		__le32 dw0;
@@ -8055,9 +8147,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * do all le32_to_cpu() conversions on the spot.
 + */
 +union alx_sw_tpdesc {
-+	struct alx_tpdes_general   genr;
-+	struct alx_tpdes_checksum  csum;
-+	struct alx_tpdes_tso       tso;
++	struct alx_sw_tpdes_general   genr;
++	struct alx_sw_tpdes_checksum  csum;
++	struct alx_sw_tpdes_tso       tso;
 +
 +	/* dword flat format */
 +	struct {
@@ -8075,11 +8167,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +};
 +
 +#define ALX_RRD(_que, _i)	\
-+		(&(((union alx_rrdesc *)(_que)->rrq.rrdesc)[(_i)]))
++		(&(((union alx_hw_rrdesc *)(_que)->rrq.rrdesc)[(_i)]))
 +#define ALX_RFD(_que, _i)	\
-+		(&(((union alx_rfdesc *)(_que)->rfq.rfdesc)[(_i)]))
++		(&(((union alx_hw_rfdesc *)(_que)->rfq.rfdesc)[(_i)]))
 +#define ALX_TPD(_que, _i)	\
-+		(&(((union alx_tpdesc *)(_que)->tpq.tpdesc)[(_i)]))
++		(&(((union alx_hw_tpdesc *)(_que)->tpq.tpdesc)[(_i)]))
 +
 +
 +/*
@@ -8114,8 +8206,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +/* receive free descriptor (rfd) queue */
 +struct alx_rfd_queue {
-+	struct alx_buffer *rfbuff;
-+	union alx_rfdesc *rfdesc;   /* virtual address */
++	struct alx_buffer   *rfbuff;
++	union alx_hw_rfdesc *rfdesc;   /* virtual address */
 +	dma_addr_t         rfdma;    /* physical address */
 +	u16 size;          /* length in bytes */
 +	u16 count;         /* number of descriptors in the ring */
@@ -8125,8 +8217,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +/* receive return desciptor (rrd) queue */
 +struct alx_rrd_queue {
-+	union alx_rrdesc *rrdesc;    /* virtual address */
-+	dma_addr_t         rrdma;     /* physical address */
++	union alx_hw_rrdesc *rrdesc;    /* virtual address */
++	dma_addr_t          rrdma;     /* physical address */
 +	u16 size;          /* length in bytes */
 +	u16 count;         /* number of descriptors in the ring */
 +	u16 produce_idx;   /* unused */
@@ -8168,8 +8260,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +/* transimit packet descriptor (tpd) ring */
 +struct alx_tpd_queue {
-+	struct alx_buffer *tpbuff;
-+	union alx_tpdesc *tpdesc;   /* virtual address */
++	struct alx_buffer   *tpbuff;
++	union alx_hw_tpdesc *tpdesc;   /* virtual address */
 +	dma_addr_t         tpdma;    /* physical address */
 +
 +	u16 size;    /* length in bytes */
@@ -8313,9 +8405,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	u32 rxbuf_size;
 +
-+	struct alx_cmb cmb;
-+	struct alx_smb smb;
-+
 +	/* structs defined in alx_hw.h */
 +	struct alx_hw       hw;
 +	struct alx_hw_stats hw_stats;
@@ -8327,44 +8416,44 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	unsigned long link_jiffies;
 +
-+	u32 wol;
++	u32  wol;
++	bool cifs;
++	int  bars;
++	bool ioport;
 +	spinlock_t tx_lock;
 +	spinlock_t rx_lock;
 +	atomic_t irq_sem;
 +
++#ifdef CONFIG_ALX_DEBUGFS
++	struct alx_debugfs_param dfs;
++#endif
 +	u16 msg_enable;
-+	unsigned long flags[2];
++	unsigned long flags;
 +};
 +
-+#define ALX_ADPT_FLAG_0_MSI_CAP                 0x00000001
-+#define ALX_ADPT_FLAG_0_MSI_EN                  0x00000002
-+#define ALX_ADPT_FLAG_0_MSIX_CAP                0x00000004
-+#define ALX_ADPT_FLAG_0_MSIX_EN                 0x00000008
-+#define ALX_ADPT_FLAG_0_MRQ_CAP                 0x00000010
-+#define ALX_ADPT_FLAG_0_MRQ_EN                  0x00000020
-+#define ALX_ADPT_FLAG_0_MTQ_CAP                 0x00000040
-+#define ALX_ADPT_FLAG_0_MTQ_EN                  0x00000080
-+#define ALX_ADPT_FLAG_0_SRSS_CAP                0x00000100
-+#define ALX_ADPT_FLAG_0_SRSS_EN                 0x00000200
-+#define ALX_ADPT_FLAG_0_FIXED_MSIX              0x00000400
++#define ALX_ADPT_FLAG_MSI_CAP                 0x00000001
++#define ALX_ADPT_FLAG_MSI_EN                  0x00000002
++#define ALX_ADPT_FLAG_MSIX_CAP                0x00000004
++#define ALX_ADPT_FLAG_MSIX_EN                 0x00000008
++#define ALX_ADPT_FLAG_MRQ_CAP                 0x00000010
++#define ALX_ADPT_FLAG_MRQ_EN                  0x00000020
++#define ALX_ADPT_FLAG_MTQ_CAP                 0x00000040
++#define ALX_ADPT_FLAG_MTQ_EN                  0x00000080
++#define ALX_ADPT_FLAG_SRSS_CAP                0x00000100
++#define ALX_ADPT_FLAG_SRSS_EN                 0x00000200
++#define ALX_ADPT_FLAG_FIXED_MSIX              0x00000400
 +
-+#define ALX_ADPT_FLAG_0_TASK_REINIT_REQ         0x00010000  /* reinit */
-+#define ALX_ADPT_FLAG_0_TASK_LSC_REQ            0x00020000
++#define ALX_ADPT_FLAG_TASK_REINIT_REQ         0x00010000  /* reinit */
++#define ALX_ADPT_FLAG_TASK_LSC_REQ            0x00020000
 +
-+#define ALX_ADPT_FLAG_1_STATE_TESTING           0x00000001
-+#define ALX_ADPT_FLAG_1_STATE_RESETTING         0x00000002
-+#define ALX_ADPT_FLAG_1_STATE_DOWN              0x00000004
-+#define ALX_ADPT_FLAG_1_STATE_WATCH_DOG         0x00000008
-+#define ALX_ADPT_FLAG_1_STATE_DIAG_RUNNING      0x00000010
-+#define ALX_ADPT_FLAG_1_STATE_INACTIVE          0x00000020
++#define ALX_ADPT_FLAG_STATE_TESTING           0x00100000
++#define ALX_ADPT_FLAG_STATE_RESETTING         0x00200000
++#define ALX_ADPT_FLAG_STATE_DOWN              0x00400000
++#define ALX_ADPT_FLAG_STATE_WATCH_DOG         0x00800000
 +
-+
-+#define CHK_ADPT_FLAG(_idx, _flag)	\
-+		CHK_FLAG_ARRAY(adpt, _idx, ADPT, _flag)
-+#define SET_ADPT_FLAG(_idx, _flag)	\
-+		SET_FLAG_ARRAY(adpt, _idx, ADPT, _flag)
-+#define CLI_ADPT_FLAG(_idx, _flag)	\
-+		CLI_FLAG_ARRAY(adpt, _idx, ADPT, _flag)
++#define CHK_ADPT_FLAG(_flag)	CHK_FLAG(adpt, ADPT, _flag)
++#define SET_ADPT_FLAG(_flag)	SET_FLAG(adpt, ADPT, _flag)
++#define CLI_ADPT_FLAG(_flag)	CLI_FLAG(adpt, ADPT, _flag)
 +
 +/* default to trying for four seconds */
 +#define ALX_TRY_LINK_TIMEOUT (4 * HZ)
@@ -8380,15 +8469,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* needed by alx_ethtool.c */
 +extern char alx_drv_name[];
 +extern void alx_reinit_locked(struct alx_adapter *adpt);
++extern int alx_open_internal(struct alx_adapter *adpt, u32 ctrl);
++extern void alx_stop_internal(struct alx_adapter *adpt, u32 ctrl);
 +extern void alx_set_ethtool_ops(struct net_device *netdev);
 +#ifdef ETHTOOL_OPS_COMPAT
 +extern int ethtool_ioctl(struct ifreq *ifr);
 +#endif
 +
 +#endif /* _ALX_H_ */
+diff --git a/drivers/net/ethernet/atheros/alx/alx_cifs.c b/drivers/net/ethernet/atheros/alx/alx_cifs.c
+new file mode 100644
+index 0000000..ae6d4e5
 --- /dev/null
-+++ b/drivers/net/ethernet/atheros/alx/alx_ethtool.c
-@@ -0,0 +1,519 @@
++++ b/drivers/net/ethernet/atheros/alx/alx_cifs.c
+@@ -0,0 +1,324 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -8405,70 +8499,1599 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 + */
 +
-+#include <linux/netdevice.h>
-+#include <linux/ethtool.h>
-+#include <linux/slab.h>
-+
 +#include "alx.h"
-+#include "alx_hwcom.h"
++#include "alf_hw.h"
++#include "alc_hw.h"
 +
-+#ifdef ETHTOOL_OPS_COMPAT
-+#include "alx_compat_ethtool.c"
-+#endif
++/*
++ * Desc: CIFS offload, config the ANNOUNCEMENT message to our adapter.
++ */
++static void alx_setup_cifs(struct alx_adapter *adpt)
++{
++	struct alx_hw *hw = &adpt->hw;
++	struct alx_debugfs_param *dfs = &adpt->dfs;
++	u32 ctrl;
++	u32 i;
++	struct alx_swoi *swoi = &dfs->swoi_offload;
 +
++	if (!swoi->len) {
++		alx_hw_err(hw, "CIFS offload disabled.\n");
++		return;
++	}
 +
-+static int alx_get_settings(struct net_device *netdev,
-+			    struct ethtool_cmd *ecmd)
++	/* Write ANNOUNCEMENT message to SRAM. */
++	for (i = 0; i < swoi->len; i += 4) {
++		alx_mem_w32(hw, dfs->annce_addr_off + i,
++			    *(u32 *) &swoi->msg[i]);
++	}
++
++	ctrl = 0;
++	FIELD_SETL(ctrl, L1F_HRTBT_CTRL_PKTLEN, swoi->len);
++	FIELD_SETL(ctrl, L1F_HRTBT_CTRL_HDRADDR,
++		   ((dfs->annce_addr_off - PACKET_MAP_ADDR) >> 3));
++	if (swoi->is_vlan)
++		ctrl |= L1F_HRTBT_CTRL_HASVLAN;
++
++	/* The registration packet send period.
++	 * 1bit = 2s. nAnncePeriod = (pkt_send_period+1) *2
++	 */
++	FIELD_SETL(ctrl, L1F_HRTBT_CTRL_PERIOD, swoi->period / 2 - 1);
++	ctrl |= L1F_HRTBT_CTRL_EN;
++	alx_mem_w32(hw, L1F_HRTBT_CTRL, ctrl);
++	alx_hw_info(hw,
++		    "ANNOUNCEMENT message annce_base_addr[0x%08x], len%d, "
++		    "%s vlan, Reg%04x-%08x\n",
++		    (dfs->annce_addr_off - PACKET_MAP_ADDR) >> 3,
++		    swoi->len, swoi->is_vlan ? "has" : "no",
++		    L1F_HRTBT_CTRL, ctrl);
++
++	dfs->annce_addr_off =
++		(dfs->annce_addr_off + swoi->len + 0x0F) & 0xFFFFFFF0;
++
++	/* Enable magic because cifs needs it. */
++	alx_mem_r32(hw, L1F_WOL0, &ctrl);
++	ctrl |= (L1F_WOL0_MAGIC_EN | L1F_WOL0_PME_MAGIC_EN);
++
++	if (0 != ctrl) {
++		if (L2CB_DEV_ID == hw->pci_devid
++		    || L2CB2_DEV_ID == hw->pci_devid
++		    || L1D_DEV_ID == hw->pci_devid
++		    || L1D2_DEV_ID == hw->pci_devid) {
++			ctrl |= L1D_WOL0_OOB_EN;
++		}
++	}
++	alx_mem_w32(hw, L1F_WOL0, ctrl);
++}
++
++
++/*
++ * Desc: CIFS offload, config the ANNOUNCEMENT message to our adapter.
++ */
++static void alx_setup_swoi(struct alx_adapter *adpt)
 +{
-+	struct alx_adapter *adpt = netdev_priv(netdev);
 +	struct alx_hw *hw = &adpt->hw;
-+	u32 link_speed = hw->link_speed;
-+	bool link_up = hw->link_up;
++	struct alx_debugfs_param *dfs = &adpt->dfs;
++	u32 ctrl;
++	u32 i;
++	struct alx_swoi *swoi = &dfs->swoi_offload;
 +
-+	ecmd->supported = (SUPPORTED_10baseT_Half  |
-+			   SUPPORTED_10baseT_Full  |
-+			   SUPPORTED_100baseT_Half |
-+			   SUPPORTED_100baseT_Full |
-+			   SUPPORTED_Autoneg       |
-+			   SUPPORTED_TP);
-+	if (CHK_HW_FLAG(GIGA_CAP))
-+		ecmd->supported |= SUPPORTED_1000baseT_Full;
++	if (!swoi->len) {
++		alx_hw_err(hw, "SWOI offload disabled.\n");
++		return;
++	}
 +
-+	ecmd->advertising = ADVERTISED_TP;
++	/* Write ANNOUNCEMENT message to SRAM. */
++	for (i = 0; i < swoi->total_len; i += 4) {
++		alx_mem_w32(hw, dfs->annce_addr_off + i,
++			    *(u32 *) &swoi->msg[i]);
++	}
 +
-+	ecmd->advertising |= ADVERTISED_Autoneg;
-+	ecmd->advertising |= hw->autoneg_advertised;
++	ctrl = 0;
++	FIELD_SETL(ctrl, L1F_HRTBT_CTRL_PKTLEN, swoi->len);
++	FIELD_SETL(ctrl, L1F_HRTBT_CTRL_HDRADDRB0,
++		   ((dfs->annce_addr_off - PACKET_MAP_ADDR) >> 4));
++	if (swoi->fraged)
++		ctrl |= L1F_HRTBT_CTRL_PKT_FRAG;
 +
-+	ecmd->port = PORT_TP;
-+	ecmd->phy_address = 0;
-+	ecmd->autoneg = AUTONEG_ENABLE;
-+	ecmd->transceiver = XCVR_INTERNAL;
++	if (swoi->is_vlan)
++		ctrl |= L1F_HRTBT_CTRL_HASVLAN;
++
++	/* The registration packet send period.
++	 * 1bit = 2s. nAnncePeriod = (pkt_send_period+1) *2
++	 */
++	FIELD_SETL(ctrl, L1F_HRTBT_CTRL_PERIOD, swoi->period / 2 - 1);
++	ctrl |= L1F_HRTBT_CTRL_EN;
++	alx_mem_w32(hw, L1F_HRTBT_CTRL, ctrl);
++	alx_hw_info(hw,
++		    "ANNOUNCEMENT message annce_base_addr[0x%08x], len%d, "
++		    "%s frag, %s vlan, Reg%04x-%08x\n",
++		    (dfs->annce_addr_off - PACKET_MAP_ADDR) >> 3, swoi->len,
++		    swoi->fraged ? "has" : "no", swoi->is_vlan ? "has" : "no",
++		    L1F_HRTBT_CTRL, ctrl);
++
++	ctrl = 0;
++	FIELD_SETL(ctrl, L1F_HRTBT_EXT_CTRL_FRAG_LEN, swoi->frag_len);
++	if (swoi->pkt_is_8023)
++		ctrl |= L1F_HRTBT_EXT_CTRL_IS_8023;
++	if (swoi->pkt_is_ipv6)
++		ctrl |= L1F_HRTBT_EXT_CTRL_IS_IPV6;
 +
-+	if (!in_interrupt()) {
-+		hw->cbs.check_phy_link(hw, &link_speed, &link_up);
-+		hw->link_speed = link_speed;
-+		hw->link_up = link_up;
++	ctrl |= L1F_HRTBT_EXT_CTRL_WAKEUP_EN | (swoi->pkt_is_ipv6 ?
++						L1F_HRTBT_EXT_CTRL_NS_EN :
++						L1F_HRTBT_EXT_CTRL_ARP_EN);
++	alx_mem_w32(hw, L1F_HRTBT_EXT_CTRL, ctrl);
++	alx_mem_r32(hw, L1F_PMOFLD, &ctrl);
++	/* Config host mac address. */
++	alx_mem_r32(hw, L1F_STAD0, &i);
++	alx_mem_w32(hw, L1F_ARP_MAC0, i);
++	/* alx_mem_w32(hw, L1F_1ST_NS_MAC0, i); */
++	alx_mem_w32(hw, L1F_2ND_NS_MAC0, i);
++	alx_mem_r32(hw, L1F_STAD1, &i);
++	alx_mem_w32(hw, L1F_ARP_MAC1, i);
++	/* alx_mem_w32(hw, L1F_1ST_NS_MAC1, i); */
++	alx_mem_w32(hw, L1F_2ND_NS_MAC1, i);
++
++	if (swoi->pkt_is_ipv6) {
++		alx_mem_w32(hw, L1F_HRTBT_REM_IPV6_ADDR3,
++			    swoi->svr_ipv6_addr[0]);
++		alx_mem_w32(hw, L1F_HRTBT_REM_IPV6_ADDR2,
++			    swoi->svr_ipv6_addr[1]);
++		alx_mem_w32(hw, L1F_HRTBT_REM_IPV6_ADDR1,
++			    swoi->svr_ipv6_addr[2]);
++		alx_mem_w32(hw, L1F_HRTBT_REM_IPV6_ADDR0,
++			    swoi->svr_ipv6_addr[3]);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_1_3,
++			    swoi->host_ipv6_addr[0]);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_1_2,
++			    swoi->host_ipv6_addr[1]);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_1_1,
++			    swoi->host_ipv6_addr[2]);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_1_0,
++			    swoi->host_ipv6_addr[3]);
++		alx_mem_w32(hw, L1F_2ND_SN_IPV6_3, swoi->host_ipv6_addr[0]);
++		alx_mem_w32(hw, L1F_2ND_SN_IPV6_2, swoi->host_ipv6_addr[1]);
++		alx_mem_w32(hw, L1F_2ND_SN_IPV6_1, swoi->host_ipv6_addr[2]);
++		alx_mem_w32(hw, L1F_2ND_SN_IPV6_0, swoi->host_ipv6_addr[3]);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_2_0, 0);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_2_1, 0);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_2_2, 0);
++		alx_mem_w32(hw, L1F_2ND_TAR_IPV6_2_3, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_1_0, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_1_1, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_1_2, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_1_3, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_2_0, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_2_1, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_2_2, 0);
++		alx_mem_w32(hw, L1F_1ST_TAR_IPV6_2_3, 0);
++		if (!(L1F_PMOFLD_BY_HW & ctrl)) {
++			/* no pm offload, we need config. */
++			alx_mem_r32(hw, L1F_MAC_CTRL, &ctrl);
++			alx_mem_w32(hw, L1F_MAC_CTRL,
++				    ctrl | L1F_MAC_CTRL_MULTIALL_EN);
++		} else {
++			if (!(L1F_PMOFLD_MULTI_SOLD & ctrl)) {
++				/* MS PM offload */
++				alx_mem_w32(hw, L1F_ARP_REMOTE_IPV4, 0);
++				alx_mem_w32(hw, L1F_1ST_REMOTE_IPV6_0, 0);
++				alx_mem_w32(hw, L1F_1ST_REMOTE_IPV6_1, 0);
++				alx_mem_w32(hw, L1F_1ST_REMOTE_IPV6_2, 0);
++				alx_mem_w32(hw, L1F_1ST_REMOTE_IPV6_3, 0);
++				alx_mem_w32(hw, L1F_2ND_REMOTE_IPV6_0, 0);
++				alx_mem_w32(hw, L1F_2ND_REMOTE_IPV6_1, 0);
++				alx_mem_w32(hw, L1F_2ND_REMOTE_IPV6_2, 0);
++				alx_mem_w32(hw, L1F_2ND_REMOTE_IPV6_3, 0);
++			}
++		}
++	} else {
++		alx_mem_w32(hw, L1F_HRTBT_REM_IPV4_ADDR, swoi->svr_ipv4_addr);
++		alx_mem_w32(hw, L1F_HRTBT_HOST_IPV4_ADDR,
++			    swoi->host_ipv4_addr);
++		alx_mem_w32(hw, L1F_ARP_HOST_IPV4, swoi->host_ipv4_addr);
 +	}
 +
-+	if (link_up) {
-+		switch (link_speed) {
-+		case ALX_LINK_SPEED_10_HALF:
++	ctrl = 0;
++	FIELD_SETL(ctrl, L1F_HRTBT_WAKEUP_PORT_SRC, swoi->svr_port);
++	FIELD_SETL(ctrl, L1F_HRTBT_WAKEUP_PORT_DEST, swoi->host_port);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_PORT, ctrl);
++	/* NIC will compare the received encrypted nonce
++	 * with the following data:
++	 */
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA7, swoi->wakeup_data[0]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA6, swoi->wakeup_data[1]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA5, swoi->wakeup_data[2]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA4, swoi->wakeup_data[3]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA3, swoi->wakeup_data[4]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA2, swoi->wakeup_data[5]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA1, swoi->wakeup_data[6]);
++	alx_mem_w32(hw, L1F_HRTBT_WAKEUP_DATA0, swoi->wakeup_data[7]);
++	dfs->annce_addr_off =
++		(dfs->annce_addr_off + swoi->total_len + 0x0F) & 0xFFFFFFF0;
++}
++
++
++/*
++ * Desc: CIFS offload, config the ANNOUNCEMENT message to our adapter.
++ */
++static void alx_setup_teredo(struct alx_adapter *adpt)
++{
++	struct alx_hw *hw = &adpt->hw;
++	struct alx_debugfs_param *dfs = &adpt->dfs;
++	u32 ctrl;
++	u32 i;
++	struct alx_teredo *trd = &dfs->teredo_offload;
++
++	if (!trd->len) {
++		alx_hw_err(hw, "TEREDO offload disabled.\n");
++		return;
++	}
++
++	/* Write TEREDO message to SRAM. */
++	for (i = 0; i < trd->len; i += 4) {
++		alx_mem_w32(hw, dfs->annce_addr_off + i,
++			    *(u32 *) &trd->msg[i]);
++	}
++
++	ctrl = 0;
++	ctrl |= (L1F_TRD_CTRL_EN | L1F_TRD_CTRL_BUBBLE_WAKE_EN);
++	FIELD_SETL(ctrl, L1F_TRD_CTRL_RSHDR_ADDR,
++		   ((dfs->annce_addr_off - PACKET_MAP_ADDR) >> 3));
++	FIELD_SETL(ctrl, L1F_TRD_CTRL_SINTV_MAX, trd->intv_max);
++	FIELD_SETL(ctrl, L1F_TRD_CTRL_SINTV_MIN, trd->intv_min);
++	alx_mem_w32(hw, L1F_TRD_CTRL, ctrl);
++	alx_hw_info(hw, "TEREDO message annce_base_addr[0x%08x], len%d\n",
++		    (dfs->annce_addr_off - PACKET_MAP_ADDR) >> 3,
++		    trd->len);
++
++	ctrl = 0;
++	FIELD_SETL(ctrl, L1F_TRD_RS_SZ, trd->len);
++	/* FIELD_SETL(ctrl, L1F_TRD_RS_NONCE_OFS, trd->nonce_off); */
++	FIELD_SETL(ctrl, L1F_TRD_RS_SEQ_OFS, trd->ipv4_id_off);
++	alx_mem_w32(hw, L1F_TRD_RS, ctrl);
++
++	alx_mem_w32(hw, L1F_TRD_SRV_IP4, trd->svr_ip4);
++	alx_mem_w32(hw, L1F_TRD_CLNT_EXTNL_IP4, trd->clt_external_ip4);
++	ctrl = 0;
++	FIELD_SETL(ctrl, L1F_TRD_PORT_CLNT_EXTNL, trd->clt_external_port);
++	FIELD_SETL(ctrl, L1F_TRD_PORT_SRV, trd->svr_port);
++	alx_mem_w32(hw, L1F_TRD_PORT, ctrl);
++	alx_mem_w32(hw, L1F_TRD_PREFIX, trd->prefix);
++	alx_mem_w32(hw, L1F_TRD_BUBBLE_DA_IP4, trd->clt_ip4);
++	alx_mem_w32(hw, L1F_TRD_BUBBLE_DA_PORT, trd->clt_port);
++
++	dfs->annce_addr_off =
++		(dfs->annce_addr_off + trd->len + 0x0F) & 0xFFFFFFF0;
++}
++
++
++int alx_setup_annce(struct alx_adapter *adpt, u32 wire_speed)
++{
++	struct alx_hw *hw = &adpt->hw;
++	struct alx_debugfs_param *dfs = &adpt->dfs;
++	u32 ctrl;
++	struct alx_swoi *swoi = &dfs->swoi_offload;
++	struct alx_teredo *trd = &dfs->teredo_offload;
++
++	dfs->annce_addr_off = PACKET_MAP_ADDR + (CIFS_ANNCE_ADDR << 3);
++	if (!swoi->len && !trd->len) {
++		alx_hw_err(hw, "No cifs or teredo offload.\n");
++		return -EINVAL;
++	}
++
++	if (swoi->ver == ALX_SWOI_VER_CIFS)
++		alx_setup_cifs(adpt);
++	else if (swoi->ver == ALX_SWOI_VER_SWOI)
++		alx_setup_swoi(adpt);
++	alx_setup_teredo(adpt);
++
++	alx_mem_r32(hw, L1F_GAP, &ctrl);
++	FIELD_SETL(ctrl, L1F_GAP_IPGT, 0x60);
++	alx_mem_w32(hw, L1F_GAP, ctrl);
++
++	alx_mem_r32(hw, L1F_MAC_CTRL, &ctrl);
++	ctrl |= (L1F_MAC_CTRL_TX_EN | L1F_MAC_CTRL_PCRCE | L1F_MAC_CTRL_CRCE);
++	alx_mem_w32(hw, L1F_MAC_CTRL, ctrl);
++
++
++	/* The HW won't switch clock even if we slow it down
++	 * when the wire speedis 1G. When the wire speed is 100M,
++	 * we shouldn't slow it down or the HW can't send frames correctly.
++	 * If the wire speed is 10M, we should slow it
++	 * down to save power, and the HW does work, too.
++	 */
++	if (wire_speed == SPEED_100) {
++		alx_mem_r32(hw, L1F_SERDES, &ctrl);
++		ctrl &= ~L1F_SERDES_MACCLK_SLWDWN;
++		alx_mem_w32(hw, L1F_SERDES, ctrl);
++	}
++
++	return 0;
++}
+diff --git a/drivers/net/ethernet/atheros/alx/alx_cifs.h b/drivers/net/ethernet/atheros/alx/alx_cifs.h
+new file mode 100644
+index 0000000..a206bf1
+--- /dev/null
++++ b/drivers/net/ethernet/atheros/alx/alx_cifs.h
+@@ -0,0 +1,73 @@
++/*
++ * Copyright (c) 2012 Qualcomm Atheros, Inc.
++ *
++ * Permission to use, copy, modify, and/or distribute this software for any
++ * purpose with or without fee is hereby granted, provided that the above
++ * copyright notice and this permission notice appear in all copies.
++ *
++ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
++ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
++ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
++ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
++ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
++ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
++ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
++ */
++
++#ifndef _ALX_CIFS_H_
++#define _ALX_CIFS_H_
++
++/* cifs */
++#define CIFS_ANNCE_ADDR                 0x700 /* ANNOUNCEMENT msg address */
++#define PACKET_MAP_ADDR                 0x8000
++
++#define ALX_SWOI_VER_CIFS       0x01
++#define ALX_SWOI_VER_SWOI       0x02
++#define ALX_MAX_ANNCE_LEN       1522
++
++struct alx_teredo {
++	u32 ver:4;
++	u32 prefix_hw_compare:1;
++	u32 intv_max:8;
++	u32 intv_min:8;
++	u32 ipv4_id_off:8;
++	u32 s5_wakeup:1;
++	u32 svr_ip4;		/* little endian order,
++				 * compatible with our NIC. */
++	u16 svr_port;		/* little endian order */
++	u32 clt_ip4;		/* little endian order */
++	u16 clt_port;		/* little endian order */
++	u32 clt_external_ip4;	/* little endian order */
++	u16 clt_external_port;	/* little endian order */
++	u32 prefix;		/* little endian order */
++	u32 len;
++	char msg[ALX_MAX_ANNCE_LEN];
++};
++
++struct alx_swoi {
++	u32 ver:4;
++	u32 period:6;
++	u32 is_vlan:1;
++	u32 fraged:1;
++	u32 len:12;
++	u32 pkt_is_8023:1;
++	u32 pkt_is_ipv6:1;
++	u32 pkt_wakeup_en:1;
++	u32 frag_len:16;
++	u32 svr_ipv4_addr;	/* The source ipv4 address
++				 * for SWOI wakeup msg. */
++	u32 host_ipv4_addr;	/* little endian order */
++	u32 svr_ipv6_addr[4];	/* little endian order */
++	u32 host_ipv6_addr[4];	/* little endian order */
++	u16 svr_port;		/* SWOI wakeup packet UDP source port. */
++	u16 host_port;		/* little endian order */
++	u32 wakeup_data[8];	/* little endian order */
++
++	u32 total_len;		/* annce_len + padding, for SW use only */
++	char msg[ALX_MAX_ANNCE_LEN];
++};
++
++struct alx_adapter;
++int alx_setup_annce(struct alx_adapter *adpt, u32 wire_speed);
++
++#endif /*_ALX_CIFS_H_*/
+diff --git a/drivers/net/ethernet/atheros/alx/alx_dfs.c b/drivers/net/ethernet/atheros/alx/alx_dfs.c
+new file mode 100644
+index 0000000..e1e21a7
+--- /dev/null
++++ b/drivers/net/ethernet/atheros/alx/alx_dfs.c
+@@ -0,0 +1,937 @@
++/*
++ * Copyright (c) 2012 Qualcomm Atheros, Inc.
++ *
++ * Permission to use, copy, modify, and/or distribute this software for any
++ * purpose with or without fee is hereby granted, provided that the above
++ * copyright notice and this permission notice appear in all copies.
++ *
++ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
++ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
++ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
++ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
++ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
++ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
++ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
++ */
++
++#include <linux/ip.h>
++#include <net/ipv6.h>
++#include <linux/if_vlan.h>
++#include <linux/debugfs.h>
++
++#include "alx.h"
++#include "alf_hw.h"
++
++
++static void alx_mem_r8(const struct alx_hw *hw, int reg, u8 *val)
++{
++	if (unlikely(!hw->link_up))
++		readl(hw->hw_addr + reg);
++	*val = readb(hw->hw_addr + reg);
++}
++
++
++static void alx_io_r32(const struct alx_hw *hw, int reg, u32 *pval)
++{
++	*pval = inl(hw->io_addr + reg);
++}
++
++
++static void alx_io_w32(const struct alx_hw *hw, int reg, u32 val)
++{
++	outl(val, hw->io_addr + reg);
++}
++
++static void alx_dfs_device_reinit(struct alx_adapter *adpt)
++{
++	if (CHK_ADPT_FLAG(STATE_DOWN) ||
++	    CHK_ADPT_FLAG(STATE_RESETTING)) {
++		return;
++	}
++
++	while (CHK_ADPT_FLAG(STATE_RESETTING))
++		msleep(20);
++	SET_ADPT_FLAG(STATE_RESETTING);
++
++	alx_stop_internal(adpt, ALX_OPEN_CTRL_RESET_ALL);
++	alx_open_internal(adpt, ALX_OPEN_CTRL_RESET_ALL);
++
++	CLI_ADPT_FLAG(STATE_RESETTING);
++}
++
++
++/*
++ * Diagnostic Support
++ */
++static void alx_dfs_diag_config_packet(struct alx_adapter *adpt,
++				       struct alx_diag_packet *pkt,
++				       union alx_sw_rrdesc *srrd)
++{
++	u32 pid;
++
++	if (adpt->hw.mac_type == alx_mac_l1f ||
++	    adpt->hw.mac_type == alx_mac_l2f ||
++	    adpt->hw.mac_type == alx_mac_l1h ||
++	    adpt->hw.mac_type == alx_mac_l2h) {
++		pid = srrd->genr.pid;
++	} else {
++		pid = srrd->genr.reserve;
++	}
++
++	pkt->type = 0;
++	switch (pid) {
++	case 0: /* non-ip */
++		break;
++	case 1: /* ipv4(only) */
++		pkt->type |= ALX_DIAG_PKTYPE_IPV4;
++		break;
++	case 2: /* tcp/ipv6 */
++		pkt->type |= ALX_DIAG_PKTYPE_IPV6;
++		pkt->type |= ALX_DIAG_PKTYPE_TCP;
++		break;
++	case 3: /* tcp/ipv4 */
++		pkt->type |= ALX_DIAG_PKTYPE_IPV4;
++		pkt->type |= ALX_DIAG_PKTYPE_TCP;
++		break;
++	case 4: /* udp/ipv6 */
++		pkt->type |= ALX_DIAG_PKTYPE_IPV6;
++		pkt->type |= ALX_DIAG_PKTYPE_UDP;
++		break;
++	case 5: /* udp/ipv4 */
++		pkt->type |= ALX_DIAG_PKTYPE_IPV4;
++		pkt->type |= ALX_DIAG_PKTYPE_UDP;
++		break;
++	case 6: /* ipv6(only) */
++		pkt->type |= ALX_DIAG_PKTYPE_IPV6;
++		break;
++	case 7:
++		pkt->type |= ALX_DIAG_PKTYPE_LLDP;
++		break;
++	case 8:
++		pkt->type |= ALX_DIAG_PKTYPE_PTP;
++		break;
++	default: /* invalid protocol */
++		break;
++	}
++
++	if (srrd->genr.type)
++		pkt->type |= ALX_DIAG_PKTYPE_802_3;
++	else
++		pkt->type |= ALX_DIAG_PKTYPE_EII;
++
++	/* error */
++	if (srrd->genr.res) {
++		pkt->type |= ALX_DIAG_PKTYPE_RX_ERR;
++		if (srrd->genr.crc)
++			pkt->type |= ALX_DIAG_PKTYPE_CRC_ERR;
++	}
++
++	if (srrd->genr.icmp)
++		pkt->type |= ALX_DIAG_PKTYPE_INCOMPLETE_ERR;
++
++	if (srrd->genr.l4f)
++		pkt->type |= ALX_DIAG_PKTYPE_L4XSUM_ERR;
++
++	if (srrd->genr.ipf)
++		pkt->type |= ALX_DIAG_PKTYPE_IPXSUM_ERR;
++
++	if (srrd->genr.lene)
++		pkt->type |= ALX_DIAG_PKTYPE_802_3_LEN_ERR;
++
++	pkt->rss_hash    = srrd->genr.hash;
++	pkt->rss_cpu_num = srrd->genr.rss_cpu;
++	pkt->xsum        = srrd->genr.xsum;
++	pkt->length      = srrd->genr.pkt_len - 4;
++
++	if (srrd->genr.vlan_flag)
++		ALX_TAG_TO_VLAN(srrd->genr.vlan_tag, pkt->vlanid);
++}
++
++
++void alx_dfs_diag_receive_skb(struct alx_adapter *adpt, struct sk_buff *skb,
++			      union alx_sw_rrdesc *srrd)
++{
++	struct sk_buff_head    *skb_list = &adpt->dfs.diag_skb_list;
++	struct alx_diag_packet *pkt;
++
++	if (skb_queue_len(skb_list) >= ALX_DIAG_MAX_RX_PACKETS) {
++		if (skb)
++			dev_kfree_skb_irq(skb);
++		return;
++	}
++
++	pkt = adpt->dfs.diag_pkt_info;
++	adpt->dfs.diag_pkt_info++;
++	memset(pkt, 0, sizeof(struct alx_diag_packet));
++	if (((u8 *)adpt->dfs.diag_pkt_info) >=
++	    (adpt->dfs.diag_info_buf + adpt->dfs.diag_info_sz)) {
++		adpt->dfs.diag_pkt_info =
++			(struct alx_diag_packet *)adpt->dfs.diag_info_buf;
++	}
++	alx_dfs_diag_config_packet(adpt, pkt, srrd);
++
++	/* borrow skb->sk point store struct alx_diag_packet */
++	skb->sk = (struct sock *)pkt;
++
++	skb_queue_tail(skb_list, skb);
++}
++
++
++static bool alx_dfs_set_tpdesc(struct alx_tx_queue *txque,
++			       union alx_sw_tpdesc *stpd)
++{
++	union alx_hw_tpdesc *htpd;
++
++	txque->tpq.last_produce_idx = txque->tpq.produce_idx;
++	htpd = ALX_TPD(txque, txque->tpq.produce_idx);
++
++	if (++txque->tpq.produce_idx == txque->tpq.count)
++		txque->tpq.produce_idx = 0;
++
++#ifdef DESC_DUMP
++	printk(KERN_INFO "TXQ[%x]: STPD[%x]: 0x%x:0x%x:0x%x:0x%x\n",
++	       txque->que_idx, txque->tpq.last_produce_idx,
++	       stpd->dfmt.dw0, stpd->dfmt.dw1, stpd->dfmt.dw2, stpd->dfmt.dw3);
++#endif
++	htpd->dfmt.dw0 = cpu_to_le32(stpd->dfmt.dw0);
++	htpd->dfmt.dw1 = cpu_to_le32(stpd->dfmt.dw1);
++	htpd->qfmt.qw1 = cpu_to_le64(stpd->qfmt.qw1);
++
++	return true;
++}
++
++/*
++ * Calculate the transmit packet descript needed
++ */
++static bool alx_dfs_diag_check_num_tpdescs(struct alx_tx_queue *txque,
++					   struct alx_diag_packet *pkt)
++{
++	u16 num_required = 1;
++	u16 num_available = 0;
++	u16 produce_idx = txque->tpq.produce_idx;
++	u16 consume_idx = txque->tpq.consume_idx;
++
++	if (pkt->type & ALX_DIAG_PKTYPE_TSOV2)
++		num_required += 1;
++
++	num_available = (u16)(consume_idx > produce_idx) ?
++		(consume_idx - produce_idx - 1) :
++		(txque->tpq.count + consume_idx - produce_idx - 1);
++
++	return num_required < num_available;
++}
++
++
++/*
++ * configure tpds according the diag packet
++ */
++static void alx_dfs_diag_config_tpd_tsov2(struct alx_tx_queue *txque,
++					  struct alx_diag_packet *pkt,
++					  union alx_sw_tpdesc *stpd)
++{
++	/* lso v2 need an extension TPD */
++	if (!(pkt->type & ALX_DIAG_PKTYPE_TSOV2))
++		return;
++
++	stpd->tso.lso     = 1;
++	stpd->tso.lso_v2  = 1;
++	stpd->tso.pkt_len = pkt->buf[0].length;
++	alx_dfs_set_tpdesc(txque, stpd);
++	memset(stpd, 0, sizeof(union alx_sw_tpdesc));
++}
++
++
++static void alx_dfs_diag_config_tpd(struct alx_tx_queue *txque,
++				    struct alx_diag_packet *pkt,
++				    union alx_sw_tpdesc *stpd)
++{
++	u16 machdr_offset = 0;
++	u16 iphdr_offset  = 0;
++	struct iphdr *iph;
++
++	/* VLAN */
++	if (pkt->type & ALX_DIAG_PKTYPE_VLANINST) {
++		stpd->genr.instag   = 1;
++		ALX_VLAN_TO_TAG(pkt->vlanid, stpd->genr.vlan_tag);
++	}
++
++	if (pkt->type & ALX_DIAG_PKTYPE_VLANTAGGED)
++		stpd->genr.vtagged  = 1;
++
++	/* checksum offload */
++	if (!(pkt->type & ALX_DIAG_PKTYPE_EII))
++		stpd->genr.type = 1;
++
++	/* MAC header length */
++	machdr_offset = 14;
++	if (pkt->type & ALX_DIAG_PKTYPE_SNAP)
++		machdr_offset += 8;
++
++	if (pkt->type & ALX_DIAG_PKTYPE_VLANTAGGED)
++		machdr_offset += 4;
++
++	/* IP header length */
++	if (pkt->type & ALX_DIAG_PKTYPE_IPV4) {
++		iph = (struct iphdr *)(pkt->buf[0].addr + machdr_offset);
++		iphdr_offset = iph->ihl << 2;
++	} else if (pkt->type & ALX_DIAG_PKTYPE_IPV6) {
++		struct ipv6hdr      *ipv6h;
++		struct ipv6_opt_hdr *opth;
++		u8  nexthdr;
++
++		ipv6h = (struct ipv6hdr *)(pkt->buf[0].addr + machdr_offset);
++		iphdr_offset = sizeof(struct ipv6hdr);
++		nexthdr = ipv6h->nexthdr;
++		while (nexthdr != NEXTHDR_TCP && nexthdr != NEXTHDR_UDP &&
++		       nexthdr != NEXTHDR_NONE) {
++			/* have IPv6 extension header */
++			opth = (struct ipv6_opt_hdr *)
++					((u8 *)ipv6h + iphdr_offset);
++
++			if (nexthdr == NEXTHDR_FRAGMENT)
++				iphdr_offset += 8;
++			else if (nexthdr == NEXTHDR_AUTH)
++				iphdr_offset += (opth->hdrlen + 2) << 2;
++			else
++				iphdr_offset += ipv6_optlen(opth);
++			nexthdr = opth->nexthdr;
++		}
++	}
++
++	/* checksum */
++	if (pkt->type & ALX_DIAG_PKTYPE_IPXSUM) {
++		/* IP checksum */
++		stpd->csum.ip_csum = 1;
++	}
++
++	if (pkt->type & ALX_DIAG_PKTYPE_L4XSUM) {
++		/* L4 checksum */
++		if (pkt->type & ALX_DIAG_PKTYPE_TCP)
++			stpd->csum.tcp_csum = 1;
++
++		if (pkt->type & ALX_DIAG_PKTYPE_UDP)
++			stpd->csum.udp_csum = 1;
++
++		stpd->csum.payld_offset = machdr_offset + iphdr_offset;
++	}
++
++	if (pkt->type & ALX_DIAG_PKTYPE_CXSUM) {
++		/* Custom checksum */
++		stpd->csum.c_csum        = 1;
++		stpd->csum.payld_offset = pkt->csum_start >> 1;
++		stpd->csum.cxsum_offset = pkt->csum_pos >> 1;
++	}
++
++	/* TCP Large send offload */
++	if (pkt->type & ALX_DIAG_PKTYPE_TSOV1) {
++		stpd->tso.lso           = 1;
++		stpd->tso.tcphdr_offset = machdr_offset + iphdr_offset;
++		stpd->tso.mss           = pkt->mss;
++	}
++
++	if (pkt->type & ALX_DIAG_PKTYPE_TSOV2) {
++		stpd->tso.lso           = 1;
++		stpd->tso.lso_v2        = 1;
++		stpd->tso.tcphdr_offset = machdr_offset + iphdr_offset;
++		stpd->tso.mss           = pkt->mss;
++	}
++
++	if (pkt->type & ALX_DIAG_PKTYPE_IPV4)
++		stpd->genr.ipv4 = 1;
++}
++
++
++static void alx_dfs_diag_tx_map(struct alx_adapter *adpt,
++				struct alx_tx_queue *txque,
++				struct alx_diag_packet *pkt,
++				union alx_sw_tpdesc *stpd)
++{
++	struct alx_buffer *tpbuf = NULL;
++	union alx_hw_tpdesc *htpd;
++
++	tpbuf = GET_TP_BUFFER(txque, txque->tpq.produce_idx);
++	tpbuf->length = pkt->buf[0].length;
++	tpbuf->dma    = dma_map_single(txque->dev, pkt->buf[0].addr,
++				       tpbuf->length, DMA_TO_DEVICE);
++	stpd->genr.addr       = tpbuf->dma;
++	stpd->genr.buffer_len = tpbuf->length;
++	alx_dfs_set_tpdesc(txque, stpd);
++
++	/* The last tpd */
++	htpd = ALX_TPD(txque, txque->tpq.last_produce_idx);
++	htpd->dfmt.dw1 |= cpu_to_le32(0x80000000);
++
++	/* diag don't use skb, so it's not need to free */
++	tpbuf->skb = NULL;
++}
++
++
++static netdev_tx_t alx_dfs_diag_xmit_frame(struct alx_adapter *adpt,
++					   struct alx_tx_queue *txque,
++					   struct alx_diag_packet *pkt)
++{
++	struct alx_hw     *hw = &adpt->hw;
++	unsigned long     flags = 0;
++	union alx_sw_tpdesc stpd; /* normal*/
++
++	if (CHK_ADPT_FLAG(STATE_DOWN))
++		return NETDEV_TX_OK;
++
++	if (!spin_trylock_irqsave(&adpt->tx_lock, flags)) {
++		alx_err(adpt, "tx locked!\n");
++		return NETDEV_TX_LOCKED;
++	}
++
++	if (!alx_dfs_diag_check_num_tpdescs(txque, pkt)) {
++		/* no enough descriptor, just stop queue */
++		spin_unlock_irqrestore(&adpt->tx_lock, flags);
++		return NETDEV_TX_BUSY;
++	}
++
++	memset(&stpd, 0, sizeof(union alx_sw_tpdesc));
++	alx_dfs_diag_config_tpd_tsov2(txque, pkt, &stpd);
++	alx_dfs_diag_config_tpd(txque, pkt, &stpd);
++	alx_dfs_diag_tx_map(adpt, txque, pkt, &stpd);
++
++	/* update produce idx */
++	wmb();
++	alx_mem_w16(hw, txque->produce_reg, txque->tpq.produce_idx);
++
++	spin_unlock_irqrestore(&adpt->tx_lock, flags);
++	return NETDEV_TX_OK;
++}
++
++
++static int alx_dfs_diag_begin(struct alx_adapter *adpt)
++{
++	struct alx_hw *hw = &adpt->hw;
++	int retval = 0;
++
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
++		alx_err(adpt, "warning! Please use MSI or Shared intr\n");
++		return -EINVAL;
++	}
++
++	if (CHK_ADPT_FLAG(STATE_TESTING)) {
++		alx_err(adpt, "warning! device is testing\n");
++		return -EINVAL;
++	}
++
++	if (CHK_ADPT_FLAG(STATE_DOWN) ||
++	    CHK_ADPT_FLAG(STATE_RESETTING)) {
++		alx_err(adpt, "warning! device is down or resetting\n");
++		return -EINVAL;
++	}
++
++	SET_ADPT_FLAG(STATE_TESTING);
++	SET_HW_FLAG(LOOPBACK_EN);
++	hw->cbs.update_mac_filter(hw);
++
++	alx_mem_w32(hw, ALX_CLK_GATE, 0x0);
++
++	skb_queue_head_init(&adpt->dfs.diag_skb_list);
++
++	adpt->dfs.diag_recv_sz = ALX_DIAG_MAX_DATA_BUFFER +
++		sizeof(struct alx_diag_packet) * ALX_DIAG_MAX_RX_PACKETS;
++	adpt->dfs.diag_send_sz = ALX_DIAG_MAX_DATA_BUFFER +
++		sizeof(struct alx_diag_packet) * ALX_DIAG_MAX_TX_PACKETS;
++	adpt->dfs.diag_info_sz =
++		sizeof(struct alx_diag_packet) * ALX_DIAG_MAX_RX_PACKETS;
++
++	netif_info(adpt, hw, adpt->netdev,
++		   "send_buf_sz=0x%x, recv_buf_sz=0x%x, info_buf_sz=0x%x\n",
++		   adpt->dfs.diag_send_sz, adpt->dfs.diag_recv_sz,
++		   adpt->dfs.diag_info_sz);
++
++	adpt->dfs.diag_recv_buf = kmalloc(adpt->dfs.diag_recv_sz, GFP_KERNEL);
++	if (!adpt->dfs.diag_recv_buf) {
++		alx_err(adpt, "error alloc recv buff\n");
++		retval = -ENOMEM;
++		goto err_alloc_recv_mem;
++	}
++
++	adpt->dfs.diag_send_buf = kmalloc(adpt->dfs.diag_send_sz, GFP_KERNEL);
++	if (!adpt->dfs.diag_send_buf) {
++		alx_err(adpt, "error alloc send buff\n");
++		retval = -ENOMEM;
++		goto err_alloc_send_mem;
++	}
++
++	adpt->dfs.diag_info_buf = kmalloc(adpt->dfs.diag_info_sz, GFP_KERNEL);
++	if (!adpt->dfs.diag_info_buf) {
++		alx_err(adpt, "error alloc packet info buff\n");
++		retval = -ENOMEM;
++		goto err_alloc_info_mem;
++	}
++	adpt->dfs.diag_pkt_info =
++			(struct alx_diag_packet *)adpt->dfs.diag_info_buf;
++	return 0;
++
++err_alloc_info_mem:
++	kfree(adpt->dfs.diag_send_buf);
++err_alloc_send_mem:
++	kfree(adpt->dfs.diag_recv_buf);
++err_alloc_recv_mem:
++	CLI_HW_FLAG(LOOPBACK_EN);
++	hw->cbs.update_mac_filter(hw);
++	CLI_ADPT_FLAG(STATE_TESTING);
++	return retval;
++}
++
++
++static int alx_dfs_diag_end(struct alx_adapter *adpt)
++{
++	struct alx_hw *hw = &adpt->hw;
++
++	if (!CHK_ADPT_FLAG(STATE_TESTING)) {
++		alx_err(adpt, "can't end diag, becasue diag isn't running\n");
++		return -EINVAL;
++	}
++
++	kfree(adpt->dfs.diag_recv_buf);
++	kfree(adpt->dfs.diag_send_buf);
++	kfree(adpt->dfs.diag_info_buf);
++	adpt->dfs.diag_recv_buf = NULL;
++	adpt->dfs.diag_send_buf = NULL;
++	adpt->dfs.diag_info_buf = NULL;
++	adpt->dfs.diag_pkt_info = NULL;
++	adpt->dfs.diag_info_sz = 0;
++	adpt->dfs.diag_recv_sz = 0;
++	adpt->dfs.diag_send_sz = 0;
++
++	skb_queue_purge(&adpt->dfs.diag_skb_list);
++
++	CLI_HW_FLAG(LOOPBACK_EN);
++	hw->cbs.update_mac_filter(hw);
++	CLI_ADPT_FLAG(STATE_TESTING);
++	return 0;
++}
++
++
++static int alx_dfs_diag_rx_pkts(struct alx_adapter *adpt, char *buf,
++				u32 size_in, u32 *size_out)
++{
++	struct sk_buff_head *list  = &adpt->dfs.diag_skb_list;
++	struct alx_diag_packet *pkt, *fpkt;
++	struct sk_buff *skb;
++	u8  *data;
++	u32 i, count, offset;
++
++	if (CHK_ADPT_FLAG(STATE_DOWN) ||
++	    !CHK_ADPT_FLAG(STATE_TESTING)) {
++		alx_err(adpt, "warning! Diag isn't running or nic is down\n");
++		return -EINVAL;
++	}
++
++	count  = skb_queue_len(list);
++	if (!count) {
++		*size_out = 0;
++		return -EINVAL;
++	}
++
++	offset = count * sizeof(struct alx_diag_packet);
++	if (offset >= adpt->dfs.diag_recv_sz) {
++		alx_err(adpt, "used diag buffer is greater than allocated\n");
++		return -EINVAL;
++	}
++
++	memset(adpt->dfs.diag_recv_buf, 0, adpt->dfs.diag_recv_sz);
++	fpkt = pkt  = (struct alx_diag_packet *)adpt->dfs.diag_recv_buf;
++	data = adpt->dfs.diag_recv_buf + offset;
++
++	for (i = 0; i < count; i++) {
++		skb = skb_dequeue(list);
++		if (!skb)
++			break;
++		memcpy(pkt, skb->sk, sizeof(struct alx_diag_packet));
++		pkt->buf[0].offset = offset;
++		pkt->buf[0].length = pkt->length;
++
++		if (pkt->length != skb->len) {
++			netif_warn(adpt, hw, adpt->netdev,
++				   "pkt->length(0x%x) != skb->len(0x%x)\n",
++				   pkt->length, skb->len);
++		}
++		memcpy(data, skb->data, pkt->length);
++
++		offset += pkt->length;
++		if (offset >= adpt->dfs.diag_recv_sz) {
++			alx_err(adpt,
++				"used diag buffer is greater than allocated\n");
++		}
++		kfree_skb(skb);
++		pkt->next = pkt + 1;
++		pkt++;
++		data = adpt->dfs.diag_recv_buf + offset;
++	}
++	fpkt[count - 1].next = NULL;
++
++	if (!buf || offset > size_in) {
++		alx_err(adpt, "receive buf is null or too small\n");
++		return -EINVAL;
++	}
++
++	*size_out = offset;
++	if (copy_to_user((void __user *)buf, adpt->dfs.diag_recv_buf,
++			  offset)) {
++		alx_err(adpt, "can't copy to user space\n");
++		return -EFAULT;
++	}
++	return 0;
++}
++
++static int alx_dfs_diag_tx_pkts(struct alx_adapter *adpt,
++				char *buf, u32 size_in)
++{
++	struct alx_diag_packet *pkt;
++	struct alx_tx_queue    *txque = adpt->tx_queue[0];
++	int num_pkts = ALX_DIAG_MAX_TX_PACKETS;
++
++	if (CHK_ADPT_FLAG(STATE_DOWN) ||
++	    !CHK_ADPT_FLAG(STATE_TESTING)) {
++		alx_err(adpt, "warning! Diag isn't running or nic is down\n");
++		return -EINVAL;
++	}
++
++	pkt = (struct alx_diag_packet *)adpt->dfs.diag_send_buf;
++	if (!buf || size_in > adpt->dfs.diag_send_sz) {
++		alx_err(adpt, "sending buf is null or too big\n");
++		return -EINVAL;
++	}
++
++	if (copy_from_user(pkt, (void __user *)buf, size_in)) {
++		alx_err(adpt, "can't copy from user\n");
++		return -EFAULT;
++	}
++
++	do {
++		/* fix buf[0].addr in alx_diag_packet */
++		if (pkt->buf[0].offset > size_in)
++			alx_err(adpt, "offset of alx_diag_packet error\n");
++
++		pkt->buf[0].addr = adpt->dfs.diag_send_buf + pkt->buf[0].offset;
++
++		alx_dfs_diag_xmit_frame(adpt, txque, pkt);
++
++		if (pkt->next == NULL)
++			break;
++		pkt++;
++	} while (--num_pkts);
++
++	return 0;
++}
++
++
++
++static int alx_dfs_cifs_annce_clear(struct alx_adapter *adpt,
++				    struct alx_dfs_ioctl_data *did)
++{
++	adpt->dfs.swoi_offload.len = 0;
++	return 0;
++}
++
++static int alx_dfs_cifs_annce_config(struct alx_adapter *adpt,
++				     struct alx_dfs_ioctl_data *did)
++{
++	struct alx_hw *hw = &adpt->hw;
++	int ret = 0;
++
++	if (!adpt->cifs ||
++	    did->param.buf.addr == NULL ||
++	    did->param.buf.size_in != sizeof(adpt->dfs.swoi_offload)) {
++		adpt->dfs.swoi_offload.len = 0;
++		return -EINVAL;
++	}
++
++	ret = copy_from_user(&adpt->dfs.swoi_offload,
++			     (void __user *)did->param.buf.addr,
++			     sizeof(adpt->dfs.swoi_offload));
++	if (ret != 0)
++		return -EINVAL;
++
++	if (adpt->dfs.swoi_offload.ver == ALX_SWOI_VER_CIFS) {
++		if (FIELD_GETX(hw->pci_revid, L1F_PCI_REVID) > L1F_REV_A1) {
++			adpt->dfs.swoi_offload.len = 0;
++			return -EINVAL;
++		}
++	} else if (adpt->dfs.swoi_offload.ver == ALX_SWOI_VER_SWOI) {
++		if (FIELD_GETX(hw->pci_revid, L1F_PCI_REVID) < L1F_REV_B0) {
++			adpt->dfs.swoi_offload.total_len = 0;
++			return -EINVAL;
++		}
++	} else {
++		adpt->dfs.swoi_offload.total_len = 0;
++		return -EINVAL;
++	}
++
++	return 0;
++}
++
++
++static int alx_dfs_ioctl_command_general(struct alx_adapter *adpt,
++					 struct alx_dfs_ioctl_data *did)
++{
++	struct alx_hw *hw = &adpt->hw;
++	int retval = 0;
++
++	switch (did->sub_cmd) {
++	case ALX_DFS_IOCTL_SCMD_GMAC_REG_32:
++		alx_mem_r32(hw, did->param.mac.num, &did->param.mac.val32);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: Read reg_32 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val32);
++		break;
++	case ALX_DFS_IOCTL_SCMD_SMAC_REG_32:
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: write reg_32 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val32);
++		alx_mem_w32(hw, did->param.mac.num, did->param.mac.val32);
++		break;
++
++	case ALX_DFS_IOCTL_SCMD_GMAC_REG_16:
++		alx_mem_r16(hw, did->param.mac.num, &did->param.mac.val16);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: read reg_16 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val16);
++		break;
++	case ALX_DFS_IOCTL_SCMD_SMAC_REG_16:
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: write reg_16 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val16);
++		alx_mem_w16(hw, did->param.mac.num, did->param.mac.val16);
++		break;
++	case ALX_DFS_IOCTL_SCMD_GMAC_REG_8:
++		alx_mem_r8(hw, did->param.mac.num, &did->param.mac.val8);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: read reg_8 %04x %08x\n",
++			      did->param.mac.num, did->param.mac.val8);
++		break;
++	case ALX_DFS_IOCTL_SCMD_SMAC_REG_8:
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: write reg_8 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val8);
++		alx_mem_w8(hw, did->param.mac.num, did->param.mac.val8);
++		break;
++
++	/* Read/Write MAC Register By config Mode */
++	case ALX_DFS_IOCTL_SCMD_GMAC_CFG_32:
++		alx_cfg_r32(hw, did->param.mac.num, &did->param.mac.val32);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: read cfg_32 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val32);
++		break;
++	case ALX_DFS_IOCTL_SCMD_SMAC_CFG_32:
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: write cfg_32 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val32);
++		alx_cfg_w32(hw, did->param.mac.num, did->param.mac.val32);
++		break;
++
++	/* Read/Write MAC Register By IO Port */
++	case ALX_DFS_IOCTL_SCMD_GMAC_IO_32:
++		alx_io_r32(hw, did->param.mac.num, &did->param.mac.val32);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: read io_32 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val32);
++		break;
++	case ALX_DFS_IOCTL_SCMD_SMAC_IO_32:
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: write io_32 %04x %08x\n",
++			  did->param.mac.num, did->param.mac.val32);
++		alx_io_w32(hw, did->param.mac.num, did->param.mac.val32);
++		break;
++
++
++	/* Read/Write PHY Ext Register */
++	case ALX_DFS_IOCTL_SCMD_GMII_EXT_REG:
++		if (!capable(CAP_NET_ADMIN)) {
++			retval = -EPERM;
++			goto out;
++		}
++
++		retval = hw->cbs.read_ext_phy_reg(hw, (u8)did->param.mii.dev,
++						  did->param.mii.num,
++						  &did->param.mii.val);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: read phy_ext %02x:%02x %04x\n",
++			  did->param.mii.dev, did->param.mii.num,
++			  did->param.mii.val);
++		if (retval) {
++			retval = -EIO;
++			goto out;
++		}
++		break;
++
++	case ALX_DFS_IOCTL_SCMD_SMII_EXT_REG:
++		if (!capable(CAP_NET_ADMIN)) {
++			retval = -EPERM;
++			goto out;
++		}
++
++		retval = hw->cbs.write_ext_phy_reg(hw, (u8)did->param.mii.dev,
++						   did->param.mii.num,
++						   did->param.mii.val);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: write phy_ext %02x:%02x %04x\n",
++			  did->param.mii.dev, did->param.mii.num,
++			  did->param.mii.val);
++		if (retval) {
++			retval = -EIO;
++			goto out;
++		}
++		break;
++
++
++	/* Diag */
++	case ALX_DFS_IOCTL_SCMD_DEVICE_REINIT:
++		netif_dbg(adpt, hw, adpt->netdev, "DFS: Device Reset\n");
++		alx_dfs_device_reinit(adpt);
++		break;
++
++	case ALX_DFS_IOCTL_SCMD_DIAG_BEGIN:
++		netif_dbg(adpt, hw, adpt->netdev, "DFS: Diag begin.\n");
++		retval = alx_dfs_diag_begin(adpt);
++		break;
++	case ALX_DFS_IOCTL_SCMD_DIAG_END:
++		netif_dbg(adpt, hw, adpt->netdev, "DFS: Diag end.\n");
++		retval = alx_dfs_diag_end(adpt);
++		break;
++	case ALX_DFS_IOCTL_SCMD_DIAG_TX_PKT:
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: Diag TX (%p:in-%08x)\n",
++			  did->param.buf.addr, did->param.buf.size_in);
++		retval = alx_dfs_diag_tx_pkts(adpt, did->param.buf.addr,
++					      did->param.buf.size_in);
++		break;
++	case ALX_DFS_IOCTL_SCMD_DIAG_RX_PKT:
++		retval = alx_dfs_diag_rx_pkts(adpt, did->param.buf.addr,
++					      did->param.buf.size_in,
++					      &did->param.buf.size_out);
++		netif_dbg(adpt, hw, adpt->netdev,
++			  "DFS: Diag RX (%p:in-%08x, out-%08x)\n",
++			  did->param.buf.addr, did->param.buf.size_in,
++			  did->param.buf.size_out);
++		break;
++
++	/* SWOI */
++	case ALX_DFS_IOCTL_SCMD_ANNCE_CLEAR:
++		retval = alx_dfs_cifs_annce_clear(adpt, did);
++		break;
++
++	case ALX_DFS_IOCTL_SCMD_ANNCE_CONFIG:
++		retval = alx_dfs_cifs_annce_config(adpt, did);
++		break;
++
++	default:
++		retval = -EOPNOTSUPP;
++		break;
++	}
++out:
++	return retval;
++}
++
++/*
++ * debugfs file operation
++ */
++static long alx_debugfs_ioctl(struct file *file, unsigned int cmd,
++			      unsigned long arg)
++{
++	struct alx_adapter *adpt = (struct alx_adapter *)file->private_data;
++	struct alx_dfs_ioctl_data did;
++	long retval = 0;
++
++	if (copy_from_user(&did, (void __user *)arg, sizeof(did)))
++		return -EFAULT;
++
++	switch (cmd) {
++	case ALX_DFS_IOCTL_CMD_GENR:
++		retval = alx_dfs_ioctl_command_general(adpt, &did);
++		break;
++	default:
++		return -EINVAL;
++	}
++
++	if (copy_to_user((void __user *)arg, &did, sizeof(did)))
++		return -EFAULT;
++
++	return retval;
++}
++
++
++static struct dentry *alx_debugfs_dir;
++
++static const struct file_operations alx_fops_debugfs = {
++	.open = simple_open,
++	.unlocked_ioctl = alx_debugfs_ioctl,
++	.compat_ioctl = alx_debugfs_ioctl,
++};
++
++/*
++ * Use network device events to create/remove/rename
++ * debugfs file entries
++ */
++static int alx_debugfs_event(struct notifier_block *nb,
++			     unsigned long event, void *ptr)
++{
++	struct net_device *netdev = ptr;
++	struct alx_adapter *adpt = netdev_priv(netdev);
++
++	if (adpt->hw.pci_venid != ALX_VENDOR_ID || !alx_debugfs_dir)
++		return NOTIFY_DONE;
++
++	switch (event) {
++	case NETDEV_CHANGENAME:
++		netif_info(adpt, hw, adpt->netdev,
++			   "changename event, name is %s\n", netdev->name);
++		if (adpt->dfs.fent) {
++			adpt->dfs.fent = debugfs_rename(alx_debugfs_dir,
++							adpt->dfs.fent,
++							alx_debugfs_dir,
++							netdev->name);
++		}
++		break;
++	case NETDEV_GOING_DOWN:
++		netif_info(adpt, hw, adpt->netdev, "going down event\n");
++		if (adpt->dfs.fent) {
++			debugfs_remove(adpt->dfs.fent);
++			adpt->dfs.fent = NULL;
++		}
++		break;
++	case NETDEV_UP:
++		netif_info(adpt, hw, adpt->netdev,
++			   "up event, name is %s\n", netdev->name);
++		adpt->dfs.fent = debugfs_create_file(netdev->name, S_IRUGO,
++						     alx_debugfs_dir, adpt,
++						     &alx_fops_debugfs);
++		if (IS_ERR(adpt->dfs.fent))
++			adpt->dfs.fent = NULL;
++	}
++
++	return NOTIFY_DONE;
++}
++
++
++static struct notifier_block alx_notify_debugfs = {
++	.notifier_call = alx_debugfs_event,
++};
++
++void __init alx_debug_init(void)
++{
++	struct dentry *dent;
++
++	dent = debugfs_create_dir("alx", NULL);
++	if (!dent || IS_ERR(dent))
++		return;
++	alx_debugfs_dir = dent;
++
++	register_netdevice_notifier(&alx_notify_debugfs);
++}
++
++void __exit alx_debug_exit(void)
++{
++	if (alx_debugfs_dir) {
++		unregister_netdevice_notifier(&alx_notify_debugfs);
++		debugfs_remove(alx_debugfs_dir);
++		alx_debugfs_dir = NULL;
++	}
++}
+diff --git a/drivers/net/ethernet/atheros/alx/alx_dfs.h b/drivers/net/ethernet/atheros/alx/alx_dfs.h
+new file mode 100644
+index 0000000..0dba78d
+--- /dev/null
++++ b/drivers/net/ethernet/atheros/alx/alx_dfs.h
+@@ -0,0 +1,184 @@
++/*
++ * Copyright (c) 2012 Qualcomm Atheros, Inc.
++ *
++ * Permission to use, copy, modify, and/or distribute this software for any
++ * purpose with or without fee is hereby granted, provided that the above
++ * copyright notice and this permission notice appear in all copies.
++ *
++ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
++ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
++ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
++ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
++ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
++ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
++ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
++ */
++
++#ifndef _ALX_DFS_H_
++#define _ALX_DFS_H_
++
++#include "alx_cifs.h"
++/*
++ * debugfs parameter in alx_adapter
++ */
++struct alx_debugfs_param {
++	struct dentry *fent;
++
++	/* DIAG parameter */
++	u8 *diag_recv_buf;
++	u8 *diag_send_buf;
++	u8 *diag_info_buf;
++	u32 diag_recv_sz;
++	u32 diag_send_sz;
++	u32 diag_info_sz;
++	struct alx_diag_packet *diag_pkt_info;
++	struct sk_buff_head     diag_skb_list;
++
++	/* SWOI parameter */
++	u32               annce_addr_off;
++	struct alx_swoi   swoi_offload;
++	struct alx_teredo teredo_offload;
++};
++
++/*
++ * debugfs IOCTL parameter
++ */
++struct alx_dfs_ioctl_param_buf {
++	void *addr;
++	__u32 size_in;
++	__u32 size_out;
++};
++
++struct alx_dfs_ioctl_param_dat {
++	__u32 val0;
++	__u32 val1;
++};
++
++struct alx_dfs_ioctl_param_mac {
++	__u32 num;
++	union {
++		__u32 val32;
++		__u16 val16;
++		__u8 val8;
++	};
++};
++
++struct alx_dfs_ioctl_param_mii {
++	__u16 dev;
++	__u16 num;
++	__u16 val;
++};
++
++
++struct alx_dfs_ioctl_data {
++	__u32 sub_cmd;
++	union {
++		struct alx_dfs_ioctl_param_buf buf;
++		struct alx_dfs_ioctl_param_dat dat;
++		struct alx_dfs_ioctl_param_mac mac;
++		struct alx_dfs_ioctl_param_mii mii;
++	} param;
++};
++
++
++#define ALX_DFS_IOCTL_CMD_GENR	_IOWR('L', 0x80, struct alx_dfs_ioctl_data)
++
++#define ALX_DFS_IOCTL_SCMD_GMAC_REG_32       0x0001
++#define ALX_DFS_IOCTL_SCMD_SMAC_REG_32       0x0002
++#define ALX_DFS_IOCTL_SCMD_GMAC_REG_16       0x0003
++#define ALX_DFS_IOCTL_SCMD_SMAC_REG_16       0x0004
++#define ALX_DFS_IOCTL_SCMD_GMAC_REG_8        0x0005
++#define ALX_DFS_IOCTL_SCMD_SMAC_REG_8        0x0006
++
++#define ALX_DFS_IOCTL_SCMD_GMAC_CFG_32       0x0011
++#define ALX_DFS_IOCTL_SCMD_SMAC_CFG_32       0x0012
++
++#define ALX_DFS_IOCTL_SCMD_GMAC_IO_32        0x0021
++#define ALX_DFS_IOCTL_SCMD_SMAC_IO_32        0x0022
++
++#define ALX_DFS_IOCTL_SCMD_GMII_EXT_REG      0x0031
++#define ALX_DFS_IOCTL_SCMD_SMII_EXT_REG      0x0032
++#define ALX_DFS_IOCTL_SCMD_GMII_IDR_REG      0x0033
++#define ALX_DFS_IOCTL_SCMD_SMII_IDR_REG      0x0034
++
++#define ALX_DFS_IOCTL_SCMD_DEVICE_INACTIVE   0x10001
++#define ALX_DFS_IOCTL_SCMD_DEVICE_REINIT     0x10002
++#define ALX_DFS_IOCTL_SCMD_DIAG_BEGIN        0x10003
++#define ALX_DFS_IOCTL_SCMD_DIAG_END          0x10004
++#define ALX_DFS_IOCTL_SCMD_DIAG_TX_PKT       0x10005
++#define ALX_DFS_IOCTL_SCMD_DIAG_RX_PKT       0x10006
++
++#define ALX_DFS_IOCTL_SCMD_ANNCE_CLEAR       0x20001
++#define ALX_DFS_IOCTL_SCMD_ANNCE_CONFIG      0x20002
++
++
++/*
++ * Diag tool support
++ */
++#define ALX_DIAG_MAX_PACKET_BUFS        1
++#define ALX_DIAG_MAX_DATA_BUFFER        (32 * 64 * 1024)
++#define ALX_DIAG_MAX_TX_PACKETS         32
++#define ALX_DIAG_MAX_RX_PACKETS         512
++
++struct alx_diag_buf {
++	u8	*addr;
++	u32	offset;
++	u32	length;
++};
++
++struct alx_diag_packet {
++	struct alx_diag_packet *next;
++	u32                     length;  /* total length of the packet(buf) */
++	u32                     type;    /* packet type, vlan, ip checksum */
++	struct alx_diag_buf     buf[ALX_DIAG_MAX_PACKET_BUFS];
++	struct alx_diag_buf     sglist[ALX_DIAG_MAX_PACKET_BUFS];
++	u16                     vlanid;
++	u16                     mss;
++	u32                     rss_hash;
++	u16                     rss_cpu_num;
++	u16                     xsum;        /* rx, ip-payload checksum */
++	u16                     csum_start;  /* custom checksum offset to the
++					      * mac-header */
++	u16                     csum_pos;    /* custom checksom position
++					      * (to the mac_header) */
++	void                   *uplevel_reserved[4];
++	void                   *lowlevel_reserved[4];
++};
++#define ALX_DIAG_PKTYPE_IPXSUM          0x00000001L /* ip checksum offload,
++						     * TO:task offload */
++#define ALX_DIAG_PKTYPE_L4XSUM          0x00000002L /* tcp/udp checksum
++						     * offload */
++#define ALX_DIAG_PKTYPE_VLANINST        0x00000004L /* insert vlan tag */
++#define ALX_DIAG_PKTYPE_TSOV1           0x00000008L /* tcp large send v1 */
++#define ALX_DIAG_PKTYPE_TSOV2           0x00000010L /* tcp large send v2 */
++#define ALX_DIAG_PKTYPE_CXSUM           0x00000020L /* checksum offload */
++#define ALX_DIAG_PKTYPE_VLANTAGGED      0x00000040L /* vlan tag */
++#define ALX_DIAG_PKTYPE_IPV4            0x00000080L /* ipv4 */
++#define ALX_DIAG_PKTYPE_IPV6            0x00000100L /* ipv6 */
++#define ALX_DIAG_PKTYPE_TCP             0x00000200L /* tcp */
++#define ALX_DIAG_PKTYPE_UDP             0x00000400L /* udp */
++#define ALX_DIAG_PKTYPE_EII             0x00000800L /* ethernet II */
++#define ALX_DIAG_PKTYPE_802_3           0x00001000L /* 802.3 */
++#define ALX_DIAG_PKTYPE_SNAP            0x00002000L /* 802.2/snap */
++#define ALX_DIAG_PKTYPE_FRAGMENT        0x00004000L /* fragment ip packet */
++#define ALX_DIAG_PKTYPE_SGLIST_VALID    0x00008000L /* SGList valid */
++#define ALX_DIAG_PKTYPE_HASH_VLAID      0x00010000L /* Hash valid */
++#define ALX_DIAG_PKTYPE_CPUNUM_VALID    0x00020000L /* CpuNum valid */
++#define ALX_DIAG_PKTYPE_XSUM_VALID      0x00040000L
++#define ALX_DIAG_PKTYPE_IPXSUM_ERR      0x00080000L
++#define ALX_DIAG_PKTYPE_L4XSUM_ERR      0x00100000L
++#define ALX_DIAG_PKTYPE_802_3_LEN_ERR   0x00200000L
++#define ALX_DIAG_PKTYPE_INCOMPLETE_ERR  0x00400000L
++#define ALX_DIAG_PKTYPE_CRC_ERR         0x00800000L
++#define ALX_DIAG_PKTYPE_RX_ERR          0x01000000L
++#define ALX_DIAG_PKTYPE_PTP             0x02000000L /* 1588 PTP */
++#define ALX_DIAG_PKTYPE_LLDP            0x04000000L /* IEEE LLDP */
++
++
++union alx_sw_rrdesc;
++int alx_flush_mac_address(struct alx_adapter *adpt);
++void alx_dfs_diag_receive_skb(struct alx_adapter *adpt, struct sk_buff *skb,
++			      union alx_sw_rrdesc *srrd);
++void alx_debug_init(void);
++void alx_debug_exit(void);
++#endif
+diff --git a/drivers/net/ethernet/atheros/alx/alx_ethtool.c b/drivers/net/ethernet/atheros/alx/alx_ethtool.c
+new file mode 100644
+index 0000000..9eae78a
+--- /dev/null
++++ b/drivers/net/ethernet/atheros/alx/alx_ethtool.c
+@@ -0,0 +1,369 @@
++/*
++ * Copyright (c) 2012 Qualcomm Atheros, Inc.
++ *
++ * Permission to use, copy, modify, and/or distribute this software for any
++ * purpose with or without fee is hereby granted, provided that the above
++ * copyright notice and this permission notice appear in all copies.
++ *
++ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
++ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
++ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
++ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
++ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
++ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
++ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
++ */
++
++
++#include <linux/pci.h>
++#include <linux/ethtool.h>
++
++#include "alx.h"
++#include "alx_hwcom.h"
++
++static int alx_get_settings(struct net_device *netdev,
++			    struct ethtool_cmd *ecmd)
++{
++	struct alx_adapter *adpt = netdev_priv(netdev);
++	struct alx_hw *hw = &adpt->hw;
++
++	ecmd->supported = (SUPPORTED_10baseT_Half  |
++			   SUPPORTED_10baseT_Full  |
++			   SUPPORTED_100baseT_Half |
++			   SUPPORTED_100baseT_Full |
++			   SUPPORTED_Autoneg       |
++			   SUPPORTED_TP);
++	if (CHK_HW_FLAG(GIGA_CAP))
++		ecmd->supported |= SUPPORTED_1000baseT_Full;
++
++	ecmd->advertising = ADVERTISED_TP;
++
++	ecmd->advertising |= ADVERTISED_Autoneg;
++	ecmd->advertising |= hw->autoneg_advertised;
++
++	ecmd->port = PORT_TP;
++	ecmd->phy_address = 0;
++	ecmd->autoneg = AUTONEG_ENABLE;
++	ecmd->transceiver = XCVR_INTERNAL;
++
++	if (hw->link_up) {
++		switch (hw->link_speed) {
++		case LX_LC_10H:
 +			ethtool_cmd_speed_set(ecmd, SPEED_10);
 +			ecmd->duplex = DUPLEX_HALF;
 +			break;
-+		case ALX_LINK_SPEED_10_FULL:
++		case LX_LC_10F:
 +			ethtool_cmd_speed_set(ecmd, SPEED_10);
 +			ecmd->duplex = DUPLEX_FULL;
 +			break;
-+		case ALX_LINK_SPEED_100_HALF:
++		case LX_LC_100H:
 +			ethtool_cmd_speed_set(ecmd, SPEED_100);
 +			ecmd->duplex = DUPLEX_HALF;
 +			break;
-+		case ALX_LINK_SPEED_100_FULL:
++		case LX_LC_100F:
 +			ethtool_cmd_speed_set(ecmd, SPEED_100);
 +			ecmd->duplex = DUPLEX_FULL;
 +			break;
-+		case ALX_LINK_SPEED_1GB_FULL:
++		case LX_LC_1000F:
 +			ethtool_cmd_speed_set(ecmd, SPEED_1000);
 +			ecmd->duplex = DUPLEX_FULL;
 +			break;
@@ -8494,51 +10117,53 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	u32 advertised, old;
 +	int error = 0;
 +
-+	while (CHK_ADPT_FLAG(1, STATE_RESETTING))
++	while (CHK_ADPT_FLAG(STATE_RESETTING))
 +		msleep(20);
-+	SET_ADPT_FLAG(1, STATE_RESETTING);
++	SET_ADPT_FLAG(STATE_RESETTING);
 +
 +	old = hw->autoneg_advertised;
 +	advertised = 0;
 +	if (ecmd->autoneg == AUTONEG_ENABLE) {
-+		advertised = ALX_LINK_SPEED_DEFAULT;
++		advertised = LX_LC_ALL;
 +	} else {
 +		u32 speed = ethtool_cmd_speed(ecmd);
 +		if (speed == SPEED_1000) {
 +			if (ecmd->duplex != DUPLEX_FULL) {
 +				dev_warn(&adpt->pdev->dev,
 +					 "1000M half is invalid\n");
-+				CLI_ADPT_FLAG(1, STATE_RESETTING);
++				CLI_ADPT_FLAG(STATE_RESETTING);
 +				return -EINVAL;
 +			}
-+			advertised = ALX_LINK_SPEED_1GB_FULL;
++			advertised = LX_LC_1000F;
 +		} else if (speed == SPEED_100) {
 +			if (ecmd->duplex == DUPLEX_FULL)
-+				advertised = ALX_LINK_SPEED_100_FULL;
++				advertised = LX_LC_100F;
 +			else
-+				advertised = ALX_LINK_SPEED_100_HALF;
++				advertised = LX_LC_100H;
 +		} else {
 +			if (ecmd->duplex == DUPLEX_FULL)
-+				advertised = ALX_LINK_SPEED_10_FULL;
++				advertised = LX_LC_10F;
 +			else
-+				advertised = ALX_LINK_SPEED_10_HALF;
++				advertised = LX_LC_10H;
 +		}
 +	}
 +
 +	if (hw->autoneg_advertised == advertised) {
-+		CLI_ADPT_FLAG(1, STATE_RESETTING);
++		CLI_ADPT_FLAG(STATE_RESETTING);
 +		return error;
 +	}
 +
-+	error = hw->cbs.setup_phy_link_speed(hw, advertised, true,
++	hw->autoneg_advertised = advertised;
++	error = hw->cbs.setup_phy_link(hw, hw->autoneg_advertised, true,
 +			!hw->disable_fc_autoneg);
 +	if (error) {
 +		dev_err(&adpt->pdev->dev,
 +			"setup link failed with code %d\n", error);
-+		hw->cbs.setup_phy_link_speed(hw, old, true,
++		hw->autoneg_advertised = old;
++		hw->cbs.setup_phy_link(hw, hw->autoneg_advertised, true,
 +				!hw->disable_fc_autoneg);
 +	}
-+	CLI_ADPT_FLAG(1, STATE_RESETTING);
++	CLI_ADPT_FLAG(STATE_RESETTING);
 +	return error;
 +}
 +
@@ -8576,9 +10201,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	bool disable_fc_autoneg;
 +	int retval;
 +
-+	while (CHK_ADPT_FLAG(1, STATE_RESETTING))
++	while (CHK_ADPT_FLAG(STATE_RESETTING))
 +		msleep(20);
-+	SET_ADPT_FLAG(1, STATE_RESETTING);
++	SET_ADPT_FLAG(STATE_RESETTING);
 +
 +	req_fc_mode        = hw->req_fc_mode;
 +	disable_fc_autoneg = hw->disable_fc_autoneg;
@@ -8612,7 +10237,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			hw->cbs.config_fc(hw);
 +	}
 +
-+	CLI_ADPT_FLAG(1, STATE_RESETTING);
++	CLI_ADPT_FLAG(STATE_RESETTING);
 +	return 0;
 +}
 +
@@ -8653,144 +10278,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alx_get_eeprom_len(struct net_device *netdev)
-+{
-+	struct alx_adapter *adpt = netdev_priv(netdev);
-+	struct alx_hw *hw = &adpt->hw;
-+	return hw->eeprom_sz;
-+}
-+
-+
-+static int alx_get_eeprom(struct net_device *netdev,
-+			  struct ethtool_eeprom *eeprom, u8 *bytes)
-+{
-+	struct alx_adapter *adpt = netdev_priv(netdev);
-+	struct alx_hw *hw = &adpt->hw;
-+	bool eeprom_exist = false;
-+	u32 *eeprom_buff;
-+	int first_dword, last_dword;
-+	int retval = 0;
-+	int i;
-+
-+	if (eeprom->len == 0)
-+		return -EINVAL;
-+
-+	if (hw->cbs.check_nvram)
-+		hw->cbs.check_nvram(hw, &eeprom_exist);
-+	if (!eeprom_exist)
-+		return -EOPNOTSUPP;
-+
-+	eeprom->magic = adpt->pdev->vendor |
-+			(adpt->pdev->device << 16);
-+
-+	first_dword = eeprom->offset >> 2;
-+	last_dword = (eeprom->offset + eeprom->len - 1) >> 2;
-+
-+	eeprom_buff = kmalloc(sizeof(u32) *
-+			(last_dword - first_dword + 1), GFP_KERNEL);
-+	if (eeprom_buff == NULL)
-+		return -ENOMEM;
-+
-+	for (i = first_dword; i < last_dword; i++) {
-+		if (hw->cbs.read_nvram) {
-+			retval = hw->cbs.read_nvram(hw, i*4,
-+					&(eeprom_buff[i-first_dword]));
-+			if (retval) {
-+				retval =  -EIO;
-+				goto out;
-+			}
-+		}
-+	}
-+
-+	/* Device's eeprom is always little-endian, word addressable */
-+	for (i = 0; i < last_dword - first_dword; i++)
-+		le32_to_cpus(&eeprom_buff[i]);
-+
-+	memcpy(bytes, (u8 *)eeprom_buff + (eeprom->offset & 3), eeprom->len);
-+out:
-+	kfree(eeprom_buff);
-+	return retval;
-+}
-+
-+
-+static int alx_set_eeprom(struct net_device *netdev,
-+			  struct ethtool_eeprom *eeprom, u8 *bytes)
-+{
-+	struct alx_adapter *adpt = netdev_priv(netdev);
-+	struct alx_hw *hw = &adpt->hw;
-+	bool eeprom_exist = false;
-+	u32 *eeprom_buff;
-+	u32 *ptr;
-+	int first_dword, last_dword;
-+	int retval = 0;
-+	int i;
-+
-+	if (eeprom->len == 0)
-+		return -EINVAL;
-+
-+	if (hw->cbs.check_nvram)
-+		hw->cbs.check_nvram(hw, &eeprom_exist);
-+	if (!eeprom_exist)
-+		return -EOPNOTSUPP;
-+
-+
-+	if (eeprom->magic != (adpt->pdev->vendor |
-+				(adpt->pdev->device << 16)))
-+		return -EINVAL;
-+
-+	first_dword = eeprom->offset >> 2;
-+	last_dword = (eeprom->offset + eeprom->len - 1) >> 2;
-+	eeprom_buff = kmalloc(ALX_MAX_EEPROM_LEN, GFP_KERNEL);
-+	if (eeprom_buff == NULL)
-+		return -ENOMEM;
-+
-+	ptr = (u32 *)eeprom_buff;
-+
-+	if (eeprom->offset & 3) {
-+		/* need read/modify/write of first changed EEPROM word */
-+		/* only the second byte of the word is being modified */
-+		if (hw->cbs.read_nvram) {
-+			retval = hw->cbs.read_nvram(hw, first_dword * 4,
-+						&(eeprom_buff[0]));
-+			if (retval) {
-+				retval = -EIO;
-+				goto out;
-+			}
-+		}
-+		ptr++;
-+	}
-+
-+	if (((eeprom->offset + eeprom->len) & 3)) {
-+		/* need read/modify/write of last changed EEPROM word */
-+		/* only the first byte of the word is being modified */
-+		if (hw->cbs.read_nvram) {
-+			retval = hw->cbs.read_nvram(hw, last_dword * 4,
-+				&(eeprom_buff[last_dword - first_dword]));
-+			if (retval) {
-+				retval = -EIO;
-+				goto out;
-+			}
-+		}
-+	}
-+
-+	/* Device's eeprom is always little-endian, word addressable */
-+	memcpy(ptr, bytes, eeprom->len);
-+	for (i = 0; i < last_dword - first_dword + 1; i++) {
-+		if (hw->cbs.write_nvram) {
-+			retval = hw->cbs.write_nvram(hw, (first_dword + i) * 4,
-+						eeprom_buff[i]);
-+			if (retval) {
-+				retval = -EIO;
-+				goto out;
-+			}
-+		}
-+	}
-+out:
-+	kfree(eeprom_buff);
-+	return retval;
-+}
-+
-+
 +static void alx_get_drvinfo(struct net_device *netdev,
 +			    struct ethtool_drvinfo *drvinfo)
 +{
@@ -8823,6 +10310,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	case ALX_DEV_ID_AR8152_V2:
 +	case ALX_DEV_ID_AR8161:
 +	case ALX_DEV_ID_AR8162:
++	case ALX_DEV_ID_AR8171:
++	case ALX_DEV_ID_AR8172:
 +		retval = 0;
 +		break;
 +	default:
@@ -8898,9 +10387,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	.set_msglevel    = alx_set_msglevel,
 +	.nway_reset      = alx_nway_reset,
 +	.get_link        = ethtool_op_get_link,
-+	.get_eeprom_len  = alx_get_eeprom_len,
-+	.get_eeprom      = alx_get_eeprom,
-+	.set_eeprom      = alx_set_eeprom,
 +};
 +
 +
@@ -8908,9 +10394,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	SET_ETHTOOL_OPS(netdev, &alx_ethtool_ops);
 +}
+diff --git a/drivers/net/ethernet/atheros/alx/alx_hwcom.h b/drivers/net/ethernet/atheros/alx/alx_hwcom.h
+new file mode 100644
+index 0000000..25a2d33
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alx_hwcom.h
-@@ -0,0 +1,187 @@
+@@ -0,0 +1,127 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -8936,63 +10425,17 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +#define BIT_ALL	    0xffffffffUL
 +
-+#define ASHFT31(_x)  ((_x) << 31)
-+#define ASHFT30(_x)  ((_x) << 30)
-+#define ASHFT29(_x)  ((_x) << 29)
-+#define ASHFT28(_x)  ((_x) << 28)
-+#define ASHFT27(_x)  ((_x) << 27)
-+#define ASHFT26(_x)  ((_x) << 26)
-+#define ASHFT25(_x)  ((_x) << 25)
-+#define ASHFT24(_x)  ((_x) << 24)
-+#define ASHFT23(_x)  ((_x) << 23)
-+#define ASHFT22(_x)  ((_x) << 22)
-+#define ASHFT21(_x)  ((_x) << 21)
-+#define ASHFT20(_x)  ((_x) << 20)
-+#define ASHFT19(_x)  ((_x) << 19)
-+#define ASHFT18(_x)  ((_x) << 18)
-+#define ASHFT17(_x)  ((_x) << 17)
-+#define ASHFT16(_x)  ((_x) << 16)
-+#define ASHFT15(_x)  ((_x) << 15)
-+#define ASHFT14(_x)  ((_x) << 14)
-+#define ASHFT13(_x)  ((_x) << 13)
-+#define ASHFT12(_x)  ((_x) << 12)
-+#define ASHFT11(_x)  ((_x) << 11)
-+#define ASHFT10(_x)  ((_x) << 10)
-+#define ASHFT9(_x)   ((_x) << 9)
-+#define ASHFT8(_x)   ((_x) << 8)
-+#define ASHFT7(_x)   ((_x) << 7)
-+#define ASHFT6(_x)   ((_x) << 6)
-+#define ASHFT5(_x)   ((_x) << 5)
-+#define ASHFT4(_x)   ((_x) << 4)
-+#define ASHFT3(_x)   ((_x) << 3)
-+#define ASHFT2(_x)   ((_x) << 2)
-+#define ASHFT1(_x)   ((_x) << 1)
-+#define ASHFT0(_x)   ((_x) << 0)
-+
-+
-+#define FIELD_GETX(_x, _name)   (((_x) & (_name##_MASK)) >> (_name##_SHIFT))
++#define FIELD_GETX(_x, _name)   (((_x) >> (_name##_SHIFT)) & (_name##_MASK))
 +#define FIELD_SETS(_x, _name, _v)   (\
 +(_x) =                               \
-+((_x) & ~(_name##_MASK))            |\
-+(((u16)(_v) << (_name##_SHIFT)) & (_name##_MASK)))
++((_x) & ~((_name##_MASK) << (_name##_SHIFT)))            |\
++(((u16)(_v) & (_name##_MASK)) << (_name##_SHIFT)))
 +#define FIELD_SETL(_x, _name, _v)   (\
 +(_x) =                               \
-+((_x) & ~(_name##_MASK))            |\
-+(((u32)(_v) << (_name##_SHIFT)) & (_name##_MASK)))
-+#define FIELDL(_name, _v) (((u32)(_v) << (_name##_SHIFT)) & (_name##_MASK))
-+#define FIELDS(_name, _v) (((u16)(_v) << (_name##_SHIFT)) & (_name##_MASK))
-+
-+
-+
-+#define LX_SWAP_DW(_x) (\
-+	(((_x) << 24) & 0xFF000000UL) |\
-+	(((_x) <<  8) & 0x00FF0000UL) |\
-+	(((_x) >>  8) & 0x0000FF00UL) |\
-+	(((_x) >> 24) & 0x000000FFUL))
-+
-+#define LX_SWAP_W(_x) (\
-+	(((_x) >> 8) & 0x00FFU) |\
-+	(((_x) << 8) & 0xFF00U))
++((_x) & ~((_name##_MASK) << (_name##_SHIFT)))            |\
++(((u32)(_v) & (_name##_MASK)) << (_name##_SHIFT)))
++#define FIELDL(_name, _v) (((u32)(_v) & (_name##_MASK)) << (_name##_SHIFT))
++#define FIELDS(_name, _v) (((u16)(_v) & (_name##_MASK)) << (_name##_SHIFT))
 +
 +
 +#define LX_ERR_SUCCESS          0x0000
@@ -9011,22 +10454,22 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	(LX_LC_10H|LX_LC_10F|LX_LC_100H|LX_LC_100F|LX_LC_1000F)
 +
 +/* options for MAC contrl */
-+#define LX_MACSPEED_1000        BIT(0)  /* 1:1000M, 0:10/100M */
-+#define LX_MACDUPLEX_FULL       BIT(1)  /* 1:full, 0:half */
-+#define LX_FLT_BROADCAST        BIT(2)  /* 1:enable rx-broadcast */
-+#define LX_FLT_MULTI_ALL        BIT(3)
-+#define LX_FLT_DIRECT           BIT(4)
-+#define LX_FLT_PROMISC          BIT(5)
++#define LX_FLT_DIRECT           BIT(0)
++#define LX_FLT_BROADCAST        BIT(1)  /* 1:enable rx-broadcast */
++#define LX_FLT_MULTI_ALL        BIT(2)
++#define LX_FLT_PROMISC          BIT(3)
++#define LX_VLAN_STRIP           BIT(4)
++#define LX_LOOPBACK             BIT(5)
 +#define LX_FC_TXEN              BIT(6)
 +#define LX_FC_RXEN              BIT(7)
-+#define LX_VLAN_STRIP           BIT(8)
-+#define LX_LOOPBACK             BIT(9)
-+#define LX_ADD_FCS              BIT(10)
-+#define LX_SINGLE_PAUSE         BIT(11)
++#define LX_ADD_FCS              BIT(8)
++#define LX_SINGLE_PAUSE         BIT(9)
++#define LX_MACSPEED_1000        BIT(10)  /* 1:1000M, 0:10/100M */
++#define LX_MACDUPLEX_FULL       BIT(11)  /* 1:full, 0:half */
 +
 +
 +/* interop between drivers */
-+#define LX_DRV_TYPE_MASK                ASHFT27(0x1FUL)
++#define LX_DRV_TYPE_MASK                0x1FUL
 +#define LX_DRV_TYPE_SHIFT               27
 +#define LX_DRV_TYPE_UNKNOWN             0
 +#define LX_DRV_TYPE_BIOS                1
@@ -9049,7 +10492,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define LX_DRV_PHY_10                   BIT(23)
 +#define LX_DRV_PHY_DUPLEX               BIT(22)  /* 1:full, 0:half */
 +#define LX_DRV_PHY_FC                   BIT(21)  /* 1:en flow control */
-+#define LX_DRV_PHY_MASK                 ASHFT21(0x1FUL)
++#define LX_DRV_PHY_MASK                 0x1FUL
 +#define LX_DRV_PHY_SHIFT                21
 +#define LX_DRV_PHY_UNKNOWN              0
 +#define LX_DRV_DISABLE                  BIT(18)
@@ -9060,19 +10503,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define LX_DRV_WOLLINKUP_EN             BIT(10)
 +#define LX_DRV_WOLMAGIC_EN              BIT(9)
 +#define LX_DRV_WOLCAP_BIOS_EN           BIT(8)
-+#define LX_DRV_ASPM_SPD1000LMT_MASK     ASHFT4(3UL)
++#define LX_DRV_ASPM_SPD1000LMT_MASK     0x3UL
 +#define LX_DRV_ASPM_SPD1000LMT_SHIFT    4
 +#define LX_DRV_ASPM_SPD1000LMT_100M     0
 +#define LX_DRV_ASPM_SPD1000LMT_NO       1
 +#define LX_DRV_ASPM_SPD1000LMT_1M       2
 +#define LX_DRV_ASPM_SPD1000LMT_10M      3
-+#define LX_DRV_ASPM_SPD100LMT_MASK      ASHFT2(3UL)
++#define LX_DRV_ASPM_SPD100LMT_MASK      0x3UL
 +#define LX_DRV_ASPM_SPD100LMT_SHIFT     2
 +#define LX_DRV_ASPM_SPD100LMT_1M        0
 +#define LX_DRV_ASPM_SPD100LMT_10M       1
 +#define LX_DRV_ASPM_SPD100LMT_100M      2
 +#define LX_DRV_ASPM_SPD100LMT_NO        3
-+#define LX_DRV_ASPM_SPD10LMT_MASK       ASHFT0(3UL)
++#define LX_DRV_ASPM_SPD10LMT_MASK       0x3UL
 +#define LX_DRV_ASPM_SPD10LMT_SHIFT      0
 +#define LX_DRV_ASPM_SPD10LMT_1M         0
 +#define LX_DRV_ASPM_SPD10LMT_10M        1
@@ -9082,25 +10525,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* flag of phy inited */
 +#define LX_PHY_INITED           0x003F
 +
-+/* check if the mac address is valid */
-+#define macaddr_valid(_addr) (\
-+	((*(u8 *)(_addr))&1) == 0 && \
-+	!(*(u32 *)(_addr) == 0 && *((u16 *)(_addr)+2) == 0))
-+
-+#define test_set_or_clear(_val, _ctrl, _flag, _bit)	\
-+do {							\
-+	if ((_ctrl) & (_flag))				\
-+		(_val) |= (_bit);			\
-+	else						\
-+		(_val) &= ~(_bit);			\
-+} while (0)
-+
 +
 +#endif/*_ALX_HWCOMMON_H_*/
-+
+diff --git a/drivers/net/ethernet/atheros/alx/alx_main.c b/drivers/net/ethernet/atheros/alx/alx_main.c
+new file mode 100644
+index 0000000..d5096f9
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alx_main.c
-@@ -0,0 +1,3899 @@
+@@ -0,0 +1,3988 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -9117,13 +10549,21 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 + */
 +
++#include <linux/module.h>
++#include <linux/pci.h>
++#include <linux/interrupt.h>
++#include <linux/ip.h>
++#include <linux/ipv6.h>
++#include <linux/if_vlan.h>
++#include <linux/mii.h>
++#include <linux/aer.h>
++
 +#include "alx.h"
 +#include "alx_hwcom.h"
 +
 +char alx_drv_name[] = "alx";
 +static const char alx_drv_description[] =
-+	"Qualcomm Atheros(R) "
-+	"AR813x/AR815x/AR816x PCI-E Ethernet Network Driver";
++"Qualcomm Atheros(R) AR813x/AR815x/AR816x/AR817x PCI-E Ethernet Network Driver";
 +
 +/* alx_pci_tbl - PCI Device ID Table
 + *
@@ -9144,6 +10584,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	ALX_ETHER_DEVICE(ALX_DEV_ID_AR8152_V2),
 +	ALX_ETHER_DEVICE(ALX_DEV_ID_AR8161),
 +	ALX_ETHER_DEVICE(ALX_DEV_ID_AR8162),
++	ALX_ETHER_DEVICE(ALX_DEV_ID_AR8171),
++	ALX_ETHER_DEVICE(ALX_DEV_ID_AR8172),
 +	{0,}
 +};
 +MODULE_DEVICE_TABLE(pci, alx_pci_tbl);
@@ -9151,21 +10593,27 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +MODULE_DESCRIPTION("Qualcomm Atheros Gigabit Ethernet Driver");
 +MODULE_LICENSE("Dual BSD/GPL");
 +
-+static int alx_open_internal(struct alx_adapter *adpt, u32 ctrl);
-+static void alx_stop_internal(struct alx_adapter *adpt, u32 ctrl);
++
++int alx_cfg_r32(const struct alx_hw *hw, int reg, u32 *pval)
++{
++	return pci_read_config_dword(hw->adpt->pdev, reg, pval);
++}
++
++
++int alx_cfg_w32(const struct alx_hw *hw, int reg, u32 val)
++{
++	return pci_write_config_dword(hw->adpt->pdev, reg, val);
++}
++
 +
 +int alx_cfg_r16(const struct alx_hw *hw, int reg, u16 *pval)
 +{
-+	if (!(hw && hw->adpt && hw->adpt->pdev))
-+		return -EINVAL;
 +	return pci_read_config_word(hw->adpt->pdev, reg, pval);
 +}
 +
 +
 +int alx_cfg_w16(const struct alx_hw *hw, int reg, u16 val)
 +{
-+	if (!(hw && hw->adpt && hw->adpt->pdev))
-+		return -EINVAL;
 +	return pci_write_config_word(hw->adpt->pdev, reg, val);
 +}
 +
@@ -9180,7 +10628,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	if (unlikely(!hw->link_up))
 +		readl(hw->hw_addr + reg);
-+	*(u32 *)val = readl(hw->hw_addr + reg);
++	*val = readl(hw->hw_addr + reg);
 +}
 +
 +
@@ -9192,15 +10640,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static void alx_mem_r16(const struct alx_hw *hw, int reg, u16 *val)
++void alx_mem_r16(const struct alx_hw *hw, int reg, u16 *val)
 +{
 +	if (unlikely(!hw->link_up))
 +		readl(hw->hw_addr + reg);
-+	*(u16 *)val = readw(hw->hw_addr + reg);
++	*val = readw(hw->hw_addr + reg);
 +}
 +
 +
-+static void alx_mem_w16(const struct alx_hw *hw, int reg, u16 val)
++void alx_mem_w16(const struct alx_hw *hw, int reg, u16 val)
 +{
 +	if (hw->mac_type == alx_mac_l2cb_v20 && reg < 0x1400)
 +		readl(hw->hw_addr + reg);
@@ -9230,7 +10678,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	vaf.va = &args;
 +
 +	if (hw && hw->adpt && hw->adpt->netdev)
-+		__netdev_printk(level, hw->adpt->netdev, &vaf);
++		netdev_printk(level, hw->adpt->netdev, "%pV", &vaf);
 +	else
 +		printk("%salx_hw: %pV", level, &vaf);
 +
@@ -9245,16 +10693,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	int retval = 0;
 +
-+	if (mac_addr[0] & 0x01) {
-+		printk(KERN_DEBUG "MAC address is multicast\n");
++	if (is_broadcast_ether_addr(mac_addr)) {
++		pr_debug("MAC address is broadcast\n");
 +		retval = -EADDRNOTAVAIL;
-+	} else if (mac_addr[0] == 0xff && mac_addr[1] == 0xff) {
-+		printk(KERN_DEBUG "MAC address is broadcast\n");
++	} else if (is_multicast_ether_addr(mac_addr)) {
++		pr_debug("MAC address is multicast\n");
 +		retval = -EADDRNOTAVAIL;
-+	} else if (mac_addr[0] == 0 && mac_addr[1] == 0 &&
-+		   mac_addr[2] == 0 && mac_addr[3] == 0 &&
-+		   mac_addr[4] == 0 && mac_addr[5] == 0) {
-+		printk(KERN_DEBUG "MAC address is all zeros\n");
++	} else if (is_zero_ether_addr(mac_addr)) {
++		pr_debug("MAC address is all zeros\n");
 +		retval = -EADDRNOTAVAIL;
 +	}
 +	return retval;
@@ -9266,6 +10712,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + */
 +static int alx_set_mac_type(struct alx_adapter *adpt)
 +{
++	struct pci_dev *pdev = adpt->pdev;
 +	struct alx_hw *hw = &adpt->hw;
 +	int retval = 0;
 +
@@ -9299,6 +10746,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		case ALX_DEV_ID_AR8162:
 +			hw->mac_type = alx_mac_l2f;
 +			break;
++		case ALX_DEV_ID_AR8171:
++			hw->mac_type = alx_mac_l1h;
++			break;
++		case ALX_DEV_ID_AR8172:
++			hw->mac_type = alx_mac_l2h;
++			break;
 +		default:
 +			retval = -EINVAL;
 +			break;
@@ -9307,8 +10760,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		retval = -EINVAL;
 +	}
 +
-+	netif_info(adpt, hw, adpt->netdev,
-+		   "found mac: %d, returns: %d\n", hw->mac_type, retval);
++	dev_info(&pdev->dev, "found mac: %d, returns: %d\n",
++		 hw->mac_type, retval);
 +	return retval;
 +}
 +
@@ -9326,6 +10779,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	switch (hw->mac_type) {
 +	case alx_mac_l1f:
 +	case alx_mac_l2f:
++	case alx_mac_l1h:
++	case alx_mac_l2h:
 +		retval = alf_init_hw_callbacks(hw);
 +		break;
 +	case alx_mac_l1c:
@@ -9349,22 +10804,22 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	WARN_ON(in_interrupt());
 +
-+	while (CHK_ADPT_FLAG(1, STATE_RESETTING))
++	while (CHK_ADPT_FLAG(STATE_RESETTING))
 +		msleep(20);
-+	SET_ADPT_FLAG(1, STATE_RESETTING);
++	SET_ADPT_FLAG(STATE_RESETTING);
 +
 +	alx_stop_internal(adpt, ALX_OPEN_CTRL_RESET_MAC);
 +	alx_open_internal(adpt, ALX_OPEN_CTRL_RESET_MAC);
 +
-+	CLI_ADPT_FLAG(1, STATE_RESETTING);
++	CLI_ADPT_FLAG(STATE_RESETTING);
 +}
 +
 +
 +static void alx_task_schedule(struct alx_adapter *adpt)
 +{
-+	if (!CHK_ADPT_FLAG(1, STATE_DOWN) &&
-+	    !CHK_ADPT_FLAG(1, STATE_WATCH_DOG)) {
-+		SET_ADPT_FLAG(1, STATE_WATCH_DOG);
++	if (!CHK_ADPT_FLAG(STATE_DOWN) &&
++	    !CHK_ADPT_FLAG(STATE_WATCH_DOG)) {
++		SET_ADPT_FLAG(STATE_WATCH_DOG);
 +		schedule_work(&adpt->alx_task);
 +	}
 +}
@@ -9372,10 +10827,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +static void alx_check_lsc(struct alx_adapter *adpt)
 +{
-+	SET_ADPT_FLAG(0, TASK_LSC_REQ);
++	SET_ADPT_FLAG(TASK_LSC_REQ);
 +	adpt->link_jiffies = jiffies + ALX_TRY_LINK_TIMEOUT;
 +
-+	if (!CHK_ADPT_FLAG(1, STATE_DOWN))
++	if (!CHK_ADPT_FLAG(STATE_DOWN))
 +		alx_task_schedule(adpt);
 +}
 +
@@ -9388,8 +10843,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_adapter *adpt = netdev_priv(netdev);
 +
 +	/* Do the reset outside of interrupt context */
-+	if (!CHK_ADPT_FLAG(1, STATE_DOWN)) {
-+		SET_ADPT_FLAG(0, TASK_REINIT_REQ);
++	if (!CHK_ADPT_FLAG(STATE_DOWN)) {
++		SET_ADPT_FLAG(TASK_REINIT_REQ);
 +		alx_task_schedule(adpt);
 +	}
 +}
@@ -9414,7 +10869,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		CLI_HW_FLAG(MULTIALL_EN);
 +		CLI_HW_FLAG(PROMISC_EN);
 +	}
-+	hw->cbs.config_mac_ctrl(hw);
++	hw->cbs.update_mac_filter(hw);
 +
 +	/* clear the old settings from the multicast hash table */
 +	hw->cbs.clear_mc_addr(hw);
@@ -9479,7 +10934,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			rfbuf[j].dma = 0;
 +	}
 +
-+	if (CHK_ADPT_FLAG(0, SRSS_EN))
++	if (CHK_ADPT_FLAG(SRSS_EN))
 +		goto srrs_enable;
 +
 +	return;
@@ -9526,7 +10981,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	}
 +
 +	if (hw->cbs.config_rss)
-+		hw->cbs.config_rss(hw, CHK_ADPT_FLAG(0, SRSS_EN));
++		hw->cbs.config_rss(hw, CHK_ADPT_FLAG(SRSS_EN));
 +}
 +
 +
@@ -9549,22 +11004,22 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +static bool alx_get_rrdesc(struct alx_rx_queue *rxque,
 +			   union alx_sw_rrdesc *srrd)
 +{
-+	union alx_rrdesc *hrrd =
++	union alx_hw_rrdesc *hrrd =
 +			ALX_RRD(rxque, rxque->rrq.consume_idx);
 +
-+	srrd->dfmt.dw0 = le32_to_cpu(hrrd->dfmt.dw0);
-+	srrd->dfmt.dw1 = le32_to_cpu(hrrd->dfmt.dw1);
-+	srrd->dfmt.dw2 = le32_to_cpu(hrrd->dfmt.dw2);
 +	srrd->dfmt.dw3 = le32_to_cpu(hrrd->dfmt.dw3);
-+
 +	if (!srrd->genr.update)
 +		return false;
 +
-+	if (likely(srrd->genr.nor != 1)) {
-+		/* TODO support mul rfd*/
-+		printk(KERN_EMERG "Multi rfd not support yet!\n");
-+	}
++	srrd->dfmt.dw2 = le32_to_cpu(hrrd->dfmt.dw2);
++	srrd->dfmt.dw1 = le32_to_cpu(hrrd->dfmt.dw1);
++	srrd->dfmt.dw0 = le32_to_cpu(hrrd->dfmt.dw0);
 +
++#ifdef DESC_DUMP
++	printk(KERN_INFO "RXQ[%x]: SRRD[%x]: 0x%x:0x%x:0x%x:0x%x\n",
++		rxque->que_idx, rxque->rrq.consume_idx,
++		srrd->dfmt.dw0, srrd->dfmt.dw1, srrd->dfmt.dw2, srrd->dfmt.dw3);
++#endif
 +	srrd->genr.update = 0;
 +	hrrd->dfmt.dw3 = cpu_to_le32(srrd->dfmt.dw3);
 +	if (++rxque->rrq.consume_idx == rxque->rrq.count)
@@ -9577,7 +11032,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +static bool alx_set_rfdesc(struct alx_rx_queue *rxque,
 +			   union alx_sw_rfdesc *srfd)
 +{
-+	union alx_rfdesc *hrfd =
++	union alx_hw_rfdesc *hrfd =
 +			ALX_RFD(rxque, rxque->rfq.produce_idx);
 +
 +	hrfd->qfmt.qw0 = cpu_to_le64(srfd->qfmt.qw0);
@@ -9592,14 +11047,18 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +static bool alx_set_tpdesc(struct alx_tx_queue *txque,
 +			   union alx_sw_tpdesc *stpd)
 +{
-+	union alx_tpdesc *htpd;
++	union alx_hw_tpdesc *htpd;
 +
 +	txque->tpq.last_produce_idx = txque->tpq.produce_idx;
 +	htpd = ALX_TPD(txque, txque->tpq.produce_idx);
 +
 +	if (++txque->tpq.produce_idx == txque->tpq.count)
 +		txque->tpq.produce_idx = 0;
-+
++#ifdef DESC_DUMP
++	printk(KERN_INFO "TXQ[%x]: STPD[%x]: 0x%x:0x%x:0x%x:0x%x\n",
++	       txque->que_idx, txque->tpq.last_produce_idx,
++	       stpd->dfmt.dw0, stpd->dfmt.dw1, stpd->dfmt.dw2, stpd->dfmt.dw3);
++#endif
 +	htpd->dfmt.dw0 = cpu_to_le32(stpd->dfmt.dw0);
 +	htpd->dfmt.dw1 = cpu_to_le32(stpd->dfmt.dw1);
 +	htpd->qfmt.qw1 = cpu_to_le64(stpd->qfmt.qw1);
@@ -9610,7 +11069,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +static void alx_set_tpdesc_lastfrag(struct alx_tx_queue *txque)
 +{
-+	union alx_tpdesc *htpd;
++	union alx_hw_tpdesc *htpd;
 +#define ALX_TPD_LAST_FLAGMENT  0x80000000
 +	htpd = ALX_TPD(txque, txque->tpq.last_produce_idx);
 +	htpd->dfmt.dw1 |= cpu_to_le32(ALX_TPD_LAST_FLAGMENT);
@@ -9699,20 +11158,28 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +				struct alx_rx_queue *rxque)
 +{
 +	struct alx_adapter *adpt = msix->adpt;
++	struct alx_hw *hw = &adpt->hw;
 +	struct pci_dev *pdev = adpt->pdev;
 +	struct net_device *netdev  = adpt->netdev;
-+
 +	union alx_sw_rrdesc srrd;
 +	struct alx_buffer *rfbuf;
 +	struct sk_buff *skb;
 +	struct alx_rx_queue *swque;
 +	struct alx_sw_buffer *curr_swbuf;
 +	struct alx_sw_buffer *next_swbuf;
-+
 +	u16 next_produce_idx;
++	u16 hw_consume_idx, num_consume_pkts;
 +	u16 count = 0;
 +
++	alx_mem_r16(hw, rxque->consume_reg, &hw_consume_idx);
++	num_consume_pkts = (hw_consume_idx >= rxque->rrq.consume_idx) ?
++		(hw_consume_idx -  rxque->rrq.consume_idx) :
++		(hw_consume_idx + rxque->rrq.count - rxque->rrq.consume_idx);
++
 +	while (1) {
++		if (!num_consume_pkts)
++			break;
++
 +		if (!alx_get_rrdesc(rxque, &srrd))
 +			break;
 +
@@ -9724,21 +11191,17 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			continue;
 +		}
 +
-+		/* Good Receive */
-+		if (likely(srrd.genr.nor == 1)) {
-+			rfbuf = GET_RF_BUFFER(rxque, srrd.genr.si);
-+			pci_unmap_single(pdev, rfbuf->dma,
-+					 rfbuf->length, DMA_FROM_DEVICE);
-+			rfbuf->dma = 0;
-+			skb = rfbuf->skb;
-+			netif_info(adpt, rx_err, adpt->netdev,
-+				   "skb addr = %p, rxbuf_len = %x\n",
-+				   skb->data, rfbuf->length);
-+		} else {
-+			/* TODO */
++		/* Bad Receive */
++		if (srrd.genr.nor != 1) {
 +			alx_err(adpt, "Multil rfd not support yet!\n");
 +			break;
 +		}
++
++		rfbuf = GET_RF_BUFFER(rxque, srrd.genr.si);
++		pci_unmap_single(pdev, rfbuf->dma, rfbuf->length,
++				 DMA_FROM_DEVICE);
++		rfbuf->dma = 0;
++		skb = rfbuf->skb;
 +		alx_clean_rfdesc(rxque, &srrd);
 +
 +		skb_put(skb, srrd.genr.pkt_len - ETH_FCS_LEN);
@@ -9812,16 +11275,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_hw *hw = &adpt->hw;
 +	struct pci_dev *pdev = adpt->pdev;
 +	struct net_device *netdev  = adpt->netdev;
-+
 +	union alx_sw_rrdesc srrd;
 +	struct alx_buffer *rfbuf;
 +	struct sk_buff *skb;
-+
 +	u16 hw_consume_idx, num_consume_pkts;
 +	u16 count = 0;
 +
 +	alx_mem_r16(hw, rxque->consume_reg, &hw_consume_idx);
-+	num_consume_pkts = (hw_consume_idx > rxque->rrq.consume_idx) ?
++	num_consume_pkts = (hw_consume_idx >= rxque->rrq.consume_idx) ?
 +		(hw_consume_idx -  rxque->rrq.consume_idx) :
 +		(hw_consume_idx + rxque->rrq.count - rxque->rrq.consume_idx);
 +
@@ -9840,26 +11301,33 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			continue;
 +		}
 +
-+		/* TODO: Good Receive */
-+		if (likely(srrd.genr.nor == 1)) {
-+			rfbuf = GET_RF_BUFFER(rxque, srrd.genr.si);
-+			pci_unmap_single(pdev, rfbuf->dma, rfbuf->length,
-+					 DMA_FROM_DEVICE);
-+			rfbuf->dma = 0;
-+			skb = rfbuf->skb;
-+		} else {
-+			/* TODO */
++		/* Bad Receive */
++		if (srrd.genr.nor != 1) {
 +			alx_err(adpt, "Multil rfd not support yet!\n");
 +			break;
 +		}
++
++		rfbuf = GET_RF_BUFFER(rxque, srrd.genr.si);
++		pci_unmap_single(pdev, rfbuf->dma, rfbuf->length,
++				 DMA_FROM_DEVICE);
++		rfbuf->dma = 0;
++		skb = rfbuf->skb;
 +		alx_clean_rfdesc(rxque, &srrd);
 +
++#ifdef CONFIG_ALX_DEBUGFS
++		if (CHK_ADPT_FLAG(STATE_TESTING)) {
++			skb_put(skb, srrd.genr.pkt_len - ETH_FCS_LEN);
++			alx_dfs_diag_receive_skb(adpt, skb, &srrd);
++		} else {
++#endif
 +		skb_put(skb, srrd.genr.pkt_len - ETH_FCS_LEN);
 +		skb->protocol = eth_type_trans(skb, netdev);
 +		skb_checksum_none_assert(skb);
 +		alx_receive_skb(adpt, skb, (u16)srrd.genr.vlan_tag,
 +				(bool)srrd.genr.vlan_flag);
-+
++#ifdef CONFIG_ALX_DEBUGFS
++		}
++#endif
 +		num_consume_pkts--;
 +		count++;
 +		(*num_pkts)++;
@@ -10051,7 +11519,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	for (i = 0; i < msix->rx_count; i++) {
 +		rque_idx = msix->rx_map[i];
 +		num_pkts = 0;
-+		if (CHK_ADPT_FLAG(0, SRSS_EN)) {
++		if (CHK_ADPT_FLAG(SRSS_EN)) {
 +			if (!spin_trylock_irqsave(&adpt->rx_lock, flags))
 +				goto clean_sw_irq;
 +
@@ -10090,7 +11558,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* If all work done, exit the polling mode */
 +	if (num_pkts < max_pkts) {
 +		napi_complete(napi);
-+		if (!CHK_ADPT_FLAG(1, STATE_DOWN))
++		if (!CHK_ADPT_FLAG(STATE_DOWN))
 +			hw->cbs.enable_msix_intr(hw, msix->vec_idx);
 +	}
 +
@@ -10116,7 +11584,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		   "NAPI: msix vec_idx = %d\n", msix->vec_idx);
 +
 +	/* Keep link state information with original netdev */
-+	if (!netif_carrier_ok(adpt->netdev))
++	if (!netif_carrier_ok(adpt->netdev) &&
++	    !CHK_ADPT_FLAG(STATE_TESTING))
 +		goto enable_rtx_irq;
 +
 +	for (que_idx = 0; que_idx < adpt->num_txques; que_idx++)
@@ -10171,7 +11640,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			SET_MSIX_FLAG(RX7);
 +			break;
 +		default:
-+			printk(KERN_ERR "alx_set_msix_flags: rx error.");
++			pr_err("%s: rx error\n", __func__);
 +			break;
 +		}
 +	} else if (type == alx_msix_type_tx) {
@@ -10189,7 +11658,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			SET_MSIX_FLAG(TX3);
 +			break;
 +		default:
-+			printk(KERN_ERR "alx_set_msix_flags: tx error.");
++			pr_err("%s: tx error\n", __func__);
 +			break;
 +		}
 +	} else if (type == alx_msix_type_other) {
@@ -10207,7 +11676,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			SET_MSIX_FLAG(PHY);
 +			break;
 +		default:
-+			printk(KERN_ERR "alx_set_msix_flags: other error.");
++			pr_err("%s: other error\n", __func__);
 +			break;
 +		}
 +	}
@@ -10225,7 +11694,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int num_msix_txques = adpt->num_msix_txques;
 +	int num_msix_noques = adpt->num_msix_noques;
 +
-+	if (CHK_ADPT_FLAG(0, FIXED_MSIX))
++	if (CHK_ADPT_FLAG(FIXED_MSIX))
 +		goto fixed_msix_map;
 +
 +	netif_warn(adpt, ifup, adpt->netdev,
@@ -10264,7 +11733,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (msix_idx != (num_msix_rxques + num_msix_txques))
 +		netif_warn(adpt, ifup, adpt->netdev, "msix_idx is wrong\n");
 +
-+
 +	/*
 +	 * For NON queue msix map
 +	 */
@@ -10299,7 +11767,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/*
 + * alx_enable_intr - Enable default interrupt generation settings
 + */
-+static inline void alx_enable_intr(struct alx_adapter *adpt)
++static void alx_enable_intr(struct alx_adapter *adpt)
 +{
 +	struct alx_hw *hw = &adpt->hw;
 +	int i;
@@ -10321,7 +11789,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* alx_disable_intr - Mask off interrupt generation on the NIC */
-+static inline void alx_disable_intr(struct alx_adapter *adpt)
++static void alx_disable_intr(struct alx_adapter *adpt)
 +{
 +	struct alx_hw *hw = &adpt->hw;
 +	atomic_inc(&adpt->irq_sem);
@@ -10329,7 +11797,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (hw->cbs.disable_legacy_intr)
 +		hw->cbs.disable_legacy_intr(hw);
 +
-+	if (CHK_ADPT_FLAG(0, MSIX_EN)) {
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
 +		int i;
 +		for (i = 0; i < adpt->num_msix_intrs; i++) {
 +			synchronize_irq(adpt->msix_entries[i].vector);
@@ -10338,8 +11806,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	} else {
 +		synchronize_irq(adpt->pdev->irq);
 +	}
-+
-+
 +}
 +
 +
@@ -10377,13 +11843,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +				   "isr error (status = 0x%x)\n",
 +				   status & ALX_ISR_ERROR);
 +			if (status & ALX_ISR_PCIE_FERR) {
-+				alx_mem_w16(hw, ALX_DEV_STAT,
-+					    ALX_DEV_STAT_FERR |
-+					    ALX_DEV_STAT_NFERR |
-+					    ALX_DEV_STAT_CERR);
++				alx_mem_w16(hw, ALX_PCI_DEV_STAT,
++					    ALX_PCI_DEV_STAT_FERR |
++					    ALX_PCI_DEV_STAT_NFERR |
++					    ALX_PCI_DEV_STAT_CERR);
 +			}
 +			/* reset MAC */
-+			SET_ADPT_FLAG(0, TASK_REINIT_REQ);
++			SET_ADPT_FLAG(TASK_REINIT_REQ);
 +			alx_task_schedule(adpt);
 +			return IRQ_HANDLED;
 +		}
@@ -10490,7 +11956,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		irq_set_affinity_hint(adpt->msix_entries[i].vector, NULL);
 +		free_irq(adpt->msix_entries[i].vector, adpt->msix[i]);
 +	}
-+	CLI_ADPT_FLAG(0, MSIX_EN);
++	CLI_ADPT_FLAG(MSIX_EN);
 +	pci_disable_msix(adpt->pdev);
 +	kfree(adpt->msix_entries);
 +	adpt->msix_entries = NULL;
@@ -10507,7 +11973,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int retval;
 +
 +	/* request MSIX irq */
-+	if (CHK_ADPT_FLAG(0, MSIX_EN)) {
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
 +		retval = alx_request_msix_irq(adpt);
 +		if (retval) {
 +			alx_err(adpt, "request msix irq failed, error = %d\n",
@@ -10517,7 +11983,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	}
 +
 +	/* request MSI irq */
-+	if (CHK_ADPT_FLAG(0, MSI_EN)) {
++	if (CHK_ADPT_FLAG(MSI_EN)) {
 +		retval = request_irq(adpt->pdev->irq, alx_interrupt, 0,
 +			netdev->name, netdev);
 +		if (retval) {
@@ -10544,7 +12010,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct net_device *netdev = adpt->netdev;
 +	int i;
 +
-+	if (CHK_ADPT_FLAG(0, MSIX_EN)) {
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
 +		for (i = 0; i < adpt->num_msix_intrs; i++) {
 +			struct alx_msix_param *msix = adpt->msix[i];
 +			netif_info(adpt, ifdown, adpt->netdev,
@@ -10570,7 +12036,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_adapter *adpt = netdev_priv(netdev);
 +	struct alx_hw *hw = &adpt->hw;
 +
-+	if (!CHK_ADPT_FLAG(1, STATE_DOWN))
++	if (!CHK_ADPT_FLAG(STATE_DOWN))
 +		alx_disable_intr(adpt);
 +
 +	if (features & NETIF_F_HW_VLAN_RX) {
@@ -10580,9 +12046,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		/* disable VLAN tag insert/strip */
 +		CLI_HW_FLAG(VLANSTRIP_EN);
 +	}
-+	hw->cbs.config_mac_ctrl(hw);
++	hw->cbs.update_mac_filter(hw);
 +
-+	if (!CHK_ADPT_FLAG(1, STATE_DOWN))
++	if (!CHK_ADPT_FLAG(STATE_DOWN))
 +		alx_enable_intr(adpt);
 +}
 +
@@ -10599,7 +12065,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int num_msix_intrs = adpt->num_msix_intrs;
 +	int msix_idx;
 +
-+	if (!CHK_ADPT_FLAG(0, MSIX_EN))
++	if (!CHK_ADPT_FLAG(MSIX_EN))
 +		num_msix_intrs = 1;
 +
 +	for (msix_idx = 0; msix_idx < num_msix_intrs; msix_idx++) {
@@ -10617,7 +12083,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int num_msix_intrs = adpt->num_msix_intrs;
 +	int msix_idx;
 +
-+	if (!CHK_ADPT_FLAG(0, MSIX_EN))
++	if (!CHK_ADPT_FLAG(MSIX_EN))
 +		num_msix_intrs = 1;
 +
 +	for (msix_idx = 0; msix_idx < num_msix_intrs; msix_idx++) {
@@ -10642,9 +12108,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		tpbuf = GET_TP_BUFFER(txque, i);
 +		if (tpbuf->dma) {
 +			pci_unmap_single(to_pci_dev(dev),
-+					tpbuf->dma,
-+					tpbuf->length,
-+					DMA_TO_DEVICE);
++					 tpbuf->dma,
++					 tpbuf->length,
++					 DMA_TO_DEVICE);
 +			tpbuf->dma = 0;
 +		}
 +		if (tpbuf->skb) {
@@ -10693,9 +12159,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +			if (rfbuf->dma) {
 +				pci_unmap_single(to_pci_dev(dev),
-+						rfbuf->dma,
-+						rfbuf->length,
-+						DMA_FROM_DEVICE);
++						 rfbuf->dma,
++						 rfbuf->length,
++						 DMA_FROM_DEVICE);
 +				rfbuf->dma = 0;
 +			}
 +			if (rfbuf->skb) {
@@ -10760,7 +12226,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	struct alx_hw *hw = &adpt->hw;
 +
-+	if (hw->mac_type == alx_mac_l1f || hw->mac_type == alx_mac_l2f)
++	if (hw->mac_type == alx_mac_l1f || hw->mac_type == alx_mac_l2f ||
++	    hw->mac_type == alx_mac_l1h || hw->mac_type == alx_mac_l2h)
 +		adpt->num_txques = 4;
 +	else
 +		adpt->num_txques = 2;
@@ -10772,7 +12239,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + */
 +static inline void alx_set_num_rxques(struct alx_adapter *adpt)
 +{
-+	if (CHK_ADPT_FLAG(0, SRSS_CAP)) {
++	if (CHK_ADPT_FLAG(SRSS_CAP)) {
 +		adpt->num_hw_rxques = 1;
 +		adpt->num_sw_rxques = adpt->max_rxques;
 +		adpt->num_rxques =
@@ -10800,6 +12267,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* alx_alloc_all_rtx_queue - allocate all queues */
 +static int alx_alloc_all_rtx_queue(struct alx_adapter *adpt)
 +{
++	struct pci_dev *pdev = adpt->pdev;
 +	int que_idx;
 +
 +	for (que_idx = 0; que_idx < adpt->num_txques; que_idx++) {
@@ -10829,7 +12297,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		rxque->dev = &adpt->pdev->dev;
 +		rxque->netdev = adpt->netdev;
 +
-+		if (CHK_ADPT_FLAG(0, SRSS_EN)) {
++		if (CHK_ADPT_FLAG(SRSS_EN)) {
 +			if (que_idx < adpt->num_hw_rxques)
 +				SET_RX_FLAG(HW_QUE);
 +			if (que_idx < adpt->num_sw_rxques)
@@ -10839,17 +12307,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		}
 +		adpt->rx_queue[que_idx] = rxque;
 +	}
-+	netif_dbg(adpt, probe, adpt->netdev,
-+		  "num_tx_descs = %d, num_rx_descs = %d\n",
-+		  adpt->num_txdescs, adpt->num_rxdescs);
 +	return 0;
 +
 +err_alloc_rx_queue:
-+	alx_err(adpt, "goto err_alloc_rx_queue");
++	dev_err(&pdev->dev, "goto err_alloc_rx_queue\n");
 +	for (que_idx = 0; que_idx < adpt->num_rxques; que_idx++)
 +		kfree(adpt->rx_queue[que_idx]);
 +err_alloc_tx_queue:
-+	alx_err(adpt, "goto err_alloc_tx_queue");
++	dev_err(&pdev->dev, "goto err_alloc_tx_queue\n");
 +	for (que_idx = 0; que_idx < adpt->num_txques; que_idx++)
 +		kfree(adpt->tx_queue[que_idx]);
 +	return -ENOMEM;
@@ -10875,11 +12340,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* alx_set_interrupt_param - set interrupt parameter */
 +static int alx_set_interrupt_param(struct alx_adapter *adpt)
 +{
++	struct pci_dev *pdev = adpt->pdev;
 +	struct alx_msix_param *msix;
 +	int (*poll)(struct napi_struct *, int);
 +	int msix_idx;
 +
-+	if (CHK_ADPT_FLAG(0, MSIX_EN)) {
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
 +		poll = &alx_napi_msix_rtx;
 +	} else {
 +		adpt->num_msix_intrs = 1;
@@ -10887,8 +12353,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	}
 +
 +	for (msix_idx = 0; msix_idx < adpt->num_msix_intrs; msix_idx++) {
-+		msix = kzalloc(sizeof(struct alx_msix_param),
-+					   GFP_KERNEL);
++		msix = kzalloc(sizeof(struct alx_msix_param), GFP_KERNEL);
 +		if (!msix)
 +			goto err_alloc_msix;
 +		msix->adpt = adpt;
@@ -10916,7 +12381,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		kfree(msix);
 +		adpt->msix[msix_idx] = NULL;
 +	}
-+	alx_err(adpt, "can't allocate memory\n");
++	dev_err(&pdev->dev, "can't allocate memory\n");
 +	return -ENOMEM;
 +}
 +
@@ -10941,15 +12406,16 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* set msix interrupt mode */
 +static int alx_set_msix_interrupt_mode(struct alx_adapter *adpt)
 +{
++	struct pci_dev *pdev = adpt->pdev;
 +	int msix_intrs, msix_idx;
 +	int retval = 0;
 +
 +	adpt->msix_entries = kcalloc(adpt->max_msix_intrs,
 +				sizeof(struct msix_entry), GFP_KERNEL);
 +	if (!adpt->msix_entries) {
-+		netif_info(adpt, probe, adpt->netdev,
-+			   "can't allocate msix entry\n");
-+		CLI_ADPT_FLAG(0, MSIX_EN);
++		dev_info(&pdev->dev,
++			 "can't allocate msix entry\n");
++		CLI_ADPT_FLAG(MSIX_EN);
 +		goto try_msi_mode;
 +	}
 +
@@ -10969,46 +12435,42 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			msix_intrs = retval;
 +	}
 +	if (msix_intrs < adpt->min_msix_intrs) {
-+		netif_info(adpt, probe, adpt->netdev,
-+			   "can't enable MSI-X interrupts\n");
-+		CLI_ADPT_FLAG(0, MSIX_EN);
++		dev_info(&pdev->dev,
++			 "can't enable MSI-X interrupts\n");
++		CLI_ADPT_FLAG(MSIX_EN);
 +		kfree(adpt->msix_entries);
 +		adpt->msix_entries = NULL;
 +		goto try_msi_mode;
 +	}
 +
-+	netif_info(adpt, probe, adpt->netdev,
-+		   "enable MSI-X interrupts, num_msix_intrs = %d\n",
-+		   msix_intrs);
-+	SET_ADPT_FLAG(0, MSIX_EN);
-+	if (CHK_ADPT_FLAG(0, SRSS_CAP))
-+		SET_ADPT_FLAG(0, SRSS_EN);
++	SET_ADPT_FLAG(MSIX_EN);
++	if (CHK_ADPT_FLAG(SRSS_CAP))
++		SET_ADPT_FLAG(SRSS_EN);
 +
 +	adpt->num_msix_intrs = min_t(int, msix_intrs, adpt->max_msix_intrs);
-+	retval = 0;
-+	return retval;
++	return 0;
 +
 +try_msi_mode:
-+	CLI_ADPT_FLAG(0, SRSS_CAP);
-+	CLI_ADPT_FLAG(0, SRSS_EN);
++	CLI_ADPT_FLAG(SRSS_CAP);
++	CLI_ADPT_FLAG(SRSS_EN);
 +	alx_set_num_queues(adpt);
-+	retval = -1;
-+	return retval;
++	return -EINVAL;
 +}
 +
 +
 +/* set msi interrupt mode */
 +static int alx_set_msi_interrupt_mode(struct alx_adapter *adpt)
 +{
++	struct pci_dev *pdev = adpt->pdev;
 +	int retval;
 +
 +	retval = pci_enable_msi(adpt->pdev);
 +	if (retval) {
-+		netif_info(adpt, probe, adpt->netdev,
-+			   "can't enable MSI interrupt, error = %d\n", retval);
++		dev_info(&pdev->dev,
++			 "can't enable MSI interrupt, error = %d\n", retval);
 +		return retval;
 +	}
-+	SET_ADPT_FLAG(0, MSI_EN);
++	SET_ADPT_FLAG(MSI_EN);
 +	return retval;
 +}
 +
@@ -11016,50 +12478,61 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +/* set interrupt mode */
 +static int alx_set_interrupt_mode(struct alx_adapter *adpt)
 +{
-+	int retval = 0;
++	int retval;
 +
-+	if (CHK_ADPT_FLAG(0, MSIX_CAP)) {
-+		netif_info(adpt, probe, adpt->netdev,
-+			   "try to set MSIX interrupt\n");
++	if (CHK_ADPT_FLAG(MSIX_CAP)) {
 +		retval = alx_set_msix_interrupt_mode(adpt);
 +		if (!retval)
 +			return retval;
 +	}
 +
-+	if (CHK_ADPT_FLAG(0, MSI_CAP)) {
-+		netif_info(adpt, probe, adpt->netdev,
-+			   "try to set MSI interrupt\n");
++	if (CHK_ADPT_FLAG(MSI_CAP)) {
 +		retval = alx_set_msi_interrupt_mode(adpt);
 +		if (!retval)
 +			return retval;
 +	}
-+
-+	netif_info(adpt, probe, adpt->netdev,
-+		   "can't enable MSIX and MSI, will enable shared interrupt\n");
-+	retval = 0;
-+	return retval;
++	return 0;
 +}
 +
 +
 +static void alx_reset_interrupt_mode(struct alx_adapter *adpt)
 +{
-+	if (CHK_ADPT_FLAG(0, MSIX_EN)) {
-+		CLI_ADPT_FLAG(0, MSIX_EN);
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
++		CLI_ADPT_FLAG(MSIX_EN);
 +		pci_disable_msix(adpt->pdev);
 +		kfree(adpt->msix_entries);
 +		adpt->msix_entries = NULL;
-+	} else if (CHK_ADPT_FLAG(0, MSI_EN)) {
-+		CLI_ADPT_FLAG(0, MSI_EN);
++	} else if (CHK_ADPT_FLAG(MSI_EN)) {
++		CLI_ADPT_FLAG(MSI_EN);
 +		pci_disable_msi(adpt->pdev);
 +	}
 +}
 +
 +
++static void __devinit alx_patch_assign(struct alx_adapter *adpt)
++{
++	struct alx_hw *hw = &adpt->hw;
++	u32 misc_ctrl;
++
++	if (hw->pci_devid == ALX_DEV_ID_AR8152_V2 &&
++	    hw->pci_revid == ALX_REV_ID_AR8152_V2_1) {
++		/* config acess mode */
++		alx_cfg_w32(hw, ALX_PCI_IND_ACC_ADDR, ALX_PCI_DEV_MISC_CTRL);
++		alx_cfg_r32(hw, ALX_PCI_IND_ACC_DATA, &misc_ctrl);
++		misc_ctrl &= ~0x100;
++		alx_cfg_w32(hw, ALX_PCI_IND_ACC_ADDR, ALX_PCI_DEV_MISC_CTRL);
++		alx_cfg_w32(hw, ALX_PCI_IND_ACC_DATA, misc_ctrl);
++	}
++}
++
++
 +static int __devinit alx_init_adapter_special(struct alx_adapter *adpt)
 +{
 +	switch (adpt->hw.mac_type) {
 +	case alx_mac_l1f:
 +	case alx_mac_l2f:
++	case alx_mac_l1h:
++	case alx_mac_l2h:
 +		goto init_alf_adapter;
 +		break;
 +	case alx_mac_l1c:
@@ -11077,7 +12550,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return -1;
 +
 +init_alc_adapter:
-+	if (CHK_ADPT_FLAG(0, MSIX_CAP))
++	if (CHK_ADPT_FLAG(MSIX_CAP))
 +		alx_err(adpt, "ALC doesn't support MSIX\n");
 +
 +	/* msi for tx, rx and none queues */
@@ -11087,7 +12560,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	return 0;
 +
 +init_alf_adapter:
-+	if (CHK_ADPT_FLAG(0, MSIX_CAP)) {
++	if (CHK_ADPT_FLAG(MSIX_CAP)) {
 +		/* msix for tx, rx and none queues */
 +		adpt->num_msix_txques = 4;
 +		adpt->num_msix_rxques = 8;
@@ -11125,31 +12598,35 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	hw->pci_sub_venid = pdev->subsystem_vendor;
 +	hw->pci_sub_devid = pdev->subsystem_device;
 +
++	alx_patch_assign(adpt);
++
 +	if (alx_init_hw_callbacks(adpt) != 0) {
-+		alx_err(adpt, "set HW function pointers failed\n");
-+		return -1;
++		dev_err(&pdev->dev, "set HW function pointers failed\n");
++		return -EINVAL;
 +	}
 +
 +	if (hw->cbs.identify_nic(hw) != 0) {
-+		alx_err(adpt, "HW is disabled\n");
-+		return -1;
++		dev_err(&pdev->dev, "HW is disabled\n");
++		return -EINVAL;
 +	}
 +
 +	/* Set adapter flags */
 +	switch (hw->mac_type) {
 +	case alx_mac_l1f:
 +	case alx_mac_l2f:
++	case alx_mac_l1h:
++	case alx_mac_l2h:
 +#ifdef CONFIG_ALX_MSI
-+		SET_ADPT_FLAG(0, MSI_CAP);
++		SET_ADPT_FLAG(MSI_CAP);
 +#endif
 +#ifdef CONFIG_ALX_MSIX
-+		SET_ADPT_FLAG(0, MSIX_CAP);
++		SET_ADPT_FLAG(MSIX_CAP);
 +#endif
-+		if (CHK_ADPT_FLAG(0, MSIX_CAP)) {
-+			SET_ADPT_FLAG(0, FIXED_MSIX);
-+			SET_ADPT_FLAG(0, MRQ_CAP);
++		if (CHK_ADPT_FLAG(MSIX_CAP)) {
++			SET_ADPT_FLAG(FIXED_MSIX);
++			SET_ADPT_FLAG(MRQ_CAP);
 +#ifdef CONFIG_ALX_RSS
-+			SET_ADPT_FLAG(0, SRSS_CAP);
++			SET_ADPT_FLAG(SRSS_CAP);
 +#endif
 +		}
 +		pdev->dev_flags |= PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
@@ -11162,7 +12639,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	case alx_mac_l2cb_v20:
 +	case alx_mac_l2cb_v21:
 +#ifdef CONFIG_ALX_MSI
-+		SET_ADPT_FLAG(0, MSI_CAP);
++		SET_ADPT_FLAG(MSI_CAP);
 +#endif
 +		break;
 +	default:
@@ -11179,13 +12656,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	device_set_wakeup_enable(&pdev->dev, false);
 +
 +	/* set default for alx_hw */
++	hw->msi_lnkpatch = false;
 +	hw->link_up = false;
-+	hw->link_speed = ALX_LINK_SPEED_UNKNOWN;
-+	hw->preamble = 7;
++	hw->link_speed = 0;
 +	hw->intr_mask = ALX_IMR_NORMAL_MASK;
 +	hw->smb_timer = 400; /* 400ms */
 +	hw->mtu = adpt->netdev->mtu;
-+	hw->imt = 100;       /* set to 200us */
++	hw->imt_mod = 100;       /* set to 200us */
 +
 +	/* set default for wrr */
 +	hw->wrr_prio0 = 4;
@@ -11220,7 +12697,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			return -EINVAL;
 +	}
 +
-+	SET_ADPT_FLAG(1, STATE_DOWN);
++	SET_ADPT_FLAG(STATE_DOWN);
 +	return 0;
 +}
 +
@@ -11233,6 +12710,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	switch (adpt->hw.mac_type) {
 +	case alx_mac_l1f:
 +	case alx_mac_l2f:
++	case alx_mac_l1h:
++	case alx_mac_l2h:
 +		goto cache_alf_register;
 +		break;
 +	case alx_mac_l1c:
@@ -11293,6 +12772,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +				   struct alx_tx_queue *txque)
 +{
 +	struct alx_ring_header *ring_header = &adpt->ring_header;
++	struct alx_hw *hw = &adpt->hw;
++	u16 que_idx = txque->que_idx;
 +	int size;
 +
 +	netif_info(adpt, ifup, adpt->netdev,
@@ -11304,13 +12785,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		goto err_alloc_tpq_buffer;
 +
 +	/* round up to nearest 4K */
-+	txque->tpq.size = txque->tpq.count * sizeof(union alx_tpdesc);
++	txque->tpq.size = txque->tpq.count * sizeof(union alx_hw_tpdesc);
 +
 +	txque->tpq.tpdma = ring_header->dma + ring_header->used;
 +	txque->tpq.tpdesc = ring_header->desc + ring_header->used;
-+	adpt->hw.tpdma[txque->que_idx] = (u64)txque->tpq.tpdma;
 +	ring_header->used += ALIGN(txque->tpq.size, 8);
 +
++	hw->dma.tpdmem_hi[que_idx] = ALX_DMA_ADDR_HI(txque->tpq.tpdma);
++	hw->dma.tpdmem_lo[que_idx] = ALX_DMA_ADDR_LO(txque->tpq.tpdma);
++
 +	txque->tpq.produce_idx = 0;
 +	txque->tpq.consume_idx = 0;
 +	txque->max_packets = txque->tpq.count;
@@ -11347,6 +12830,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +				   struct alx_rx_queue *rxque)
 +{
 +	struct alx_ring_header *ring_header = &adpt->ring_header;
++	struct alx_hw *hw = &adpt->hw;
++	u16 que_idx = rxque->que_idx;
 +	int size;
 +
 +	netif_info(adpt, ifup, adpt->netdev,
@@ -11365,20 +12850,23 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +		/* Round up to nearest 4K */
 +		rxque->rrq.size =
-+			rxque->rrq.count * sizeof(union alx_rrdesc);
++			rxque->rrq.count * sizeof(union alx_hw_rrdesc);
 +		rxque->rfq.size =
-+			rxque->rfq.count * sizeof(union alx_rfdesc);
++			rxque->rfq.count * sizeof(union alx_hw_rfdesc);
 +
 +		rxque->rrq.rrdma = ring_header->dma + ring_header->used;
 +		rxque->rrq.rrdesc = ring_header->desc + ring_header->used;
-+		adpt->hw.rrdma[rxque->que_idx] = (u64)rxque->rrq.rrdma;
 +		ring_header->used += ALIGN(rxque->rrq.size, 8);
 +
 +		rxque->rfq.rfdma = ring_header->dma + ring_header->used;
 +		rxque->rfq.rfdesc = ring_header->desc + ring_header->used;
-+		adpt->hw.rfdma[rxque->que_idx] = (u64)rxque->rfq.rfdma;
 +		ring_header->used += ALIGN(rxque->rfq.size, 8);
 +
++		hw->dma.rrdmem_hi[que_idx] = ALX_DMA_ADDR_HI(rxque->rrq.rrdma);
++		hw->dma.rrdmem_lo[que_idx] = ALX_DMA_ADDR_LO(rxque->rrq.rrdma);
++		hw->dma.rfdmem_hi[que_idx] = ALX_DMA_ADDR_HI(rxque->rfq.rfdma);
++		hw->dma.rfdmem_lo[que_idx] = ALX_DMA_ADDR_LO(rxque->rfq.rfdma);
++
 +		/* clean all counts within rxque */
 +		rxque->rrq.produce_idx = 0;
 +		rxque->rrq.consume_idx = 0;
@@ -11505,12 +12993,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	 * additional bytes tacked onto the end.
 +	 */
 +	ring_header->size =
-+		num_tques * num_tx_descs * sizeof(union alx_tpdesc) +
-+		num_rques * num_rx_descs * sizeof(union alx_rfdesc) +
-+		num_rques * num_rx_descs * sizeof(union alx_rrdesc) +
-+		sizeof(struct coals_msg_block) +
-+		sizeof(struct alx_hw_stats) +
-+		num_tques * 8 + num_rques * 2 * 8 + 8 * 2;
++		num_tques * num_tx_descs * sizeof(union alx_hw_tpdesc) +
++		num_rques * num_rx_descs * sizeof(union alx_hw_rfdesc) +
++		num_rques * num_rx_descs * sizeof(union alx_hw_rrdesc) +
++		num_tques * 8 + num_rques * 2 * 8;
 +	netif_info(adpt, ifup, adpt->netdev,
 +		   "num_tques = %d, num_tx_descs = %d\n",
 +		   num_tques, num_tx_descs);
@@ -11544,15 +13030,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (retval)
 +		goto err_alloc_rx;
 +
-+	/* Init CMB dma address */
-+	adpt->cmb.dma = ring_header->dma + ring_header->used;
-+	adpt->cmb.cmb = (u8 *) ring_header->desc + ring_header->used;
-+	ring_header->used += ALIGN(sizeof(struct coals_msg_block), 8);
-+
-+	adpt->smb.dma = ring_header->dma + ring_header->used;
-+	adpt->smb.smb = (u8 *)ring_header->desc + ring_header->used;
-+	ring_header->used += ALIGN(sizeof(struct alx_hw_stats), 8);
-+
 +	return 0;
 +
 +err_alloc_rx:
@@ -11575,18 +13052,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_free_all_tx_descriptor(adpt);
 +	alx_free_all_rx_descriptor(adpt);
 +
-+	adpt->cmb.dma = 0;
-+	adpt->cmb.cmb = NULL;
-+	adpt->smb.dma = 0;
-+	adpt->smb.smb = NULL;
-+
 +	pci_free_consistent(pdev, ring_header->size, ring_header->desc,
 +					ring_header->dma);
 +	ring_header->desc = NULL;
 +	ring_header->size = ring_header->used = 0;
 +}
 +
-+
 +static netdev_features_t alx_fix_features(struct net_device *netdev,
 +					  netdev_features_t features)
 +{
@@ -11618,6 +13089,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		alx_vlan_mode(netdev, features);
 +	return 0;
 +}
++
 +/*
 + * alx_change_mtu - Change the Maximum Transfer Unit
 + */
@@ -11649,7 +13121,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alx_open_internal(struct alx_adapter *adpt, u32 ctrl)
++int alx_open_internal(struct alx_adapter *adpt, u32 ctrl)
 +{
 +	struct alx_hw *hw = &adpt->hw;
 +	int retval = 0;
@@ -11660,13 +13132,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_set_multicase_list(adpt->netdev);
 +	alx_restore_vlan(adpt);
 +
-+	if (hw->cbs.config_mac)
-+		retval = hw->cbs.config_mac(hw, adpt->rxbuf_size,
++	if (hw->cbs.init_mac)
++		retval = hw->cbs.init_mac(hw, adpt->rxbuf_size,
 +				adpt->num_hw_rxques, adpt->num_rxdescs,
 +				adpt->num_txques, adpt->num_txdescs);
 +
 +	if (hw->cbs.config_tx)
-+		retval = hw->cbs.config_tx(hw);
++		hw->cbs.config_tx(hw);
 +
 +	if (hw->cbs.config_rx)
 +		retval = hw->cbs.config_rx(hw);
@@ -11679,8 +13151,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* configure HW regsiters of MSIX */
 +	if (hw->cbs.config_msix)
 +		retval = hw->cbs.config_msix(hw, adpt->num_msix_intrs,
-+					CHK_ADPT_FLAG(0, MSIX_EN),
-+					CHK_ADPT_FLAG(0, MSI_EN));
++				 CHK_ADPT_FLAG(MSIX_EN),
++				 CHK_ADPT_FLAG(MSI_EN));
 +
 +	if (ctrl & ALX_OPEN_CTRL_IRQ_EN) {
 +		retval = alx_request_irq(adpt);
@@ -11695,10 +13167,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	netif_tx_start_all_queues(adpt->netdev);
 +
-+	CLI_ADPT_FLAG(1, STATE_DOWN);
++	CLI_ADPT_FLAG(STATE_DOWN);
 +
 +	/* check link status */
-+	SET_ADPT_FLAG(0, TASK_LSC_REQ);
++	SET_ADPT_FLAG(TASK_LSC_REQ);
 +	adpt->link_jiffies = jiffies + ALX_TRY_LINK_TIMEOUT;
 +	mod_timer(&adpt->alx_timer, jiffies);
 +
@@ -11710,12 +13182,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static void alx_stop_internal(struct alx_adapter *adpt, u32 ctrl)
++void alx_stop_internal(struct alx_adapter *adpt, u32 ctrl)
 +{
 +	struct net_device *netdev = adpt->netdev;
 +	struct alx_hw *hw = &adpt->hw;
 +
-+	SET_ADPT_FLAG(1, STATE_DOWN);
++	SET_ADPT_FLAG(STATE_DOWN);
 +
 +	netif_tx_stop_all_queues(netdev);
 +	/* call carrier off first to avoid false dev_watchdog timeouts */
@@ -11729,8 +13201,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (ctrl & ALX_OPEN_CTRL_IRQ_EN)
 +		alx_free_irq(adpt);
 +
-+	CLI_ADPT_FLAG(0, TASK_LSC_REQ);
-+	CLI_ADPT_FLAG(0, TASK_REINIT_REQ);
++	CLI_ADPT_FLAG(TASK_LSC_REQ);
++	CLI_ADPT_FLAG(TASK_REINIT_REQ);
 +	del_timer_sync(&adpt->alx_timer);
 +
 +	if (ctrl & ALX_OPEN_CTRL_RESET_PHY)
@@ -11739,7 +13211,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (ctrl & ALX_OPEN_CTRL_RESET_MAC)
 +		hw->cbs.reset_mac(hw);
 +
-+	adpt->hw.link_speed = ALX_LINK_SPEED_UNKNOWN;
++	adpt->hw.link_speed = 0;
 +
 +	alx_clean_all_tx_queues(adpt);
 +	alx_clean_all_rx_queues(adpt);
@@ -11756,8 +13228,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int retval;
 +
 +	/* disallow open during test */
-+	if (CHK_ADPT_FLAG(1, STATE_TESTING) ||
-+	    CHK_ADPT_FLAG(1, STATE_DIAG_RUNNING))
++	if (CHK_ADPT_FLAG(STATE_TESTING))
 +		return -EBUSY;
 +
 +	netif_carrier_off(netdev);
@@ -11791,7 +13262,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +{
 +	struct alx_adapter *adpt = netdev_priv(netdev);
 +
-+	if (CHK_ADPT_FLAG(1, STATE_RESETTING))
++	if (CHK_ADPT_FLAG(STATE_RESETTING))
 +		netif_warn(adpt, ifdown, adpt->netdev,
 +			   "flag STATE_RESETTING has already set\n");
 +
@@ -11808,10 +13279,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_adapter *adpt = pci_get_drvdata(pdev);
 +	struct net_device *netdev = adpt->netdev;
 +	struct alx_hw *hw = &adpt->hw;
-+	u32 wufc = adpt->wol;
++	u32 misc, wufc = adpt->wol;
 +	u16 lpa;
-+	u32 speed, adv_speed, misc;
++	u8 speed, adv_speed;
 +	bool link_up;
++	bool wol_en, tx_en, rx_en;
 +	int i;
 +	int retval = 0;
 +
@@ -11830,7 +13302,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	if (link_up) {
 +		if (hw->mac_type == alx_mac_l1f ||
-+		    hw->mac_type == alx_mac_l2f) {
++		    hw->mac_type == alx_mac_l2f ||
++		    hw->mac_type == alx_mac_l1h ||
++		    hw->mac_type == alx_mac_l2h) {
 +			alx_mem_r32(hw, ALX_MISC, &misc);
 +			misc |= ALX_MISC_INTNLOSC_OPEN;
 +			alx_mem_w32(hw, ALX_MISC, misc);
@@ -11840,15 +13314,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		if (retval)
 +			return retval;
 +
-+		adv_speed = ALX_LINK_SPEED_10_HALF;
++		adv_speed = LX_LC_10H;
 +		if (lpa & LPA_10FULL)
-+			adv_speed = ALX_LINK_SPEED_10_FULL;
++			adv_speed = LX_LC_10F;
 +		else if (lpa & LPA_10HALF)
-+			adv_speed = ALX_LINK_SPEED_10_HALF;
++			adv_speed = LX_LC_10H;
 +		else if (lpa & LPA_100FULL)
-+			adv_speed = ALX_LINK_SPEED_100_FULL;
++			adv_speed = LX_LC_100F;
 +		else if (lpa & LPA_100HALF)
-+			adv_speed = ALX_LINK_SPEED_100_HALF;
++			adv_speed = LX_LC_100H;
 +
 +		retval = hw->cbs.setup_phy_link(hw, adv_speed, true,
 +				!hw->disable_fc_autoneg);
@@ -11864,7 +13338,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +				break;
 +		}
 +	} else {
-+		speed = ALX_LINK_SPEED_10_HALF;
++		speed = LX_LC_10H;
 +		link_up = false;
 +	}
 +	hw->link_speed = speed;
@@ -11879,18 +13353,28 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	if (retval)
 +		return retval;
 +
-+	if (wufc) {
++	wol_en = wufc ? true : false;
++	tx_en = false;
++	rx_en = (wufc & ALX_WOL_MAGIC) ? true : false;
++#ifdef CONFIG_ALX_DEBUGFS
++	if (adpt->cifs && adpt->dfs.swoi_offload.len != 0) {
++		netif_info(adpt, wol, adpt->netdev, "swoi enabled\n");
++		alx_setup_annce(adpt, adpt->hw.link_speed);
++		wol_en = tx_en = rx_en = true;
++	}
++#endif
++
++	if (wol_en) {
 +		/* pcie patch */
 +		device_set_wakeup_enable(&pdev->dev, 1);
 +	}
 +
 +	retval = hw->cbs.config_pow_save(hw, adpt->hw.link_speed,
-+			(wufc ? true : false), false,
-+			(wufc & ALX_WOL_MAGIC ? true : false), true);
++				     wol_en, tx_en, rx_en, true);
 +	if (retval)
 +		return retval;
 +
-+	*wakeup = wufc ? true : false;
++	*wakeup = wol_en;
 +	pci_disable_device(pdev);
 +	return 0;
 +}
@@ -11979,7 +13463,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	u32 hwstat_reg;
 +	u32 hwstat_data;
 +
-+	if (CHK_ADPT_FLAG(1, STATE_DOWN) || CHK_ADPT_FLAG(1, STATE_RESETTING))
++	if (CHK_ADPT_FLAG(STATE_DOWN) || CHK_ADPT_FLAG(STATE_RESETTING))
 +		return;
 +
 +	/* update RX status */
@@ -12053,11 +13537,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_hw *hw = &adpt->hw;
 +	char *link_desc;
 +
-+	if (!CHK_ADPT_FLAG(0, TASK_LSC_REQ))
++	if (!CHK_ADPT_FLAG(TASK_LSC_REQ))
 +		return;
-+	CLI_ADPT_FLAG(0, TASK_LSC_REQ);
++	CLI_ADPT_FLAG(TASK_LSC_REQ);
 +
-+	if (CHK_ADPT_FLAG(1, STATE_DOWN))
++	if (CHK_ADPT_FLAG(STATE_DOWN))
 +		return;
 +
 +	if (hw->cbs.check_phy_link) {
@@ -12065,7 +13549,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +			&hw->link_speed, &hw->link_up);
 +	} else {
 +		/* always assume link is up, if no check link function */
-+		hw->link_speed = ALX_LINK_SPEED_1GB_FULL;
++		hw->link_speed = LX_LC_1000F;
 +		hw->link_up = true;
 +	}
 +	netif_info(adpt, timer, adpt->netdev,
@@ -12073,30 +13557,31 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		   hw->link_speed, hw->link_up);
 +
 +	if (!hw->link_up && time_after(adpt->link_jiffies, jiffies))
-+		SET_ADPT_FLAG(0, TASK_LSC_REQ);
++		SET_ADPT_FLAG(TASK_LSC_REQ);
 +
 +	if (hw->link_up) {
 +		if (netif_carrier_ok(netdev))
 +			return;
 +
-+		link_desc = (hw->link_speed == ALX_LINK_SPEED_1GB_FULL) ?
++		link_desc = hw->link_speed == LX_LC_1000F ?
 +			"1 Gbps Duplex Full" :
-+			(hw->link_speed == ALX_LINK_SPEED_100_FULL ?
-+			 "100 Mbps Duplex Full" :
-+			 (hw->link_speed == ALX_LINK_SPEED_100_HALF ?
-+			  "100 Mbps Duplex Half" :
-+			  (hw->link_speed == ALX_LINK_SPEED_10_FULL ?
-+			   "10 Mbps Duplex Full" :
-+			   (hw->link_speed == ALX_LINK_SPEED_10_HALF ?
-+			    "10 Mbps Duplex HALF" :
-+			    "unknown speed"))));
++			hw->link_speed == LX_LC_100F ?
++			"100 Mbps Duplex Full" :
++			hw->link_speed == LX_LC_100H ?
++			"100 Mbps Duplex Half" :
++			hw->link_speed == LX_LC_10F ?
++			"10 Mbps Duplex Full" :
++			hw->link_speed == LX_LC_10H ?
++			"10 Mbps Duplex HALF" :
++			"unknown speed";
 +		netif_info(adpt, timer, adpt->netdev,
 +			   "NIC Link is Up %s\n", link_desc);
 +
++		hw->cbs.post_phy_link(hw, CHK_HW_FLAG(AZ_EN), hw->link_up,
++				      hw->link_speed);
 +		hw->cbs.config_aspm(hw, true, true);
 +		hw->cbs.start_mac(hw);
 +		netif_carrier_on(netdev);
-+		netif_tx_wake_all_queues(netdev);
 +	} else {
 +		/* only continue if link was up previously */
 +		if (!netif_carrier_ok(netdev))
@@ -12105,8 +13590,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		hw->link_speed = 0;
 +		netif_info(adpt, timer, adpt->netdev, "NIC Link is Down\n");
 +		netif_carrier_off(netdev);
-+		netif_tx_stop_all_queues(netdev);
 +
++		hw->cbs.post_phy_link(hw, CHK_HW_FLAG(AZ_EN), hw->link_up,
++				      hw->link_speed);
 +		hw->cbs.stop_mac(hw);
 +		hw->cbs.config_aspm(hw, false, true);
 +		hw->cbs.setup_phy_link(hw, hw->autoneg_advertised, true,
@@ -12117,11 +13603,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +static void alx_reinit_task_routine(struct alx_adapter *adpt)
 +{
-+	if (!CHK_ADPT_FLAG(0, TASK_REINIT_REQ))
++	if (!CHK_ADPT_FLAG(TASK_REINIT_REQ))
 +		return;
-+	CLI_ADPT_FLAG(0, TASK_REINIT_REQ);
++	CLI_ADPT_FLAG(TASK_REINIT_REQ);
 +
-+	if (CHK_ADPT_FLAG(1, STATE_DOWN) || CHK_ADPT_FLAG(1, STATE_RESETTING))
++	if (CHK_ADPT_FLAG(STATE_DOWN) || CHK_ADPT_FLAG(STATE_RESETTING))
 +		return;
 +
 +	alx_reinit_locked(adpt);
@@ -12137,7 +13623,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	unsigned long delay;
 +
 +	/* poll faster when waiting for link */
-+	if (CHK_ADPT_FLAG(0, TASK_LSC_REQ))
++	if (CHK_ADPT_FLAG(TASK_LSC_REQ))
 +		delay = HZ / 10;
 +	else
 +		delay = HZ * 2;
@@ -12157,7 +13643,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_adapter *adpt = container_of(work,
 +				struct alx_adapter, alx_task);
 +	/* test state of adapter */
-+	if (!CHK_ADPT_FLAG(1, STATE_WATCH_DOG))
++	if (!CHK_ADPT_FLAG(STATE_WATCH_DOG))
 +		netif_warn(adpt, timer, adpt->netdev,
 +			   "flag STATE_WATCH_DOG doesn't set\n");
 +
@@ -12170,7 +13656,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* flush memory to make sure state is correct before next watchog */
 +	smp_mb__before_clear_bit();
 +
-+	CLI_ADPT_FLAG(1, STATE_WATCH_DOG);
++	CLI_ADPT_FLAG(STATE_WATCH_DOG);
 +}
 +
 +
@@ -12202,10 +13688,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +}
 +
 +
-+static int alx_tso_csum(struct alx_adapter *adpt,
-+			struct alx_tx_queue *txque,
-+			struct sk_buff *skb,
-+			union alx_sw_tpdesc *stpd)
++static int alx_tso_csum(struct alx_adapter *adpt, struct alx_tx_queue *txque,
++			struct sk_buff *skb, union alx_sw_tpdesc *stpd)
 +{
 +	struct pci_dev *pdev = adpt->pdev;
 +	u8  hdr_len;
@@ -12255,7 +13739,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +						&ipv6_hdr(skb)->saddr,
 +						&ipv6_hdr(skb)->daddr,
 +						0, IPPROTO_TCP, 0);
-+			extra_tpd.tso.addr_lo = skb->len;
++			extra_tpd.tso.pkt_len = skb->len;
 +			extra_tpd.tso.lso = 0x1;
 +			extra_tpd.tso.lso_v2 = 0x1;
 +			alx_set_tpdesc(txque, &extra_tpd);
@@ -12274,25 +13758,23 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		cso = skb_checksum_start_offset(skb);
 +
 +		if (unlikely(cso & 0x1)) {
-+			dev_err(&pdev->dev, "pay load offset should not be an "
-+				"event number\n");
++			dev_err(&pdev->dev,
++				"payload offset can't be an event number\n");
 +			return -1;
 +		} else {
 +			css = cso + skb->csum_offset;
 +
 +			stpd->csum.payld_offset = cso >> 1;
 +			stpd->csum.cxsum_offset = css >> 1;
-+			stpd->csum.c_sum = 0x1;
++			stpd->csum.c_csum = 0x1;
 +		}
 +	}
 +	return 0;
 +}
 +
 +
-+static void alx_tx_map(struct alx_adapter *adpt,
-+		       struct alx_tx_queue *txque,
-+		       struct sk_buff *skb,
-+		       union alx_sw_tpdesc *stpd)
++static void alx_tx_map(struct alx_adapter *adpt, struct alx_tx_queue *txque,
++		       struct sk_buff *skb, union alx_sw_tpdesc *stpd)
 +{
 +	struct alx_buffer *tpbuf = NULL;
 +
@@ -12365,8 +13847,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	unsigned long     flags = 0;
 +	union alx_sw_tpdesc stpd; /* normal*/
 +
-+	if (CHK_ADPT_FLAG(1, STATE_DOWN) ||
-+	    CHK_ADPT_FLAG(1, STATE_DIAG_RUNNING)) {
++	if (CHK_ADPT_FLAG(STATE_DOWN) || CHK_ADPT_FLAG(STATE_TESTING)) {
 +		dev_kfree_skb_any(skb);
 +		return NETDEV_TX_OK;
 +	}
@@ -12503,6 +13984,29 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	}
 +}
 +
++static bool alx_enable_ioport(struct pci_dev *pdev)
++{
++#ifdef CONFIG_ALX_DEBUGFS
++	switch (pdev->device) {
++	case ALX_DEV_ID_AR8131:
++	case ALX_DEV_ID_AR8132:
++	case ALX_DEV_ID_AR8151_V1:
++	case ALX_DEV_ID_AR8151_V2:
++	case ALX_DEV_ID_AR8152_V1:
++	case ALX_DEV_ID_AR8152_V2:
++	case ALX_DEV_ID_AR8161:
++	case ALX_DEV_ID_AR8162:
++	case ALX_DEV_ID_AR8171:
++	case ALX_DEV_ID_AR8172:
++		return true;
++	default:
++		return false;
++	}
++#else
++	return false;
++#endif
++}
++
 +
 +#ifdef CONFIG_NET_POLL_CONTROLLER
 +static void alx_poll_controller(struct net_device *netdev)
@@ -12512,10 +14016,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int msix_idx;
 +
 +	/* if interface is down do nothing */
-+	if (CHK_ADPT_FLAG(1, STATE_DOWN))
++	if (CHK_ADPT_FLAG(STATE_DOWN))
 +		return;
 +
-+	if (CHK_ADPT_FLAG(0, MSIX_EN)) {
++	if (CHK_ADPT_FLAG(MSIX_EN)) {
 +		for (msix_idx = 0; msix_idx < num_msix_intrs; msix_idx++) {
 +			struct alx_msix_param *msix = adpt->msix[msix_idx];
 +			if (CHK_MSIX_FLAG(RXS) || CHK_MSIX_FLAG(TXS))
@@ -12559,16 +14063,25 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 + * alx_init - Device Initialization Routine
 + */
 +static int __devinit alx_init(struct pci_dev *pdev,
-+		       const struct pci_device_id *ent)
++			      const struct pci_device_id *ent)
 +{
 +	struct net_device *netdev;
 +	struct alx_adapter *adpt = NULL;
 +	struct alx_hw *hw = NULL;
 +	static int cards_found;
-+	int retval;
++	bool enable_ioport;
++	int i, bars, retval;
 +
 +	/* enable device (incl. PCI PM wakeup and hotplug setup) */
-+	retval = pci_enable_device_mem(pdev);
++	enable_ioport = alx_enable_ioport(pdev);
++	if (enable_ioport) {
++		bars = pci_select_bars(pdev, IORESOURCE_MEM | IORESOURCE_IO);
++		retval = pci_enable_device(pdev);
++	} else {
++		bars = pci_select_bars(pdev, IORESOURCE_MEM);
++		retval = pci_enable_device_mem(pdev);
++	}
++
 +	if (retval) {
 +		dev_err(&pdev->dev, "cannot enable PCI device\n");
 +		goto err_alloc_device;
@@ -12595,15 +14108,13 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +		}
 +	}
 +
-+	retval = pci_request_selected_regions(pdev, pci_select_bars(pdev,
-+					IORESOURCE_MEM), alx_drv_name);
++	retval = pci_request_selected_regions(pdev, bars, alx_drv_name);
 +	if (retval) {
 +		dev_err(&pdev->dev,
-+			"pci_request_selected_regions failed 0x%x\n", retval);
++			"pci_request_selected_regions failed(bars:%d)\n", bars);
 +		goto err_alloc_pci_res_mem;
 +	}
 +
-+
 +	pci_enable_pcie_error_reporting(pdev);
 +	pci_set_master(pdev);
 +
@@ -12624,35 +14135,46 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	hw = &adpt->hw;
 +	hw->adpt = adpt;
 +	adpt->msg_enable = ALX_MSG_DEFAULT;
++	adpt->ioport = enable_ioport;
++	adpt->bars = bars;
 +
-+	adpt->hw.hw_addr = ioremap(pci_resource_start(pdev, BAR_0),
-+				   pci_resource_len(pdev, BAR_0));
-+	if (!adpt->hw.hw_addr) {
-+		alx_err(adpt, "cannot map device registers\n");
++	hw->hw_addr = pci_ioremap_bar(pdev, BAR_0);
++	if (!hw->hw_addr) {
++		dev_err(&pdev->dev, "cannot map device registers\n");
 +		retval = -EIO;
 +		goto err_iomap;
 +	}
 +	netdev->base_addr = (unsigned long)adpt->hw.hw_addr;
 +
++	if (adpt->ioport) {
++		for (i = BAR_1; i <= BAR_5; i++) {
++			if (pci_resource_len(pdev, i) == 0)
++				continue;
++			if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
++				hw->io_addr = pci_resource_start(pdev, i);
++				break;
++			}
++		}
++	}
++
 +	/* set cb member of netdev structure*/
 +	netdev->netdev_ops = &alx_netdev_ops;
 +	alx_set_ethtool_ops(netdev);
-+	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
-+	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
 +
++	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
 +	adpt->bd_number = cards_found;
 +
 +	/* init alx_adapte structure */
 +	retval = alx_init_adapter(adpt);
 +	if (retval) {
-+		alx_err(adpt, "net device private data init failed\n");
++		dev_err(&pdev->dev, "net device private data init failed\n");
 +		goto err_init_adapter;
 +	}
 +
 +	/* reset pcie */
 +	retval = hw->cbs.reset_pcie(hw, true, true);
 +	if (retval) {
-+		alx_err(adpt, "PCIE Reset failed, error = %d\n", retval);
++		dev_err(&pdev->dev, "PCIE Reset failed, error = %d\n", retval);
 +		retval = -EIO;
 +		goto err_init_adapter;
 +	}
@@ -12660,7 +14182,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* Init GPHY as early as possible due to power saving issue  */
 +	retval = hw->cbs.reset_phy(hw);
 +	if (retval) {
-+		alx_err(adpt, "PHY Reset failed, error = %d\n", retval);
++		dev_err(&pdev->dev, "PHY Reset failed, error = %d\n", retval);
 +		retval = -EIO;
 +		goto err_init_adapter;
 +	}
@@ -12668,7 +14190,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* reset mac */
 +	retval = hw->cbs.reset_mac(hw);
 +	if (retval) {
-+		alx_err(adpt, "MAC Reset failed, error = %d\n", retval);
++		dev_err(&pdev->dev, "MAC Reset failed, error = %d\n", retval);
 +		retval = -EIO;
 +		goto err_init_adapter;
 +	}
@@ -12714,7 +14236,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	memcpy(netdev->perm_addr, hw->mac_perm_addr, netdev->addr_len);
 +	retval = alx_validate_mac_addr(netdev->perm_addr);
 +	if (retval) {
-+		alx_err(adpt, "invalid MAC address\n");
++		dev_err(&pdev->dev, "invalid MAC address\n");
 +		goto err_init_adapter;
 +	}
 +
@@ -12726,38 +14248,24 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_set_num_queues(adpt);
 +	retval = alx_set_interrupt_mode(adpt);
 +	if (retval) {
-+		alx_err(adpt, "can't set interrupt mode\n");
++		dev_err(&pdev->dev, "can't set interrupt mode\n");
 +		goto err_set_interrupt_mode;
 +	}
 +
 +	retval = alx_set_interrupt_param(adpt);
 +	if (retval) {
-+		alx_err(adpt, "can't set interrupt parameter\n");
++		dev_err(&pdev->dev, "can't set interrupt parameter\n");
 +		goto err_set_interrupt_param;
 +	}
 +
 +	retval = alx_alloc_all_rtx_queue(adpt);
 +	if (retval) {
-+		alx_err(adpt, "can't allocate memory for queues\n");
++		dev_err(&pdev->dev, "can't allocate memory for queues\n");
 +		goto err_alloc_rtx_queue;
 +	}
 +
 +	alx_set_register_info_special(adpt);
 +
-+	netif_dbg(adpt, probe, adpt->netdev,
-+		  "num_msix_noque_intrs = %d, num_msix_rxque_intrs = %d, "
-+		  "num_msix_txque_intrs = %d\n",
-+		  adpt->num_msix_noques, adpt->num_msix_rxques,
-+		  adpt->num_msix_txques);
-+	netif_dbg(adpt, probe, adpt->netdev, "num_msix_all_intrs = %d\n",
-+		  adpt->num_msix_intrs);
-+
-+	netif_dbg(adpt, probe, adpt->netdev,
-+		  "RX Queue Count = %u, HRX Queue Count = %u, "
-+		  "SRX Queue Count = %u, TX Queue Count = %u\n",
-+		  adpt->num_rxques, adpt->num_hw_rxques, adpt->num_sw_rxques,
-+		  adpt->num_txques);
-+
 +	/* WOL not supported for all but the following */
 +	switch (hw->pci_devid) {
 +	case ALX_DEV_ID_AR8131:
@@ -12767,22 +14275,26 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	case ALX_DEV_ID_AR8152_V1:
 +	case ALX_DEV_ID_AR8152_V2:
 +		adpt->wol = (ALX_WOL_MAGIC | ALX_WOL_PHY);
++		adpt->cifs = false;
 +		break;
 +	case ALX_DEV_ID_AR8161:
 +	case ALX_DEV_ID_AR8162:
++	case ALX_DEV_ID_AR8171:
++	case ALX_DEV_ID_AR8172:
 +		adpt->wol = (ALX_WOL_MAGIC | ALX_WOL_PHY);
++		adpt->cifs = true;
 +		break;
 +	default:
 +		adpt->wol = 0;
++		adpt->cifs = false;
 +		break;
 +	}
 +	device_set_wakeup_enable(&adpt->pdev->dev, adpt->wol);
 +
-+	SET_ADPT_FLAG(1, STATE_DOWN);
-+	strcpy(netdev->name, "eth%d");
++	SET_ADPT_FLAG(STATE_DOWN);
 +	retval = register_netdev(netdev);
 +	if (retval) {
-+		alx_err(adpt, "register netdevice failed\n");
++		dev_err(&pdev->dev, "register netdevice failed\n");
 +		goto err_register_netdev;
 +	}
 +	adpt->netdev_registered = true;
@@ -12792,37 +14304,49 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* keep stopping all the transmit queues for older kernels */
 +	netif_tx_stop_all_queues(netdev);
 +
++	/* print some debug messages */
++	netif_dbg(adpt, probe, adpt->netdev,
++		  "num_msix_noque_intrs = %d, num_msix_rxque_intrs = %d, num_msix_txque_intrs = %d\n",
++		  adpt->num_msix_noques, adpt->num_msix_rxques,
++		  adpt->num_msix_txques);
++	netif_dbg(adpt, probe, adpt->netdev, "num_msix_all_intrs = %d\n",
++		  adpt->num_msix_intrs);
++	netif_dbg(adpt, probe, adpt->netdev,
++		  "RX Queue Count = %u, HRX Queue Count = %u, SRX Queue Count = %u, TX Queue Count = %u\n",
++		  adpt->num_rxques, adpt->num_hw_rxques, adpt->num_sw_rxques,
++		  adpt->num_txques);
++
 +	/* print the MAC address */
 +	netif_info(adpt, probe, adpt->netdev, "%pM\n", netdev->dev_addr);
 +
 +	/* print the adapter capability */
-+	if (CHK_ADPT_FLAG(0, MSI_CAP)) {
++	if (CHK_ADPT_FLAG(MSI_CAP)) {
 +		netif_info(adpt, probe, adpt->netdev,
 +			   "MSI Capable: %s\n",
-+			   CHK_ADPT_FLAG(0, MSI_EN) ? "Enable" : "Disable");
++			   CHK_ADPT_FLAG(MSI_EN) ? "Enable" : "Disable");
 +	}
-+	if (CHK_ADPT_FLAG(0, MSIX_CAP)) {
++	if (CHK_ADPT_FLAG(MSIX_CAP)) {
 +		netif_info(adpt, probe, adpt->netdev,
 +			   "MSIX Capable: %s\n",
-+			   CHK_ADPT_FLAG(0, MSIX_EN) ? "Enable" : "Disable");
++			   CHK_ADPT_FLAG(MSIX_EN) ? "Enable" : "Disable");
 +	}
-+	if (CHK_ADPT_FLAG(0, MRQ_CAP)) {
++	if (CHK_ADPT_FLAG(MRQ_CAP)) {
 +		netif_info(adpt, probe, adpt->netdev,
 +			   "MRQ Capable: %s\n",
-+			   CHK_ADPT_FLAG(0, MRQ_EN) ? "Enable" : "Disable");
++			   CHK_ADPT_FLAG(MRQ_EN) ? "Enable" : "Disable");
 +	}
-+	if (CHK_ADPT_FLAG(0, MRQ_CAP)) {
++	if (CHK_ADPT_FLAG(MRQ_CAP)) {
 +		netif_info(adpt, probe, adpt->netdev,
 +			   "MTQ Capable: %s\n",
-+			   CHK_ADPT_FLAG(0, MTQ_EN) ? "Enable" : "Disable");
++			   CHK_ADPT_FLAG(MTQ_EN) ? "Enable" : "Disable");
 +	}
-+	if (CHK_ADPT_FLAG(0, SRSS_CAP)) {
++	if (CHK_ADPT_FLAG(SRSS_CAP)) {
 +		netif_info(adpt, probe, adpt->netdev,
 +			   "RSS(SW) Capable: %s\n",
-+			   CHK_ADPT_FLAG(0, SRSS_EN) ? "Enable" : "Disable");
++			   CHK_ADPT_FLAG(SRSS_EN) ? "Enable" : "Disable");
 +	}
 +
-+	printk(KERN_INFO "alx: Atheros Gigabit Network Connection\n");
++	pr_info("alx: Atheros Gigabit Network Connection\n");
 +	cards_found++;
 +	return 0;
 +
@@ -12838,13 +14362,11 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +err_iomap:
 +	free_netdev(netdev);
 +err_alloc_netdev:
-+	pci_release_selected_regions(pdev,
-+				     pci_select_bars(pdev, IORESOURCE_MEM));
++	pci_release_selected_regions(pdev, bars);
 +err_alloc_pci_res_mem:
 +	pci_disable_device(pdev);
 +err_alloc_device:
-+	dev_err(&pdev->dev,
-+		"error when probe device, error = %d\n", retval);
++	dev_err(&pdev->dev, "error when probe device, error = %d\n", retval);
 +	return retval;
 +}
 +
@@ -12858,11 +14380,10 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	struct alx_hw *hw = &adpt->hw;
 +	struct net_device *netdev = adpt->netdev;
 +
-+	SET_ADPT_FLAG(1, STATE_DOWN);
++	SET_ADPT_FLAG(STATE_DOWN);
 +	cancel_work_sync(&adpt->alx_task);
 +
-+	hw->cbs.config_pow_save(hw, ALX_LINK_SPEED_UNKNOWN,
-+				false, false, false, false);
++	hw->cbs.config_pow_save(hw, 0, false, false, false, false);
 +
 +	/* resume permanent mac address */
 +	hw->cbs.set_mac_addr(hw, hw->mac_perm_addr);
@@ -12877,10 +14398,9 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_reset_interrupt_mode(adpt);
 +
 +	iounmap(adpt->hw.hw_addr);
-+	pci_release_selected_regions(pdev,
-+				     pci_select_bars(pdev, IORESOURCE_MEM));
++	pci_release_selected_regions(pdev, adpt->bars);
 +
-+	netif_info(adpt, probe, adpt->netdev, "complete\n");
++	dev_info(&pdev->dev, "complete\n");
 +	free_netdev(netdev);
 +
 +	pci_disable_pcie_error_reporting(pdev);
@@ -12983,12 +14503,12 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +static int __init alx_init_module(void)
 +{
-+	int retval;
++	pr_info("%s\n", alx_drv_description);
 +
-+	printk(KERN_INFO "%s\n", alx_drv_description);
-+	retval = pci_register_driver(&alx_driver);
-+
-+	return retval;
++#ifdef CONFIG_ALX_DEBUGFS
++	alx_debug_init();
++#endif
++	return pci_register_driver(&alx_driver);
 +}
 +module_init(alx_init_module);
 +
@@ -12996,13 +14516,17 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +static void __exit alx_exit_module(void)
 +{
 +	pci_unregister_driver(&alx_driver);
++#ifdef CONFIG_ALX_DEBUGFS
++	alx_debug_exit();
++#endif
 +}
-+
-+
 +module_exit(alx_exit_module);
+diff --git a/drivers/net/ethernet/atheros/alx/alx_sw.h b/drivers/net/ethernet/atheros/alx/alx_sw.h
+new file mode 100644
+index 0000000..21e9860
 --- /dev/null
 +++ b/drivers/net/ethernet/atheros/alx/alx_sw.h
-@@ -0,0 +1,493 @@
+@@ -0,0 +1,506 @@
 +/*
 + * Copyright (c) 2012 Qualcomm Atheros, Inc.
 + *
@@ -13022,9 +14546,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#ifndef _ALX_SW_H_
 +#define _ALX_SW_H_
 +
-+#include <linux/netdevice.h>
-+#include <linux/crc32.h>
-+
 +/* Vendor ID */
 +#define ALX_VENDOR_ID                   0x1969
 +
@@ -13037,6 +14558,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define ALX_DEV_ID_AR8152_V2            0x2062   /* l2cb_v2 */
 +#define ALX_DEV_ID_AR8161               0x1091   /* l1f */
 +#define ALX_DEV_ID_AR8162               0x1090   /* l2f */
++#define ALX_DEV_ID_AR8171               0x10A1
++#define ALX_DEV_ID_AR8172               0x10A0
 +
 +#define ALX_REV_ID_AR8152_V1_0          0xc0
 +#define ALX_REV_ID_AR8152_V1_1          0xc1
@@ -13044,11 +14567,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define ALX_REV_ID_AR8152_V2_1          0xc1
 +#define ALX_REV_ID_AR8161_V2_0          0x10  /* B0 */
 +
++
++#define ALX_PCI_CMD (PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER)
++
 +/* Generic Registers */
-+#define ALX_DEV_STAT                    0x62  /* 16 bits */
-+#define ALX_DEV_STAT_CERR               0x0001
-+#define ALX_DEV_STAT_NFERR              0x0002
-+#define ALX_DEV_STAT_FERR               0x0004
++#define ALX_PCI_DEV_STAT                0x62  /* 16 bits */
++#define ALX_PCI_DEV_STAT_CERR           0x0001
++#define ALX_PCI_DEV_STAT_NFERR          0x0002
++#define ALX_PCI_DEV_STAT_FERR           0x0004
++
++#define ALX_PCI_IND_ACC_ADDR            0x80  /* 32 bits */
++#define ALX_PCI_IND_ACC_DATA            0x84  /* 32 bits */
++
++#define ALX_PCI_DEV_MISC_CTRL           0x21C
 +
 +#define ALX_ISR                         0x1600
 +#define ALX_IMR                         0x1604
@@ -13150,27 +14681,15 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +#define ALX_DMA_ADDR_LO(_addr) \
 +		((u32)((u64)(_addr) & DMA_ADDR_LO_MASK))
 +
++#define ALX_MAX_HW_TXQ                  4
++#define ALX_MAX_HW_RXQ                  1
++
 +/* mac address length */
-+#define ALX_ETH_LENGTH_OF_ADDRESS       6
++#define ALX_ETH_LENGTH_OF_ADDRESS       ETH_ALEN
 +#define ALX_ETH_LENGTH_OF_HEADER        ETH_HLEN
 +
 +#define ALX_ETH_CRC(_addr, _len)        ether_crc((_len), (_addr));
 +
-+/* Autonegotiation advertised speeds */
-+/* Link speed */
-+#define ALX_LINK_SPEED_UNKNOWN          0x0
-+#define ALX_LINK_SPEED_10_HALF          0x0001
-+#define ALX_LINK_SPEED_10_FULL          0x0002
-+#define ALX_LINK_SPEED_100_HALF         0x0004
-+#define ALX_LINK_SPEED_100_FULL         0x0008
-+#define ALX_LINK_SPEED_1GB_FULL         0x0020
-+#define ALX_LINK_SPEED_DEFAULT (\
-+		ALX_LINK_SPEED_10_HALF  |\
-+		ALX_LINK_SPEED_10_FULL  |\
-+		ALX_LINK_SPEED_100_HALF |\
-+		ALX_LINK_SPEED_100_FULL |\
-+		ALX_LINK_SPEED_1GB_FULL)
-+
 +#define ALX_MAX_SETUP_LNK_CYCLE         100
 +
 +/* Device Type definitions for new protocol MDIO commands */
@@ -13219,8 +14738,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_mac_l2cb_v21,
 +	alx_mac_l1f,
 +	alx_mac_l2f,
++	alx_mac_l1h,
++	alx_mac_l2h,
 +};
 +
++struct alx_hw_dma {
++	u32 rfdmem_hi[ALX_MAX_HW_RXQ];
++	u32 rfdmem_lo[ALX_MAX_HW_RXQ];
++	u32 rrdmem_hi[ALX_MAX_HW_RXQ];
++	u32 rrdmem_lo[ALX_MAX_HW_RXQ];
++
++	u32 tpdmem_hi[ALX_MAX_HW_TXQ];
++	u32 tpdmem_lo[ALX_MAX_HW_TXQ];
++};
 +
 +/* Statistics counters collected by the MAC */
 +struct alx_hw_stats {
@@ -13289,18 +14819,20 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int (*reset_phy)(struct alx_hw *);
 +	int (*read_phy_reg)(struct alx_hw *, u16, u16 *);
 +	int (*write_phy_reg)(struct alx_hw *, u16, u16);
++
 +	/* Link */
-+	int (*setup_phy_link)(struct alx_hw *, u32, bool, bool);
-+	int (*setup_phy_link_speed)(struct alx_hw *, u32, bool, bool);
-+	int (*check_phy_link)(struct alx_hw *, u32 *, bool *);
++	int (*setup_phy_link)(struct alx_hw *, u8, bool, bool);
++	int (*check_phy_link)(struct alx_hw *, u8 *, bool *);
++	int (*post_phy_link)(struct alx_hw *, bool, bool, u8);
++
 +
 +	/* MAC */
 +	int (*reset_mac)(struct alx_hw *);
 +	int (*start_mac)(struct alx_hw *);
 +	int (*stop_mac)(struct alx_hw *);
-+	int (*config_mac)(struct alx_hw *, u16, u16, u16, u16, u16);
++	int (*init_mac)(struct alx_hw *, u16, u16, u16, u16, u16);
 +	int (*get_mac_addr)(struct alx_hw *, u8 *);
-+	int (*set_mac_addr)(struct alx_hw *, u8 *);
++	void (*set_mac_addr)(struct alx_hw *, u8 *);
 +	int (*set_mc_addr)(struct alx_hw *, u8 *);
 +	int (*clear_mc_addr)(struct alx_hw *);
 +
@@ -13313,14 +14845,14 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +	/* Configure */
 +	int (*config_rx)(struct alx_hw *);
-+	int (*config_tx)(struct alx_hw *);
++	void (*config_tx)(struct alx_hw *);
 +	int (*config_fc)(struct alx_hw *);
 +	int (*config_rss)(struct alx_hw *, bool);
 +	int (*config_msix)(struct alx_hw *, u16, bool, bool);
 +	int (*config_wol)(struct alx_hw *, u32);
 +	int (*config_aspm)(struct alx_hw *, bool, bool);
-+	int (*config_mac_ctrl)(struct alx_hw *);
-+	int (*config_pow_save)(struct alx_hw *, u32,
++	void (*update_mac_filter)(struct alx_hw *);
++	int (*config_pow_save)(struct alx_hw *, u8,
 +				bool, bool, bool, bool);
 +	int (*reset_pcie)(struct alx_hw *, bool, bool);
 +
@@ -13330,13 +14862,19 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	int (*write_nvram)(struct alx_hw *, u16, u32);
 +
 +	/* Others */
-+	int (*get_ethtool_regs)(struct alx_hw *, void *);
++	void (*get_ethtool_regs)(struct alx_hw *, void *);
++
++#ifdef CONFIG_ALX_DEBUGFS
++	int (*read_ext_phy_reg)(struct alx_hw *, u8, u16, u16 *);
++	int (*write_ext_phy_reg)(struct alx_hw *, u8, u16, u16);
++#endif
 +};
 +
 +struct alx_hw {
 +	struct alx_adapter	*adpt;
 +	struct alx_hw_callbacks	 cbs;
 +	u8 __iomem     *hw_addr; /* inner register address */
++	u16             io_addr; /* ioport base address */
 +	u16             pci_venid;
 +	u16             pci_devid;
 +	u16             pci_sub_devid;
@@ -13354,7 +14892,7 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	/* PHY parameter */
 +	u32             phy_id;
 +	u32             autoneg_advertised;
-+	u32             link_speed;
++	u8              link_speed;
 +	bool            link_up;
 +	spinlock_t      mdio_lock;
 +
@@ -13373,9 +14911,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	u16             tx_cons_reg[4];
 +	u16             rx_prod_reg[2];
 +	u16             rx_cons_reg[2];
-+	u64             tpdma[4];
-+	u64             rfdma[2];
-+	u64             rrdma[2];
++
++	struct alx_hw_dma dma;
 +
 +	/* WRR parameter */
 +	enum alx_wrr_mode wrr_mode;
@@ -13400,29 +14937,32 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	bool            fc_single_pause;
 +
 +	/* Others */
-+	u32             preamble;
 +	u32             intr_mask;
 +	u16             smb_timer;
-+	u16             imt;    /* Interrupt Moderator timer (2us) */
++	u16             imt_mod;    /* Interrupt Moderator timer (2us) */
 +	u32             flags;
 +};
 +
-+#define ALX_HW_FLAG_L0S_CAP             0x00000001
-+#define ALX_HW_FLAG_L0S_EN              0x00000002
-+#define ALX_HW_FLAG_L1_CAP              0x00000004
-+#define ALX_HW_FLAG_L1_EN               0x00000008
-+#define ALX_HW_FLAG_PWSAVE_CAP          0x00000010
-+#define ALX_HW_FLAG_PWSAVE_EN           0x00000020
-+#define ALX_HW_FLAG_AZ_CAP              0x00000040
-+#define ALX_HW_FLAG_AZ_EN               0x00000080
-+#define ALX_HW_FLAG_PTP_CAP             0x00000100
-+#define ALX_HW_FLAG_PTP_EN              0x00000200
-+#define ALX_HW_FLAG_GIGA_CAP            0x00000400
 +
-+#define ALX_HW_FLAG_PROMISC_EN          0x00010000   /* for mac ctrl reg */
-+#define ALX_HW_FLAG_VLANSTRIP_EN        0x00020000   /* for mac ctrl reg */
-+#define ALX_HW_FLAG_MULTIALL_EN         0x00040000   /* for mac ctrl reg */
-+#define ALX_HW_FLAG_LOOPBACK_EN         0x00080000   /* for mac ctrl reg */
++#define ALX_HW_FLAG_LX_MASK             0x3F
++#define ALX_HW_FLAG_BROADCAST_EN        LX_FLT_BROADCAST
++#define ALX_HW_FLAG_MULTIALL_EN         LX_FLT_MULTI_ALL
++#define ALX_HW_FLAG_PROMISC_EN          LX_FLT_PROMISC
++#define ALX_HW_FLAG_VLANSTRIP_EN        LX_VLAN_STRIP
++#define ALX_HW_FLAG_LOOPBACK_EN         LX_LOOPBACK
++
++#define ALX_HW_FLAG_L0S_CAP             0x00010000
++#define ALX_HW_FLAG_L0S_EN              0x00020000
++#define ALX_HW_FLAG_L1_CAP              0x00040000
++#define ALX_HW_FLAG_L1_EN               0x00080000
++#define ALX_HW_FLAG_PWSAVE_CAP          0x00100000
++#define ALX_HW_FLAG_PWSAVE_EN           0x00200000
++#define ALX_HW_FLAG_AZ_CAP              0x00400000
++#define ALX_HW_FLAG_AZ_EN               0x00800000
++#define ALX_HW_FLAG_PTP_CAP             0x01000000
++#define ALX_HW_FLAG_PTP_EN              0x02000000
++#define ALX_HW_FLAG_GIGA_CAP            0x04000000
++
 +
 +#define CHK_HW_FLAG(_flag)              CHK_FLAG(hw, HW, _flag)
 +#define SET_HW_FLAG(_flag)              SET_FLAG(hw, HW, _flag)
@@ -13442,22 +14982,18 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +
 +
 +/* definitions for flags */
-+
-+#define CHK_FLAG_ARRAY(_st, _idx, _type, _flag)	\
-+		((_st)->flags[_idx] & (ALX_##_type##_FLAG_##_idx##_##_flag))
-+#define CHK_FLAG(_st, _type, _flag)	\
++#define CHK_FLAG(_st, _type, _flag) \
 +		((_st)->flags & (ALX_##_type##_FLAG_##_flag))
 +
-+#define SET_FLAG_ARRAY(_st, _idx, _type, _flag) \
-+		((_st)->flags[_idx] |= (ALX_##_type##_FLAG_##_idx##_##_flag))
 +#define SET_FLAG(_st, _type, _flag) \
 +		((_st)->flags |= (ALX_##_type##_FLAG_##_flag))
 +
-+#define CLI_FLAG_ARRAY(_st, _idx, _type, _flag) \
-+		((_st)->flags[_idx] &= ~(ALX_##_type##_FLAG_##_idx##_##_flag))
 +#define CLI_FLAG(_st, _type, _flag) \
 +		((_st)->flags &= ~(ALX_##_type##_FLAG_##_flag))
 +
++
++int alx_cfg_r32(const struct alx_hw *hw, int reg, u32 *pval);
++int alx_cfg_w32(const struct alx_hw *hw, int reg, u32 val);
 +int alx_cfg_r16(const struct alx_hw *hw, int reg, u16 *pval);
 +int alx_cfg_w16(const struct alx_hw *hw, int reg, u16 val);
 +
@@ -13465,6 +15001,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +void alx_mem_flush(const struct alx_hw *hw);
 +void alx_mem_r32(const struct alx_hw *hw, int reg, u32 *val);
 +void alx_mem_w32(const struct alx_hw *hw, int reg, u32 val);
++void alx_mem_r16(const struct alx_hw *hw, int reg, u16 *val);
++void alx_mem_w16(const struct alx_hw *hw, int reg, u16 val);
 +void alx_mem_w8(const struct alx_hw *hw, int reg, u8 val);
 +
 +
@@ -13484,8 +15022,8 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +extern int alf_init_hw_callbacks(struct alx_hw *hw);
 +
 +/* Logging message functions */
-+void __printf(3, 4) alx_hw_printk(const char *level, const struct alx_hw *hw,
-+				  const char *fmt, ...);
++void __printf(3, 4)
++alx_hw_printk(const char *level, const struct alx_hw *hw, const char *fmt, ...);
 +
 +#define alx_hw_err(_hw, _format, ...) \
 +	alx_hw_printk(KERN_ERR, _hw, _format, ##__VA_ARGS__)
@@ -13495,4 +15033,6 @@ Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>
 +	alx_hw_printk(KERN_INFO, _hw, _format, ##__VA_ARGS__)
 +
 +#endif /* _ALX_SW_H_ */
-+
+-- 
+1.7.7
+
diff --git a/crap/network/0002-backport-alx.patch b/crap/network/0002-backport-alx.patch
index 7570057..5c886eb 100644
--- a/crap/network/0002-backport-alx.patch
+++ b/crap/network/0002-backport-alx.patch
@@ -2,11 +2,11 @@ This should go into patches/01-netdev.patch
 
 --- a/drivers/net/ethernet/atheros/alx/alx_main.c
 +++ b/drivers/net/ethernet/atheros/alx/alx_main.c
-@@ -318,7 +318,11 @@ static void alx_set_multicase_list(struc
+@@ -341,7 +341,11 @@ static void alx_set_multicase_list(struct net_device *netdev)
  
  	/* comoute mc addresses' hash value ,and put it into hash table */
  	netdev_for_each_mc_addr(ha, netdev)
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))		
  		hw->cbs.set_mc_addr(hw, ha->addr);
 +#else
 +		hw->cbs.set_mc_addr(hw, ha->dmi_addr);
@@ -14,7 +14,7 @@ This should go into patches/01-netdev.patch
  }
  
  
-@@ -337,8 +341,10 @@ static int alx_set_mac_address(struct ne
+@@ -360,8 +364,10 @@ static int alx_set_mac_address(struct net_device *netdev, void *data)
  	if (netif_running(netdev))
  		return -EBUSY;
  
@@ -25,25 +25,23 @@ This should go into patches/01-netdev.patch
  
  	memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);
  	memcpy(hw->mac_addr, addr->sa_data, netdev->addr_len);
-@@ -2483,7 +2489,7 @@ static void alx_free_all_rtx_descriptor(
+@@ -2523,6 +2529,7 @@ static void alx_free_all_rtx_descriptor(struct alx_adapter *adpt)
  	ring_header->size = ring_header->used = 0;
  }
  
--
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  static netdev_features_t alx_fix_features(struct net_device *netdev,
  					  netdev_features_t features)
  {
-@@ -2515,6 +2521,8 @@ static int alx_set_features(struct net_d
+@@ -2554,6 +2561,7 @@ static int alx_set_features(struct net_device *netdev,
  		alx_vlan_mode(netdev, features);
  	return 0;
  }
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
-+
+ 
  /*
   * alx_change_mtu - Change the Maximum Transfer Unit
-  */
-@@ -2538,7 +2546,17 @@ static int alx_change_mtu(struct net_dev
+@@ -2578,7 +2586,17 @@ static int alx_change_mtu(struct net_device *netdev, int new_mtu)
  		adpt->hw.mtu = new_mtu;
  		adpt->rxbuf_size = new_mtu > ALX_DEF_RX_BUF_SIZE ?
  				   ALIGN(max_frame, 8) : ALX_DEF_RX_BUF_SIZE;
@@ -61,7 +59,7 @@ This should go into patches/01-netdev.patch
  		alx_reinit_locked(adpt);
  	}
  
-@@ -3444,8 +3462,10 @@ static const struct net_device_ops alx_n
+@@ -3516,8 +3534,10 @@ static const struct net_device_ops alx_netdev_ops = {
  	.ndo_change_mtu         = alx_change_mtu,
  	.ndo_do_ioctl           = alx_ioctl,
  	.ndo_tx_timeout         = alx_tx_timeout,
@@ -72,16 +70,16 @@ This should go into patches/01-netdev.patch
  #ifdef CONFIG_NET_POLL_CONTROLLER
  	.ndo_poll_controller    = alx_poll_controller,
  #endif
-@@ -3532,7 +3552,7 @@ static int __devinit alx_init(struct pci
- 	netdev->base_addr = (unsigned long)adpt->hw.hw_addr;
+@@ -3623,7 +3643,7 @@ static int __devinit alx_init(struct pci_dev *pdev,
+ 	}
  
  	/* set cb member of netdev structure*/
 -	netdev->netdev_ops = &alx_netdev_ops;
 +	netdev_attach_ops(netdev, &alx_netdev_ops);
  	alx_set_ethtool_ops(netdev);
+ 
  	netdev->watchdog_timeo = ALX_WATCHDOG_TIME;
- 	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
-@@ -3580,6 +3600,7 @@ static int __devinit alx_init(struct pci
+@@ -3670,6 +3690,7 @@ static int __devinit alx_init(struct pci_dev *pdev,
  	adpt->max_rxques = min_t(int, ALX_MAX_RX_QUEUES, num_online_cpus());
  	adpt->max_txques = min_t(int, ALX_MAX_TX_QUEUES, num_online_cpus());
  
@@ -89,13 +87,13 @@ This should go into patches/01-netdev.patch
  	netdev->hw_features = NETIF_F_SG	 |
  			      NETIF_F_HW_CSUM	 |
  			      NETIF_F_HW_VLAN_RX;
-@@ -3591,6 +3612,19 @@ static int __devinit alx_init(struct pci
+@@ -3681,6 +3702,19 @@ static int __devinit alx_init(struct pci_dev *pdev,
  	}
  	netdev->features = netdev->hw_features |
  			   NETIF_F_HW_VLAN_TX;
 +#else
-+	netdev->features = NETIF_F_SG	 |
-+			   NETIF_F_HW_CSUM	 |
++	netdev->features = NETIF_F_SG |
++			   NETIF_F_HW_CSUM |
 +			   NETIF_F_HW_VLAN_RX;
 +	if (adpt->hw.mac_type != alx_mac_l1c &&
 +	    adpt->hw.mac_type != alx_mac_l2c) {
@@ -109,7 +107,7 @@ This should go into patches/01-netdev.patch
  
  	/* get mac addr and perm mac addr, set to register */
  	if (hw->cbs.get_mac_addr)
-@@ -3860,6 +3894,8 @@ static struct pci_error_handlers alx_err
+@@ -3948,6 +3982,8 @@ static struct pci_error_handlers alx_err_handler = {
  
  
  #ifdef CONFIG_PM_SLEEP
@@ -118,15 +116,15 @@ This should go into patches/01-netdev.patch
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -3874,7 +3910,12 @@ static struct pci_driver alx_driver = {
+@@ -3962,7 +3998,12 @@ static struct pci_driver alx_driver = {
  	.remove      = __devexit_p(alx_remove),
  	.shutdown    = alx_shutdown,
  	.err_handler = &alx_err_handler,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm   = ALX_PM_OPS,
 +#elif defined(CONFIG_PM_SLEEP)
-+	.suspend        = alx_suspend_compat,
-+	.resume         = alx_resume_compat,
++	.suspend     = alx_suspend_compat,
++	.resume      = alx_resume_compat,
 +#endif
  };
  
-- 
1.7.7

