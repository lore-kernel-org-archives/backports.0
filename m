Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:37544 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbdLBQbD (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 2 Dec 2017 11:31:03 -0500
Received: by mail-pg0-f45.google.com with SMTP id y6so5786389pgp.4
        for <backports@vger.kernel.org>; Sat, 02 Dec 2017 08:31:03 -0800 (PST)
Subject: Re: Cross-compiling wifi driver on Android
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <41f0fd53-25ef-420e-8ef8-f24498b8118e@gmail.com>
 <1512202131.26976.4.camel@sipsolutions.net>
From: Remington Furman <remicles2@gmail.com>
Message-ID: <043841bf-92f4-e240-ea3b-2ae6946aae66@gmail.com> (sfid-20171202_173105_619774_22B9D3EA)
Date: Sat, 2 Dec 2017 08:31:00 -0800
MIME-Version: 1.0
In-Reply-To: <1512202131.26976.4.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Johannes,

Thank you very much.  That tip to follow the dependencies helped a lot.  
I had been using "/" before, but just learned you can type the numbers 
in parenthesis in the search results to jump to them. Saves a lot of time.

After working recursively through the dependencies for the backports 
menuconfig option I wanted (RTL8192CU) I found out that CPTCFG_MAC80211 
wasn't appearing as an option in backports because my target kernel did 
not satisfy it's dependencies for CRYPTO_CCM, CRYPTO_GCM, and 
CRYPTO_CMAC.  After enabling those on my target kernel, CPTCFG_MAC80211 
appeared and I could enable everything in backports down to my desired 
driver.

Thanks again.  I'll let you know when I'm able to get the new drivers 
loaded on my target next week.

Cheers,

Remington

On 12/02/2017 12:08 AM, Johannes Berg wrote:
> On Fri, 2017-12-01 at 16:44 -0800, Remington Furman wrote:
>
>> That succeeds and shows me a menu.  However, '<M> USB Network
>> Adapters ----' is an empty menu and the rtl8192cu driver I am
>> after is not available.  Enabling CPTCFG_WLAN_VENDOR_REALTEK in
>> 'make menuconfig' doesn't lead to any other options.
> In menuconfig, hit "/" and search for (part of) the symbol you want
> (e.g. "RTL8192"), and check the dependencies.
>
> It really only has one though "depends on USB", which is weird. Check
> it there.
>
>> If I understand this page correctly, I need to first disable
>> conflicting drivers in my target kernel .config before running
>> 'make menuconfig' in backports.
>> <https://backports.wiki.kernel.org/index.php/Documentation/integration#Kernel_integration_menuconfig>
>> I've tried a number of target kernel configurations, but haven't
>> found a combination that makes backports happy yet.  I've disable
>> CONFIG_CFG80211 and CONFIG_WLAN, but no luck.
> You don't want integration, so I think you can ignore that page.
>
> johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
