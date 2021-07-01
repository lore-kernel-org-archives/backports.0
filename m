Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4212C11F67
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 22:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96A561353
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhGAW5z (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 1 Jul 2021 18:57:55 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:35026 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232807AbhGAW5w (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 1 Jul 2021 18:57:52 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.168])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id B6588A006C;
        Thu,  1 Jul 2021 22:55:20 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 69F6D880069;
        Thu,  1 Jul 2021 22:55:20 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C73EA13C2B1;
        Thu,  1 Jul 2021 15:55:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C73EA13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625180119;
        bh=fhlUKFK10csmHMfZ2jBQlTmLHacTgO6l7k87QnyF2q4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HBHJXnpnHQETRipNZwqgkvRzgGPvsWKOHI6j8LtgaRV8edQ6zXpTcLQL7koRU+p7x
         TMdx+nHsqLIUql/iEwD3r38octvTWtChvQOnnTyPJFT4uSyebDQA1tu/VyjDabaZ2x
         /FW9UlYBIPOkxQYzc8ZjFSGAtYy9B8LWY0ohSLfk=
Subject: Re: backports spatch question
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
 <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
 <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
 <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <91aec554-c4e3-3a1f-8283-f857c6cf8af3@candelatech.com>
Date:   Thu, 1 Jul 2021 15:55:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1625180121-ftODrrkZmmoA
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/1/21 2:51 PM, Johannes Berg wrote:
> On Thu, 2021-07-01 at 14:40 -0700, Ben Greear wrote:
>>
>> [greearb@v-f34-64 backports]$ spatch --version
>> spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1
> 
> 
> I just realized I never even tried on my system recently, I'm still on
> F33 and have
> 
> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
> 
> Could you try some other version? Backports says it needs "at least"
> 1.0.7 but perhaps only exactly that works?
> 
> johannes
> 

I get the same error on F33, with same version of spatch as you show above.

Maybe I broke something trying to update the patches to work against my 5.13 tree
(and, in case you can use any of those patches when you do your own port to 5.13,
  of course feel free to grab them from my tree.)

If you have time to try it out:

Here is my backports project tree:

https://github.com/greearb/backports-project-5.13

And this is the tree I'm trying to generate from:

https://github.com/greearb/linux-ct-5.13

I cloned both in ~/git and ran from ~/git/backports/:

./gentree.py --clean ~/git/linux-5.13.dev.y/ ~/tmp/backports

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
