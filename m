Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44110 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbaFOQfk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 12:35:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 99E747E59
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 18:35:37 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: remove DMA shared buffer backport
Date: Sun, 15 Jun 2014 18:35:17 +0200
Message-Id: <1402850123-22382-1-git-send-email-hauke@hauke-m.de> (sfid-20140615_183553_057246_858B1DB5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The DMA shared buffer backport is only used by v4l2 and this works also 
with the in kernel API of kernel >= 3.5. In the next backports version 
some bigger changes to the DMA shared buffer backport would be needed, 
but I would more like to remove it.

Hauke Mehrtens (6):
  backports: disable DMA shared buffer support for kernel < 3.5 in v4l2
  backports: remove backport of DMA shared buffers
  backports: add i2c_add_mux_adapter()
  backports: add I2C_CLIENT_SCCB
  backports: fix a compile warning in devnode
  backports: activate some more media drivers

 backport/backport-include/linux/dma-buf.h          |   8 +
 backport/backport-include/linux/i2c-mux.h          |   5 +-
 backport/backport-include/linux/i2c.h              |   5 +
 backport/compat/Kconfig                            |  13 -
 backport/compat/backports.h                        |   8 -
 backport/compat/main.c                             |   2 -
 copy-list                                          |   3 +
 dependencies                                       |  61 +---
 patches/backport-adjustments/dma-buf.patch         |  73 ----
 .../media/0002-no_dmabuf/v4l2.patch                | 375 +++++++++++++++++++++
 .../media/0004-devnode_param_type/INFO             |   8 +
 .../media/0004-devnode_param_type/ddbridge.patch   |  14 +
 .../media/0004-devnode_param_type/dvb-core.patch   |  14 +
 .../media/0004-devnode_param_type/rc.patch         |  14 +
 14 files changed, 451 insertions(+), 152 deletions(-)
 create mode 100644 backport/backport-include/linux/dma-buf.h
 delete mode 100644 patches/backport-adjustments/dma-buf.patch
 create mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/INFO
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/ddbridge.patch
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/dvb-core.patch
 create mode 100644 patches/collateral-evolutions/media/0004-devnode_param_type/rc.patch

-- 
1.9.1

