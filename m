Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01520C07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC88A613C9
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGET2v (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:28:51 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:40704 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhGET2u (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 15:28:50 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.128])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 322AD1C0061;
        Mon,  5 Jul 2021 19:26:12 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EFB8A780076;
        Mon,  5 Jul 2021 19:26:11 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5578313C2B1;
        Mon,  5 Jul 2021 12:26:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5578313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625513171;
        bh=pt9YugPmk0+PMPOusX2ygZYXQPt3w0A1Q30TOCSsaxs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HlXGQuQqB/U8ykKLRSMm3TAFpocVR0nWTxfIA10/oo0bYnPD5ehpZAa6rjyT8zyzT
         oqzTG6DzD/3LruELsu/4ua7eA/Nu0FsODaGDSiBYXfrsQi7Weppljvol2roroNiLzo
         qXmk7TWce88umJ7G6Jk3njeFE9Tkk/Zdg3Qp+Rqo=
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
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d772161b-673c-cb57-ca18-ce994fd1b28e@candelatech.com>
Date:   Mon, 5 Jul 2021 12:26:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <33deca8741a231072f2a835ccf7a93eac1430e9d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1625513172-lLkGaC5F9l7E
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/5/21 12:19 PM, Johannes Berg wrote:
> On Mon, 2021-07-05 at 12:17 -0700, Ben Greear wrote:
>>
>> Did you test it?
>>
> 
> Yes, pretty sure we do it basically all the time. We don't have kernels
> that new yet in most of our test setups.
> 
>>    Because that should be logically identical to what I tried if I read this file properly:
> 
> Actually, your version might be more correct than ours ...
> 
> I dunno. I note we also have an <linux/rfkill.h> include in cfg80211.h,
> but that should be there upstream too, so not sure.

There are a lot of rfkill.h files, what logic makes the backports code include the specific
backport/backport-include/linux/rfkill.h file?  I suspect that isn't working for the cfg80211.h
file for whatever reason.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
