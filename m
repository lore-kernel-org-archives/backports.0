Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BAAC433EF
	for <backports@archiver.kernel.org>; Sun, 28 Nov 2021 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbhK1V6B (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 28 Nov 2021 16:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhK1V4B (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 28 Nov 2021 16:56:01 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0170C061746
        for <backports@vger.kernel.org>; Sun, 28 Nov 2021 13:52:44 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4J2MfL34NQzQk21;
        Sun, 28 Nov 2021 22:52:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1638136360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oU8k6pbixw9BTQD5GGs9oBGN19H/V0i75QsX+m7GjtA=;
        b=j/SeUuKhFOp1cMyl46fn2PkhEHRg1hYJGGLTEs1d9SQz2QN3zFYzwoDb7RZA0KlOfxdnq/
        VpvKo7WSj47LOHTFszXlKzA+Q7T55a7wSjude7YRN84zq3MkaozADUClzWVAxIWtZoFaaw
        2z6MHDIXGhBAnRg6HGHMqmlaf9G5Fjx9btbdhvTThSWoLZIv12FwZReA0z94RRnXf0lUFG
        hGn2XgYrB30mTmb9bnC1vGPVVSCtBLfTp27w4SN43OKJd/5Lh/UCoPNWa8hFQr20sS9ow/
        7//ZO0TfCpwYHai13T29fr0jULa+vc17V1AXfnpwWx9i78BVraYsUJQo3QCuLQ==
Subject: Re: [PATCH 0/7] Resurrect backports Integration Mode
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        backports <backports@vger.kernel.org>
Cc:     Luis Rodriguez <mcgrof@kernel.org>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1f3c9b00-0d84-7663-5264-b4146cfe38d1@hauke-m.de>
Date:   Sun, 28 Nov 2021 22:52:33 +0100
MIME-Version: 1.0
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 11/24/21 6:54 AM, Thomas Pedersen wrote:
> The backports integration mode[0] seems to have suffered some bitrot and
> doesn't currently work. Integration mode can be convenient in certain
> use cases and build flows though, so this patch set tries to fixup the
> integration mode.
> 
> These changes were developed and tested for backporting a v5.10
> backports + linux branch to a v4.19 kernel. v5.15-rc6 backports + linux
> was successfully built against v4.19.
> 
> 0: https://backports.wiki.kernel.org/index.php/Documentation/integration

Thank you for your work. I didn't use this feature and you are right it 
did bit rot.

Hauke

> 
> Thomas Pedersen (7):
>    backport: refresh integration patch
>    backport: resurrect integrations
>    gentree: try to make patch operation idempotent in case of --clean
>    gentree: do not prefix Kernel.local symbols
>    lib/bpversion: calculate Kconfig.versions for next major version
>    backport: expose BP_MODULES in package mode only
>    kconfig: fix select conversion for BPAUTO_ symbols in integration mode
> 
>   backport/Kconfig.integrate                    | 11 ++--
>   backport/Kconfig.package                      | 10 +--
>   backport/Kconfig.package.hacks                |  9 +++
>   backport/Kconfig.sources                      | 18 +++---
>   backport/compat/Kconfig                       |  9 ---
>   gentree.py                                    | 62 +++++++++++++------
>   .../0001-enable-backports-built-in.patch      | 34 +++++-----
>   lib/bpversion.py                              | 11 +++-
>   lib/kconfig.py                                |  5 +-
>   9 files changed, 96 insertions(+), 73 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
