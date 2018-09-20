Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50942 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726954AbeITRLv (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:51 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:28 +0300
Message-Id: <20180920112842.27198-1-luca@coelho.fi> (sfid-20180920_132851_572621_E565E5E5)
Subject: [PATCH 00/14] backport: updates for 4.19
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

I finally found the time to go through the backports I had made for
our internal tree and send them upstream.

We've compile tested this on some old kernels, but the list is far
from being comprehensive.

Please review.

Cheers,
Luca.


Johannes Berg (1):
  backports: improve skb->xmit_more handling

Luca Coelho (12):
  backport: fix compilation with IPV6 not set
  backport: introduce match_string() for kernels < 4.6
  backport: add patch to ignore iwlwifi removal on < 3.14 kernels
  backport: convert tree section names to ascii
  backport: add rhashtable-types.h
  backport: remove duplicate leds.h inclusion from backport-4.5.c
  backport: prevent unused subclass variable warning in < 3.18
  backport: make ktime_get_boottime_seconds() non-inline
  backport: update u64_stats_init() to a new version in kernels < 4.2
  backport: update lib-rhashtable.c
  backport: convert int led activate op to void when needed
  backports: add __alloc_bucket_spinlocks() for < 4.19

Shahar S Matityahu (1):
  backports: add wait_event_killable_timeout backport support

 backport/backport-include/linux/netdevice.h   | 10 ++++++
 backport/backport-include/linux/skbuff.h      |  9 ++++++
 backport/backport-include/linux/spinlock.h    | 32 +++++++++++++++++++
 backport/backport-include/linux/string.h      |  4 +++
 backport/backport-include/linux/timekeeping.h |  5 +--
 backport/backport-include/linux/wait.h        | 15 +++++++++
 backport/compat/Kconfig                       |  1 +
 backport/compat/Makefile                      |  1 +
 backport/compat/backport-4.18.c               | 11 +++++++
 backport/compat/backport-4.4.c                |  6 ++++
 backport/compat/backport-4.5.c                |  1 -
 backport/compat/backport-4.6.c                | 26 +++++++++++++++
 devel/git-tracker.py                          |  2 ++
 .../0059-skb_xmit_more/skb_no_xmit_more.cocci | 10 ++----
 patches/iwlwifi-pci-device-removal.patch      | 24 ++++++++++++++
 patches/led_activate.cocci                    | 24 ++++++++++++++
 patches/lib-rhashtable.patch                  | 14 ++++++++
 17 files changed, 183 insertions(+), 12 deletions(-)
 create mode 100644 backport/compat/backport-4.18.c
 create mode 100644 patches/iwlwifi-pci-device-removal.patch
 create mode 100644 patches/led_activate.cocci
 create mode 100644 patches/lib-rhashtable.patch

-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
