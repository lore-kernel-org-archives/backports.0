Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:40814 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbeIWXn7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:43:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/10] backports: misc fixes to improve support of 4.19
Date: Sun, 23 Sep 2018 19:45:25 +0200
Message-Id: <20180923174535.16198-1-hauke@hauke-m.de> (sfid-20180923_194546_955479_ADD694EF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These patches are based on top of Luca's patches.

This was only basically tested that it compiles against kernel 4.4, 4.9 
and 4.14 on x86 and mips be in OpenWrt.

Hauke Mehrtens (10):
  backports: Remove ssb and bcma
  backports: Remove NFC support
  copy: Add crc32poly.h
  dependencies: Make RSI_COEX coexistence depend on kernel >= 4.17
  dependencies: Make WIL6210 depend on kernel >= 4.8
  dependencies: make hostap and atmel depend on kernel >= 4.18
  patches: make mt76 use skb_pad() instead of __skb_pad()
  patches: remove .coredump from struct driver for kernel < 4.16
  backports: Make netdev destructor spatch apply correctly again
  patches: Do not remove linux/kmemleak.h include

 backport/Kconfig.sources                           |  5 --
 backport/Makefile.kernel                           |  4 -
 .../linux/bcma/bcma_driver_chipcommon.h            | 23 ++++++
 backport/defconfigs/b43                            |  7 --
 backport/defconfigs/b43legacy                      |  5 --
 backport/defconfigs/brcmsmac                       |  2 -
 backport/defconfigs/nfc                            | 20 -----
 backport/defconfigs/wifi                           |  6 --
 copy-list                                          | 16 +---
 dependencies                                       | 66 +++------------
 patches/0013-fix-makefile-includes/mei_phy.patch   | 10 ---
 patches/0051-no-wakeup_path/ssb.patch              | 12 ---
 patches/0059-uuid-in-mei/nfc.patch                 | 32 --------
 patches/0061-termios_rwsem/nfc.patch               | 20 -----
 patches/0069-remove-of_irq/bcma.patch              | 24 ------
 patches/0079-netdev-destructor.cocci               | 32 ++++++++
 patches/0081-proto_ops-accept/nfc.patch            | 16 ----
 patches/0085-not-include-kmemleak.patch            | 11 ---
 patches/0088-coredump.cocci                        | 93 ++++++++++++++++++++++
 patches/0090-use-skb_pad.patch                     | 11 +++
 20 files changed, 169 insertions(+), 246 deletions(-)
 create mode 100644 backport/backport-include/linux/bcma/bcma_driver_chipcommon.h
 delete mode 100644 backport/defconfigs/nfc
 delete mode 100644 patches/0013-fix-makefile-includes/mei_phy.patch
 delete mode 100644 patches/0051-no-wakeup_path/ssb.patch
 delete mode 100644 patches/0059-uuid-in-mei/nfc.patch
 delete mode 100644 patches/0061-termios_rwsem/nfc.patch
 delete mode 100644 patches/0069-remove-of_irq/bcma.patch
 delete mode 100644 patches/0081-proto_ops-accept/nfc.patch
 delete mode 100644 patches/0085-not-include-kmemleak.patch
 create mode 100644 patches/0088-coredump.cocci
 create mode 100644 patches/0090-use-skb_pad.patch

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
