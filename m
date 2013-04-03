Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:35190 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759574Ab3DCLbm (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 3 Apr 2013 07:31:42 -0400
Message-ID: <1364988697.8351.15.camel@jlt4.sipsolutions.net> (sfid-20130403_133144_245875_662B42EB)
Subject: Re: [PATCH 2/2] compat: add HDMI library support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 03 Apr 2013 13:31:37 +0200
In-Reply-To: <1364963566-31377-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130403_063310_293485_8E9CDCC2)
References: <1364963566-31377-1-git-send-email-mcgrof@do-not-panic.com>
	 <1364963566-31377-3-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130403_063310_293485_8E9CDCC2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-04-02 at 21:32 -0700, Luis R. Rodriguez wrote:

> --- a/backport/compat/Kconfig
> +++ b/backport/compat/Kconfig
> @@ -118,6 +118,16 @@ config BACKPORT_BUILD_DMA_SHARED_BUFFER
>  config BACKPORT_DMA_SHARED_BUFFER
>  	bool
>  
> +config BACKPORT_BUILD_HDMI
> +	bool
> +	depends on !BACKPORT_KERNEL_3_0
> +	default y if BACKPORT_KERNEL_3_9
> +	default y if BACKPORT_USERSEL_BUILD_ALL
> +	default y if !HDMI && BACKPORT_HDMI

You enable this if HDMI wasn't supported in the base kernel and if it's
needed (or build-all selected), but why also if the kernel is < 3.9? It
seems it should be something like

default y if (!HDMI || BACKPORT_KERNEL_3_9) && BACKPORT_HDMI

to basically make it ignore the HDMI symbol in kernels < 3.9?



Btw, I had an idea for doing things like this automatically -- we
actually know which symbols need to be changed to
LINUX_BACKPORT(symbol): all the ones that are exported of course, so
grep for "EXPORT_SYMBOL(_GPL)?" in the sources. It's still tricky, but
we could consider trying it next time.

johannes

