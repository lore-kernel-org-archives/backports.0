Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32800 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbcILJYy (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 12 Sep 2016 05:24:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id cm16so49314220pac.0
        for <backports@vger.kernel.org>; Mon, 12 Sep 2016 02:24:53 -0700 (PDT)
Subject: Re: [PATCH] gentree: create Kconfig.local, use it to restrict compat
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <1472493101-6058-1-git-send-email-johannes@sipsolutions.net>
 <4d5c9281-7f15-37ec-d0f7-099cc9a12f53@broadcom.com>
Cc: Jouni Malinen <j@w1.fi>, Johannes Berg <johannes.berg@intel.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <e22778ec-4398-5e65-203c-341ccb29a8a4@broadcom.com> (sfid-20160912_112457_101496_5F5CBDCC)
Date: Mon, 12 Sep 2016 11:24:45 +0200
MIME-Version: 1.0
In-Reply-To: <4d5c9281-7f15-37ec-d0f7-099cc9a12f53@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 12-9-2016 11:17, Arend Van Spriel wrote:
> On 29-8-2016 19:51, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Not all the compat code is always necessary, for example code
>> enabled by BPAUTO_CRYPTO_SKCIPHER and by BPAUTO_RHASHTABLE is
>> gated on other symbols being selected. Checking against the
>> Kconfig symbols as it's done right now is wrong though, since
>> the base kernel's Kconfig symbols would be used, selecting,
>> for example, BPAUTO_CRYPTO_SKCIPHER when the base kernel has
>> CONFIG_BT set, but doing that when BT isn't even part of the
>> backport, or when it's disabled in the backport.
> 
> Excellent. Thanks for this. I have been spending some time on fixing
> that skcipher stuff (attached) although the stuff in my selective
> backport does not need it.

For people considering the patch please be warned that I did not
actually test it. I added two structures, but did not verify if those
are the same for kernel versions 3.0 to 4.8. For struct
skcipher_instance a .init field was added so that at least needs to be
fixed.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
