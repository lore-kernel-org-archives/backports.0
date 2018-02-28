Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:32996 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752412AbeB1SsV (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 28 Feb 2018 13:48:21 -0500
Message-ID: <1519843697.3891.15.camel@coelho.fi> (sfid-20180228_194823_878807_36A6B264)
From: Luca Coelho <luca@coelho.fi>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc: Sara Sharon <sara.sharon@intel.com>
Date: Wed, 28 Feb 2018 20:48:17 +0200
In-Reply-To: <e59b84ac-99c0-9797-bc87-763a62a9bd0d@hauke-m.de>
References: <20180218132459.11011-1-luca@coelho.fi>
         <20180218132459.11011-11-luca@coelho.fi>
         <e59b84ac-99c0-9797-bc87-763a62a9bd0d@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 10/10] backport: implement alloc_percpu_gfp() for < 3.18.
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-02-28 at 19:32 +0100, Hauke Mehrtens wrote:
> 
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
> 
> This path is wrong, please add this to
> backport/backport-include/linux/percpu.h
> 
> As this was already applied, will you send a patch to fix this
> please.

Oh, sorry.  My bad.  Our internal tree is a backport itself, so the
tree struct is different.  Usually the patches apply nicely and go to
the correct directories automatically (git magic), but I since this is
a new file, it couldn't detect anything similar and just added it to
the wrong place.

I'll send a fix.  Thanks for pointing out.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
