Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63679 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab3LFS3n (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 6 Dec 2013 13:29:43 -0500
Received: by mail-wi0-f171.google.com with SMTP id bz8so1156595wib.16
        for <backports@vger.kernel.org>; Fri, 06 Dec 2013 10:29:42 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] backports: synch up to next-20131206
Date: Fri,  6 Dec 2013 19:29:27 +0100
Message-Id: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20131206_192945_651575_DBD3D137)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm back! These changes are needed to let us use next-20131206.
Compilation worked fine, I'll let the patches sit and see if
anyone has comments. I haven't merged the python script
replacement as I figured I'd replace the other shell script
get-compat-trees as well and just merge it into the new
Python script to do that as well. I'll send a v3 later as
soon as its done.

As we start embracing Coccinelle lets please try to keep
track of the run time and version of coccinelle used. This
can later be used to graph things as we advance. Metrics
are of course attached to the system we use to generate things
but the folks doing the generation and generic built tests
are using the same system so this should be fine. The hope is
that things will get faster with time.

Luis R. Rodriguez (3):
  backports: backport ktime_to_ms()
  backports: backport getrawmonotonic() with
    do_posix_clock_monotonic_gettime()
  backports: refresh patches for next-20131206

 backport/backport-include/linux/ktime.h                    | 14 ++++++++++++++
 backport/backport-include/linux/time.h                     |  4 ++++
 .../0003-netdev-needed_headroom_tailroom/mac80211.patch    |  4 ++--
 .../network/0006-disable-dump-adjust-on-old-kernels.patch  |  4 ++--
 .../09-cfg80211-wext-padding/include_net_cfg80211.patch    |  2 +-
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch          |  4 ++--
 .../drivers_net_wireless_ti_wlcore_main.patch              |  6 +++---
 .../10-add-wext-handlers-to-netdev/net_wireless_core.patch |  2 +-
 .../network/11-dev-pm-ops/drivers_bcma_host_pci.patch      |  4 ++--
 .../11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch |  4 ++--
 .../drivers_net_wireless_iwlegacy_3945-mac.patch           |  2 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch            |  4 ++--
 .../drivers_net_wireless_libertas_if_spi.patch             |  6 +++---
 .../12-mac80211-disable-tx-status/net_mac80211_tx.patch    |  4 ++--
 .../network/16-bluetooth/net_bluetooth_l2cap_sock.patch    |  6 +++---
 .../network/17-netdev-queue/net_mac80211_iface.patch       |  4 ++--
 .../network/22-multiqueue/net_mac80211_tx.patch            |  2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch              |  4 ++--
 .../25-multicast-list_head/include_net_mac80211.patch      |  2 +-
 .../25-multicast-list_head/net_mac80211_ieee80211_i.patch  |  2 +-
 .../25-multicast-list_head/net_mac80211_iface.patch        |  4 ++--
 ...vers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |  4 ++--
 .../network/30-bridge-port/net_wireless_nl80211.patch      |  2 +-
 .../network/36-workqueue/net_mac80211_main.patch           |  2 +-
 .../network/42-netlink_seq/net_wireless_nl80211.patch      |  2 +-
 .../drivers_net_wireless_ath_wcn36xx_main.patch            |  6 +++---
 .../drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch        |  2 +-
 .../network/69-wowlan-no-socket/net_wireless_nl80211.patch |  2 +-
 .../network/77-led-blink-api/mac80211.patch                |  2 +-
 .../network/81-genl-const/hwsim.patch                      |  2 +-
 .../network/81-genl-const/nl80211.patch                    |  6 +++---
 31 files changed, 68 insertions(+), 50 deletions(-)
 create mode 100644 backport/backport-include/linux/ktime.h

-- 
1.8.4.3

