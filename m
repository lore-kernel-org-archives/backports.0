Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:43453 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932332AbdCINFi (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 9 Mar 2017 08:05:38 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 0/4] backports: fixes for wireless-testing
Date: Thu,  9 Mar 2017 12:57:29 +0000
Message-Id: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140611_729182_C316A114)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This series fixes backport issues found backporting the wireless-testing
tree that moved to 4.11-rc1.

Arend van Spriel (4):
  patches: update crypto-ccm.patch for v4.11-rc1
  backports: add backport for idr_remove
  backports: introduce new definition for DECLARE_EWMA macro
  backports: add dummy include/linux/sched/signal.h

 backport/backport-include/linux/average.h      | 65 +++++++++++++++++---------
 backport/backport-include/linux/idr.h          | 10 ++++
 backport/backport-include/linux/sched/signal.h | 10 ++++
 patches/crypto-ccm.patch                       |  9 ++--
 4 files changed, 69 insertions(+), 25 deletions(-)
 create mode 100644 backport/backport-include/linux/sched/signal.h

--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
