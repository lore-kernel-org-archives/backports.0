Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48607 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbbFHTpy (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Jun 2015 15:45:54 -0400
Message-ID: <1433792751.10172.0.camel@sipsolutions.net> (sfid-20150608_214556_213239_286729C7)
Subject: Re: [PATCH 3/4] gentree.py: add SmPL patch equivalence proof support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Date: Mon, 08 Jun 2015 21:45:51 +0200
In-Reply-To: <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com> (sfid-20150608_213135_744448_A746EA2B)
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
	 <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
	 <1433592743.2467.7.camel@sipsolutions.net>
	 <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com>
	 (sfid-20150608_213135_744448_A746EA2B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-06-08 at 12:31 -0700, Luis R. Rodriguez wrote:

> This is true, its in the like of how we wrote pycocci to provide us
> with a multithreaded solution for spatch integration / development as
> well and how pycocci now is upstream on Coccinelle.

Speaking of which - are you aware that pycocci fails (or rather doesn't
fail!) miserably when cocci isn't installed/in the $PATH? At least I got
a report to that extent, that it didn't really complete nor report an
error in that case.

johannes

