Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48070 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaIFTog (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 15:44:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: bring to next-20140822 and remove regulator drivers
Date: Sat,  6 Sep 2014 21:44:14 +0200
Message-Id: <1410032659-30404-1-git-send-email-hauke@hauke-m.de> (sfid-20140906_214439_319933_6A7CC36B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Maintaining the regulator driver costs some time and I removed them to 
make it possible to do more releases. Feel free to send patches to add 
some needed regulator driver again.

Hauke Mehrtens (5):
  backports: remove ath5k section mismatch patch
  backports: fix build with Ubuntu mainline kernels
  backports: update test kernel versions
  backports: remove regulator drivers
  backports: refresh patches on next-20140822

 backport/Kconfig                                   |  1 -
 backport/Makefile.kernel                           |  1 -
 backport/backport-include/generated/utsrelease.h   | 16 +++++
 backport/backport-include/linux/regulator/driver.h | 16 -----
 backport/compat/backport-3.10.c                    | 53 --------------
 backport/defconfigs/regulator                      | 66 -----------------
 copy-list                                          | 31 --------
 dependencies                                       | 82 ----------------------
 devel/backports-update-manager                     | 13 ++--
 .../0030-qdisc_tx_busylock/ieee802154.patch        |  4 +-
 .../network/67-fix-section-mismatch/INFO           |  9 ---
 .../drivers_net_wireless_ath_ath5k_led.patch       | 11 ---
 12 files changed, 25 insertions(+), 278 deletions(-)
 delete mode 100644 backport/defconfigs/regulator
 delete mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
 delete mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch

-- 
1.9.1

