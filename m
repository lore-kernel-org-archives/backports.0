Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01903C433FE
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 14:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbiBGOHQ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390449AbiBGN5p (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 08:57:45 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9AC0401C8
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 05:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+EBsYnmJmL5vST+XhFLJM0xX36cF6IRZ/DFjvZwXgvg=;
        t=1644242264; x=1645451864; b=WAeMvUZzdRJFdLz1e4sK+LaK/EykHLbpqgCz8oznA1upkwp
        mVoIT+Bafo+jtL/+LvTrukDHdbZj3MVLbir9hmq3i8JWJvAu9/Uw90aa4eh4PHb4ThQhPj63PrYjh
        xvViI/84nLRDqWs7jIgys9I6rk3HMs3uusDDzu/60eALuJtnbSupQR1UHqgd99rQ8LrLCUeVjfyzB
        kq2C5c2dM904GRaApZHLyatit3Et10FR0dOARwUVsaNP0ioJ+1JO4Tx+iO4PCZXNovzqtIJifLz6m
        SfKOYnmx7lxmGaQb/4S7iR7uOyZbRhtRzr+rEaZenJqbk/01he3bECWJPboqiSkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nH4WU-00FdsW-LP;
        Mon, 07 Feb 2022 14:57:42 +0100
Message-ID: <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon, 07 Feb 2022 14:57:41 +0100
In-Reply-To: <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
         <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
         <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
         <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
         <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
         <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
         <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
         <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-02-07 at 13:40 +0000, Jiaxun Yang wrote:
> 
> Sorry I didn't follow, the problem for 4.9.297+ is when we are including
> bug.h, it just include build_bug.h from backport-include.
> Then in backport-include build_bug.h, the include_next is excluded so
> the real build_bug.h from kernel tree is never included and thus those
> macros supposed to be in build_bug.h can never work.
> 

Ah! Now I understand. Hmm, don't think I have a solution off the top of
my head ...

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
