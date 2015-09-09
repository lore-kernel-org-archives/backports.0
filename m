Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:42554 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbbIIId5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Sep 2015 04:33:57 -0400
Message-ID: <55EFEEF2.2060205@broadcom.com> (sfid-20150909_103401_031785_6658449D)
Date: Wed, 9 Sep 2015 10:33:54 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: backport devcoredump
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Johannes,

I noticed that devcoredump has been added to backports project through 
backport-adjustment patch. brcmfmac now select WANT_DEV_COREDUMP. 
However, when I run gentree.py the devcoredump patch is not applied. 
Also Kconfig of brcm80211 still shows WANT_DEV_COREDUMP. I tried 
changing it to BPAUTO_WANT_DEV_COREDUMP, but that did not help.

   CC [M] 
/iscsi/arend/git/brcm80211-backport/drivers/net/wireless/brcm80211/brcmfmac/debug.o
/iscsi/arend/git/brcm80211-backport/drivers/net/wireless/brcm80211/brcmfmac/debug.c:19:31: 
fatal error: linux/devcoredump.h: No such file or directory
  #include <linux/devcoredump.h>
                                ^
compilation terminated.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
