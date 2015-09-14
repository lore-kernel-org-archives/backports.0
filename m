Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55097 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbbINI1g (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 04:27:36 -0400
Message-ID: <1442219253.2075.4.camel@sipsolutions.net> (sfid-20150914_102738_281757_5653902C)
Subject: Re: [PATCH v2] backports: add spatch to handle IFF_NO_QUEUE
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Date: Mon, 14 Sep 2015 10:27:33 +0200
In-Reply-To: <CAB=NE6VMH6Ket9CRni2KMiTaAgStUGqDtUoZw4buF0R=9TH_Aw@mail.gmail.com> (sfid-20150914_102534_238057_71CA5FF2)
References: <1441790875-8496-1-git-send-email-johannes@sipsolutions.net>
	 <CAB=NE6VMH6Ket9CRni2KMiTaAgStUGqDtUoZw4buF0R=9TH_Aw@mail.gmail.com>
	 (sfid-20150914_102534_238057_71CA5FF2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-09-14 at 01:25 -0700, Luis R. Rodriguez wrote:

> > ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
> > + E->priv_flags |= IFF_NO_QUEUE;
> > ++#else
> > ++E->tx_queue_len = 0;
> > ++#endif
> 
> Interesting so although priv_flags may be a member name prevalent in
> *many* data structures the SmPL rule here is very specific about the
> use of IFF_NO_QUEUE as a flag, and since we know that is unique to one
> use case we take the liberty over using expression here. Replying just
> to annotate this practice and Cc Julia on her thoughts.
> 

Yeah I thought about this for a while - it doesn't even cover all cases
(there might be drivers that don't use |=, for example).

However, for now this seemed sufficient since very few places in the
code actually use this.

That said, there are cases where E really needs to be an expression
since it's not just "dev->..." but something like "foo->dev->...".

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
