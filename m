Return-path: <backports-owner@vger.kernel.org>
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:44496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933657AbeFMKac (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 13 Jun 2018 06:30:32 -0400
Date: Wed, 13 Jun 2018 05:30:27 -0500
From: Wan-Hua Chang <winnie.chang@cypress.com>
To: Aaron Komisar <aaron.komisar@tandemg.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "chi-hsien.lin@cypress.com" <chi-hsien.lin@cypress.com>
Subject: Re: [PATCH] Updating id field in backports genl family
Message-ID: <20180613103026.GC177225@aremote01.aus.cypress.com> (sfid-20180613_123035_109559_19718577)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1528719907.10346.0.camel@sipsolutions.net>
 <6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com>
 <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 12, 2018 at 12:10:36PM +0000, Aaron Komisar wrote:
> 
> On  6/12/2018 4:50, Chi-hsien Lin wrote:
> >On 06/11/2018 8:25, Johannes Berg wrote:
> >> On Mon, 2018-06-11 at 05:29 -0500, Wan-Hua Chang wrote:
> >>> Hi,
> >>>
> >>> I see the patch causes compiling error becasue family->family is not
> >>> found when LINUX_VERSION >= 3.13
> >>>
> >>> backports/backport/backport-include/genetlink.h
> >>> struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13
> >>>
> 
> I built backports-output for recent kernels (4.4.92, for example) and didn't get any compilation errors.
> Which version are you using?

I am using target kernel version 4.1.15. In this case, I can see
compiling error that family->family is not found.

> 
> >>>
> >>> And in backports/backport/compat/backport-3.13.c line 127
> >>>
> >>> family->id = family->family.id
> >>>
> >>> it looks like this line has done what the patch want to do. Is the
> >>> comprehension correct?
> 
> This line does update family id, but it gets **copy**->family.
> copy->family.id in backport-4.12.c is changed, but family->family.id remains unchanged.
> 
> >> 
> >> I guess we have to put an ifdef around this ...
> >> 
> >> Aaron?
> >
> >Hi Aaron,
> >
> >As Wan-Hua mentioned, it looks like backport-3.13.c line 127 syncs back 
> >the id for backport_genl_family structure for kernel < 3.13 already.
> >
> >Could you please share more details about the failure you saw without 
> >this change? What's the kernel version you used?
> >
> 
> I am using target kernel version 3.10.104.
> The problem I saw was that a driver using family id after calling genl_register_family would always get 0 instead of the actual value.
> 
> >
> >Regards,
> >Chi-hsien Lin
> >
> >> 
> >> johannes
> > .
> > 
> 
> Aaron
>     
--
To unsubscribe from this list: send the line "unsubscribe backports" in
