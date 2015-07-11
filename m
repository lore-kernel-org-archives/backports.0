Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:7878 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbbGKN2K (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 11 Jul 2015 09:28:10 -0400
Message-ID: <55A119E7.3050809@broadcom.com> (sfid-20150711_152812_915704_24C3DEB8)
Date: Sat, 11 Jul 2015 15:28:07 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>
Subject: backport for aead_request_set_ad()
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am running backports on 4.2-rc1 source tree and hit following problem:

   CC [M]  /tmp/bp-test/net/mac80211/aes_ccm.o
/tmp/bp-test/net/mac80211/aes_ccm.c: In function 
���ieee80211_aes_ccm_encrypt���:
/tmp/bp-test/net/mac80211/aes_ccm.c:41:2: error: implicit declaration of 
function ���aead_request_set_ad��� [-Werror=implicit-function-declaration]
   aead_request_set_ad(aead_req, sg[0].length);
   ^
cc1: some warnings being treated as errors

Looking at commit 957e0fe62923 ("mac80211: Switch to new AEAD 
interface") introducing this call it seems not so trivial and may 
require a backports patch. Just wondering if anyone already had a shot 
at this one.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
