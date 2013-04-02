Return-path: <backports-owner@vger.kernel.org>
Received: from quad.pendre.co.uk ([195.137.4.79]:40135 "EHLO quad.pendre.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab3DBVTS (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 2 Apr 2013 17:19:18 -0400
Message-ID: <515B4994.3030309@pendre.co.uk> (sfid-20130402_231923_075543_11BA9561)
Date: Tue, 02 Apr 2013 22:11:48 +0100
From: Phil Perry <phil@pendre.co.uk>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [ANN] new backports project
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>  (sfid-20130402_151948_622703_76140D33) <1364923241.8204.15.camel@jlt4.sipsolutions.net>
In-Reply-To: <1364923241.8204.15.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/04/13 18:20, Johannes Berg wrote:
>
>>   * Redhat kernel backport support -- this should be fairly easy
>

I too am very interested in support for RHEL.

We had support up to date for compat-wireless-3.5 under RHEL-6.3.

Unsurprisingly the release of RHEL-6.4 broke a whole load of stuff given 
the amount of backporting RH did into their kernel (I believe they 
backported the wireless stack from ~ kernel-3.5 into their kernel).

I (and a colleague) played with compat-drivers-2013-03-07-u.tar.bz2 to 
get alx to build under RHEL-6.4 but I never got as far as looking at 
building everything. The seemingly endless cycle of breakage on every 
RHEL release and having to fix it kind of left me losing the will to 
keep fixing it, especially as for the moment the RHEL kernel has a 
relatively recent wireless driver stack. Any solution that might ease 
this break and fix cycle would be very welcome here.

> I addressed this, but I'm unsure of it and don't have a way to test it,
> so any testing would be appreciated (as it is in general, of course)
>

I've not looked closely at what you've done, but I have an interest in 
building/packaging compat-drivers for RHEL and can possibly help test. 
If you have a snapshot that you think should build on RHEL or that I 
could use as a starting point?

Phil


