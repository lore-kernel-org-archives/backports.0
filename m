Return-path: <backports-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:57420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbeBRR66 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 18 Feb 2018 12:58:58 -0500
Message-ID: <1518976736.7832.64.camel@intel.com> (sfid-20180218_185900_696918_27C855F6)
Subject: Re: [PATCH 10/10] backport: implement alloc_percpu_gfp() for < 3.18.
From: Luciano Coelho <luciano.coelho@intel.com>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc: Sara Sharon <sara.sharon@intel.com>
Date: Sun, 18 Feb 2018 19:58:56 +0200
In-Reply-To: <4eb11ec9-3d1e-91ee-6585-7c8221454faf@hauke-m.de>
References: <20180218132459.11011-1-luca@coelho.fi>
         <20180218132459.11011-11-luca@coelho.fi>
         <4eb11ec9-3d1e-91ee-6585-7c8221454faf@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-02-18 at 17:10 +0100, Hauke Mehrtens wrote:
> On 02/18/2018 02:24 PM, Luca Coelho wrote:
> > From: Sara Sharon <sara.sharon@intel.com>
> > 
> > mac80211 now uses the alloc_percpu_gfp() function, which doesn't
> > exist
> > in kernels older than 3.18.  Backport it accordingly.
> > 
> > Signed-off-by: Sara Sharon <sara.sharon@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  backport-include/linux/percpu.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 backport-include/linux/percpu.h
> > 
> > diff --git a/backport-include/linux/percpu.h b/backport-
> > include/linux/percpu.h
> > new file mode 100644
> > index 000000000000..10be03cba795
> > --- /dev/null
> > +++ b/backport-include/linux/percpu.h
> > @@ -0,0 +1,19 @@
> > +/*
> > + * Copyright (C) 2018 Intel Corporation
> > + */
> > +#ifndef __BACKPORT_PERCPU_H
> > +#define __BACKPORT_PERCPU_H
> > +#include_next <linux/percpu.h>
> > +
> > +#if LINUX_VERSION_IS_LESS(3,18,0)
> > +static inline void __percpu *__alloc_gfp_warn(void)
> > +{
> > +	WARN(1, "Cannot backport alloc_percpu_gfp");
> > +	return NULL;
> 
> Is this only called with GFP_KERNEL for now or why is it ok to only
> show
> an error message here?

Yes, exactly.  For now we only use it with GFP_KERNEL and backporting
for the other cases would be very difficult, so I took this shortcut
here.

--
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
