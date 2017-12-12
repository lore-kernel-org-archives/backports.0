Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:45104 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdLLOi0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 12 Dec 2017 09:38:26 -0500
Received: by mail-pf0-f179.google.com with SMTP id u19so14331187pfa.12
        for <backports@vger.kernel.org>; Tue, 12 Dec 2017 06:38:26 -0800 (PST)
Subject: Re: Cross-compiling wifi driver on Android
From: Remington Furman <remicles2@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <41f0fd53-25ef-420e-8ef8-f24498b8118e@gmail.com>
 <1512202131.26976.4.camel@sipsolutions.net>
 <043841bf-92f4-e240-ea3b-2ae6946aae66@gmail.com>
Message-ID: <1d5b2161-5808-140f-0d4c-d0d396e57c9f@gmail.com> (sfid-20171212_153829_295286_6E9772E5)
Date: Tue, 12 Dec 2017 06:38:22 -0800
MIME-Version: 1.0
In-Reply-To: <043841bf-92f4-e240-ea3b-2ae6946aae66@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

I want to say thanks for the help and give an update on where I
got with this.

I was able to build the RTL8192CU driver and it's dependencies
and load them onto my target.  However, I got stuck debugging
some run-time driver dependencies on my Android system that
caused kernel panics.  Unfortunately, I ran out of time to sort
this out and must move on to another project.

A little background for those interested in the details, please
feel free to stop reading.

I'm developing for the Dragonboard 410c single-board computer and
an Android 5.1.1 build provided by the board vendor.  The kernel
version is based on 3.10.49 and modified by the vendor for
Android (last commit for that branch is from July 2015). The
board has a built-in WCN3620 wifi+bluetooth low energy+fm radio
chip.  I think there are two drivers for that: wcnss/wcn36xx,
which is in-tree, and prima, which is out-of-tree.

My project is using both wifi and BLE, but we were having
problems with dropped BLE packets when using both at the same
time, so our workaround was to use a USB wifi adapter and not use
the wcnss/prima wifi driver.  However, we had RTL driver related
problems that caused unreliable wifi performance and dropped
connections.  Hence our choice to backport the latest RTL driver.

The current issue at runtime is that the Android stack still
depends on the WCN3620 driver, so disabling it is not an option.
But building and running both is not an option either, because
both depend on CFG80211 and that is now provided by backports,
and our out-of-tree prima driver isn't backported.  I did notice
a WCN36xx driver in backports (which might solve our original
wifi+ble issue), but it depends on kernel code that appeared in
Sept 2015 and our kernel can't satisfy those dependencies, so we
have build errors.

I think the best path forward is to migrate to the latest build
from the vendor, which is Android 6.0.  That way we'll have a
more up-to-date kernel with driver bug-fixes that might solve our
problem or at least help us backport a shorter distance. But
again, I must move on to another project for now.

Thanks again for all your help!

-Remington

On 12/02/2017 08:31 AM, Remington Furman wrote:
> Hi Johannes,
>
> Thank you very much.  That tip to follow the dependencies helped a 
> lot.  I had been using "/" before, but just learned you can type the 
> numbers in parenthesis in the search results to jump to them. Saves a 
> lot of time.
>
> After working recursively through the dependencies for the backports 
> menuconfig option I wanted (RTL8192CU) I found out that 
> CPTCFG_MAC80211 wasn't appearing as an option in backports because my 
> target kernel did not satisfy it's dependencies for CRYPTO_CCM, 
> CRYPTO_GCM, and CRYPTO_CMAC.  After enabling those on my target 
> kernel, CPTCFG_MAC80211 appeared and I could enable everything in 
> backports down to my desired driver.
>
> Thanks again.  I'll let you know when I'm able to get the new drivers 
> loaded on my target next week.
>
> Cheers,
>
> Remington
>
> On 12/02/2017 12:08 AM, Johannes Berg wrote:
>> On Fri, 2017-12-01 at 16:44 -0800, Remington Furman wrote:
>>
>>> That succeeds and shows me a menu. However, '<M> USB Network
>>> Adapters ----' is an empty menu and the rtl8192cu driver I am
>>> after is not available.  Enabling CPTCFG_WLAN_VENDOR_REALTEK in
>>> 'make menuconfig' doesn't lead to any other options.
>> In menuconfig, hit "/" and search for (part of) the symbol you want
>> (e.g. "RTL8192"), and check the dependencies.
>>
>> It really only has one though "depends on USB", which is weird. Check
>> it there.
>>
>>> If I understand this page correctly, I need to first disable
>>> conflicting drivers in my target kernel .config before running
>>> 'make menuconfig' in backports.
>>> <https://backports.wiki.kernel.org/index.php/Documentation/integration#Kernel_integration_menuconfig> 
>>>
>>> I've tried a number of target kernel configurations, but haven't
>>> found a combination that makes backports happy yet.  I've disable
>>> CONFIG_CFG80211 and CONFIG_WLAN, but no luck.
>> You don't want integration, so I think you can ignore that page.
>>
>> johannes
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
