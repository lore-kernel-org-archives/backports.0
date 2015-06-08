Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48717 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbbFHU3b (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Jun 2015 16:29:31 -0400
Message-ID: <1433795370.10172.2.camel@sipsolutions.net> (sfid-20150608_222933_684157_484764E0)
Subject: Re: [PATCH 3/4] gentree.py: add SmPL patch equivalence proof support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Date: Mon, 08 Jun 2015 22:29:30 +0200
In-Reply-To: <CAB=NE6WTxatq3BAw=_84qwVEOhQezY3ik8GMM-zxeHZYYPZKYg@mail.gmail.com> (sfid-20150608_220920_158737_89BFA6E4)
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
	 <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
	 <1433592743.2467.7.camel@sipsolutions.net>
	 <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com>
	 <1433792751.10172.0.camel@sipsolutions.net>
	 <CAB=NE6WTxatq3BAw=_84qwVEOhQezY3ik8GMM-zxeHZYYPZKYg@mail.gmail.com>
	 (sfid-20150608_220920_158737_89BFA6E4)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-06-08 at 13:08 -0700, Luis R. Rodriguez wrote:

> > Speaking of which - are you aware that pycocci fails (or rather doesn't
> > fail!) miserably when cocci isn't installed/in the $PATH? At least I got
> > a report to that extent,
> 
> Did you verify it?

No, sorry. It was actually a pretty old discussion that came to my mind
now.

> mcgrof@ergon ~/linux-next (git::20150604-proto_ops-send-rcv-smpl)$ which pycocci
> which: no pycocci in
> (/usr/local/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/home/mcgrof/bin/:/usr/bin:/usr/local/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/home/mcgrof/bin/:/usr/bin:/usr/local/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/home/mcgrof/bin/:/usr/bin:/home/mcgrof/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games)
> 
> So not on my path.

Ah, no, I meant if *spatch* isn't on the $PATH, but you call pycocci ...
the report said that in that case pycocci wasn't really failing
"gracefully".

Anyway - I really should verify that myself first.

> Also Johannes, I value your time and I feel you're
> investing quite a bit of time into this NACK discussion, I obviously
> trust your judgement completely on gentree.py maintenance so for your
> convenience feel free to be concise in your NACK's for patches there.

Nah, don't worry -- I need to write it down to actually have a coherent
argument myself :)

johannes

