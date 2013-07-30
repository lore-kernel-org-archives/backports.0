Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:34184 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3G3Jbi (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:31:38 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so2470344pbc.37
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:31:37 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 0/4] backports: take us up to next-20130729
Date: Tue, 30 Jul 2013 02:31:28 -0700
Message-Id: <1375176692-1878-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_113140_164293_530A8319)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This brings at least the patches up to next-20130729
and addresses two collateral evolutions which I have
spotted so far that needed to be addressed. I'm test
compiling the last two patches now but figured I'd post
before hitting the sack.

This would go on top of the last series.

Luis R. Rodriguez (4):
  backports: backport adding RW and RO attribute macros
  backports: backport (bin_)attribute(_groups) macros
  backports: fix patches for next-20130729
  backports: refresh patches for next-20130729

 backport/backport-include/linux/device.h           |   23 +++++++++
 backport/backport-include/linux/sysfs.h            |   50 ++++++++++++++++++++
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    6 +--
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   20 ++++----
 .../network/0001-netdev_ops/atl1e.patch            |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../network/0001-netdev_ops/wil6210.patch          |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   22 ++++-----
 .../network/0010-disable-usb-net-asix.patch        |    2 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   12 ++---
 ...ivers_net_wireless_ath_ath5k_mac80211-ops.patch |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |    2 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |   24 +++++-----
 .../32-remove-ns-type/net_wireless_sysfs.patch     |    4 +-
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +--
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../54-get_ts_info/drivers_net_usb_usbnet.patch    |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 27 files changed, 139 insertions(+), 66 deletions(-)

-- 
1.7.10.4

