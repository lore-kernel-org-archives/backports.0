Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ABAC433EF
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 22:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiBDWRR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 17:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348258AbiBDWRQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 17:17:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6365C4FAEF9
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 14:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KWlqvEWd2scnWhoh9hWmNinTXya6FZ/qNa9ouVJ0eQY=; b=18Qp+2qQcxk+OQF2Pi6JbU6n9g
        CpN3X8CHx3Pk14plccErlrRp159EfF1N3pnMmT0+z5DqRKp/5jDQ9OnOwdl3oMmZGL1KIagUmTFua
        i5W4MD04Y8OmrPFdcewtTg5OdwkQCtGSHkKqYCZUgMpV4MVcBE+y50GqrUFyq1CwjWRa5qp/61SR+
        ZG8x6ioxjHDPdgEjyWuU5wD+W8iNpwftKY3IgJBhEZANd0dFLgDMCqjIdoOBLoCTpcyzux4dSBsel
        eOzlG8ra5VeA570sOT6Xp50JhACDZEWHk1ME8+vMkHI4VuvDfBGJvi2FjuDM3vW6jYIgDjehvxsVM
        tgqEIbCA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6t7-005Xpb-R3; Fri, 04 Feb 2022 22:17:05 +0000
Date:   Fri, 4 Feb 2022 14:17:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     hauke@hauke-m.de, backports@vger.kernel.org, thomas@adapt-ip.com
Subject: Re: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
Message-ID: <Yf2l4ephui5WtT2R@bombadil.infradead.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
 <20220204214131.1306843-5-mcgrof@kernel.org>
 <33b187cc471610599be0662e6d2050d3b26c98a2.camel@sipsolutions.net>
 <Yf2eRJmG80L9htvo@bombadil.infradead.org>
 <Yf2hKANE9QSXHHiH@bombadil.infradead.org>
 <10a126d4350ab9c06e0cd12630dc088a428c49ba.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10a126d4350ab9c06e0cd12630dc088a428c49ba.camel@sipsolutions.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, Feb 04, 2022 at 10:59:18PM +0100, Johannes Berg wrote:
> On Fri, 2022-02-04 at 13:56 -0800, Luis Chamberlain wrote:
> > 
> > Look at it this way, you can apply this and then get upates in the
> > future by just using one command (and folks do the effort as a group)
> > or you can try to do the update now yourself and deal with the effort.
> > 
> 
> No no, I meant
>  - remove the kconfig code
>  - add a rule to copy the kconfig code from the kernel we're generating
>    the backport from
> 
> That might not really be ideal since you'd end up using kconfig from a
> newer kernel against an older kernel,

Yes.

> but we have that either way, even
> if we take your github tree?

Indeed.

> > As it is right Thomas was waiting on some update on kconfig on
> > backports, so he can update the integration work. Which way do you
> > prefer to go?
> 
> That just needs patch 1, no?

Um, it requires updating kconfig to work with some newer stuff.
So no, I think it requires picking either updating kconfig manually or
using this git subtree.

> In integration I assume you don't use
> backports's kconfig at all.

It does, it uses the kernel target's kconfig.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
