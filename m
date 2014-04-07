Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:34696 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbaDGRZd (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 13:25:33 -0400
Message-ID: <1396891524.6270.3.camel@jlt4.sipsolutions.net> (sfid-20140407_192535_606543_32BEFA21)
Subject: Re: [PATCH 26/27] backports: convert threaded IRQ suport into an
 SmPL patch
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Date: Mon, 07 Apr 2014 19:25:24 +0200
In-Reply-To: <CAB=NE6VWRcVwMjWJEJNVfHCuEwvA94u4p-W+JHEXOU74MtLtSA@mail.gmail.com> (sfid-20140407_192155_711729_741FD1C6)
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
	 <1396701662-15165-27-git-send-email-mcgrof@do-not-panic.com>
	 <1396866692.6270.0.camel@jlt4.sipsolutions.net>
	 <CAB=NE6VWRcVwMjWJEJNVfHCuEwvA94u4p-W+JHEXOU74MtLtSA@mail.gmail.com>
	 (sfid-20140407_192155_711729_741FD1C6)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2014-04-07 at 10:19 -0700, Luis R. Rodriguez wrote:
> On Mon, Apr 7, 2014 at 3:31 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Sat, 2014-04-05 at 05:41 -0700, Luis R. Rodriguez wrote:
> >
> >> ++ret = compat_request_threaded_irq(&private->irq_compat,
> >
> > Whhy not go to backport namespace too?
> 
> Sure, how about as a second patch?

Sure, I was just wondering if there was a particular reason you didn't
while you rewrote the whole thing anyway.

johannes

