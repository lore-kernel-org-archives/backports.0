Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9977C433F5
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiBDV5A (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBDV47 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:56:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2346C061714
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q0HLJWUexcT+ZfOwcTb5judRL7lDOEysEOmHNKQeiKA=; b=vPE600dkrOXqEFnpIJD5YpWdXM
        OZGaLr2U6ZbS8OKQO1rERiy0pHENiAj7DpL2XdFGxp4eUUQFFmtg9yDSqgOwgFcaZi8PXzREAncqp
        WG02XiwbA0TRQT11282lf8RhABIf6V9qNb86dKaSEDHgILe9Oe/8U0+jUX3qXg75KeTo4mtR87cVd
        +mHbuHzcjNq/48tvWHUIYVAk7na+VwKsXPHKJeKqHUo6oVQMleKkey8jr/uG3VSc4hGGMkgKQG1cH
        ncdmRccAtzR759LCulszEL2wTI3W7FXySJdxtoBBuQzZUJ/Sb3p8DFiJtMg14pEaFncdDQXed1FuO
        6Ns1ic3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Zc-005VD4-JB; Fri, 04 Feb 2022 21:56:56 +0000
Date:   Fri, 4 Feb 2022 13:56:56 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     hauke@hauke-m.de, backports@vger.kernel.org, thomas@adapt-ip.com
Subject: Re: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
Message-ID: <Yf2hKANE9QSXHHiH@bombadil.infradead.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
 <20220204214131.1306843-5-mcgrof@kernel.org>
 <33b187cc471610599be0662e6d2050d3b26c98a2.camel@sipsolutions.net>
 <Yf2eRJmG80L9htvo@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf2eRJmG80L9htvo@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, Feb 04, 2022 at 01:44:36PM -0800, Luis Chamberlain wrote:
> On Fri, Feb 04, 2022 at 10:43:14PM +0100, Johannes Berg wrote:
> > On Fri, 2022-02-04 at 13:41 -0800, Luis Chamberlain wrote:
> > > 
> > > +add-kconfig-remote:
> > > +	git remote add kconfig https://github.com/mcgrof/kconfig.git
> > > 
> > 
> > Does this really make sense?
> > 
> > We could do what we do for a lot of other code, and just copy it from
> > the kernel while generating the backport. Why depend on another project?
> 
> Up to you, it took me 3-4 hours to figure out how to update without
> breaking things. Now I just do that work once and can benefit from
> the same effort *once*.

Look at it this way, you can apply this and then get upates in the
future by just using one command (and folks do the effort as a group)
or you can try to do the update now yourself and deal with the effort.

As it is right Thomas was waiting on some update on kconfig on
backports, so he can update the integration work. Which way do you
prefer to go?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
