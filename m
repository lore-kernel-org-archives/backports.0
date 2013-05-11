Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:44434 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab3EKSyf (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 11 May 2013 14:54:35 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so1629974pbb.14
        for <backports@vger.kernel.org>; Sat, 11 May 2013 11:54:34 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 0/5] backports: move us up to next-20130423
Date: Sat, 11 May 2013 11:54:24 -0700
Message-Id: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_205438_343570_19DD7C0B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

I've addressed backporting rfkill here in a way that
I think is more suitable. Let me know what you think.

Johannes Berg (1):
  backports: adjust snd_portid patch for nl80211 update

Luis R. Rodriguez (4):
  backports: backport rfkill properly
  backports: backport vlan ethernet changes
  backports: address vlan ethernet driver changes
  backports: refresh patches for next-20130423

 backport/backport-include/linux/if_vlan.h          |   18 +++++
 backport/backport-include/linux/netdev_features.h  |   23 +++++++
 backport/backport-include/linux/rfkill.h           |   13 ++--
 copy-list                                          |    4 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../0005-netlink-portid/mac80211_hwsim.patch       |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   69 +++++++++++---------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/0007-ksize-orinoco.patch               |    1 +
 .../network/0008-rfkill.patch                      |   34 ++++++----
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_mwl8k.patch               |   10 +--
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |   14 ++--
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |    6 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    4 +-
 .../drivers_net_ethernet_atheros_atlx_atl2.patch   |   49 ++++++++++----
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_rt2x00_rt2500usb.patch    |    2 +-
 .../network/66-uapi-changes/INFO                   |   18 -----
 .../include_linux_rfkill_backport.patch            |   11 ----
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 32 files changed, 190 insertions(+), 134 deletions(-)
 create mode 100644 backport/backport-include/linux/if_vlan.h
 delete mode 100644 patches/collateral-evolutions/network/66-uapi-changes/INFO
 delete mode 100644 patches/collateral-evolutions/network/66-uapi-changes/include_linux_rfkill_backport.patch

-- 
1.7.10.4

