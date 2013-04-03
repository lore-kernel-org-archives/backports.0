Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:35194 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760584Ab3DCLe6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 3 Apr 2013 07:34:58 -0400
Message-ID: <1364988895.8351.18.camel@jlt4.sipsolutions.net> (sfid-20130403_133501_082323_5D8D3E6E)
Subject: Re: [PATCH 2/2] compat: add HDMI library support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 03 Apr 2013 13:34:55 +0200
In-Reply-To: <1364988697.8351.15.camel@jlt4.sipsolutions.net> (sfid-20130403_133144_245875_662B42EB)
References: <1364963566-31377-1-git-send-email-mcgrof@do-not-panic.com>
	 <1364963566-31377-3-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130403_063310_293485_8E9CDCC2) <1364988697.8351.15.camel@jlt4.sipsolutions.net>
	 (sfid-20130403_133144_245875_662B42EB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-03 at 13:31 +0200, Johannes Berg wrote:
> On Tue, 2013-04-02 at 21:32 -0700, Luis R. Rodriguez wrote:
> 
> > --- a/backport/compat/Kconfig
> > +++ b/backport/compat/Kconfig
> > @@ -118,6 +118,16 @@ config BACKPORT_BUILD_DMA_SHARED_BUFFER
> >  config BACKPORT_DMA_SHARED_BUFFER
> >  	bool
> >  
> > +config BACKPORT_BUILD_HDMI
> > +	bool
> > +	depends on !BACKPORT_KERNEL_3_0
> > +	default y if BACKPORT_KERNEL_3_9
> > +	default y if BACKPORT_USERSEL_BUILD_ALL
> > +	default y if !HDMI && BACKPORT_HDMI
> 
> You enable this if HDMI wasn't supported in the base kernel and if it's
> needed (or build-all selected), but why also if the kernel is < 3.9? It
> seems it should be something like
> 
> default y if (!HDMI || BACKPORT_KERNEL_3_9) && BACKPORT_HDMI
> 
> to basically make it ignore the HDMI symbol in kernels < 3.9?

Or like for the dmabuf stuff:

config BACKPORT_BUILD_HDMI
	bool
	# not possible on kernel < 3.0
	depends on !BACKPORT_KERNEL_3_0

	# don't build if base kernel has it, except on kernel < 3.9
	depends on !HDMI || BACKPORT_KERNEL_3_9

	# build for testing
	default y if BACKPORT_USERSEL_BUILDALL

	# build if a driver needs it
	default y if BACKPORT_HDMI

I think that's more expressive as to what we want here?

(maybe we should actually have the comments in there)

johannes

