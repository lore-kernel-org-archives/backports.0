Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B12DC07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC76761961
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGETk5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:40:57 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:41302 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhGETk4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 15:40:56 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.172])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 623712005E;
        Mon,  5 Jul 2021 19:38:18 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 064BD14006A;
        Mon,  5 Jul 2021 19:38:17 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 54A8D13C2B3;
        Mon,  5 Jul 2021 12:38:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 54A8D13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625513897;
        bh=2t+H1tww6qOphpuMdyJJUQ5WkuSFPUTRM14o32e7qD8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UPgls180JPaJwHvrvtL/C7q9dkWtn2ApcS4Mfvxf7+7ZUGS41mqtg1UWFyFmmTjOx
         g8LueVqaViodUdlKNTmX8L1Oa5OsPU7us5WCUzrlHG+y0RaZLNOibMltSRFLWHM/NZ
         qzkSvSOrGEndfACwFOhgGVRqSxiw2maGPXt7ilPA=
Subject: Re: backports spatch question
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
 <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
 <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
 <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
 <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
 <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
 <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
 <05c73f83ce63bc1e15c40836fce56dcdb7eb9a8b.camel@sipsolutions.net>
 <f00e3ea0-97e4-4f47-b8d1-fd667668754b@candelatech.com>
 <33deca8741a231072f2a835ccf7a93eac1430e9d.camel@sipsolutions.net>
 <d772161b-673c-cb57-ca18-ce994fd1b28e@candelatech.com>
 <9ace0ebe7417d5ade9f5f1df02e46ad982c11c5e.camel@sipsolutions.net>
 <5cb833b8-4c9d-7628-fd1d-d95f12c3962c@candelatech.com>
 <40985f693651f6712aad27f1033c48d99dc5298c.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <967d7217-bcc9-5d87-2327-a9010e0eed45@candelatech.com>
Date:   Mon, 5 Jul 2021 12:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <40985f693651f6712aad27f1033c48d99dc5298c.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1625513898-M7Yj9G1ga6Dx
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/5/21 12:32 PM, Johannes Berg wrote:
> On Mon, 2021-07-05 at 12:32 -0700, Ben Greear wrote:
>> On 7/5/21 12:26 PM, Johannes Berg wrote:
>>> On Mon, 2021-07-05 at 12:26 -0700, Ben Greear wrote:
>>>> On 7/5/21 12:19 PM, Johannes Berg wrote:
>>>>> On Mon, 2021-07-05 at 12:17 -0700, Ben Greear wrote:
>>>>>>
>>>>>> Did you test it?
>>>>>>
>>>>>
>>>>> Yes, pretty sure we do it basically all the time. We don't have kernels
>>>>> that new yet in most of our test setups.
>>>>>
>>>>>>      Because that should be logically identical to what I tried if I read this file properly:
>>>>>
>>>>> Actually, your version might be more correct than ours ...
>>>>>
>>>>> I dunno. I note we also have an <linux/rfkill.h> include in cfg80211.h,
>>>>> but that should be there upstream too, so not sure.
>>>>
>>>> There are a lot of rfkill.h files, what logic makes the backports code include the specific
>>>> backport/backport-include/linux/rfkill.h file?  I suspect that isn't working for the cfg80211.h
>>>> file for whatever reason.
>>>
>>> It's just an additional -I flag on the compiler command line, or -
>>> isystem or something like that.
>>>
>>> johannes
>>>
>>
>> my cfg80211.h shows this line:
>>
>> #include <uapi/linux/rfkill.h>
> 
> Not a later <linux/rfkill.h> line? We have one like that in our version
> ...
> 
> I guess we should really only have the <linux/rfkill.h> one, but since
> we want the function declaration, we really ought to have that?
> 
> johannes
> 
> 

This is from Linus' 5.13 tree.  My grep sucks, but gets the job done.

[greearb@ben-dt4 configs]$ grep rfkill\.h ~/git/linux-2.6/include/net/cfg80211.h
#include <uapi/linux/rfkill.h>
  *	functions to adjust rfkill hw state
  * @reason: one of reasons in &enum rfkill_hard_block_reasons
				      enum rfkill_hard_block_reasons reason);


Is 'your version' of the kernel public somewhere?

I can try changing the cfg80211.h in the upstream kernel that I am generating the backports
package from, but that will not help anyone else trying to create a backports package from a stock 5.13
kernel...

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
