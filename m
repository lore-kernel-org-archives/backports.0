Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33537 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbETQxl (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 20 May 2015 12:53:41 -0400
Received: by oica37 with SMTP id a37so40814616oic.0
        for <backports@vger.kernel.org>; Wed, 20 May 2015 09:53:40 -0700 (PDT)
Message-ID: <555CBC12.4020800@lwfinger.net> (sfid-20150520_185343_552273_6D40FEDF)
Date: Wed, 20 May 2015 11:53:38 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>		 (sfid-20150519_154230_230935_983C6CAB) <1432110463.2174.2.camel@sipsolutions.net>		 <1432110664.5612.6.camel@intel.com>		 <1432110893.2174.3.camel@sipsolutions.net>	 <1432111194.8314.1.camel@intel.com> <555CA897.4010606@lwfinger.net> <1432140155.11332.3.camel@intel.com>
In-Reply-To: <1432140155.11332.3.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/20/2015 11:42 AM, Grumbach, Emmanuel wrote:
>
> Good question... I don't know. OTOH, distros don't really support
> backport. You can't really blame them if they break backport, why should
> they care?
> I agree. It is annoying. We can try to convince them, but I don't think
> that saying "you are all wrong" is the right path. Maybe we should try
> to have them more involved in backport to fix it themselves?
> And explain to them how important it is to be able to run backport on
> top of all their shipped kernels?

Supporting backport would be a first step, but that won't help all of the rtl8* 
repos that I have at GitHub. Most of those do not have drivers in the kernel, 
thus the users are dependent on that kind of external repo; however, I do not 
have any desire to find out what macro needs to be tested so that these drivers 
will build on distros that I do not use.

I guess I should report a bug to whatever disto breaks my driver and request 
that they fix it. I already know how much that will help :)

Larry


