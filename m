Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E75DC433EF
	for <backports@archiver.kernel.org>; Mon, 11 Apr 2022 22:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350421AbiDKWEU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350381AbiDKWDh (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Apr 2022 18:03:37 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B551A381
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 15:01:01 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KcjV32YS5z9sSn;
        Tue, 12 Apr 2022 00:00:59 +0200 (CEST)
Message-ID: <14dd3d75-92d3-ed8c-edda-15d589dc8bbc@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649714457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2FZ2YbIOcE3liQt3w4s6Ns/BD7IySfQYHtQwX29UEA8=;
        b=Fu9iSp1Yi5+49nsSZ3Zg5U4u71cwvmC35dhjsZvAe7Fz4CeLZky7pFfcoJZxURBI7DqxqG
        +ngCBFhz1+Jmlp+Xrga/sVm+aPDnz03VgEkAxb4MAQsx14wVMMtxFbTSdp65vCtocyDi5e
        qrC7OIJ2Za898GbTDJveGNupCeVeYy0GV+BmlylVOCExOJC7P9yJsHR/kBR79FgABd5u+6
        El+UQjqBKhIeDtOA7hwLlkxhDuigLppIrhg8htCc9YAbhuiXl2CvipDU+AdMMCiWE/24om
        fdtTMG9M+i+ry8p8wu4ripQIDCp3kQUvQ7FkX44ehRU5YwB7vznfOR8C/mHprQ==
Date:   Tue, 12 Apr 2022 00:00:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/6] backports: Backport some ath11k runtime
 dependencies
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, mcgrof@kernel.org
Cc:     backports@vger.kernel.org
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/7/22 12:33, Jiaxun Yang wrote:
> Backport mhi bus driver and QRTR driver.
> ath11k requires them aligned with latest version at runtime.
> 
> Thanks.
> 
> v2: Make ath11k depend on 5.2 (hauke)
> 
> Jiaxun Yang (7):
>    headers: Add MHI stuff to mod_devicetable
>    backports: Add mhi bus driver
>    backports: backport {get,set}_user_ifreq
>    headers: backport sk_error_report
>    backports: Add QRTR driver
>    dependencies: Limit ATH11K to 5.2+
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
>   dependencies                                  |  9 ++++
>   12 files changed, 113 insertions(+), 1 deletion(-)
>   create mode 100644 backport/compat/backport-5.15.c
>   create mode 100644 backport/defconfigs/ath11k
> 

Thank you for your patches, I applied them to master with small changes.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
