Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:11431 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751670AbbINTP7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 14 Sep 2015 15:15:59 -0400
Date: Mon, 14 Sep 2015 21:15:57 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH v2] backports: add spatch to handle IFF_NO_QUEUE
In-Reply-To: <1442219253.2075.4.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.02.1509142115530.2048@localhost6.localdomain6> (sfid-20150914_211601_439956_4412DCFC)
References: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net>  <CAB=NE6VMH6Ket9CRni2KMiTaAgStUGqDtUoZw4buF0R=9TH_Aw@mail.gmail.com>  (sfid-20150914_102534_238057_71CA5FF2) <1442219253.2075.4.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Mon, 14 Sep 2015, Johannes Berg wrote:

> On Mon, 2015-09-14 at 01:25 -0700, Luis R. Rodriguez wrote:
> 
> > > ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
> > > + E->priv_flags |= IFF_NO_QUEUE;
> > > ++#else
> > > ++E->tx_queue_len = 0;
> > > ++#endif
> > 
> > Interesting so although priv_flags may be a member name prevalent in
> > *many* data structures the SmPL rule here is very specific about the
> > use of IFF_NO_QUEUE as a flag, and since we know that is unique to one
> > use case we take the liberty over using expression here. Replying just
> > to annotate this practice and Cc Julia on her thoughts.

I'm OK with the above reasoning for using expression.  If you don't use 
expression, you need to be sure that adequate type information is 
available.  So if the context is unambiguous for some reason, then 
expression is better.

julia

> > 
> 
> Yeah I thought about this for a while - it doesn't even cover all cases
> (there might be drivers that don't use |=, for example).
> 
> However, for now this seemed sufficient since very few places in the
> code actually use this.
> 
> That said, there are cases where E really needs to be an expression
> since it's not just "dev->..." but something like "foo->dev->...".
> 
> johannes
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
