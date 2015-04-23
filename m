Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933975AbbDWLe7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 23 Apr 2015 07:34:59 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 0/4] backports: deal with timespec64 changes
Date: Thu, 23 Apr 2015 13:33:41 +0200
Message-Id: <1429788825-18466-1-git-send-email-sassmann@kpanic.de> (sfid-20150423_133500_494621_7677B177)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This series adds cocci patches to deal with struct timespec64 changes
and also has several other bits to get igb working again. Patches have
been tested against next-20150402.

The struct timespec64 patches are not perfect, but they should get us
started. There are still some warnings, which we can fix along the way.

Stefan Assmann (4):
  backports: handle ndo_gso_check() to ndo_features_check() changes
  backports: add passthru_features_check()
  backports: deal with struct timespec64 changes
  backports: deal with struct struct ptp_clock_info get/settime64
    changes

 backport/backport-include/linux/netdevice.h        |  6 ++
 backport/compat/Makefile                           |  1 +
 backport/compat/backport-4.1.c                     | 19 +++++
 .../network/0056-ndo_features_check/INFO           | 12 ++++
 .../0056-ndo_features_check/features_check.cocci   | 19 +++++
 .../network/0057-timespec64/INFO                   | 11 +++
 .../network/0057-timespec64/igb.patch              | 16 +++++
 .../network/0057-timespec64/timespec64.cocci       | 83 ++++++++++++++++++++++
 .../network/0058-ptp_getsettime64/INFO             | 11 +++
 .../0058-ptp_getsettime64/ptp_getsettime64.cocci   | 33 +++++++++
 10 files changed, 211 insertions(+)
 create mode 100644 backport/compat/backport-4.1.c
 create mode 100644 patches/collateral-evolutions/network/0056-ndo_features_check/INFO
 create mode 100644 patches/collateral-evolutions/network/0056-ndo_features_check/features_check.cocci
 create mode 100644 patches/collateral-evolutions/network/0057-timespec64/INFO
 create mode 100644 patches/collateral-evolutions/network/0057-timespec64/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0057-timespec64/timespec64.cocci
 create mode 100644 patches/collateral-evolutions/network/0058-ptp_getsettime64/INFO
 create mode 100644 patches/collateral-evolutions/network/0058-ptp_getsettime64/ptp_getsettime64.cocci

-- 
2.1.0

