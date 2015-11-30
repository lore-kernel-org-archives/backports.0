Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:24826 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbbK3Jwn (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 30 Nov 2015 04:52:43 -0500
Received: from [10.176.128.83] (bld-bun-01.bun.broadcom.com [10.176.128.83])
	by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 231F627A81	for
 <backports@vger.kernel.org>; Mon, 30 Nov 2015 01:52:40 -0800 (PST)
Message-ID: <565C1C67.3080506@broadcom.com> (sfid-20151130_105245_365999_BBB2DB93)
Date: Mon, 30 Nov 2015 10:52:39 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: backporting 4.4-rc2
Content-Type: multipart/mixed;
	boundary="------------000402010801010509020206"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

--------------000402010801010509020206
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am trying to backport 4.4-rc2, but end up with only hwsim defconfig in 
the generated backport. Any clues where to look?

In drivers/net/wireless/Kconfig several "source" commands are commented 
out, which I suspect is related. Running make menuconfig does not 
present any wireless drivers to be selected.

Regards,
Arend

--------------000402010801010509020206
Content-Type: text/plain; charset="UTF-8"; name="copy-list"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="copy-list"

#
# This file specifies which sources are copied from the kernel
# into the backports package.
#
# Directories must end with a slash (e.g. "net/wireless/") and
# are then copied with all their contents.
#
# It is also possible to rename while copying, to do so list
# old name -> new name
# Note that in this case the spaces are needed: " -> "
#

COPYING
MAINTAINERS
include/linux/unaligned/
include/linux/hashtable.h

# 802.11
drivers/net/wireless/Kconfig
drivers/net/wireless/Makefile

include/linux/wireless.h
include/uapi/linux/wireless.h
include/linux/ieee80211.h
include/linux/pci_ids.h
include/uapi/linux/pci_regs.h
include/linux/mmc/sdio_ids.h
include/linux/ath9k_platform.h
include/uapi/linux/wil6210_uapi.h
include/linux/wl12xx.h
include/linux/rndis.h
include/linux/bcm47xx_wdt.h
include/linux/usb/usbnet.h
include/linux/usb/rndis_host.h
include/linux/spi/libertas_spi.h
include/linux/platform_data/brcmfmac-sdio.h
include/uapi/linux/nl80211.h

include/net/cfg80211.h
include/net/cfg80211-wext.h
include/net/ieee80211_radiotap.h
include/net/lib80211.h
include/net/mac80211.h
include/net/regulatory.h

net/Makefile
net/Kconfig
net/wireless/
net/mac80211/

include/linux/ssb/
drivers/bcma/
include/linux/bcma/
drivers/net/wireless/brcm80211/

include/net/netns/ieee802154_6lowpan.h

# MPLS labels, checked on skb->protocol on the
# respective 802 family, only ethernet seems to use
# this right now, see 960d97f95
include/linux/mpls.h
include/uapi/linux/mpls.h

# fixup needed for CONFIG_WLAN
drivers/net/wireless/realtek/Makefile

--------------000402010801010509020206--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
