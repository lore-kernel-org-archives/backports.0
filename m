Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39619 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BMz (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 29 Aug 2018 21:12:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so11732961oig.6
        for <backports@vger.kernel.org>; Wed, 29 Aug 2018 14:14:13 -0700 (PDT)
Subject: Re: Backports not building configured drivers
To: Marlon Smith <marlon.smith10@gmail.com>,
        Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
References: <1535407305.25991.36.camel@gmail.com>
 <203184ae0ffe879f79d8051807aa7f8326aaa311.camel@coelho.fi>
 <1535576146.25991.52.camel@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f1692edb-a6c4-a155-e067-9f83ac5a7e3f@lwfinger.net> (sfid-20180829_231426_547273_AA801DAC)
Date: Wed, 29 Aug 2018 16:14:11 -0500
MIME-Version: 1.0
In-Reply-To: <1535576146.25991.52.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/29/2018 03:55 PM, Marlon Smith wrote:
> On Tue, 2018-08-28 at 07:42 +0300, Luca Coelho wrote:
>> On Mon, 2018-08-27 at 15:01 -0700, Marlon Smith wrote:
>>>   
>>> Hi everyone,
>> Hi Marlon,
>>>>>   
>>> I'm using backports 4.14 to build for a custom kernel 3.14.  That
>>> kernel includes the RT2800 wifi driver, and if I configure
>>> backports
>>> with menuconfig to build a newer version of that driver it works
>>> perfectly.  However, if I configure backports to build the RTL8821
>>> driver, which my kernel otherwise does not include, the driver
>>> never
>>> gets built and backports shows it as not selected the next time I
>>> run
>>> menuconfig.
>>>   
>>> Is this expected behaviour?  Is there something I can do to force
>>> this
>>> driver to build?
>> This probably means that your 3.14 kernel doesn't have some of the
>> dependencies needed by the RTL8821 driver from 4.14.  Check the list
>> of
>> dependencies for the driver and make sure they are included in your
>> 3.14 kernel.
>>> --
>> Luca.
> 
> Hey Luca, thanks for the reply!  The requirements in the backports 4.14
> menuconfig are listed as follows:
> 
> Depends on: WLAN [=y] && WLAN_VENDOR_REALTEK [=y] && RTL_CARDS [=m] &&
> m && BP_MODULES [=y] && PCI [=y]
> 
> I can find the symbol WLAN_VENDOR_REALTEK in the backports 4.14
> menuconfig but not in the 3.14 kernel's menuconfig.  Does this mean I
> can't use the driver with this kernel?
> --

Marlon,

That symbol postdates kernel 3.14. I have no idea if the backports code will 
run, or even build, in kernels that old, but I think it would be safe for you to 
edit the symbol WLAN_VENDOR_REALTEK out of that "depends on" line in the 
configuration menu. At least, that will get you to the next problem. :)

Larry

--
To unsubscribe from this list: send the line "unsubscribe backports" in
