Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48745 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaDHDc3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:29 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so388155pde.10
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:29 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/12] backports: cath up to next-20140320
Date: Mon,  7 Apr 2014 20:32:11 -0700
Message-Id: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053232_629514_E645A4EE)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This pushes backports to catch up to next-20140320 and depends on my last
series. I'm pretty sure this compiles on all supported kernels but am leaving
a ckmake job running and should have the results to be sure in an hour or so.
In the meantime I'll go watch Cosmos with a group.

It seems the last series was sane as I haven't gotten anyone
throwing apples at me, so I'll push that out later tonight if
no one sends any more feedback. Note that change I had to make
on net_get_random_once() on the original series, I posted to
the list about that.

If you want to download both series in one shot and git am them you can
use this file:

http://drvbp1.linux-foundation.org/~mcgrof/patches/2014/04/07/pend-2014-04-07.patch

mcgrof@ergon ~/backports (git::master)$ sha1sum pend-2014-04-07.patch
15c25d339de270119a4962ff2d066f97cb94358a  pend-2014-04-07.patch

Luis R. Rodriguez (12):
  backports: backport u64_stats_fetch_begin_irq() and
    u64_stats_fetch_retry_irq()
  backports: backport APIs for manipulating skb page fragments
  backports: backport skb_set_hash()
  backports: complete backport of frag size accessors
  backports: complete backport of translation of MMD EEE registers
  backports: add GRO_* enums, and its new gro_result_t typedef
  backports: bump kernel requirements for drivers that use s2mps14.h
  backports: disable DVB_RTL2832 and DVB_USB_RTL28XXU
  backports: bump NFC_TRF7970A requirements to 3.5
  backports: make IEEE802154_AT86RF230 depend require 3.3.
  backports: add kernel base requirement of 3.5 to IR_IMG
  backports: refresh patches for next-20140320

 backport/backport-include/linux/mdio.h             |  29 +++
 backport/backport-include/linux/netdevice.h        |  40 ++++
 backport/backport-include/linux/skbuff.h           | 217 +++++++++++++++++++++
 backport/backport-include/linux/u64_stats_sync.h   |  23 +--
 dependencies                                       |  30 ++-
 .../0001-6lowpan-namespace.patch                   |  31 ++-
 patches/backport-adjustments/sch_fq_codel.patch    |   2 +-
 .../media/0004-sysfs-api.patch                     |   2 +-
 .../0012-ieee802154-6lowpan-namespace.patch        |   8 +-
 .../network/0013-lowpan-inet_frag_lru_move.patch   |   6 +-
 .../network/0013-net-user-ns.patch                 |   2 +-
 .../network/0014-inet_frag_evictor.patch           |   4 +-
 .../network/05-usb/p54usb.patch                    |   2 +-
 .../drivers_net_wireless_iwlwifi.patch             |   4 +-
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |   2 +-
 .../drivers_net_wireless_iwlwifi_mvm_led.patch     |   2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   2 +-
 .../drivers_net_wireless_ath_wil6210_netdev.patch  |  10 +-
 .../network/81-genl-const/nfc.patch                |   2 +-
 .../82-struct_property_missing/mwifiex.patch       |   4 +-
 .../84-ethernet/0001-igb_net_device_ops.patch      |   6 +-
 .../84-ethernet/0002-igb_pci_sriov_configure.patch |   8 +-
 .../network/84-ethernet/0006-igb_eee.patch         |   4 +-
 .../network/84-ethernet/0007-igb_ethtool_ops.patch |   6 +-
 .../network/84-ethernet/0008-igb_no_fcs.patch      |   2 +-
 .../network/84-ethernet/0009-igb_vlan_rx_vid.patch |   6 +-
 .../network/84-ethernet/0010-igb_ethtool_ops.patch |  10 +-
 .../network/84-ethernet/0011-igb_ethtool_ops.patch |   2 +-
 .../84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch |   8 +-
 .../85-hid_ll_driver/net_bluetooth_hidp_core.patch |   8 +-
 .../network/86-qdisc_tx_busylock/ieee802154.patch  |   4 +-
 31 files changed, 395 insertions(+), 91 deletions(-)

-- 
1.8.5.3

