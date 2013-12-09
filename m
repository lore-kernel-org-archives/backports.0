Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33500 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933259Ab3LIV5a (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 16:57:30 -0500
Date: Mon, 9 Dec 2013 22:57:27 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Peter Senna <peter.senna@gmail.com>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [PATCH 1/3] backports: convert the 62-usb_driver_lpm patch series
 to SmPL
In-Reply-To: <CAB=NE6VHM3bSXb_3eeEOJ4QLQd3MKkABE=Ky1BdJLZqhjdmFxg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1312092252140.2041@localhost6.localdomain6> (sfid-20131209_225740_497376_87721DCA)
References: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com> <1386613665-11656-2-git-send-email-mcgrof@do-not-panic.com> <1386617105.5042.0.camel@jlt4.sipsolutions.net> <CAB=NE6VHM3bSXb_3eeEOJ4QLQd3MKkABE=Ky1BdJLZqhjdmFxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 9 Dec 2013, Luis R. Rodriguez wrote:

> On Mon, Dec 9, 2013 at 8:25 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Mon, 2013-12-09 at 19:27 +0100, Luis R. Rodriguez wrote:
> >
> >> +++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
> >> @@ -0,0 +1,9 @@
> >> +@@
> >> +identifier backport_driver;
> >> +@@
> >> +struct usb_driver backport_driver = {
> >
> > You don't need "..." here?
> 
> Not in this case, it works, adding it actually doesn't work right now as I wish.

Structure initializers are a little bit special.  The programmer can put 
them in any order and all of them are optional.  So in a semantic patch, 
you can put only the ones that are relevant to the patch, in any order 
that you want.  All of them have to appear, but others can appear as well.

The only time when you would want to put ... in this case is when you are 
adding a new field initializer (note that Luis's patch only adds 
decoration round an existing field initializer).  In that case, if you put 
..., before the added field initializer, the addition will be at the end, 
and if you put ..., after the field initializer, the addition will be at 
the beginning.

Note that this is completely different than the declaration of the 
structure type itself.  In that case, the fields are ordered, so ... is 
needed.

julia



> 
> >> ++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> >> +     .disable_hub_initiated_lpm = 1,
> >> ++#endif
> >> +...
> >> +};
> 
>   Luis
> 
