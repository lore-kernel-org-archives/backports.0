Return-path: <backports-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45736 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751822AbeD3LQE (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 30 Apr 2018 07:16:04 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: backports@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 0/3] backports: enable building v4.17 kernel
Date: Mon, 30 Apr 2018 13:15:43 +0200
Message-Id: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20180430_131606_942335_69A5E506)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This series enables backporting v4.17-rcX kernel sources. It was
not tested against every target kernel, but it does work properly
for 3.11 FC19 kernel.

It applies to the master branch of the backports repository.

Arend van Spriel (3):
  patches: update patches for v4.17-rc1
  backport-include: add ETH_P_PREAUTH definition in if_ether.h
  backport-include: deal with struct sock::sk_pacing_shift

 backport/backport-include/linux/if_ether.h |  4 ++++
 backport/backport-include/net/sock.h       | 12 ++++++++++++
 patches/0004-disable-wext-kconfig.patch    |  4 ++--
 patches/0070-mac80211-fils.patch           |  8 ++++----
 4 files changed, 22 insertions(+), 6 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
