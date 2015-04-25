Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49643 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbbDYOBB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 10:01:01 -0400
Message-ID: <553B9E1B.8030102@hauke-m.de> (sfid-20150425_160103_897355_D014BA5F)
Date: Sat, 25 Apr 2015 16:00:59 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH 00/10] backports: replace igb patches with generic cocci
 patches
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/25/2015 03:20 PM, Stefan Assmann wrote:
> With these patches we replace several of the igb network driver specific
> patches with more generalized coccinelle patches. Thus the patches are
> no longer igb specific but apply to every wired ethernet driver we may
> choose to backport in the future.
> 
> Some of the new cocci patches required some fixes to coccinelle, thus
> the last patch bumps the required version number.
> 
> Hopefully this will ease the work of adding new network drivers to the
> project. Comments and suggestions welcome.
> 
>   Stefan
> 
> 
> Stefan Assmann (10):
>   backports: replace struct ethtool_ops get_ts_info changes with smpl
>     patch
>   backports: replace struct ethtool_ops get/set_eee changes with smpl
>     patch
>   backports: replace struct ethtool_ops get_module changes with smpl
>     patch
>   backports: replace struct pci_driver sriov_configure changes with smpl
>     patch
>   backports: replace struct pci_error_handlers changes with smpl patch
>   backports: replace struct ethtool_ops get_rxnfc changes with smpl
>     patch
>   backports: replace struct net_device_ops set_vf_spoofchk changes with
>     smpl patch
>   backports: replace struct net_device_ops set_vf_rate changes with smpl
>     patch
>   backports: remove devm_hwmon_device_register_with_groups references
>     with smpl patch
>   backports: require coccinelle version 1.0.0-rc24
> 
>  gentree.py                                         |  2 +-
>  .../network/0017-get_ts_info/cdc_ncm.patch         | 12 ----
>  .../0017-get_ts_info/drivers_net_usb_usbnet.patch  | 12 ----
>  .../network/0017-get_ts_info/get_ts_info.cocci     | 19 ++++++
>  .../network/0017-get_ts_info/igb_get_ts_info.patch | 28 --------
>  .../0032-sriov_configure/igb_sriov_configure.patch | 40 +----------
>  .../0032-sriov_configure/sriov_configure.cocci     | 19 ++++++
>  .../igb_ndo_set_vf_spoofchk.patch                  | 49 --------------
>  .../0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci | 41 ++++++++++++
>  .../network/0036-ethtool_eee/ethtool_eee.cocci     | 37 ++++++++++
>  .../network/0036-ethtool_eee/igb_ethtool_eee.patch | 29 --------
>  .../0037-ethtool_get_module/get_module.cocci       | 37 ++++++++++
>  .../0037-ethtool_get_module/igb_get_module.patch   | 29 --------
>  .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  2 +-
>  .../network/0039-ethtool_rxnfc/igb_rxnfc.patch     | 16 -----
>  .../network/0039-ethtool_rxnfc/rxnfc.cocci         | 22 ++++++
>  ...m_hwmon_device_register_with_groups.patch.cocci | 40 +++++++++++
>  ...gb-devm_hwmon_device_register_with_groups.patch | 28 --------
>  .../network/0042-pci_error_handlers/alx.patch      | 14 ----
>  .../network/0042-pci_error_handlers/atl1c.patch    | 14 ----
>  .../igb_pci_error_handlers.cocci                   |  9 +++
>  .../igb_pci_error_handlers.patch                   | 14 ----
>  .../network/0042-pci_error_handlers/ngene.patch    | 14 ----
>  .../network/0043-ndo_set_vf_rate/INFO              | 17 +++++
>  .../network/0043-ndo_set_vf_rate/igb.patch         | 78 ----------------------
>  .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     | 28 ++++++++
>  .../network/0043-ndo_set_vf_rate/set_vf_rate.cocci | 50 ++++++++++++++
>  27 files changed, 323 insertions(+), 377 deletions(-)
>  delete mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
>  delete mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
>  create mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/get_ts_info.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
>  create mode 100644 patches/collateral-evolutions/network/0032-sriov_configure/sriov_configure.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
>  create mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
>  create mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/ethtool_eee.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
>  create mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/get_module.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
>  delete mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
>  create mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/rxnfc.cocci
>  create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
>  delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
>  delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
>  create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
>  delete mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch
>  create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/INFO
>  delete mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
>  create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
>  create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/set_vf_rate.cocci
> 


Thank you for the patches, I applied and pushed them out.

hauke
