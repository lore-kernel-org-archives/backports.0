Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:34108 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755520AbcGHTxj (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 8 Jul 2016 15:53:39 -0400
Message-ID: <1468007615.25088.93.camel@coelho.fi> (sfid-20160708_215342_291030_9712F177)
From: Luca Coelho <luca@coelho.fi>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc: emmanuel.grumbach@intel.com
Date: Fri, 08 Jul 2016 22:53:35 +0300
In-Reply-To: <06392fc7-23f8-0434-8e39-27ee4239363b@hauke-m.de>
References: <1455356813-4863-1-git-send-email-luca@coelho.fi>
	 <06392fc7-23f8-0434-8e39-27ee4239363b@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: add thermal backports for kernels < 4.3
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2016-07-08 at 21:49 +0200, Hauke Mehrtens wrote:
> On 02/13/2016 10:46 AM, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > There were some API changes in the thermal framework in kernel
> > version
> > 4.3 and also earlier in 3.10.  Backport what is needed to support
> > older kernels.
> > 
> > The 4.3 change is a bit tricky, because it changes the prototypes
> > of
> > some ops.  The solution for that is to add hook functions that will
> > intercept the calls from the thermal framework and convert them to
> > calls that the backported driver provides (namely convert unsigned
> > longs to ints).
> 
> If it is just some int or unsigned long I think it is easier to just
> have a patch or spatch for your driver. I assume that your program
> logic
> does not care about the type.

Johannes and I have simplified this a bit.  I'll send a new version out
soon.


> > 
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> 
> Sorry that it took me so long to look into this.

No worries! We were wondering about you. ;)

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
