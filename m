Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:52024 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727525AbeIXOpT (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 10:45:19 -0400
Message-ID: <a33185451dea29e7302f43356cb7709d0fb7bbcd.camel@coelho.fi> (sfid-20180924_104422_784144_64030B5D)
From: Luca Coelho <luca@coelho.fi>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 24 Sep 2018 11:44:17 +0300
In-Reply-To: <4cb197ca-9ae6-18b9-ec7a-59eb893d96dd@hauke-m.de>
References: <20180920162622.30203-1-luca@coelho.fi>
         <4cb197ca-9ae6-18b9-ec7a-59eb893d96dd@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: add ktime_get_raw_ts64() backport for < 3.19
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 15:52 +0200, Hauke Mehrtens wrote:
> On 09/20/2018 06:26 PM, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > The getrawmonotonic64() function that is used by the
> > ktime_get_raw_ts64() backport was only introduced in 3.19.  To fix
> > compilation with earlier kernels, do the convertion from
> > getrawmonotonic() manually if the kernel is < 3.19.
> > 
> > Additionally, add timespec_to_timespec64() that we need for this
> > conversion (and which was only introduced in 4.15).
> > 
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  backport/backport-include/linux/timekeeping.h | 29
> > +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/backport/backport-include/linux/timekeeping.h
> > b/backport/backport-include/linux/timekeeping.h
> > index aebb00ca366b..56fca5759b8e 100644
> > --- a/backport/backport-include/linux/timekeeping.h
> > +++ b/backport/backport-include/linux/timekeeping.h
> > @@ -55,11 +55,40 @@ static inline void ktime_get_ts64(struct
> > timespec64 *ts)
> >  }
> >  #endif
> >  
> > +#if LINUX_VERSION_IS_LESS(3,19,0)
> > +/* This was introduced in 4.15, but we only need it in the
> > + * ktime_get_raw_ts64 backport() for < 3.19.
> 
> timespec_to_timespec64() was already added in 3.17, see
> https://elixir.bootlin.com/linux/v3.17.8/ident/timespec_to_timespec64

Oh, you're right.  I somehow got confused here.  I'm running some tests
and will resend a fixed version.

Thanks!

--
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
