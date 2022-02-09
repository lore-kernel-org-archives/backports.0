Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110BC433F5
	for <backports@archiver.kernel.org>; Thu, 10 Feb 2022 02:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiBJCM1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:12:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBJCM0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 Feb 2022 21:12:26 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28685111E
        for <backports@vger.kernel.org>; Wed,  9 Feb 2022 18:12:28 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4JvGgC4w2dz9sSx;
        Thu, 10 Feb 2022 00:44:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1644450245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9oiuAkRlGaa4npbX74AtLn3SxchTZdn6ES84ULyD5Y=;
        b=Ztn0ouz4csAeN6d6e3IWj0AE+npuAsAeRdf5Du+OB64OGbnR7xsTSRwAkG1bXZJXZKAk8H
        IHNQfb9P4TX5jbG8ZbYsC419d0Sgg/Awo9AsBMAkRf3LEHZiDvsr7ejyN+3PcyGo43zmca
        GCmmun7JKNGy/8O1OQgATL3nS2gmBRp8aXFrEMVxhRoqP0xBCkN0ufQFWBeavBwg1si0rc
        qDQfYNBOt006BZeDTz39hOKJZhbzcpEansGIpfKjT1vMb8LLAannFJN6MdlLI2rVgiiPLa
        9kgGOhHCamZvGj6jwX/gAd0yWJeqXgMuD2zHGycqtx7DUTJkSgHegxVs0F083g==
Message-ID: <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
Date:   Thu, 10 Feb 2022 00:44:03 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
 <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
 <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
 <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
 <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
 <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
 <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
 <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
 <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
 <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
 <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
 <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
 <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
 <a3f573f1-7f61-b38d-813a-53d4af59f322@flygoat.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Dealing with SUBLEVEL overflow in backports
In-Reply-To: <a3f573f1-7f61-b38d-813a-53d4af59f322@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/8/22 16:51, Jiaxun Yang wrote:
> 
> 
> 在 2022/2/8 15:02, Johannes Berg 写道:
>> On Tue, 2022-02-08 at 14:50 +0000, Jiaxun Yang wrote:
>>> Ah I tried this approach but find that this may break other modules
>>> depending on our headers because the cflag won't come with be
>>> inherited by them.
>>>
>> Hm. I thought about if that could happen, but decided not? We only
>> compile C files in backports, which other parts would break?
> 
> For example OpenWRT compiles mac80211 purely from backports.
> 
> So for other out-of-tree wireless drivers they have to include headers
> provided by backports, but they can't recieve cflags from our makefile.
> 
> So it will leave those macros undefined ad led to problems.
> 
> Thanks.
> - Jiaxun
> 
>>
>> johannes
> 
Hi,

What build problem do you get when you include "#include <linux/bug.h>" 
here on kernel 4.9.299? Can we somehow work around this problem by 
detection the kernel version in a different way based on a different define?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
