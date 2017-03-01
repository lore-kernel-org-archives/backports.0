Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33879 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdCAJrr (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 1 Mar 2017 04:47:47 -0500
Received: by mail-qk0-f177.google.com with SMTP id s186so61238917qkb.1
        for <backports@vger.kernel.org>; Wed, 01 Mar 2017 01:47:41 -0800 (PST)
Subject: Re: [PATCH] backports: add definitions S32_MAX and S32_MIN
To: Johannes Berg <johannes@sipsolutions.net>
References: <1487801925-22641-1-git-send-email-arend.vanspriel@broadcom.com>
 <1487836149.18380.0.camel@sipsolutions.net>
 <c5eb014a-b922-f825-0319-af46d4864ab4@broadcom.com>
 <1487939443.2540.19.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <c62a3ff4-6203-fa1d-6bf4-515b93de2c74@broadcom.com> (sfid-20170301_105119_176723_F83F71E6)
Date: Wed, 1 Mar 2017 10:47:39 +0100
MIME-Version: 1.0
In-Reply-To: <1487939443.2540.19.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 24-2-2017 13:30, Johannes Berg wrote:
> 
>> I create a package nightly for our internal tree and wireless-testing
>> and build for couple of target kernels to run some wifi tests on
>> target systems. So I tend to hit issues pretty soon. Not covering all
>> target kernels though.
> 
> Ok, that's nice. I'm torn between doing something that runs on our
> existing infrastructure (easy, but internal) or building some kind of
> infrastructure, likely on the build box we have from the LF... that's
> harder but accessible to people other than me.
> 
> Or are there any alternatives? Perhaps if I put the scripts upstream
> then it doesn't matter that I might actually be running it on our
> internal infrastructure, since anyone can just take the scripts and run
> them?

The alternative is fine by me.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
