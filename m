Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38206 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbeH3Ay0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 29 Aug 2018 20:54:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id e2-v6so2850999pgv.5
        for <backports@vger.kernel.org>; Wed, 29 Aug 2018 13:55:48 -0700 (PDT)
Message-ID: <1535576146.25991.52.camel@gmail.com> (sfid-20180829_225550_611627_5288C10A)
Subject: Re: Backports not building configured drivers
From: Marlon Smith <marlon.smith10@gmail.com>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Date: Wed, 29 Aug 2018 13:55:46 -0700
In-Reply-To: <203184ae0ffe879f79d8051807aa7f8326aaa311.camel@coelho.fi>
References: <1535407305.25991.36.camel@gmail.com>
         <203184ae0ffe879f79d8051807aa7f8326aaa311.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-08-28 at 07:42 +0300, Luca Coelho wrote:
> On Mon, 2018-08-27 at 15:01 -0700, Marlon Smith wrote:
> > 
> > Hi everyone,
> Hi Marlon,
> > > > 
> > I'm using backports 4.14 to build for a custom kernel 3.14.  That
> > kernel includes the RT2800 wifi driver, and if I configure
> > backports
> > with menuconfig to build a newer version of that driver it works
> > perfectly.  However, if I configure backports to build the RTL8821
> > driver, which my kernel otherwise does not include, the driver
> > never
> > gets built and backports shows it as not selected the next time I
> > run
> > menuconfig.
> > 
> > Is this expected behaviour?  Is there something I can do to force
> > this
> > driver to build?
> This probably means that your 3.14 kernel doesn't have some of the
> dependencies needed by the RTL8821 driver from 4.14.  Check the list
> of
> dependencies for the driver and make sure they are included in your
> 3.14 kernel.
> > --
> Luca.

Hey Luca, thanks for the reply!  The requirements in the backports 4.14
menuconfig are listed as follows:

Depends on: WLAN [=y] && WLAN_VENDOR_REALTEK [=y] && RTL_CARDS [=m] &&
m && BP_MODULES [=y] && PCI [=y]

I can find the symbol WLAN_VENDOR_REALTEK in the backports 4.14
menuconfig but not in the 3.14 kernel's menuconfig.  Does this mean I
can't use the driver with this kernel?
--
To unsubscribe from this list: send the line "unsubscribe backports" in
