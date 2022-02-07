Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D690C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 13:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiBGNdF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448115AbiBGNEZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 08:04:25 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2FEC0401C8
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=YZ4QLy39Vc5E/CiD5SRciMTNbeKe8eMa+DUs4cgqV9w=;
        t=1644239063; x=1645448663; b=oSSwT5JAmZ5F5ZfPaZqgo+czGtbL86R94MlwIM/IUKOUPUA
        +XYmw0kM48zX3dxCIG33QRndJVf9M5EaRX0W19/6ZR315TPEGJnjixUsf+Q6mD0qvfmW1APY6vPtL
        itwilwdHaBWry6brinyJ5uEwz3tAbaPofbujR2USuqlgXtR63KD0qDmw023feS+XJfVf0X7urrIRG
        nK2L54ydYwumGcGkYauVpQaeLj8i16jcBkozu19TQTfmNkB6pX0wQQ+N1g02VaT6ev85lnzjpS0fP
        0gf/ApNZP19RAB5VJbgGf2IIximllNEEYLqDsF9cZTeidP2OBD8A8Efd0QMWM32Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nH3gr-00Fd2C-Lq;
        Mon, 07 Feb 2022 14:04:21 +0100
Message-ID: <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon, 07 Feb 2022 14:04:20 +0100
In-Reply-To: <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
         <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
         <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
         <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
         <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
         <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-02-07 at 12:52 +0000, Jiaxun Yang wrote:
> 
> 在 2022/2/7 11:11, Johannes Berg 写道:
> > 
> > Looking at commit b29eec6c49, does it even matter? We can continue using
> > bug.h which includes build_bug.h, it's just pulling in more than needed.
> Sorry, in which tree?
> 

In 4.9.x.

Basically, we _cannot_ include build_bug.h where we know for sure it
does *not* exist, since that would be a compile error.

We don't _want_ to include bug.h from build_bug.h if we can avoid it,
since it's bigger and more stuff.

But for 4.9.x, I'm not sure we need to change anything, since we'll
include bug.h from build_bug.h which should continue to work?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
