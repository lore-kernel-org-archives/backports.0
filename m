Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40564 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbbAWXUr (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Jan 2015 18:20:47 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/3] backports: make backports compatible with next-20150108
Date: Sat, 24 Jan 2015 00:20:37 +0100
Message-Id: <1422055240-4753-1-git-send-email-hauke@hauke-m.de> (sfid-20150124_002049_096413_0E7C1A00)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This add some header files which were added recently or renamed.

Hauke Mehrtens (3):
  header: add linux/timecounter.h
  header: add linux/hdmi.h
  patches: refresh on next-20150108

 backport/backport-include/linux/hdmi.h             | 41 ++++++++++++++++++++++
 backport/backport-include/linux/timecounter.h      | 25 +++++++++++++
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../0011-mac80211-disable-tx-status/mwifiex.patch  |  6 ++--
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../network/0042-pci_error_handlers/atl1e.patch    |  2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  4 +--
 .../network/0050-iov_iter/bluetooth.patch          |  6 ++--
 8 files changed, 77 insertions(+), 11 deletions(-)
 create mode 100644 backport/backport-include/linux/hdmi.h
 create mode 100644 backport/backport-include/linux/timecounter.h

-- 
1.9.1

