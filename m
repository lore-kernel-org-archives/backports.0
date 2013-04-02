Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:33146 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762240Ab3DBVXI (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 17:23:08 -0400
Message-ID: <1364937780.8204.18.camel@jlt4.sipsolutions.net> (sfid-20130402_232314_835932_4BD9FEA1)
Subject: Re: [ANN] new backports project
From: Johannes Berg <johannes@sipsolutions.net>
To: Phil Perry <phil@pendre.co.uk>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 02 Apr 2013 23:23:00 +0200
In-Reply-To: <515B4994.3030309@pendre.co.uk>
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
	  (sfid-20130402_151948_622703_76140D33) <1364923241.8204.15.camel@jlt4.sipsolutions.net>
	 <515B4994.3030309@pendre.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

> I too am very interested in support for RHEL.

:-)
I should say that I have no idea what RHEL does etc.

> We had support up to date for compat-wireless-3.5 under RHEL-6.3.
> 
> Unsurprisingly the release of RHEL-6.4 broke a whole load of stuff given 
> the amount of backporting RH did into their kernel (I believe they 
> backported the wireless stack from ~ kernel-3.5 into their kernel).

Makes sense.

> I (and a colleague) played with compat-drivers-2013-03-07-u.tar.bz2 to 
> get alx to build under RHEL-6.4 but I never got as far as looking at 
> building everything. The seemingly endless cycle of breakage on every 
> RHEL release and having to fix it kind of left me losing the will to 
> keep fixing it, especially as for the moment the RHEL kernel has a 
> relatively recent wireless driver stack. Any solution that might ease 
> this break and fix cycle would be very welcome here.
> 
> > I addressed this, but I'm unsure of it and don't have a way to test it,
> > so any testing would be appreciated (as it is in general, of course)
> >
> 
> I've not looked closely at what you've done, but I have an interest in 
> building/packaging compat-drivers for RHEL and can possibly help test. 
> If you have a snapshot that you think should build on RHEL or that I 
> could use as a starting point?

I only addressed what compat-drivers-... had a few days ago.

However, I simplified the system a bit. I don't have any snapshot, but I
did announce the git tree. Grab that, run ./gentree.py against
linux-next and you should get something. Then you will have to hack up
the Kconfig (backport/compat/Kconfig) and include files
(backport/include/*), presumably.

If you're interested in alx, you'd have to add that -- look at the
copy-list.alx file for that.

I hope that soon enough Luis might cut some testing releases from this
though.

johannes

