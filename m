Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA8C4332F
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 10:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiBGK4D (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 05:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347158AbiBGKuX (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 05:50:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA870C043189
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 02:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wPSlt8gMsSEkJpY0buJWOvSMe631gIfhajDZxUS9d64=;
        t=1644231022; x=1645440622; b=OSUvvT11QvSRkccH5GlkEdYfXTpwWFeaY6jFnebGWW4uv1I
        GSv2z4azrKBNUlBtby23uo/Kz595APfHrXb74j5+YLPHqTv//nmJv15rNhBQ8R1yD+jlTvsgGmGjg
        GIDXVaPD7B2IymDyzFu+0aUV3mHPu9XS2JCQNQ5ki/5TzOKZQrppaeNlj0VntXVkjWwQJOM2lVPFI
        G5JwMiaZjKM+qy1SSe3FmHSqPqYU2N0EvqB1x/Do2BSfpMFlAL57OTK+GK9jbC/ZFzekoVqUh8oK6
        htMiXgiGGUvJLR9n1uHtJvKXfCJjmQKPJjMFAompSqPiZF2GG00nTGdf0mjP7FxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nH1bA-00Fajc-Ha;
        Mon, 07 Feb 2022 11:50:20 +0100
Message-ID: <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Date:   Mon, 07 Feb 2022 11:50:19 +0100
In-Reply-To: <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
         <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-02-07 at 10:15 +0100, Johannes Berg wrote:
> On Mon, 2022-02-07 at 01:19 +0000, Jiaxun Yang wrote:
> > Hi backport forks,
> > 
> > I was trying to fix ckmake FAIL building against 4.9 for 4.9.297+.
> > 
> > I found that macro KERNEL_VERSION_IN_RANGE(4,9,297, 4,10,0) won't work
> > because SUBLEVEL 297 had overflowed 4 bit (255) in KERNEL_VERSION.
> > 
> > How are we supposed to deal with such situation?
> > 
> 
> Hm. I guess the only way would be to somehow make a Kconfig variable in
> backports, that uses the Makefile settings? But env="SUBLEVEL" doesn't
> work, so not sure, maybe some Makefile trickery to extract it and write
> it to the config?
> 

Or just find a way to handle the specific area? Is this for the
build_bug.h stuff?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
