Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59631 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbaFAWew (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 18:34:52 -0400
Message-ID: <538BAA84.2020208@hauke-m.de> (sfid-20140602_003454_896633_7E603E70)
Date: Mon, 02 Jun 2014 00:34:44 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: Re: [PATCH 00/13] backports: rework igb patches
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/16/2014 01:21 PM, Stefan Assmann wrote:
> Reworking the igb patches so that each atomic patch requirement is
> addressed individually, including documentation of the original
> patch which introduced the change.
> 
> Stefan Assmann (13):
>   backports: remove old igb patches
>   backports: handle new sriov_configure pointer in struct pci_driver
>   backports: handle changes to vlan_rx_add/kill pointers in struct
>     net_device_ops
>   backports: handle new ndo_set_vf_spoofchk pointer in struct
>     net_device_ops
>   backports: handle no_fcs change in struct sk_buff
>   backports: handle new get_eee and set_eee pointers in struct
>     ethtool_ops
>   backports: handle new get_ts_info pointer in struct ethtool_ops
>   backports: handle new get_module_info and get_module_eeprom pointers
>     in struct ethtool_ops
>   backports: handle new rxfh_ndir pointers in struct ethtool_ops
>   backports: handle argument type change of get_rxnfc in struct
>     ethtool_ops
>   backports: handle struct ethtool_cmd MDI changes
>   backports: handle hwmon_device_register_with_groups API calls
>   backports: handle pci_error_handlers change to const
> 
>  .../network/0017-get_ts_info/igb_get_ts_info.patch | 30 +++++++++
>  .../network/0032-sriov_configure/INFO              | 13 ++++
>  .../0032-sriov_configure/igb_sriov_configure.patch | 56 ++++++++++++++++
>  .../network/0033-ndo_vlan_rx_vid/INFO              | 23 +++++++
>  .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 78 ++++++++++++++++++++++
>  .../network/0034-ndo_set_vf_spoofchk/INFO          | 12 ++++
>  .../igb_ndo_set_vf_spoofchk.patch                  | 51 ++++++++++++++
>  .../network/0035-skb_no_fcs/INFO                   | 12 ++++
>  .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   | 16 +++++
>  .../network/0036-ethtool_eee/INFO                  | 12 ++++
>  .../network/0036-ethtool_eee/igb_ethtool_eee.patch | 31 +++++++++
>  .../network/0037-ethtool_get_module/INFO           | 14 ++++
>  .../0037-ethtool_get_module/igb_get_module.patch   | 31 +++++++++
>  .../network/0038-ethtool_rxfh_indir/INFO           | 13 ++++
>  .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 48 +++++++++++++
>  .../network/0039-ethtool_rxnfc/INFO                | 14 ++++
>  .../network/0039-ethtool_rxnfc/igb_rxnfc.patch     | 18 +++++
>  .../network/0040-ethtool_cmd_mdix/INFO             | 13 ++++
>  .../igb_ethtool_cmd_mdix.patch                     | 49 ++++++++++++++
>  .../INFO                                           | 13 ++++
>  ...gb-devm_hwmon_device_register_with_groups.patch | 30 +++++++++
>  .../network/0042-pci_error_handlers/INFO           | 12 ++++
>  .../igb_pci_error_handlers.patch                   | 16 +++++
>  .../0001-igb_net_device_ops.patch                  | 54 ---------------
>  .../0002-igb_pci_sriov_configure.patch             | 57 ----------------
>  .../0001-ethernet-igb/0004-igb_err_handler.patch   | 16 -----
>  .../0001-ethernet-igb/0005-igb_mdi.patch           | 49 --------------
>  .../0001-ethernet-igb/0006-igb_eee.patch           | 31 ---------
>  .../0001-ethernet-igb/0007-igb_ethtool_ops.patch   | 56 ----------------
>  .../0001-ethernet-igb/0008-igb_no_fcs.patch        | 16 -----
>  .../0001-ethernet-igb/0009-igb_vlan_rx_vid.patch   | 64 ------------------
>  .../0001-ethernet-igb/0010-igb_ethtool_ops.patch   | 48 -------------
>  .../0001-ethernet-igb/0011-igb_ethtool_ops.patch   | 31 ---------
>  .../0012-igb_ndo_set_vf_spoofchk.patch             | 51 --------------
>  .../0001-ethernet-igb/0013-igb_hwmon.patch         | 30 ---------
>  .../0001-ethernet-igb/INFO                         | 10 ---
>  36 files changed, 605 insertions(+), 513 deletions(-)
>  create mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
>  create mode 100644 patches/collateral-evolutions/network/0032-sriov_configure/INFO
>  create mode 100644 patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
>  create mode 100644 patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/INFO
>  create mode 100644 patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
>  create mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/INFO
>  create mode 100644 patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
>  create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/INFO
>  create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
>  create mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/INFO
>  create mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
>  create mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/INFO
>  create mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
>  create mode 100644 patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/INFO
>  create mode 100644 patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
>  create mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/INFO
>  create mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
>  create mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/INFO
>  create mode 100644 patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
>  create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/INFO
>  create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
>  create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/INFO
>  create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch
>  delete mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO
> 

Thank you for the patches, they were applied, pushed and are included in
the backports-20140501 release.

Hauke
