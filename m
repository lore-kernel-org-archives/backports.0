Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58441 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932605AbcKNS7T (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 14 Nov 2016 13:59:19 -0500
Date: Mon, 14 Nov 2016 19:59:17 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH 3/3] backports: empty define for __ro_after_init
Message-ID: <20161114185917.GZ13978@wotan.suse.de> (sfid-20161114_195921_055135_E28946DD)
References: <1478981923-12298-1-git-send-email-arend.vanspriel@broadcom.com>
 <1478981923-12298-3-git-send-email-arend.vanspriel@broadcom.com>
 <1478984842.4226.1.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478984842.4226.1.camel@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Nov 12, 2016 at 10:07:22PM +0100, Johannes Berg wrote:
> On Sat, 2016-11-12 at 20:18 +0000, Arend van Spriel wrote:
> > nl80211 now uses section qualifier __ro_after_init. However, this
> > is not available in kernels before v4.6. Neither is the section
> > itself hence adding an empty define in backports.
> 
> > +#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
> > +#define __ro_after_init
> > +#endif
> 
> Due to how __ro_after_init works, it *has* to be a macro originally, so
> you could just ifndef on itself:
> 
> #ifndef __ro_after_init
> #define __ro_after_init
> #endif
> 
> and be slightly more compatible in case somebody ever backports it.

Agreed.

> Don't think it really matters much, but why not.

Distributions that do wish to backport the __ro_after_init
mechanism will have this defined, so indeed what you suggest
seems appropriate.

When backporting things like these please try to Cc the original
authors as they can easily provide feedback about issues they can think
of if you backport things one way or another. I've Cc'd Kees but
I think this backport is straight forward -- for older kernels we
just cannot backport this for modules running old kernels where we
cannot modify the kernels, making this a no-op for old kernels
is the best we can then.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
