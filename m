Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CFAC07E96
	for <backports@archiver.kernel.org>; Tue,  6 Jul 2021 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960146101C
	for <backports@archiver.kernel.org>; Tue,  6 Jul 2021 13:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGFN1D (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:27:03 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:39772 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbhGFN1D (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 6 Jul 2021 09:27:03 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.61])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 12D17A006D;
        Tue,  6 Jul 2021 13:24:24 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BAFC0C006F;
        Tue,  6 Jul 2021 13:24:23 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.183.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E263C13C2B1;
        Tue,  6 Jul 2021 06:24:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E263C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625577863;
        bh=k7YXJ8OAsgdn3PYp4SD9VXgIjP0eb3Gymv0Y2tL5C+w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pbO5P9pnBKQNU1NpxDtw1qaOegWg62zjwzV1tZs6hV/lzOVM6SNHht6HyoWdd0dU6
         lHzKwPD9WHVkg3J/S7rEHDbSUli+LKS1sVWmdl0wx9+46eaNJt7pGNxVedj9SgDl+i
         Grgoi3x6Nqf06010d546Qs0iSTcUerNclaxoe0Gw=
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
 <94421dca-f1b7-1f89-27d1-a981845b5a63@candelatech.com>
 <a9775be6b1faef0d05a5345630c52c37d9c7f220.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <eb6281da-57d6-f0ad-05e6-5adfc6ff64e3@candelatech.com>
Date:   Tue, 6 Jul 2021 06:24:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a9775be6b1faef0d05a5345630c52c37d9c7f220.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1625577864-jgDazKwI2xmr
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/5/21 11:41 PM, Johannes Berg wrote:
> On Mon, 2021-07-05 at 13:30 -0700, Ben Greear wrote:
>> So next problem is kcov stuff.  This is just FYI, I'll just revert this
>> patch since I don't need it.
> 
> I guess that works, but FWIW, I did point you to our tree already
> earlier in the thread and generally we do have backports there for
> everything we needed. In this instance:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/tree/backport-include/linux/kcov.h
> 
> johannes
> 

Oh, I thought you had a full kernel tree somewhere that you ran upstream 'backports' gentree.py against.

Either way, after kcov, there was another hack to fix some stats logic, a hack for mt76,
and then everything compiled.  I'll run-time test it today.

https://github.com/greearb/linux-ct-5.13/commit/9adefb55567bf9bddb6b1a35c3dcc2536ba79ed4
https://github.com/greearb/linux-ct-5.13/commit/fda0314f45cd32592b0db9fd18bf70e0c8a1e932
https://github.com/greearb/linux-ct-5.13/commit/9578910a5710ecc487fa6a46bafa9bedeb0ddd00

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
--
To unsubscribe from this list: send the line "unsubscribe backports" in
