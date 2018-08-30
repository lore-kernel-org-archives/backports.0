Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42187 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeH3UKj (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 30 Aug 2018 16:10:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so4092126pgp.9
        for <backports@vger.kernel.org>; Thu, 30 Aug 2018 09:07:48 -0700 (PDT)
Message-ID: <1535645266.25991.54.camel@gmail.com> (sfid-20180830_180751_563886_7FACE3CA)
Subject: Re: Backports not building configured drivers
From: Marlon Smith <marlon.smith10@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Date: Thu, 30 Aug 2018 09:07:46 -0700
In-Reply-To: <1535614402.5215.36.camel@sipsolutions.net>
References: <1535407305.25991.36.camel@gmail.com>
         <203184ae0ffe879f79d8051807aa7f8326aaa311.camel@coelho.fi>
         <1535576146.25991.52.camel@gmail.com>
         (sfid-20180829_225550_611627_5288C10A) <1535614402.5215.36.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thanks everyone for the replies.  The setting I was missing in the
kernel was that I need to have PCI enabled.  I'm not sure why the
backports menuconfig said PCI [=y], since it was not enabled in the
kernel, but once I enabled it backports built the wifi driver
correctly.

Thanks again for the help!

Marlon

On Thu, 2018-08-30 at 09:33 +0200, Johannes Berg wrote:
> On Wed, 2018-08-29 at 13:55 -0700, Marlon Smith wrote:
> 
> > 
> > Hey Luca, thanks for the reply!  The requirements in the backports
> > 4.14
> > menuconfig are listed as follows:
> > 
> > Depends on: WLAN [=y] && WLAN_VENDOR_REALTEK [=y] && RTL_CARDS [=m]
> > &&
> > m && BP_MODULES [=y] && PCI [=y]
> > 
> > I can find the symbol WLAN_VENDOR_REALTEK in the backports 4.14
> > menuconfig but not in the 3.14 kernel's menuconfig.  Does this mean
> > I
> > can't use the driver with this kernel?
> No, actually the symbol is enabled? See the [=y] above.
> 
> The above looks like it is actually enabled though, so something else
> must be going on?
> 
> johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
