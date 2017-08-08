Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33702 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751925AbdHHNOz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 Aug 2017 09:14:55 -0400
Received: by mail-pg0-f48.google.com with SMTP id u5so14774578pgn.0
        for <backports@vger.kernel.org>; Tue, 08 Aug 2017 06:14:55 -0700 (PDT)
From: AceLan Kao <acelan.kao@canonical.com>
To: hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH] backports: remove 802.15.4 entirely
Date: Tue,  8 Aug 2017 21:14:50 +0800
Message-Id: <1502198091-24156-1-git-send-email-acelan.kao@canonical.com> (sfid-20170808_151457_408526_48A1FBCC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Sorry, the previous one can not be clean applied.
Please ignore it and use this one.

AceLan Kao (1):
  backports: remove 802.15.4 entirely

 backport/Kconfig.sources                           |  5 --
 backport/Makefile.kernel                           |  6 ---
 backport/compat/Kconfig                            |  1 -
 dependencies                                       | 10 ----
 patches/0006-ieee802154-6lowpan-namespace.patch    | 63 ----------------------
 patches/0007-lowpan-inet_frag_lru_move.patch       | 59 --------------------
 patches/0008-net-user-ns.patch                     | 17 ------
 patches/0013-fix-makefile-includes/6lowpan.patch   | 10 ----
 patches/0013-fix-makefile-includes/cfg802154.patch | 10 ----
 patches/0030-qdisc_tx_busylock/ieee802154.patch    | 22 --------
 patches/0044-no_user_ns_in_net/ieee802154.patch    | 30 -----------
 .../cfg802154.patch                                | 18 -------
 patches/0068-proto-hash/ieee802154.patch           | 62 ---------------------
 13 files changed, 313 deletions(-)
 delete mode 100644 patches/0006-ieee802154-6lowpan-namespace.patch
 delete mode 100644 patches/0007-lowpan-inet_frag_lru_move.patch
 delete mode 100644 patches/0008-net-user-ns.patch
 delete mode 100644 patches/0013-fix-makefile-includes/6lowpan.patch
 delete mode 100644 patches/0013-fix-makefile-includes/cfg802154.patch
 delete mode 100644 patches/0030-qdisc_tx_busylock/ieee802154.patch
 delete mode 100644 patches/0044-no_user_ns_in_net/ieee802154.patch
 delete mode 100644 patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
 delete mode 100644 patches/0068-proto-hash/ieee802154.patch

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
