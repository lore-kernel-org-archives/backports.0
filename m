Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08DEC433F5
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244560AbiBDV7Z (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbiBDV7Y (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:59:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB0C061714
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=00U04AE4R5jdCJfds7x9VbWqkJTFp5KjRVUSmbSqFj8=;
        t=1644011964; x=1645221564; b=DTcMsJwids0Y8gHlVBCxE0ALlobUBwdzAgO6QGoRbC0TNTH
        5MF5wb6dtUfNherYDSL5vxShs6yi5QhvWQ6QBurSFmL8eU17nQ5Pnp7XCex0oALBASlzS77hyP0vc
        z4QDO8tsx/AuuRmfdHRDpybzYhFogGN/Lkj7ZscoeAZS0qftv8G93t42ZL9mPP5G+7X1gxP3I3/bd
        0Axa0oE96k7OkopvxeTBCZC/JQC7LMZQwMJLv57Qo0ATLOpV5h8Tsvy5sy1eIEHveZDgdk9PKA7hI
        579eI5zFghKLrMcx0V8hLYDayE1yvT4mXxt6KiguTlwFK4dZS+MCz8zDPrR1Qzvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6bv-00EeFu-Ol;
        Fri, 04 Feb 2022 22:59:19 +0100
Message-ID: <10a126d4350ab9c06e0cd12630dc088a428c49ba.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hauke@hauke-m.de, backports@vger.kernel.org, thomas@adapt-ip.com
Date:   Fri, 04 Feb 2022 22:59:18 +0100
In-Reply-To: <Yf2hKANE9QSXHHiH@bombadil.infradead.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
         <20220204214131.1306843-5-mcgrof@kernel.org>
         <33b187cc471610599be0662e6d2050d3b26c98a2.camel@sipsolutions.net>
         <Yf2eRJmG80L9htvo@bombadil.infradead.org>
         <Yf2hKANE9QSXHHiH@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, 2022-02-04 at 13:56 -0800, Luis Chamberlain wrote:
> 
> Look at it this way, you can apply this and then get upates in the
> future by just using one command (and folks do the effort as a group)
> or you can try to do the update now yourself and deal with the effort.
> 

No no, I meant
 - remove the kconfig code
 - add a rule to copy the kconfig code from the kernel we're generating
   the backport from

That might not really be ideal since you'd end up using kconfig from a
newer kernel against an older kernel, but we have that either way, even
if we take your github tree?

> As it is right Thomas was waiting on some update on kconfig on
> backports, so he can update the integration work. Which way do you
> prefer to go?

That just needs patch 1, no? In integration I assume you don't use
backports's kconfig at all.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
