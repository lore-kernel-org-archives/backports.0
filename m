Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9054 "EHLO
	mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752714AbaDWMOf (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 08:14:35 -0400
Date: Wed, 23 Apr 2014 14:14:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: Stefan Assmann <sassmann@kpanic.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: cocci: multiple versions of function with different arguments
In-Reply-To: <1398254986.4173.8.camel@jlt4.sipsolutions.net>
Message-ID: <alpine.DEB.2.10.1404231412450.3422@hadrien> (sfid-20140423_141444_805698_7BB34D29)
References: <53579593.40306@kpanic.de>   (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net>  <5357A065.3020400@kpanic.de> <alpine.DEB.2.10.1404231405130.3422@hadrien> <1398254986.4173.8.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Wed, 23 Apr 2014, Johannes Berg wrote:

> On Wed, 2014-04-23 at 14:07 +0200, Julia Lawall wrote:
>
> > I think that the problem is that the SmPL parser doesn't really understand
> > about the ifdef.  So it sees one expression right after another one, which
> > it is not happy about.  It would be fine if there were semicolons after
> > the function call.  If you can move up to the statement level in each
> > possible case, that might be a solution, but it might be too awkward in
> > practice.  If the macro solution is feasible, that could be better.  Fewer
> > changes to the source code as well.
>
> Yeah I was confused about all this as well - turns out that he's not
> trying to do function calls but rather function declarations:
>
> #if ...
> static int foo(void *a, int b, char c)
> #else
> static int foo(void *a, char c)
> #endif
> {
>  ...
> }
>
> or such.
>
> I'm not sure how that would compile (it would require "b" being unused),
> but still.

I can think  about it, but it is pretty far from the vision of Coccinelle,
which is that the combination of context code and + code should be a valid
syntactic unit, and on the side that we don't think much about ifdefs.

But I will think about it, because I can see that it is not a solvable
problem with the current technology.

thanks,
julia
