Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48334 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932470AbbDQS0K (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 17 Apr 2015 14:26:10 -0400
Message-ID: <1429295166.1885.6.camel@sipsolutions.net> (sfid-20150417_202615_599949_A12EFD36)
Subject: Re: Possible to build-in backports modules into kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Petr Vorel <petr.vorel@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 17 Apr 2015 20:26:06 +0200
In-Reply-To: <55314F5C.3000907@lwfinger.net> (sfid-20150417_202224_271161_EC945DE9)
References: <20150417133004.GC16380@vorel-pc>
	 <5531314D.1000706@lwfinger.net> <1429291720.1885.5.camel@sipsolutions.net>
	 <CAB=NE6X=-PQR3=uxmHZL+Jf8muX6QmmTjKkBnKXUWDk1Bkeccw@mail.gmail.com>
	 <55314F5C.3000907@lwfinger.net> (sfid-20150417_202224_271161_EC945DE9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-04-17 at 13:22 -0500, Larry Finger wrote:
> On 04/17/2015 01:03 PM, Luis R. Rodriguez wrote:
> > On Fri, Apr 17, 2015 at 10:28 AM, Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> >> Technically this is not true any more - the backports gentree.py script
> >> now supports kernel integration where it copies the backport into
> >> another kernel tree :)
> >
> > Indeed:
> >
> > https://backports.wiki.kernel.org/index.php/Documentation/integration
> 
> Just to clarify, the entire kernel will need to be built from some tree. In my 
> reading of the original post, I got the impression that Petr wanted to use a 
> pre-built kernel.

Yes, indeed, that's not possible - and doesn't really make sense anyway,
since if you have access to the kernel image and sources to build
against, you might as well rebuild the whole kernel.

johannes

