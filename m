Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:41632
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751171AbeFZGH3 (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 26 Jun 2018 02:07:29 -0400
Date: Tue, 26 Jun 2018 01:07:18 -0500
From: Wan-Hua Chang <winnie.chang@cypress.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Chi-Hsien.Lin@cypress.com,
        Aaron Komisar <aaron.komisar@tandemg.com>
Subject: Re: [PATCH] Updating id field in backports genl family
Message-ID: <20180626060717.GA33209@aremote01.aus.cypress.com> (sfid-20180626_080735_428822_F28450E6)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1529944813.10347.3.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529944813.10347.3.camel@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jun 25, 2018 at 06:40:13PM +0200, Johannes Berg wrote:
> Looking at this again ...
> 
> > I see the patch causes compiling error becasue family->family is not
> > found when LINUX_VERSION >= 3.13
> 
> Yeah, that seems right.
> 
> > backports/backport/backport-include/genetlink.h
> > struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13
> > 
> > 
> > And in backports/backport/compat/backport-3.13.c line 127 
> > 
> > family->id = family->family.id
> > 
> > it looks like this line has done what the patch want to do. Is the
> > comprehension correct?
> 
> I don't think so. We call this function - via
> __real_bp_extack_genl_register_family() - on copy->family, so we do need
> to copy like Aaron said, we just need to make it conditional for kernel
> < 3.13 because on 3.13 we don't use this sub-family thing.
> 
> I've committed a fix - does that work for both of you? Aaron?
Hi Johannes, 
Yes, the fix works for me, thanks.

> 
> johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
