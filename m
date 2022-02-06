Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96052C433EF
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiBFXaR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 18:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbiBFXaR (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 18:30:17 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D5C06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 15:30:15 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JsQVX5xGpz9sR5;
        Mon,  7 Feb 2022 00:30:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1644190211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qEbjdtY7z8Zsd+ZrRZ4DRgxtHjOHCYWuU1pCXyKkwM0=;
        b=u7I4s/amwbueqRf8iYeYcqziIqh0GN+3uAZ56sDeKHnK3eN52G+6+MFrDjQ4Qurnug/hy+
        UElbRUY2WHhUR5UOw2QaRSUovnIqIiUq36VZ51snb/NDE3g3NiVYiAAS19Y5RXT9yRi2SW
        UUm19dJKn83pZGwAS3iLxRYihWIFPO1GVhiGCVR1I+v7n5cwP/KNwdntDVAwcsptSO6bzz
        dRT0QLeMOrukA9ceskeZd19iuyGSxq2vkQFoB/JuJaUGmQDZnVpQAOkdCqosctA3aLvXEs
        5NzCktQgZ9IcRyZu2JSmtW9oUAITuifzdIACy/+WQIaBtTUXzc+sHBl4yuuzqw==
Message-ID: <12bcca34-90ec-ca85-a95b-c067b35a47ae@hauke-m.de>
Date:   Mon, 7 Feb 2022 00:30:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] backports: Backport some ath11k runtime dependencies
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, mcgrof@kernel.org
Cc:     backports@vger.kernel.org
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/6/22 23:26, Jiaxun Yang wrote:
> Backport mhi bus driver and QRTR driver.
> ath11k requires them aligned with latest version at runtime.
> 
> Jiaxun Yang (6):
>    headers: Add MHI stuff to mod_devicetable
>    backports: Add mhi bus driver
>    backports: backport {get,set}_user_ifreq
>    headers: backport sk_error_report
>    backports: Add QRTR driver
>    defconfigs: Refresh for ath11k
> 
>   backport/Kconfig.sources                      |  2 +
>   backport/Makefile.kernel                      |  2 +
>   .../backport-include/linux/mod_devicetable.h  | 15 ++++++
>   backport/backport-include/linux/netdevice.h   |  5 ++
>   backport/backport-include/net/sock.h          |  8 ++++
>   backport/compat/Makefile                      |  1 +
>   backport/compat/backport-5.15.c               | 47 +++++++++++++++++++
>   backport/compat/backport-genetlink.c          |  2 +-
>   backport/defconfigs/ath11k                    | 14 ++++++
>   backport/defconfigs/wifi                      |  3 ++
>   copy-list                                     |  6 +++
>   dependencies                                  |  6 +++
>   12 files changed, 110 insertions(+), 1 deletion(-)
>   create mode 100644 backport/compat/backport-5.15.c
>   create mode 100644 backport/defconfigs/ath11k
> 

This looks good to me.

I think you have to add "ATH11K 5.2" too to the dependencies file. If 
this is not added Kconfig will try to activate QRTR on older kernel 
configurations too.

On which kernel versions did you runtime tested this? Did you use this 
with the PCIe or the AHB version of ath11k?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
