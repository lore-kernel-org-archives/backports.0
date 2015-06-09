Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51686 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbbFIG3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 9 Jun 2015 02:29:35 -0400
Message-ID: <1433831373.1892.0.camel@sipsolutions.net> (sfid-20150609_082937_989231_7E3C4869)
Subject: Re: [PATCH] pycocci: sync pycocci with Coccinelle upstream
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Date: Tue, 09 Jun 2015 08:29:33 +0200
In-Reply-To: <CAB=NE6W68eikvWE+YKKSUC3_S_pTLY-cJq5hGeRkKp2mx9dRMA@mail.gmail.com> (sfid-20150608_224340_079310_DA6B54D3)
References: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com>
	 <1433795473.10172.3.camel@sipsolutions.net>
	 <CAB=NE6W68eikvWE+YKKSUC3_S_pTLY-cJq5hGeRkKp2mx9dRMA@mail.gmail.com>
	 (sfid-20150608_224340_079310_DA6B54D3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-06-08 at 13:43 -0700, Luis R. Rodriguez wrote:
> On Mon, Jun 8, 2015 at 1:31 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Mon, 2015-06-08 at 13:01 -0700, Luis R. Rodriguez wrote:
> >> pycocci is now part of Coccinelle upstream. Coccinelle has a plan
> >> to actually extend multithreaded support to enable us to not have
> >> to script this out. Until then pyccoci is used and I'll sync both
> >> solutions up as there is a bit of latency between a coccinelle release
> >> and what we may need from pycocci.
> >
> > If it's upstream, do they ship it? If so it wouldn't be needed that we
> > have a copy, it seems?
> 
> Indeed, Coccinelle 1.0 has pycocci except for this last patch I just
> mentioned. I think it is important enough for our sake that the errors
> are reported well, I think its fair to drop this in backports once
> Coccinelle 1.1 is released and we can reasonably expect users to have
> it installed.

Not sure I see the point in applying it now - clearly we haven't had any
issues here that required this change, so why bother?

johannes

