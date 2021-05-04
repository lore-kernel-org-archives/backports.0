Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E288C433B4
	for <backports@archiver.kernel.org>; Tue,  4 May 2021 21:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AC9613CD
	for <backports@archiver.kernel.org>; Tue,  4 May 2021 21:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhEDVg0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 4 May 2021 17:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhEDVgZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 4 May 2021 17:36:25 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A923CC061574
        for <backports@vger.kernel.org>; Tue,  4 May 2021 14:35:29 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4FZY6Q5zPqzQk1f;
        Tue,  4 May 2021 23:35:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1620164124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GznHQBXIvo0mbBNLdhcDsICsYZlCCc4dlSmE6oJy/1o=;
        b=WhK6qAlJjDJ/gSzYa+ylAgYCgewZDnLoIyDynqIBue578J9DaIMK3qjlC1oP+3o8YpLfyk
        HtFJjnMIuv1THYDDvbIUxh2IrNmJUCUm/SkQ1O4XZWeBO3rgbthCIO8iNbyD3oooPu7ql7
        IjtsfScdGSBzlWQyT8TI7rSG9UOXzVMJeRyqTqQs7cD3GmeFZgNuKHttIFXzcGKZbkzcPQ
        8UrmU0ox1oIjP5I4BE76ZOnQtZQKYMuesA6JQsEvQmXYidI2cjo6ILYb17bWI19zb1ImvG
        DbnB9sRoVw1WnEL1frYWvtpDY7XTCCdCSYrle/vHCSvAoCVJBWYe3cqQTxDdmQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 8e06wX8LUHRB; Tue,  4 May 2021 23:35:23 +0200 (CEST)
Subject: Re: [PATCH] backport: remove wext warning
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20210416115633.252b99aac931.I7a66b0233a0b6972378bb20b8d1a70b7360af932@changeid>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <7fa57d2e-cde4-f290-159c-475c9b9931cf@hauke-m.de>
Date:   Tue, 4 May 2021 23:35:22 +0200
MIME-Version: 1.0
In-Reply-To: <20210416115633.252b99aac931.I7a66b0233a0b6972378bb20b8d1a70b7360af932@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.18 / 15.00 / 15.00
X-Rspamd-Queue-Id: CBEB917CF
X-Rspamd-UID: 3a471d
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 4/16/21 11:56 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> wireless extensions are being used less, so remove the
> warning about them not working - most people probably
> won't ever see any failures, and even if not see the
> warning.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---

Thank you, I fixed it and applied. The offset in the patch was not changed.

>   .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
> index 18b50f12601b..6397a04e1e40 100644
> --- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
> +++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
> @@ -18,11 +18,6 @@
>   +#ifdef CONFIG_WIRELESS_EXT
>   +	if (!wdev->netdev->wireless_handlers)
>   +		wdev->netdev->wireless_handlers = &cfg80211_wext_handler;
> -+#else
> -+	printk_once(KERN_WARNING "cfg80211: wext will not work because "
> -+		    "kernel was compiled with CONFIG_WIRELESS_EXT=n. "
> -+		    "Tools using wext interface, like iwconfig will "
> -+		    "not work.\n");
>   +#endif
>    	wdev->wext.default_key = -1;
>    	wdev->wext.default_mgmt_key = -1;
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
