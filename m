Return-path: <backports-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:34020
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750811AbcBEKar (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Feb 2016 05:30:47 -0500
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com [10.11.16.103])
	by mail-irv-18.broadcom.com (Postfix) with ESMTP id BAFF982130
	for <backports@vger.kernel.org>; Fri,  5 Feb 2016 02:22:36 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (unknown [10.17.16.106])
	by mail-irva-13.broadcom.com (Postfix) with ESMTP id A071240FE6
	for <backports@vger.kernel.org>; Fri,  5 Feb 2016 02:22:34 -0800 (PST)
Received: from [10.176.128.83] (bld-bun-01.bun.broadcom.com [10.176.128.83])
	by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 2BB1727A81
	for <backports@vger.kernel.org>; Fri,  5 Feb 2016 02:22:35 -0800 (PST)
Message-ID: <56B477EB.1010308@broadcom.com> (sfid-20160205_113050_784576_5F9729C3)
Date: Fri, 05 Feb 2016 11:22:35 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: backports build issue with 4.5-rc2
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I created a 4.5-rc2 package and am getting build error against 3.11 
kernel for cfg80211 and mac80211. Does anyone has patch for this already?

Regards,
Arend

/tmp/brcm-backports-internal-676-g4d64fc2/net/mac80211/rx.c: In function 
‘ieee80211_rx_reorder_ready’:
/tmp/brcm-backports-internal-676-g4d64fc2/net/mac80211/rx.c:810:2: 
error: implicit declaration of function ‘BIT_ULL’ 
[-Werror=implicit-function-declaration]
   if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
   ^

cc1: some warnings being treated as errors
make[6]: *** 
[/tmp/brcm-backports-internal-676-g4d64fc2/net/mac80211/rx.o] Error 1
make[6]: *** Waiting for unfinished jobs....
/tmp/brcm-backports-internal-676-g4d64fc2/net/wireless/core.c: In 
function ‘cfg80211_netdev_notifier_call’:
/tmp/brcm-backports-internal-676-g4d64fc2/net/wireless/core.c:1176:2: 
error: implicit declaration of function ‘wireless_nlevent_flush’ 
[-Werror=implicit-function-declaration]
   wireless_nlevent_flush();
   ^
cc1: some warnings being treated as errors
--
To unsubscribe from this list: send the line "unsubscribe backports" in
