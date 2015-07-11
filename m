Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56146 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbbGKVfe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:35:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/2] backports: bring backprots to next-20150710
Date: Sat, 11 Jul 2015 23:35:26 +0200
Message-Id: <1436650528-2805-1-git-send-email-hauke@hauke-m.de> (sfid-20150711_233536_202597_2820C1F7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes backprots compatible with next-20150710.

Hauke Mehrtens (2):
  patches: remove usage of wait_on_bit_timeout() on older kernels
  patches: refresh on next-20150710

 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 38 +++++-----
 .../media/0005-dma-no-sync/v4l2.patch              | 12 +--
 .../network/0050-iov_iter/bluetooth.patch          |  8 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  8 +-
 .../hci_intel.patch                                | 88 ++++++++++++++++++++++
 6 files changed, 123 insertions(+), 35 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
