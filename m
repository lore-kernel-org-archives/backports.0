Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCA7C433E0
	for <backports@archiver.kernel.org>; Wed,  3 Feb 2021 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C566564F49
	for <backports@archiver.kernel.org>; Wed,  3 Feb 2021 00:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhBCA20 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Feb 2021 19:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBCA2Z (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Feb 2021 19:28:25 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152B3C061573
        for <backports@vger.kernel.org>; Tue,  2 Feb 2021 16:27:44 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4DVjFC0nnLzQlWG;
        Wed,  3 Feb 2021 01:27:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1612312061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMfNfChHnUZJAB/7CVasUdWmbW4ZaStw8K/H3yZDDcA=;
        b=aDqzy5uF+iIc0hyUWxZ8/chk+mQNohBzDTBRXCaVkRUvNMmnZssMkLV8S5HVBH0QyPOjZy
        e3f/dD6pGl2jkf+stSfr1hNjlNBT4NF3lH/A9hPf3ej3Rg9gAXOzsiz0cFZC0rjoaU0dUq
        /YLISZA9TXL8xCOurcsF6eJLMow4+nttihB2QgIfDXFrTe12iVRLOJ8MDVGr2jSXj2GfIV
        2lQI3XsO4dbt4jPIjbTw2GFApKf03q3hIoRdCgv+ecJSSDGHW++Ljdg4tuB7MLwa7OUKzF
        YjUn3M7tIK5y05EkTsyorZ7oLdVxl0WAhafNQ4eNWCE1jXp/EFPNnZv5s+LBAQ==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id c55chdv39Oid; Wed,  3 Feb 2021 01:27:40 +0100 (CET)
To:     Daze Urey <lunaticurey@gmail.com>, mcgrof@kernel.org
References: <CAMnQ4ijQcmNahFFg+OHDmfZKfM6bmMeGzdBRKo+ZDn6R5ehNfA@mail.gmail.com>
Cc:     "backports@vger.kernel.org" <backports@vger.kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] backports: fix timekeeping ktime_get_raw_ts64 compile
Message-ID: <50c2b560-45a8-041d-380c-a03d357e9048@hauke-m.de>
Date:   Wed, 3 Feb 2021 01:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAMnQ4ijQcmNahFFg+OHDmfZKfM6bmMeGzdBRKo+ZDn6R5ehNfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.28 / 15.00 / 15.00
X-Rspamd-Queue-Id: 535C817C4
X-Rspamd-UID: 224d9b
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/2/21 2:29 PM, Daze Urey wrote:
>  From 7c615a7077e37ca5fc3ba5ad7ebe41441521fcd5 Mon Sep 17 00:00:00 2001
> From: lunaticurey <125438787@qq.com <mailto:125438787@qq.com>>
> Date: Tue, 2 Feb 2021 21:23:53 +0800
> Subject: [PATCH] backports: fix timekeeping ktime_get_raw_ts64 in
>   kernel under 3.19 we should use struct timespec instead of timespec64 
> . this
>   can fix compile in linux 3.18 t Signed-off-by: lunaticurey 
> <125438787@qq.com <mailto:125438787@qq.com>>
> 
> Signed-off-by: lunaticurey <125438787@qq.com <mailto:125438787@qq.com>>

Hi,

It looks like this mail is white space damaged. I would suggest to use 
git send-email to send patches, this takes care that it is correctly send.

Please use your real name in the Signed-off-by line.

The change itself looks good to me.

Hauke


> ---
>   backport/backport-include/linux/timekeeping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backport/backport-include/linux/timekeeping.h 
> b/backport/backport-include/linux/timekeeping.h
> index 25ceaf3..fc2b75e 100644
> --- a/backport/backport-include/linux/timekeeping.h
> +++ b/backport/backport-include/linux/timekeeping.h
> @@ -88,7 +88,7 @@ static inline struct timespec64 
> timespec_to_timespec64(const struct timespec ts)
>   static inline void ktime_get_raw_ts64(struct timespec64 *ts)
>   {
>   #if LINUX_VERSION_IS_LESS(3,19,0)
> - struct timespec64 ts64;
> + struct timespec ts64;
> 
>    getrawmonotonic(&ts64);
>    *ts = timespec_to_timespec64(ts64);
> -- 
> 2.1.4
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
