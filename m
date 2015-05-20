Return-path: <backports-owner@vger.kernel.org>
Received: from dedo.coelho.fi ([88.198.205.34]:48459 "EHLO dedo.coelho.fi"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752531AbbETJLH (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 May 2015 05:11:07 -0400
Message-ID: <1432110968.2142.14.camel@coelho.fi> (sfid-20150520_111111_316248_C759B759)
From: Luca Coelho <luca@coelho.fi>
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 20 May 2015 11:36:08 +0300
In-Reply-To: <1432110664.5612.6.camel@intel.com>
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
	 (sfid-20150519_154230_230935_983C6CAB) <1432110463.2174.2.camel@sipsolutions.net>
	 <1432110664.5612.6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
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

At least the code as is doesn't work for me on Ubuntu 12.04 with 3.10
kernel...

--
Luca

