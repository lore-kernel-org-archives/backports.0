Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:50781 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3EKA1b (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:31 -0400
Received: by mail-ia0-f181.google.com with SMTP id f27so5315324iae.40
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 04/12] backports: copy brcmfmac-sdio.h
Date: Fri, 10 May 2013 17:26:55 -0700
Message-Id: <1368232023-23817-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022732_446894_9FBF9D98)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

On next-20130415 commit 668761ac0 added platform
specific data for brcmfmac for SDIO. Copy that
over. This is the first in a series of changes
required for next-20130415.

commit 668761ac01d6f5a36b8e5a24d4e154550e2c4c3b
Author: Hante Meuleman <meuleman@broadcom.com>
Date:   Fri Apr 12 10:55:55 2013 +0200

    brcmfmac: define and use platform specific data for SDIO.

    This patch adds support for platform specific data for SDIO
    fullmac devices. Currently OOB interrupts are configured by Kconfig
    BRCMFMAC_SDIO_OOB but that is now determined dynamically by checking
    availibility of platform data.

    Cc: Hauke Mehrtens <hauke@hauke-m.de>
    Reviewed-by: Arend Van Spriel <arend@broadcom.com>
    Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
    Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
    Reviewed-by: Piotr Haber <phaber@broadcom.com>
    Signed-off-by: Hante Meuleman <meuleman@broadcom.com>
    Signed-off-by: Arend van Spriel <arend@broadcom.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 6db79a3..8b3de0c 100644
--- a/copy-list
+++ b/copy-list
@@ -27,6 +27,7 @@ include/linux/bcm47xx_wdt.h
 include/linux/usb/usbnet.h
 include/linux/usb/rndis_host.h
 include/linux/spi/libertas_spi.h
+include/linux/platform_data/brcmfmac-sdio.h
 
 include/uapi/linux/nl80211.h
 include/linux/rfkill.h -> include/linux/rfkill_backport.h
-- 
1.7.10.4

