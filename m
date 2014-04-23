Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52685
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343AbaDWMHm (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 08:07:42 -0400
Date: Wed, 23 Apr 2014 14:07:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Stefan Assmann <sassmann@kpanic.de>
cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: cocci: multiple versions of function with different arguments
In-Reply-To: <5357A065.3020400@kpanic.de>
Message-ID: <alpine.DEB.2.10.1404231405130.3422@hadrien> (sfid-20140423_140748_749416_524DE8DC)
References: <53579593.40306@kpanic.de>  (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net> <5357A065.3020400@kpanic.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Wed, 23 Apr 2014, Stefan Assmann wrote:

> On 23.04.2014 12:41, Johannes Berg wrote:
> > On Wed, 2014-04-23 at 12:27 +0200, Stefan Assmann wrote:
> >
> >> I'm trying to generate a patch to define a function with different
> >> arguments depending on the kernel version. I'm having some difficulties,
> >> maybe you can tell me what's wrong with the following approach.
> >
> > I can't answer that, but given the premise
> >
> >> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
> >>         vlan_rx_add_vid_func(a, b, c)
> >> +#else
> >> +       vlan_rx_add_vid_func(a, c)
> >> +#endif
> >
> > and the fact that later kernel versions add an argument, wouldn't it be
> > much easier to provide a macro in the appropriate header file:
> >
> > #define vlan_rx_add_vid_func(a,b,c) vlan_rx_add_vid_func(a,c)
> >
> > johannes
> >
>
> That's one way to handle it but I'm sure there will be other cases where
> we might use coccinelle similarly, where a define might be tricky.
> Luis asked me to do some cleanup on igb, so I'm exploring ways to make
> it easier for other network drivers as well.
>
> If for some reason cocci should have a problem with this the fallback
> to a define is a good idea.
>
> Thanks Johannes!

I think that the problem is that the SmPL parser doesn't really understand
about the ifdef.  So it sees one expression right after another one, which
it is not happy about.  It would be fine if there were semicolons after
the function call.  If you can move up to the statement level in each
possible case, that might be a solution, but it might be too awkward in
practice.  If the macro solution is feasible, that could be better.  Fewer
changes to the source code as well.

julia
