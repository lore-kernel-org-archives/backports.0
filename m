Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4C2C07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396F4613C9
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGET3f (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhGET3e (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 15:29:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE15C061574
        for <backports@vger.kernel.org>; Mon,  5 Jul 2021 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ax3xrVjsEYcoiu4k+lyiYu64n4d21gsPjSQAotgONX0=;
        t=1625513217; x=1626722817; b=fAGyOdtnQicectnwCZKPwYF4mWcmY9B0gkDfLvdUt1K1F8p
        VZuxOrR5tkSFZDF6E57PVscLWnnFQ0+v9JUBxnIR0aOW0t32/x12nPHyhKIlvWg1i/dL/tpA4vxdU
        nKPwhzJvITkCVJnr6MQIFpDG17y7l0HirhqBIp6TvSFFGJEfcSk0wYNUl7TtOuK02zL5pahT1suzu
        XwMPUkz+1japzSXJ/2Xso4ycIWJfoMggBimfqed4WCe2I9mnOO+dSZsCCd6yO4pI8fc032YZbVQ1F
        9HUsffWVVsxJzEnBeGhQLfPjKLbxNHK+ZBN+58JqZx3HQkCEtGbYUa0oxSefmpAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m0UF1-00Fv6x-TN; Mon, 05 Jul 2021 21:26:51 +0200
Message-ID: <9ace0ebe7417d5ade9f5f1df02e46ad982c11c5e.camel@sipsolutions.net>
Subject: Re: backports spatch question
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
Date:   Mon, 05 Jul 2021 21:26:51 +0200
In-Reply-To: <d772161b-673c-cb57-ca18-ce994fd1b28e@candelatech.com>
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
         <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
         <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
         <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
         <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
         <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
         <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
         <05c73f83ce63bc1e15c40836fce56dcdb7eb9a8b.camel@sipsolutions.net>
         <f00e3ea0-97e4-4f47-b8d1-fd667668754b@candelatech.com>
         <33deca8741a231072f2a835ccf7a93eac1430e9d.camel@sipsolutions.net>
         <d772161b-673c-cb57-ca18-ce994fd1b28e@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2021-07-05 at 12:26 -0700, Ben Greear wrote:
> On 7/5/21 12:19 PM, Johannes Berg wrote:
> > On Mon, 2021-07-05 at 12:17 -0700, Ben Greear wrote:
> > > 
> > > Did you test it?
> > > 
> > 
> > Yes, pretty sure we do it basically all the time. We don't have kernels
> > that new yet in most of our test setups.
> > 
> > >    Because that should be logically identical to what I tried if I read this file properly:
> > 
> > Actually, your version might be more correct than ours ...
> > 
> > I dunno. I note we also have an <linux/rfkill.h> include in cfg80211.h,
> > but that should be there upstream too, so not sure.
> 
> There are a lot of rfkill.h files, what logic makes the backports code include the specific
> backport/backport-include/linux/rfkill.h file?  I suspect that isn't working for the cfg80211.h
> file for whatever reason.

It's just an additional -I flag on the compiler command line, or -
isystem or something like that.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
