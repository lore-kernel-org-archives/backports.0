Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6989CC43219
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 11:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356758AbiBGL2P (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352462AbiBGLL4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:11:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2DC043188
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ioqJutIRPJP2Qkiv6iXiqhJCNfTUoaZFXThX9xWmkbo=;
        t=1644232315; x=1645441915; b=r/PdjaTSyS2gD+M3LITYfxj4iiO8A7RQZsbE8sqDKKxC+b1
        dh0R+bDqV8nbZecy5HFl/mU60BMk6++QJTOoZHbsEmBqWp7B1vLqvfXrYZa0L4j8xUR+PJCTsU6v6
        XZ+pMqSGNmDLU/w3sGBmL6V0LjaFU7iQOSMqEutJJrVLUEP8yVuRJFyIUetS6jhS98U+2IqEUEPhw
        jeZJUNWiuH3lPrSRsJitIQrN3tAGRkdVOeirxVvDQj4Wx6UheHoFyn/U4NoROTc5rYFJ8XQcsyUh7
        DHapnrYJHaUne2Z9pryBqbLimN9lPKK2n4SAN15LsHDiE134dcUZF2DUqdzo7TOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nH1w1-00Fb8T-OL;
        Mon, 07 Feb 2022 12:11:53 +0100
Message-ID: <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon, 07 Feb 2022 12:11:52 +0100
In-Reply-To: <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
         <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
         <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
         <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-02-07 at 11:09 +0000, Jiaxun Yang wrote:
> 
> 在 2022/2/7 10:50, Johannes Berg 写道:
> > On Mon, 2022-02-07 at 10:15 +0100, Johannes Berg wrote:
> > > On Mon, 2022-02-07 at 01:19 +0000, Jiaxun Yang wrote:
> > > > Hi backport forks,
> > > > 
> > > > I was trying to fix ckmake FAIL building against 4.9 for 4.9.297+.
> > > > 
> > > > I found that macro KERNEL_VERSION_IN_RANGE(4,9,297, 4,10,0) won't work
> > > > because SUBLEVEL 297 had overflowed 4 bit (255) in KERNEL_VERSION.
> > > > 
> > > > How are we supposed to deal with such situation?
> > > > 
> > > Hm. I guess the only way would be to somehow make a Kconfig variable in
> > > backports, that uses the Makefile settings? But env="SUBLEVEL" doesn't
> > > work, so not sure, maybe some Makefile trickery to extract it and write
> > > it to the config?

> Or is it possible to persuade stable forks to define LINUX_VERSION_SUBLEVEL
> on existing stable releases?

Probably not.

> > > 
> > Or just find a way to handle the specific area? Is this for the
> > build_bug.h stuff?

> Yes, any idea?
> 

Looking at commit b29eec6c49, does it even matter? We can continue using
bug.h which includes build_bug.h, it's just pulling in more than needed.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
