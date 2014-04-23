Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:46761 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbaDWLRJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 07:17:09 -0400
Message-ID: <1398251810.4173.6.camel@jlt4.sipsolutions.net> (sfid-20140423_131717_800333_F9DB6926)
Subject: Re: cocci: multiple versions of function with different arguments
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 23 Apr 2014 13:16:50 +0200
In-Reply-To: <5357A065.3020400@kpanic.de>
References: <53579593.40306@kpanic.de>
		 (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net>
	 <5357A065.3020400@kpanic.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-04-23 at 13:13 +0200, Stefan Assmann wrote:

> > #define vlan_rx_add_vid_func(a,b,c) vlan_rx_add_vid_func(a,c)

> That's one way to handle it but I'm sure there will be other cases where
> we might use coccinelle similarly, where a define might be tricky.
> Luis asked me to do some cleanup on igb, so I'm exploring ways to make
> it easier for other network drivers as well.
> 
> If for some reason cocci should have a problem with this the fallback
> to a define is a good idea.

I don't disagree that we might have to solve this cocci problem, but I
would much prefer the define over the cocci patch as it leaves the
output code closer to the input code, which can be important for some
use cases (e.g. ours - development based on a backport tree.)

So even if we can figure out how to make such a thing work with cocci,
I'd argue that we should pick the define (in this particular case.)

johannes

