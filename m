Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99512C433EF
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 22:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiBGWSb (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiBGWSb (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 17:18:31 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2FDC061355
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 14:18:30 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Jt0sG0Jccz9sT6;
        Mon,  7 Feb 2022 23:18:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1644272303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mrnk/vS3GM5hcQydQaMvzTkPAem02V2XQm7X9DQUJu0=;
        b=WoO7G+b0kX0Y/ElW09EudBF9U2ZaPNZ+uGWlR/8smE2jfXzKgJdHZHaVIZL1SwAaGLKIPN
        J5pa4IxG3M/Bh0O8TkXx1LPqzSHjSPwZDp0eZKEa2Th5VgeZ/2/YCHHeeQxEAdmfEI9mK7
        u/P5KGoRWuoxqQnyj8yt79NCOzbJPppUfeElX9YGy14mZiSRSHscnYq+rEW0DL8LR9PDL/
        xk8FSJBGQDderWrRp+oA2KsX2Wu0fJIlWemH81J1c27enUWwiy6Z1Txwu2a+JS3KG8tgKR
        54PiOG9yC4AAExewQZaMM23cfFFN782YNpG/gcIsMR8fvwsvYEmyVCcyA6r2Aw==
Message-ID: <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
Date:   Mon, 7 Feb 2022 23:18:21 +0100
MIME-Version: 1.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Dealing with SUBLEVEL overflow in backports
In-Reply-To: <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/7/22 14:57, Johannes Berg wrote:
> On Mon, 2022-02-07 at 13:40 +0000, Jiaxun Yang wrote:
>>
>> Sorry I didn't follow, the problem for 4.9.297+ is when we are including
>> bug.h, it just include build_bug.h from backport-include.
>> Then in backport-include build_bug.h, the include_next is excluded so
>> the real build_bug.h from kernel tree is never included and thus those
>> macros supposed to be in build_bug.h can never work.
>>
> 
> Ah! Now I understand. Hmm, don't think I have a solution off the top of
> my head ...
> 
> johannes

Hi,

The LINUX_VERSION_CODE is fixed since 4.9.255, see here:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=42efb098c75f9d4b95f7cf35d3d52e80cc2fde82

SUBLEVEL should still contains the minor kernel version number.

We could extend the macros in backport/backport-include/linux/version.h 
to check for SUBLEVEL manually if it overflows.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
