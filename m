Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38407 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017AbbETRAB (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 May 2015 13:00:01 -0400
Message-ID: <1432141196.19214.20.camel@sipsolutions.net> (sfid-20150520_190006_449715_64EE67C0)
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 20 May 2015 18:59:56 +0200
In-Reply-To: <555CBC12.4020800@lwfinger.net> (sfid-20150520_185342_445170_F8450E35)
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
			 (sfid-20150519_154230_230935_983C6CAB) <1432110463.2174.2.camel@sipsolutions.net>
			 <1432110664.5612.6.camel@intel.com>
			 <1432110893.2174.3.camel@sipsolutions.net>
		 <1432111194.8314.1.camel@intel.com> <555CA897.4010606@lwfinger.net>
	 <1432140155.11332.3.camel@intel.com> <555CBC12.4020800@lwfinger.net>
	 (sfid-20150520_185342_445170_F8450E35)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-05-20 at 11:53 -0500, Larry Finger wrote:
> On 05/20/2015 11:42 AM, Grumbach, Emmanuel wrote:
> >
> > Good question... I don't know. OTOH, distros don't really support
> > backport. You can't really blame them if they break backport, why should
> > they care?
> > I agree. It is annoying. We can try to convince them, but I don't think
> > that saying "you are all wrong" is the right path. Maybe we should try
> > to have them more involved in backport to fix it themselves?
> > And explain to them how important it is to be able to run backport on
> > top of all their shipped kernels?
> 
> Supporting backport would be a first step, but that won't help all of the rtl8* 
> repos that I have at GitHub. Most of those do not have drivers in the kernel, 
> thus the users are dependent on that kind of external repo; however, I do not 
> have any desire to find out what macro needs to be tested so that these drivers 
> will build on distros that I do not use.

Maybe you could just use backports for those drivers?

johannes

