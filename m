Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:56551 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaEBM6K (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 2 May 2014 08:58:10 -0400
Message-ID: <1399035482.5487.0.camel@jlt4.sipsolutions.net> (sfid-20140502_145812_684742_BC94704B)
Subject: Re: [PATCH] backports: select_queue patch: fix callback kernel
 version
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Fri, 02 May 2014 14:58:02 +0200
In-Reply-To: <20140502015017.GA3994@garbanzo.do-not-panic.com> (sfid-20140502_035024_735654_B890241B)
References: <1398895825-18420-1-git-send-email-johannes@sipsolutions.net>
	 <20140502015017.GA3994@garbanzo.do-not-panic.com>
	 (sfid-20140502_035024_735654_B890241B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-05-01 at 18:50 -0700, Luis R. Rodriguez wrote:
> On Thu, May 01, 2014 at 12:10:25AM +0200, Johannes Berg wrote:
> > diff --git a/stack-auto.ini b/stack-auto.ini
> > index 0412f8df60e4..4679a5cd52a7 100644
> > --- a/stack-auto.ini
> > +++ b/stack-auto.ini
> > @@ -1,5 +1,5 @@
> >  [DEFAULT]
> > -cachedir = .
> > +cachedir = /home/johannes/tmp/work/
> >  
> >  [iwlwifi]
> >  
> 
> Thanks! I'll just ignore this hunk as it likely just slipped. Applied!

Err, yes, sorry about that and thanks.

johannes

