Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFEC433EF
	for <backports@archiver.kernel.org>; Wed,  4 May 2022 12:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbiEDMH7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 4 May 2022 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbiEDMH7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 4 May 2022 08:07:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68A20BF1
        for <backports@vger.kernel.org>; Wed,  4 May 2022 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IeGA9z+hYhlrZTN/RI7bkkkjo8I0dGg5a1gCnozjSms=;
        t=1651665863; x=1652875463; b=t/I1Uu2+7cl8bPlAG4VQUam2IhCz+mSRpMMQhv5MaNB87bm
        gp9BUyYeA6IhJZSdjWyTKyGoRwhpbZF78P/HzNn0vpLubPl34UA7WrrKFGU7daFKsBmCtJOzTCJ0Y
        R/bSGoKfv9DFebOCTMNNm3CFbAIHWMkFbgG7FklQ3JaCmQyzCAWQvtMCdYYR6frXQbuIYdCYHYvOJ
        mlW1vQFvtKWFIv8K4EmwrnjH9ZeEV9XrlqD+A7uUrUTM3Fi1RPgpPeUvPDZZNyUGWunDyU2TX71/p
        1q+hyqT2j/HV7pab0mNRSJQ+umKPDaRgys9zZGYUp16OCBQX1BZCVFC/dBWmghSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDjt-0021lw-Rq;
        Wed, 04 May 2022 14:04:17 +0200
Message-ID: <6fea1bbdb30f5d379b9223fed67734525092d7e4.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        backports@vger.kernel.org
Date:   Wed, 04 May 2022 14:04:17 +0200
In-Reply-To: <5a212284-063d-0b94-0186-cec415647e08@hauke-m.de>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
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
         <7c1fd2554ae907eded15dd247bbda5bc5c28cbe7.camel@sipsolutions.net>
         <64e20adf-b959-414f-8104-728ea8d23f76@www.fastmail.com>
         <5a212284-063d-0b94-0186-cec415647e08@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-04-04 at 01:19 +0200, Hauke Mehrtens wrote:
> 
> This does not work for me.
> We have to do this inside the kernel make call, when the kernel build 
> system calls backports again, we should have the needed information in 
> that call only.
> 
> The build works like this:
> 1. The normal make call to backports, KERNELRELEASE is not set and
>     Makefile forwards the call to Makefile.real.
> 2. This calls "Makefile.build modules" in the next step.
> 3. This calls the kernel build system with
>     "@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_DIR) modules"
> 4. This calls again Makefile, but now with KERNELRELEASE set.
> 5. This calls Makefile.kernel and uses the kernel build system to build
>     the backports code.
> 
> I tried adding a new rule to Makefile.kernel and then call it in 
> Makefile.build using the kernel build system, but it looks like it only 
> supports make targets supported by the kernel build system.
> 
> How do we make the kernel build system call our make target first?
> 

Maybe we don't need one?

subdir-ccflags-y += -DBACKPORT_KERNEL_SUBLEVEL=$(SUBLEVEL)

would pass it to each and every command line ... not nice, but maybe
works?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
