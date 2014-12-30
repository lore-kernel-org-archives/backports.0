Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41232 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaL3TRo (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Dec 2014 14:17:44 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so12235085iec.37
        for <backports@vger.kernel.org>; Tue, 30 Dec 2014 11:17:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54A2789C.7050407@hauke-m.de>
References: <CAK8F28=6-rCCbAwA20OvW3VMFG8yBV7oZpvgRcNL1s=snR33Sg@mail.gmail.com>
 <54A2789C.7050407@hauke-m.de>
From: Ash Charles <ashcharles@gmail.com>
Date: Tue, 30 Dec 2014 11:17:13 -0800
Message-ID: <CAK8F28mGHbPPjcd_7vwH2D8m9qqBqgEkQbY9AnemMwOJjFG+pw@mail.gmail.com> (sfid-20141230_201746_826261_9C7C5BCA)
Subject: Re: Providing Platform Data to Backported Module
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Hauke,

Thanks for the response---this makes sense and led me to a (hopefully
correct) understanding of what's happening.

Unfortunately, this particular driver uses a special built-in function
rather than the generic platform_device to set platform data.  For
reference, this is the wl12xx_set_platform_data and
wl12xx_get_platform_data functions found in
drivers/net/wireless/ti/wilink_platform_data.c file in new kernels.
The setter function is built-in and called directly from the board
file.

After a little more digging, it looks like the adopted solution checks
if the target kernel has these getter/setter functions (i.e.
CONFIG_WL12XX_PLATFORM_DATA or CONFIG_WILINK_PLATFORM_DATA enables
CPTCFG_UNIFIED_WILNK_PLATFORM_DATA).  If it does, then the board file
can just call the setter--totally built-in behaviour---and the
backported driver can call the built-in getter to fetch this data.
Otherwise, we need to rely on a device tree blob or some hard coding
to provide the data.

Thanks again,
--Ash

On Tue, Dec 30, 2014 at 2:04 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 12/30/2014 02:54 AM, Ash Charles wrote:
>> Hello,
>>
>> I'm trying to get add support for a wl18xx wireless device to my
>> omap3-based board running a 3.2 kernel.  Using backports (package, not
>> direct integration), I can compile the required drivers and load them
>> onto my system.  The driver needs some platform-specific data to
>> control the wireless device.  Normally, I'd pass this as platform data
>> from a board file (I'm not using device tree on this 3.2 kernel) but
>> as the required structures come from the backport, I can't.  How can I
>> provide this data to the module?
>>
>> Things that come to mind but don't seem quite right:
>> 1. Hard-code this setup data into the driver for my particular board
>> (seem a little heavy-handed)
>> 2. Add a backport to support a board file/pdata-quirks. (nothing else
>> in the arch tree is backported...seems to indicate this is not the
>> right way)
>> 3. Use the backports with direct integration as I think I could just
>> make the changes to the board file directly in this case (I'm using a
>> TI backport tree that doesn't support integration yet)
>> 4. Add a device tree blob or some shim such that the target kernel can
>> provide the module the data.
>>
>> Many thanks in advance for any advice or insight.
>
> You could remove the platform data header file from backports and use
> the one from your kernel, just delete the header file in backports. If
> this version does not have all the needed members just copy the header
> file from backpots into your kernel. Then you can register the device
> like any other device in your board file and fill the platform data with
> the needed data.
>
> Hauke
