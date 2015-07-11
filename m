Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:55995 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbbGKNp2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 09:45:28 -0400
Message-ID: <55A11DF5.6050202@hauke-m.de> (sfid-20150711_154659_059710_70B0A1D9)
Date: Sat, 11 Jul 2015 15:45:25 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: backport for aead_request_set_ad()
References: <55A119E7.3050809@broadcom.com>
In-Reply-To: <55A119E7.3050809@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/11/2015 03:28 PM, Arend van Spriel wrote:
> I am running backports on 4.2-rc1 source tree and hit following problem:
> 
>   CC [M]  /tmp/bp-test/net/mac80211/aes_ccm.o
> /tmp/bp-test/net/mac80211/aes_ccm.c: In function
> ���ieee80211_aes_ccm_encrypt���:
> /tmp/bp-test/net/mac80211/aes_ccm.c:41:2: error: implicit declaration of
> function ���aead_request_set_ad��� [-Werror=implicit-function-declaration]
>   aead_request_set_ad(aead_req, sg[0].length);
>   ^
> cc1: some warnings being treated as errors
> 
> Looking at commit 957e0fe62923 ("mac80211: Switch to new AEAD
> interface") introducing this call it seems not so trivial and may
> require a backports patch. Just wondering if anyone already had a shot
> at this one.
> 
> Regards,
> Arend
> -- 
> To unsubscribe from this list: send the line "unsubscribe backports" in
Hi Arend,

this is already in backports, see this commit:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=4d724eec

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
