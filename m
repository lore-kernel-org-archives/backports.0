Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AEC433EF
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbiBDVok (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiBDVok (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:44:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE00C061714
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=op7/2TQAHMneKzE7NuCDSXAiM8yUFaytLXYLtzdvOxA=; b=gqjxpI/mHedzxUlrI0QFQXXTRu
        CED+SvffnF5ZcHSmys1RDsQKiD69gE/8Whr4FkxAwGH6N8thy1U3+KwnYs5BddZSG9com1cJTh/kL
        f7TWnFDyduqOszArduh3Z5qbIvngJuHzWBiufJ6ZokqPLOG2w56T1anT1NjPWQqS2z2PXEmfBXfP7
        83M6MDmz2Q7DX27Ldgwb7vSkZ8Jf0KfK14pqZC5TVXnV3mCmhxit3+PhnR+Ik2kTvwWqZxqqtmwqv
        KewUu/D3KIprY8/MIQ4az7DZYMMXUWXr5yU8lRm8Mlk5cSWMwQjUMKV4qdjV4zdEjfiMuncx6PiJM
        WfRr5QoA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Ng-005UK3-Oc; Fri, 04 Feb 2022 21:44:36 +0000
Date:   Fri, 4 Feb 2022 13:44:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     hauke@hauke-m.de, backports@vger.kernel.org, thomas@adapt-ip.com
Subject: Re: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
Message-ID: <Yf2eRJmG80L9htvo@bombadil.infradead.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
 <20220204214131.1306843-5-mcgrof@kernel.org>
 <33b187cc471610599be0662e6d2050d3b26c98a2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33b187cc471610599be0662e6d2050d3b26c98a2.camel@sipsolutions.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, Feb 04, 2022 at 10:43:14PM +0100, Johannes Berg wrote:
> On Fri, 2022-02-04 at 13:41 -0800, Luis Chamberlain wrote:
> > 
> > +add-kconfig-remote:
> > +	git remote add kconfig https://github.com/mcgrof/kconfig.git
> > 
> 
> Does this really make sense?
> 
> We could do what we do for a lot of other code, and just copy it from
> the kernel while generating the backport. Why depend on another project?

Up to you, it took me 3-4 hours to figure out how to update without
breaking things. Now I just do that work once and can benefit from
the same effort *once*.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
