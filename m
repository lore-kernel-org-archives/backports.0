Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50796 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH3LeU (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 30 Aug 2018 07:34:20 -0400
Message-ID: <1535614402.5215.36.camel@sipsolutions.net> (sfid-20180830_093335_275301_3C50E0EC)
Subject: Re: Backports not building configured drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Marlon Smith <marlon.smith10@gmail.com>,
        Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Date: Thu, 30 Aug 2018 09:33:22 +0200
In-Reply-To: <1535576146.25991.52.camel@gmail.com> (sfid-20180829_225550_611627_5288C10A)
References: <1535407305.25991.36.camel@gmail.com>
         <203184ae0ffe879f79d8051807aa7f8326aaa311.camel@coelho.fi>
         <1535576146.25991.52.camel@gmail.com>
         (sfid-20180829_225550_611627_5288C10A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-08-29 at 13:55 -0700, Marlon Smith wrote:

> Hey Luca, thanks for the reply!  The requirements in the backports 4.14
> menuconfig are listed as follows:
> 
> Depends on: WLAN [=y] && WLAN_VENDOR_REALTEK [=y] && RTL_CARDS [=m] &&
> m && BP_MODULES [=y] && PCI [=y]
> 
> I can find the symbol WLAN_VENDOR_REALTEK in the backports 4.14
> menuconfig but not in the 3.14 kernel's menuconfig.  Does this mean I
> can't use the driver with this kernel?

No, actually the symbol is enabled? See the [=y] above.

The above looks like it is actually enabled though, so something else
must be going on?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
