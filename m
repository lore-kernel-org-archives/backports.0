Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:34247 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367Ab3J1ORX (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 28 Oct 2013 10:17:23 -0400
Message-ID: <1382969837.17956.20.camel@jlt4.sipsolutions.net> (sfid-20131028_151725_328513_064B896F)
Subject: Re: [PATCH 1/5] backports: fix kernel dependencies for regulator
 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 28 Oct 2013 15:17:17 +0100
In-Reply-To: <CAB=NE6XpXqo09-vpkPaY=qMgpJfywS61oNjZ0nkm1Mpd1PrdHA@mail.gmail.com> (sfid-20131026_114537_978407_8571F2FA)
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
	 <1382552852-15916-2-git-send-email-hauke@hauke-m.de>
	 <1382690097.4461.0.camel@jlt4.sipsolutions.net>
	 <526AE34E.5020300@hauke-m.de>
	 <CAB=NE6XpXqo09-vpkPaY=qMgpJfywS61oNjZ0nkm1Mpd1PrdHA@mail.gmail.com>
	 (sfid-20131026_114537_978407_8571F2FA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-10-26 at 11:45 +0200, Luis R. Rodriguez wrote:

> > Yes moving the dependencies is easier than backporting the code which
> > does not work any more. ;-) The problem here is that the regulator core
> > can not be backported, because it is always build into the kernel and
> > not as a module.

> As for the issues with some functionality on the regulator
> drivers requiring functionality from future kernels as its always
> built-in, that can be addressed if we add support for non-modular
> solutions on backports.

I don't think that's actually true - the regulator drivers may require
being built-in, but there are probably good reasons for that like
multiple other modules accessing them. So updating them in a backport
and building them in wouldn't really help since now you'd have two
identical regulators that conflict and have different users.

And if you tried to backport it into the tree and make it the only
regulator driver, you'd now have to forward-port all the remaining
in-tree users as well, which seems unreasonable too.

The only usage would seem to be building it including *all* users as
part of the backport, but that seems somewhat unlikely?

johannes

