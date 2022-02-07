Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC5C35271
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 09:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiBGJ2j (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 04:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352737AbiBGJPo (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 04:15:44 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42985C0401C4
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 01:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4Te+2off93+tc53CIC+umo50eopVluTpxwvMNkWsvoY=;
        t=1644225340; x=1645434940; b=eCZ3Q5Txo2YopLWBn3bagqkgDEX0//wgHblxjCBM8j4ZbHK
        cVqvo/933T0aI3EaEVaggqXsX0Lqbof57L1G0YF/GezViVa7jKLhCzs4/PquzBPYcmzESFEFYZu7S
        e1OPpUHzdcLXLMm4vd3X9+3tSLAauJVxRQQu23PpOfpdAxFjk6DigpDjrAyB8HZT4DWj9KexcRkCr
        xXZUODyy8YK2hgBuo38C8KKc1MqXianAXJau/FvIa05fohQoTQKHG/brc/pO+geH8mgdxiu6ecmuR
        kwpCjndMhVtor0lutMt+E17CHLpv/wNuQBwVOslLLpPd8UXm9tFm/u3q49i8MshA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nH07V-00FZ3E-TH;
        Mon, 07 Feb 2022 10:15:37 +0100
Message-ID: <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon, 07 Feb 2022 10:15:36 +0100
In-Reply-To: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-02-07 at 01:19 +0000, Jiaxun Yang wrote:
> Hi backport forks,
> 
> I was trying to fix ckmake FAIL building against 4.9 for 4.9.297+.
> 
> I found that macro KERNEL_VERSION_IN_RANGE(4,9,297, 4,10,0) won't work
> because SUBLEVEL 297 had overflowed 4 bit (255) in KERNEL_VERSION.
> 
> How are we supposed to deal with such situation?
> 

Hm. I guess the only way would be to somehow make a Kconfig variable in
backports, that uses the Makefile settings? But env="SUBLEVEL" doesn't
work, so not sure, maybe some Makefile trickery to extract it and write
it to the config?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
