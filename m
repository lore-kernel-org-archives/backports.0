Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34248C0032E
	for <backports@archiver.kernel.org>; Fri, 20 Oct 2023 20:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJTUHt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Oct 2023 16:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTUHs (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Oct 2023 16:07:48 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994CDD66
        for <backports@vger.kernel.org>; Fri, 20 Oct 2023 13:07:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e22f1937so724109b6e.1
        for <backports@vger.kernel.org>; Fri, 20 Oct 2023 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697832466; x=1698437266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VMg4+KtBxabjRcFgyIVwfgqv0WIZI2Zb3BqiW/3XvHA=;
        b=nRuvdqi5wMxgO93FtNYTtT+NrWsRI2Bfx/NVWl+u/tuDv9vTgInIay94kUGoZhO0km
         RwdrbaiKQIZafHQAr9zMA7CZTQNRsqJEN+cmxJdvofVX2b8aZygePLq/iBSYGDmBe1bC
         2/LYOloR9xKrK7bFk2js6fPl4FwHcJRZMKZ+tflNyld2ll1qdimUvKroyzxrGX6esX+g
         n5NsQ/4tF/Bp1HOO9SL8FAKpUddAk+gzC9qFhvesnbGjqW3axwHq8nN26q+SjTg5KBeu
         9cthVfvL+s4obBV+uWx+3lmOANQFMA9Leg9A4DsSAoE9rxUAGInFj53psKdEMtU6pBzG
         gqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832466; x=1698437266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMg4+KtBxabjRcFgyIVwfgqv0WIZI2Zb3BqiW/3XvHA=;
        b=P3gf/KjLwyZkSWGzSl7RFjinMRw2hzVKkGcETeqADK3fnLiH4VbkfUgRMUUDMSLa5N
         6L5QZY5SLltgHhxclRsZQhJ1UYfgUKsvmvbVUBlMi/dtBUjDOzjduYuGKlPw+5kzxyFT
         Pddhiimm6URszsc8ISaq1UUSXeNuWmeUKmaBCHQq+fRcc0prs56WP9/6YpEz4P4ho/To
         sO3OKp5OUsXtDNkfxobj6COj4Y9WAzQ5H3sCTlOot0NcJL71cYOonCESngROx3uQz0ly
         V/Fxwc3sTcNFAdWBwx0YGgRzdwLGC34T9z8PClUbYGn45gmRaZMpH0yCfNFLaX2XP+dP
         j3bQ==
X-Gm-Message-State: AOJu0YxK8QPQsol1fRVR6AKc/M2loifl4ZWuRsOge543CXFGhRiWgCIK
        /ejULPlQJkU6AhsYGVQUQ4MGk+kEGJ0=
X-Google-Smtp-Source: AGHT+IEIym8iNZT/FTAnf8HI1PXzCoBMURHCOGMAKPIOZomLDAFiIEhK+uIwp2mYg7w1gTve5h9Mnw==
X-Received: by 2002:a05:6808:1383:b0:3ae:5442:ed1b with SMTP id c3-20020a056808138300b003ae5442ed1bmr3169995oiw.43.1697832465763;
        Fri, 20 Oct 2023 13:07:45 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s26-20020a0568080b1a00b003ae3768ba4csm454376oij.58.2023.10.20.13.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:07:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
Date:   Fri, 20 Oct 2023 15:07:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Brian Witte <brianwitte@mailfence.com>, hauke@hauke-m.de,
        backports@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 10/20/23 02:34, Johannes Berg wrote:
> Can you explain what you're trying to achieve by that? And even, what is the 
> reason to have these out-of-tree versions of the drivers?

Johannes,

I will give you a slightly different explanation than given by Brian.

When HP or Lenovo issue a new laptop model, they always use the latest Realtek 
wifi device - the rtw89 wifi 6 models at the moment. The new computers are 
released with Windows, which does have a driver for these devices.

If the user wants to run Linux, it is likely to be an older Ubuntu version 
running a kernel issued before rtw89 became part of the kernel. As a result, the 
user has no wifi under Linux. As far as I can tell, the equivalent problem does 
not happen for Intel or Athlon wifi hardware.

I created the rtw89 GitHub repo, and rtw88 (wifi 5) repo before that to backport 
the wireless-next version of the drivers into something that will build and run 
on kernels 5.4 or newer. With a 'git clone' and 'make', a novice user can get 
working wifi.

Keep in mind that most of our users are not very sophisticated. They frequently 
do not install the kernel headers even though the README tells them explicitly 
what the error means, and what they need to do for several of the popular 
distros. In addition, they struggle with the concept that out-of-kernel drivers 
must be built for the running kernel. Most can handle 'git pull', 'make', and 
sudo make (sign) install', but not anything more complicated.

As Brian said, I have done the maintenance by copying the patches from 
wireless-next into the GitHub repo, and handling the API changes in a manual 
fashion with '#ifdef LINUX_VERSION_CODE  ...' blocks. This works for me, but 
unlike me, Brian is a programmer, and he wants to create a script whenever he 
sees anything repetitive.

As it is unlikely that I will be doing this much longer, I support whatever he 
needs to make him comfortable. Although the kernels found in newer releases of 
various distros will eventually support the drivers, Realtek is adding wifi 7 
features to the drivers. Once they release the new hardware, it will be a short 
time until it is part of new models of laptops.

I do not see where backports has any part of the solution to this problem. As I 
had difficulty in getting it configured the first time I used that project, I do 
not see that as part of the solution for rtw88/89, other than it could be used 
to suggest solutions for the API changes. My experience allows me to look at the 
wireless-next and mainline kernels and determine what changes are needed. I am 
not sure I could explain that well enough to teach Brian.

Finally, I applaud Brian's initiative toward this project and I am content in 
knowing that the code is in good hands.

Larry

--
To unsubscribe from this list: send the line "unsubscribe backports" in
