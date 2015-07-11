Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:11600 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbGKVX5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 11 Jul 2015 17:23:57 -0400
Message-ID: <55A1896A.1000108@broadcom.com> (sfid-20150711_232405_752860_50F906FF)
Date: Sat, 11 Jul 2015 23:23:54 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: backport for aead_request_set_ad()
References: <55A119E7.3050809@broadcom.com> <55A11DF5.6050202@hauke-m.de>
In-Reply-To: <55A11DF5.6050202@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/11/2015 03:45 PM, Hauke Mehrtens wrote:
> On 07/11/2015 03:28 PM, Arend van Spriel wrote:
>> I am running backports on 4.2-rc1 source tree and hit following problem:
>>
>>    CC [M]  /tmp/bp-test/net/mac80211/aes_ccm.o
>> /tmp/bp-test/net/mac80211/aes_ccm.c: In function
>> ���ieee80211_aes_ccm_encrypt���:
>> /tmp/bp-test/net/mac80211/aes_ccm.c:41:2: error: implicit declaration of
>> function ���aead_request_set_ad��� [-Werror=implicit-function-declaration]
>>    aead_request_set_ad(aead_req, sg[0].length);
>>    ^
>> cc1: some warnings being treated as errors
>>
>> Looking at commit 957e0fe62923 ("mac80211: Switch to new AEAD
>> interface") introducing this call it seems not so trivial and may
>> require a backports patch. Just wondering if anyone already had a shot
>> at this one.
>>
>> Regards,
>> Arend
>> --
>> To unsubscribe from this list: send the line "unsubscribe backports" in
> Hi Arend,
>
> this is already in backports, see this commit:
> https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=4d724eec

Thanks, Hauke

That did the trick.

Regards,
Arend
> Hauke
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
