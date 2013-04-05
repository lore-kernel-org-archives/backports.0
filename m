Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161189Ab3DEB6e (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 4 Apr 2013 21:58:34 -0400
Date: Thu, 4 Apr 2013 21:52:29 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: Phil Perry <phil@pendre.co.uk>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [ANN] new backports project
Message-ID: <20130405015229.GL27415@gospo.rdu.redhat.com> (sfid-20130405_035836_789917_03C4AA3E)
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
 <1364923241.8204.15.camel@jlt4.sipsolutions.net>
 <515B4994.3030309@pendre.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <515B4994.3030309@pendre.co.uk>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 02, 2013 at 10:11:48PM +0100, Phil Perry wrote:
> On 02/04/13 18:20, Johannes Berg wrote:
> >
> >>  * Redhat kernel backport support -- this should be fairly easy
> >
> 
> I too am very interested in support for RHEL.
> 
> We had support up to date for compat-wireless-3.5 under RHEL-6.3.
> 
> Unsurprisingly the release of RHEL-6.4 broke a whole load of stuff
> given the amount of backporting RH did into their kernel (I believe
> they backported the wireless stack from ~ kernel-3.5 into their
> kernel).
> 
> I (and a colleague) played with compat-drivers-2013-03-07-u.tar.bz2
> to get alx to build under RHEL-6.4 but I never got as far as looking
> at building everything. The seemingly endless cycle of breakage on
> every RHEL release and having to fix it kind of left me losing the
> will to keep fixing it, especially as for the moment the RHEL kernel
> has a relatively recent wireless driver stack. Any solution that
> might ease this break and fix cycle would be very welcome here.

I'm glad to hear the use of compat-wireless is at least moderately
useful on RHEL6.  A few of us have an interest in keeping compat going
on RHEL6, but none had the cycles to get compat.git fixed-up before 6.4
was released.  I'm actually in the process of posting patches for 6.3.z
as someone had created an upstream bugzilla for this, so I would
encourage anyone who wants it working on 6.4 to do the same.

> >I addressed this, but I'm unsure of it and don't have a way to test it,
> >so any testing would be appreciated (as it is in general, of course)
> >
> 
> I've not looked closely at what you've done, but I have an interest
> in building/packaging compat-drivers for RHEL and can possibly help
> test. If you have a snapshot that you think should build on RHEL or
> that I could use as a starting point?
> 

I would also like to see this -- though I guess I can probably just
clone the git repo and check it out.

