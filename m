Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:4051 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751732AbbINTsu (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 14 Sep 2015 15:48:50 -0400
Date: Mon, 14 Sep 2015 21:48:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH v2] backports: add spatch to handle IFF_NO_QUEUE
In-Reply-To: <CAB=NE6W8d-OCAMmti1Q4cWMkToe9o6m4M-_Hpz=p0peh9g5ROQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1509142148440.2048@localhost6.localdomain6> (sfid-20150914_214852_448367_7E54A691)
References: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net> <CAB=NE6VMH6Ket9CRni2KMiTaAgStUGqDtUoZw4buF0R=9TH_Aw@mail.gmail.com> <1442219253.2075.4.camel@sipsolutions.net> <CAB=NE6W8d-OCAMmti1Q4cWMkToe9o6m4M-_Hpz=p0peh9g5ROQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Mon, 14 Sep 2015, Luis R. Rodriguez wrote:

> On Mon, Sep 14, 2015 at 1:27 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Mon, 2015-09-14 at 01:25 -0700, Luis R. Rodriguez wrote:
> >
> >> > ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
> >> > + E->priv_flags |= IFF_NO_QUEUE;
> >> > ++#else
> >> > ++E->tx_queue_len = 0;
> >> > ++#endif
> >>
> >> Interesting so although priv_flags may be a member name prevalent in
> >> *many* data structures the SmPL rule here is very specific about the
> >> use of IFF_NO_QUEUE as a flag, and since we know that is unique to one
> >> use case we take the liberty over using expression here. Replying just
> >> to annotate this practice and Cc Julia on her thoughts.
> >>
> >
> > Yeah I thought about this for a while - it doesn't even cover all cases
> > (there might be drivers that don't use |=, for example).
> >
> > However, for now this seemed sufficient since very few places in the
> > code actually use this.
> 
> Sure, I wonder we could use some early rule checks to catch some
> liberal assumptions we make for some of our rules in patches/, we
> would use that to report issues *prior* to patch application and we'd
> reject moving forward with generation if all these rule checks don't
> match. If we do this that would stop patch application / compilation
> testing proactively. Something as with the kernel's
> scripts/coccinelle/ 'make coccicheck' prior to running our patch
> application. This case seems a bit hard to cover for all cases that
> don't use the assignments as in your rule though I think... if its
> easy though it could be a good example to tackle.

I'm not sure to understand what you have in mind.  Could you be more
concrete?

julia



> 
> > That said, there are cases where E really needs to be an expression
> > since it's not just "dev->..." but something like "foo->dev->...".
> 
> Right figured.
> 
>  Luis
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
