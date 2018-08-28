Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:44650 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbeH1Icr (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 28 Aug 2018 04:32:47 -0400
Message-ID: <203184ae0ffe879f79d8051807aa7f8326aaa311.camel@coelho.fi> (sfid-20180828_064301_792815_C58FF3A0)
From: Luca Coelho <luca@coelho.fi>
To: Marlon Smith <marlon.smith10@gmail.com>, backports@vger.kernel.org
Date: Tue, 28 Aug 2018 07:42:56 +0300
In-Reply-To: <1535407305.25991.36.camel@gmail.com>
References: <1535407305.25991.36.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Backports not building configured drivers
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-08-27 at 15:01 -0700, Marlon Smith wrote:
> Hi everyone,

Hi Marlon,


> I'm using backports 4.14 to build for a custom kernel 3.14.  That
> kernel includes the RT2800 wifi driver, and if I configure backports
> with menuconfig to build a newer version of that driver it works
> perfectly.  However, if I configure backports to build the RTL8821
> driver, which my kernel otherwise does not include, the driver never
> gets built and backports shows it as not selected the next time I run
> menuconfig.
> 
> Is this expected behaviour?  Is there something I can do to force
> this
> driver to build?

This probably means that your 3.14 kernel doesn't have some of the
dependencies needed by the RTL8821 driver from 4.14.  Check the list of
dependencies for the driver and make sure they are included in your
3.14 kernel.

--
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
