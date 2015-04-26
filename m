Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50095 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbbDZVEc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 Apr 2015 17:04:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] backports: bring backports to next-20150424
Date: Sun, 26 Apr 2015 23:04:17 +0200
Message-Id: <1430082264-11808-1-git-send-email-hauke@hauke-m.de> (sfid-20150426_230436_456208_1F40D688)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Just some changes to make it compatible with next-20150424, nothing 
special.

Hauke Mehrtens (7):
  header: add IS_REACHABLE()
  header: add TRACE_DEFINE_ENUM define for v4l2
  header: add clk_prepare_enable() and clk_disable_unprepare()
  copy: header file for nxp-nci NFC driver
  depends: deactivate some driver which are using
    devm_gpiod_get_optional()
  patches: do not use EPROBE_DEFER in media
  patches: refresh patches on next-20150424

 backport/backport-include/linux/clk.h              | 27 +++++++++++++
 backport/backport-include/linux/kconfig.h          | 11 ++++++
 backport/backport-include/linux/tracepoint.h       | 10 +++++
 copy-list                                          |  1 +
 dependencies                                       | 10 +++--
 .../media/0002-no_dmabuf/v4l2.patch                | 38 +++++++++----------
 .../media/0006-no-eprobe_defer/v4l2-clk.patch      | 13 +++++++
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../0018-pv-trace-fixes/net_mac80211_trace.patch   |  8 ++--
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0028-select_queue/mac80211.patch       |  4 +-
 .../net_bluetooth_hidp_core.patch                  |  6 +--
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 44 +++++++++++-----------
 13 files changed, 121 insertions(+), 55 deletions(-)
 create mode 100644 backport/backport-include/linux/tracepoint.h
 create mode 100644 patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch

-- 
1.9.1

