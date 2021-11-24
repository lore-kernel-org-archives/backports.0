Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8DC433EF
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351721AbhKXOpI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357260AbhKXOnN (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 09:43:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EA9C217E39
        for <backports@vger.kernel.org>; Wed, 24 Nov 2021 05:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNSoIC+gW/Ybe310/OKM5E8R9ZGZN8aLqfK99m4y9qE=; b=yx2Mg5hY/LMf6renOjb/y2zQfx
        z0dnkSz6XK+XIkyP0WR0/xY3q6GvHMKbW5d+eIddCLkm6kChZ2r4PFKpmnYGrZzuKMfpP9/3VvA2s
        0bpaGzgPCF01+n1KX2O9ola8LRXgIftgWsv+dvzD/KOFi7pX4NQh4it7bs/SbEi0Gd0eugxxqyqE7
        ulH0w1jD9QIE1Q8BOVV9qRXr67jkgcKuHB322YWDzC5YPfrqS/vqhkVlriPtQS1dtWYNY6pey5Hdb
        Suz9yYXJiuwpZvhiq9JD9ZCSUFI/ipAld3IrfcM5cFP3s5y5jZIMLAhZiKuOExIFxYMD97upaW03W
        wAJzJlrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpsmG-004xAu-Fu; Wed, 24 Nov 2021 13:57:36 +0000
Date:   Wed, 24 Nov 2021 05:57:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     backports <backports@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 0/7] Resurrect backports Integration Mode
Message-ID: <YZ5E0B+r0MylLwJw@bombadil.infradead.org>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Tue, Nov 23, 2021 at 09:54:58PM -0800, Thomas Pedersen wrote:
> The backports integration mode[0] seems to have suffered some bitrot and
> doesn't currently work. Integration mode can be convenient in certain
> use cases and build flows though, so this patch set tries to fixup the
> integration mode.
> 
> These changes were developed and tested for backporting a v5.10
> backports + linux branch to a v4.19 kernel. v5.15-rc6 backports + linux
> was successfully built against v4.19.
> 
> 0: https://backports.wiki.kernel.org/index.php/Documentation/integration

Good stuff, looks good, just one thing the $FOO --> $(FOO) thing,
does that assume/require a bump in kconfig used in backports, ie,
if not using integration does that still work? If so then cool,
otherwise an upgrade to kconfig would be needed, and if that is
going to be done, I have a better solution to bump kconfig soon.

I'll be making kconfig code stand alone tree soon which projects
which want to embrace it can use it as a git subtree (note this
is different and better than a git sub module). Then updates
can just be done with something like:

  make refresh-kconfig

And that would just get the latest kconfig and trigger a merge commit 
locally.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
