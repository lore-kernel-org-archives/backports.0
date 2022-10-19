Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34EC433FE
	for <backports@archiver.kernel.org>; Wed, 19 Oct 2022 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiJSU6y (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiJSU6w (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 19 Oct 2022 16:58:52 -0400
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 13:58:48 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DAB1C810A
        for <backports@vger.kernel.org>; Wed, 19 Oct 2022 13:58:47 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Mt2xk44vDz9sZQ;
        Wed, 19 Oct 2022 22:53:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1666212794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqWD+9LUEFVyZ03k37fJ39Tno/15TChhim1R/LUbgHU=;
        b=yliobsL2tJ4RartXRIlQg4X2s7JeZ1C4uV0rGTO1DeXTUIG9Gqm7G/xGl+gLMD0rQ2APbo
        rYJp2OfD0V9juulnd4V16km/d8IklhDYuMcIZFsjbO5zaENOU7E6znmzB8mUYGmtHjkBCF
        k+SMbfbr2y9Eoduq3lA5w0kgToXod7Z+aLW4uJflAKPXxik+PUHwABkySAa4JqXneCHei3
        m6s1RnQ3z1w+D558DihIshJ8yH4q+WTNhLB6SZW2vXFjrnjcqxb/JCtmxb2P2aWbzF1E/d
        WbaWgK0H2tmwjJ9zPpVhdvBS8bJI/KGOMFrscPyfrBdAdctVglMrCGcp7onSlg==
Message-ID: <364548b0-8b4e-853a-27f4-38051097cb09@hauke-m.de>
Date:   Wed, 19 Oct 2022 22:53:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/38] backports updates
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     nbd@nbd.name
References: <20221011210446.144768-1-johannes@sipsolutions.net>
Content-Language: en-US
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Mt2xk44vDz9sZQ
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 10/11/22 23:04, Johannes Berg wrote:
> So Felix inspired me to take a look at this ...
> 
> This is pretty much not cleaned up, but it's what we have internally
> now for iwlwifi.
> 
> johannes
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in

Thank you for the patches.

Can I remove some of the tags from the commit messages you probably used 
internally form the patches before applying them or will you send 
cleaned up versions?

I would like to release a new version based on kernel 5.15 and 5.10 
first. This should fix the current security problems found in mac80211 
and cfg80211.

The following patches are looking like bugfixes to me, I would like to 
add them to the version based on kernel 5.15:
* backports: increase cfg80211 wiphy padding
* main: add module_exit()	
* backports: update skb kcov ifdef
* backports: don't backport some SKB functions for RHEL 7.6
* backports: use kernel verification only if CONFIG_CRYPTO_HASH_INFO

I will take these patches first.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
