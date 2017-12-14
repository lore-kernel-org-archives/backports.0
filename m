Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:63778 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753289AbdLNPQq (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 14 Dec 2017 10:16:46 -0500
Date: Thu, 14 Dec 2017 16:16:42 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Remington Furman <remicles2@gmail.com>
cc: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org, cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <e589e785-6e08-8b37-8017-09ffc8627de2@gmail.com>
Message-ID: <alpine.DEB.2.20.1712141614460.5502@hadrien> (sfid-20171214_161712_631945_42C8D7E7)
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com> <1512116859.25588.4.camel@sipsolutions.net> <alpine.DEB.2.20.1712011015160.2865@hadrien> <1512120542.25588.7.camel@sipsolutions.net> <alpine.DEB.2.20.1712011059360.2865@hadrien>
 <e589e785-6e08-8b37-8017-09ffc8627de2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1417705839-1513264602=:5502"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1417705839-1513264602=:5502
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 12 Dec 2017, Remington Furman wrote:

> On 12/01/2017 02:00 AM, Julia Lawall wrote:
> > On Fri, 1 Dec 2017, Johannes Berg wrote:
> > > Hi Julia,
> > >
> > > On Fri, 2017-12-01 at 10:18 +0100, Julia Lawall wrote:
> > > > The handling of attributes has also been extended so that you can
> > > > actually
> > > > match against them in some cases, such as on function declarations.  On
> > > > the oher hand, nothing was done to allow attributes in front of types
> > > > that
> > > > are alone.
> > > Very cool!
> > > > I can try to fix this.  In the short term, perhaps using 1.0.4 is
> > > > acceptable.
> > > To me that's OK, I'll try to keep it in mind.
> > >
> > > Can we do some "#ifdef" type syntax in spatch on the version of it? :-)
> > There's nothing for that available at the moment.
> > > I guess I could also have two different versions of the patch and write
> > > some code to pick up which one to use, but that's a bit awkward ...
> > >
> > > But let me know if you can't actually fix this (easily), then I can do
> > > that instead.
> > OK, I'll try to look at it soon.
> >
> > julia
> I thought I'd point out the layers of coevolution that result from the
> changing spatch behavior.  :) It's a bit fractal when every layer in the
> dependency graph has the possibility to change.  I suppose a #ifdef type
> solution might remove the potential need to backport the .cocci patches
> themselves going forward.
>
> But, I think it might be sufficient to just document what version of the
> tools, in this case spatch, were used for a particular backports
> commit/release.  It's easy enough to build any version of spatch from git.  Or
> perhaps each .cocci patch could have a comment listing the spatch version it
> was developed with.  Future backports releases could then update the patch
> syntax as needed, document the spatch version, and leave it at that.

Hello,

I updated the github version of Coccinelle such that
patches/0027-genl-const/genl-const.cocci
will almost parse correctly.  The only thing that remains is to change
attribute into attribute name.

julia
--8323329-1417705839-1513264602=:5502--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
