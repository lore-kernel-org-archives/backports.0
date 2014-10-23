Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44867 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752181AbaJWUvq (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 Oct 2014 16:51:46 -0400
Date: Thu, 23 Oct 2014 13:51:40 -0700 (PDT)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Hauke Mehrtens <hauke@hauke-m.de>
cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Tag to help count manual patch fixes
In-Reply-To: <54496879.3030406@hauke-m.de>
Message-ID: <alpine.DEB.2.10.1410231351220.2833@hadrien> (sfid-20141023_225153_368878_703B61D2)
References: <CAB=NE6V=-Ef08L+7fA66a3DdZUa-WYUKBnhiuHE0bWH2VhDPbA@mail.gmail.com> <54496879.3030406@hauke-m.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 23 Oct 2014, Hauke Mehrtens wrote:

> On 10/23/2014 10:26 PM, Luis R. Rodriguez wrote:
> > I propose we we a tag to help count the amount of times we actually
> > have to do work in between release to fix patch manually. Not sure
> > what to use though, any ideas?
> >
> > Manually-fixed ?
> >
> > The use case? Well it would help us let keep count for starters and
> > see if things increase / decrease over time. This can also be used I
> > suppose by some tool to extract these patches and perhaps in the
> > future see if there's way to address these sorts of patches
> > automatically somehow.
> >
> > Are the possible gains worth it?
> >
> >   Luis
>
> From my experience making the patches apply isn't a big problem any
> more. All the patches that broke often in the early days are now using
> coccinelle or are removed because they were only needed for the older
> kernel versions.

This is a really nice comment :)

julia

> For the last releases I needed most of the time for backporting new some
> functions which are newly used and for understanding why some stuff
> breaks with some older kernels.
>
> Hauke
>
