Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:35639 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbETIez (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 May 2015 04:34:55 -0400
Message-ID: <1432110893.2174.3.camel@sipsolutions.net> (sfid-20150520_103457_283448_8B556FB1)
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
From: Johannes Berg <johannes@sipsolutions.net>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 20 May 2015 10:34:53 +0200
In-Reply-To: <1432110664.5612.6.camel@intel.com>
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
	 (sfid-20150519_154230_230935_983C6CAB) <1432110463.2174.2.camel@sipsolutions.net>
	 <1432110664.5612.6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-05-20 at 08:31 +0000, Grumbach, Emmanuel wrote:
> On Wed, 2015-05-20 at 10:27 +0200, Johannes Berg wrote:
> > On Tue, 2015-05-19 at 16:42 +0300, Emmanuel Grumbach wrote:
> > 
> > > +#if (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI < 24)
> > 
> > Now that I look at this again, I'm confused - shouldn't this whole thing
> > have a ! in front?
> > 
> 
> why?
> I need this definition only for Ubuntu releases that are below 24.
> Canonical ported that starting 24.
> What am I missing?

But every mainline kernel, say 3.10, also needs it. Also Ubuntu with
3.10, for example.

johannes

