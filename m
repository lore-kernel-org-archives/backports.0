Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:47018 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759629Ab3DFU35 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 16:29:57 -0400
Message-ID: <1365280189.8313.1.camel@jlt4.sipsolutions.net> (sfid-20130406_223002_028930_9CA983C9)
Subject: Re: [PATCH v3 6/8] backports: add NFC patches
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sat, 06 Apr 2013 22:29:49 +0200
In-Reply-To: <CAB=NE6VJt2d1JJVe0rbe50rrw-TCTHgOyt9b3ig-RU8ghR2Wbw@mail.gmail.com> (sfid-20130406_222335_063212_D6C0EFEF)
References: <1365196842-12992-6-git-send-email-thierry.escande@linux.intel.com>
	 <1365199513.8515.41.camel@jlt4.sipsolutions.net>
	 <CAB=NE6VJt2d1JJVe0rbe50rrw-TCTHgOyt9b3ig-RU8ghR2Wbw@mail.gmail.com>
	 (sfid-20130406_222335_063212_D6C0EFEF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-04-06 at 13:22 -0700, Luis R. Rodriguez wrote:

> > FWIW, it's probably more efficient to just put them all into one
> > net_nfc.patch file. The only reason they're split by *file* rather than
> > by *logical group* right now is that it was easy to do automatically and
> > solved the problem I had (of wanting to copy only some drivers and then
> > applying only some patches). For this it's not really needed or even
> > useful to split by file, it was just the fastest way :-)
> >
> > So I think it'd make sense to put it into a single file, but I'm happy
> > to apply it as-is as well (though I want to give others more time to
> > review, so I'll not do it today)
> 
> How about a directory alone for NFC patches as we do for DRM. In fact
> perhaps Bluetooth should be split out from network as well, just as
> ethernet. That is, per subsystem.

Personally, I don't care. In fact, I'm going to change the apply process
a bit to just read any *.patch file, sort the list and then see if they
need to applied (in that order) -- that way we don't have to put things
all those levels down etc. and can split it up in any logical way we
like.

johannes

