Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61443 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab3EKAdr (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:33:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so9082278ied.19
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:33:47 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 0/5] backports: move us up to next-20130423
Date: Fri, 10 May 2013 17:33:36 -0700
Message-Id: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_023350_102183_0005C199)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

These move us up to next-20130423. I can already tell
the rfkill patch is failing but I'm pretty sure the
rest should work fine. In fact I know this should work
to get compilation going as a replacement to the rfkill
patch but -- this does not seem to be the right fix given
that we are compiling rfkill for newer kernels, we've
been doing this for a while now, not sure why we never
ran into dup exported symbol conflicts.

	--- a/backport/backport-include/linux/rfkill.h
	+++ b/backport/backport-include/linux/rfkill.h
	@@ -3,7 +3,7 @@
	 #include <linux/version.h>

	 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
	-#include_next <linux/rfkill.h>
	+#include <linux/rfkill_backport.h>
	 #else
	 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
	 #define rfkill_get_led_trigger_name LINUX_BACKPORT(rfkill_get_led_trigger_name)

Johannes Berg (1):
  backports: adjust snd_portid patch for nl80211 update

Luis R. Rodriguez (4):
  backports: backport rfkill now for < v3.10
  backports: backport vlan ethernet changes
  backports: address vlan ethernet driver changes
  backports: refresh patches for next-20130423

 backport/backport-include/linux/if_vlan.h          |   18 +++++
 backport/backport-include/linux/netdev_features.h  |   23 +++++++
 backport/backport-include/linux/rfkill.h           |   11 ++--
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../0005-netlink-portid/mac80211_hwsim.patch       |    4 +-
 .../network/0005-netlink-portid/nl80211.patch      |   69 +++++++++++---------
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../network/0008-rfkill.patch                      |    2 +-
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
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 28 files changed, 167 insertions(+), 89 deletions(-)
 create mode 100644 backport/backport-include/linux/if_vlan.h

-- 
1.7.10.4

