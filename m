Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:52058 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbeIXPZN (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 11:25:13 -0400
Message-ID: <948ce87ddf7b135e98506a2f0f2d56d9ccb43228.camel@coelho.fi> (sfid-20180924_112407_617799_F22CF012)
From: Luca Coelho <luca@coelho.fi>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 24 Sep 2018 12:24:03 +0300
In-Reply-To: <1aadb207-75fa-83e6-d838-2ac878b1c7c8@hauke-m.de>
References: <20180920112842.27198-1-luca@coelho.fi>
         <20180920112842.27198-14-luca@coelho.fi>
         <1aadb207-75fa-83e6-d838-2ac878b1c7c8@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 13/14] backport: convert int led activate op to void
 when needed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 14:30 +0200, Hauke Mehrtens wrote:
> On 09/20/2018 01:28 PM, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > In kernel v4.19-rc1, the activate op in struct led_trigger, changed
> > from void to int.  To solve this, add a semantic patch to insert a
> > wrapper function that returns void and calls the function that
> > returns
> > int.
> > 
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> >  patches/led_activate.cocci | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 patches/led_activate.cocci
> > 
> > diff --git a/patches/led_activate.cocci
> > b/patches/led_activate.cocci
> > new file mode 100644
> > index 000000000000..df8211d29462
> > --- /dev/null
> > +++ b/patches/led_activate.cocci
> > @@ -0,0 +1,24 @@
> > +@act@
> > +identifier activate_fn, p;
> > +identifier m =~ "rx_led|tx_led|assoc_led|radio_led|tpt_led";
> > +fresh identifier activate_fn_wrap = "bp_" ## activate_fn;
> > +@@
> > +<...
> > ++#if LINUX_VERSION_IS_GEQ(4,19,0)
> > +p->m.activate = activate_fn;
> > ++#else
> > ++p->m.activate = activate_fn_wrap;
> > ++#endif
> > +...>
> 
> Please use <+--- ---+> here it improves the speed by some magnitudes.

Thanks for pointing out.  I remember the discussion about this with
Julia.  Johannes already fixed this in-place before applying my patch.

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
