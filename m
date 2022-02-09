Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7139AC433EF
	for <backports@archiver.kernel.org>; Thu, 10 Feb 2022 02:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiBJCNY (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:13:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBJCNY (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 Feb 2022 21:13:24 -0500
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 18:13:26 PST
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0500925CB
        for <backports@vger.kernel.org>; Wed,  9 Feb 2022 18:13:25 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JvGj33V3tz9sHY;
        Thu, 10 Feb 2022 00:45:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1644450341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiJzUWDHCrLbNo6rzWt/CrNPMBWQ7xyYp+zRh5Ygn/4=;
        b=WA2pI5gGQSy+cJp+U2aoQi8Db+fTxR83jBc8UvsxfWiP9VPpCqa8YZww/Fp/2XEtiIkeTd
        FSHMtP19QGf9hJBDW8MYhVn68kHIrSQ3tHvG5vBinrB6LzvsTOau1tHCNi+l0XJ3jKvx9P
        VDKiG+hDzbXDZMGJU4g3Pw60T0qHzRq/ejX2fyRCgmKEOTsifCiIDXsxIJC9H/IqsUP/Qq
        0MTa1DRFgV1TKVtIxDrrcpFiVMoi6blUZdYyPheepuH0f/jgaammLEMzarFNSKef/w5zbV
        maFCt1+V1nTA990rNWh+Awp4D3g0Il4YNDA72LSXxnTsIrQ3Cnoq8qD5bSq0zw==
Message-ID: <c69c18d2-82d0-41ae-5982-4716320fe4a3@hauke-m.de>
Date:   Thu, 10 Feb 2022 00:45:39 +0100
MIME-Version: 1.0
Subject: Re: Dealing with SUBLEVEL overflow in backports
Content-Language: en-US
From:   Hauke Mehrtens <hauke@hauke-m.de>
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
 <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
In-Reply-To: <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/10/22 00:44, Hauke Mehrtens wrote:
> On 2/8/22 16:51, Jiaxun Yang wrote:
>>
>>
>> 在 2022/2/8 15:02, Johannes Berg 写道:
>>> On Tue, 2022-02-08 at 14:50 +0000, Jiaxun Yang wrote:
>>>> Ah I tried this approach but find that this may break other modules
>>>> depending on our headers because the cflag won't come with be
>>>> inherited by them.
>>>>
>>> Hm. I thought about if that could happen, but decided not? We only
>>> compile C files in backports, which other parts would break?
>>
>> For example OpenWRT compiles mac80211 purely from backports.
>>
>> So for other out-of-tree wireless drivers they have to include headers
>> provided by backports, but they can't recieve cflags from our makefile.
>>
>> So it will leave those macros undefined ad led to problems.
>>
>> Thanks.
>> - Jiaxun
>>
>>>
>>> johannes
>>
> Hi,
> 
> What build problem do you get when you include "#include <linux/bug.h>" 
> here on kernel 4.9.299? Can we somehow work around this problem by 
> detection the kernel version in a different way based on a different 
> define?
> 
> Hauke

OpenWrt does not use kernel 4.9 any more, we could also drop the support 
for some external modules using backports on such old kernel versions.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
