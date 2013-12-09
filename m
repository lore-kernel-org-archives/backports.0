Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35849 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760593Ab3LIS1x (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 13:27:53 -0500
Received: by mail-we0-f174.google.com with SMTP id q58so3895871wes.33
        for <backports@vger.kernel.org>; Mon, 09 Dec 2013 10:27:52 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: peter.senna@gmail.com, julia.lawall@lip6.fr, Gilles.Muller@lip6.fr,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] backports: add two more SmPL patches
Date: Mon,  9 Dec 2013 19:27:42 +0100
Message-Id: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20131209_192759_253444_F40875A4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds two more SmPL patches (spatches) replacing tons of
patches files. The improvements on run time in Coccinelle make
it reasonable to integrate these changes due to the gains this
provides for automatic porting of collateral evolutions for
any new random driver.

Luis R. Rodriguez (3):
  backports: convert the 62-usb_driver_lpm patch series to SmPL
  backports: convert 11-dev-pm-ops patch series to SmPL
  backports: refresh patches for next-20131206 a second time

 .../network/11-dev-pm-ops.cocci                    | 42 ++++++++++++++++++++++
 .../network/11-dev-pm-ops/INFO                     |  9 -----
 .../11-dev-pm-ops/drivers_bcma_host_pci.patch      | 25 -------------
 .../drivers_net_ethernet_atheros_alx_main.patch    | 25 -------------
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch | 25 -------------
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   | 25 -------------
 .../drivers_net_wireless_ath_ath5k_pci.patch       | 25 -------------
 .../drivers_net_wireless_ath_ath9k_pci.patch       | 25 -------------
 .../drivers_net_wireless_iwlegacy_common.patch     |  8 ++---
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    | 25 -------------
 .../drivers_net_wireless_mwifiex_pcie.patch        | 12 +------
 .../drivers_net_wireless_p54_p54pci.patch          | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8192de_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8192se_sw.patch | 25 -------------
 ...drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch | 25 -------------
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |  8 ++---
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |  2 +-
 .../network/62-usb_driver_lpm.cocci                |  9 +++++
 .../drivers_bluetooth_ath3k.patch                  | 12 -------
 .../drivers_bluetooth_bcm203x.patch                | 12 -------
 .../drivers_bluetooth_bfusb.patch                  | 12 -------
 .../drivers_bluetooth_bpa10x.patch                 | 12 -------
 .../drivers_bluetooth_btusb.patch                  | 12 -------
 .../drivers_net_usb_cdc_ether.patch                | 12 -------
 .../drivers_net_usb_cdc_mbim.patch                 | 12 -------
 .../drivers_net_usb_cdc_ncm.patch                  | 12 -------
 .../drivers_net_usb_qmi_wwan.patch                 | 12 -------
 .../drivers_net_usb_rndis_host.patch               | 12 -------
 .../drivers_net_usb_sierra_net.patch               | 12 -------
 .../drivers_net_wireless_at76c50x-usb.patch        | 12 -------
 .../drivers_net_wireless_ath_ath6kl_usb.patch      | 12 -------
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   | 12 -------
 .../drivers_net_wireless_ath_carl9170_usb.patch    | 12 -------
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch | 12 -------
 .../drivers_net_wireless_libertas_if_usb.patch     | 12 -------
 .../drivers_net_wireless_libertas_tf_if_usb.patch  | 12 -------
 .../drivers_net_wireless_orinoco_orinoco_usb.patch | 12 -------
 .../drivers_net_wireless_p54_p54usb.patch          | 12 -------
 .../drivers_net_wireless_rndis_wlan.patch          | 12 -------
 .../drivers_net_wireless_rt2x00_rt2500usb.patch    | 12 -------
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    | 12 -------
 .../drivers_net_wireless_rt2x00_rt73usb.patch      | 12 -------
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch | 12 -------
 ...drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch | 12 -------
 .../drivers_net_wireless_zd1211rw_zd_usb.patch     | 12 -------
 .../drivers_usb_class_cdc-wdm.patch                | 12 -------
 48 files changed, 60 insertions(+), 691 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops.cocci
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/INFO
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_bcma_host_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath5k_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192de_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8192se_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bcm203x.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bfusb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_bpa10x.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_rndis_host.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_at76c50x-usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath6kl_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_ath9k_hif_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_ath_carl9170_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_brcm80211_brcmfmac_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_tf_if_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_orinoco_orinoco_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rndis_wlan.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2500usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt73usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtl818x_rtl8187_dev.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_zd1211rw_zd_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch

-- 
1.8.4.3

