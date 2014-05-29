Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:39962 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933562AbaE2OjD (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 29 May 2014 10:39:03 -0400
Message-ID: <53874684.5070907@broadcom.com> (sfid-20140529_163907_847654_80FA7EA6)
Date: Thu, 29 May 2014 16:39:00 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Fariya <fariyaf@gmail.com>
CC: <backports@vger.kernel.org>
Subject: Re: Procedure to make the driver into the backports project
References: <CAG+h2qgoudEKwwL7pwYAaSbwvtJw4efi3e_or1yq0YOLm98fuQ@mail.gmail.com>	<53834533.8030800@broadcom.com>	<53834C8E.5020903@broadcom.com> <CAG+h2qgsK5LMaK768sVgpv5e08dPdH0QLoBraRhPDxA7yV2Kfw@mail.gmail.com>
In-Reply-To: <CAG+h2qgsK5LMaK768sVgpv5e08dPdH0QLoBraRhPDxA7yV2Kfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/29/14 12:03, Fariya wrote:
> Hello Arend,
>
> Thanks for the reply. I do have a few more questions:
> a) I kind of went through the existing drivers in the backport release
> and found that the framework that you are talking of is more of #ifdef
> LINUX_VERSION_CODE>= KERNEL_VERSION() handling for various kernels.
> Please correct me if I am wrong.

Kind of correct. A backport release is done taking a snapshot of 
linux-stable and patch it with those ifdef and other tricks. The script 
taking the snapshot and the patches is what is in the backport repo.

Basically, the drivers are copied as is and the kernel functions these 
driver use are subject to being backported when these functions are not 
available in the older kernels.

> b) How do I ensure that my driver gets into backport repo. Do I need
> to send patches [the patch will contain code for various kernels,
> handled via the #ifdef LINUX_VERSION_CODE>= .... code?] for my latest
> driver onto this e-mail list?

The backport takes a snapshot from linux-stable and linux-next so 
anything you send to John will end up in the backport releases. So you 
only need to submit something if the backport driver code would not 
compile, which means some function called in the driver needs backporting.

> c) Assuming my driver gets into the backport repo soon, I am wondering
> how the future versions of my driver will be backported? [considering
> that I would be submitting code compatible to the latest kernel onto
> the linux-wireless mailing list] Do I need to send a patch to the
> backports mailing list, for any submission that I make to the
> linux-wireless mailing list?

As mentioned above there is no need unless you want to contribute to the 
code in the backports repo, ie. the stuff that creates the backport 
releases.

Regards,
Arend

> On Mon, May 26, 2014 at 7:45 PM, Arend van Spriel<arend@broadcom.com>  wrote:
>> On 05/26/14 15:44, Arend van Spriel wrote:
>>>
>>> On 05/26/14 11:47, Fariya wrote:
>>>>
>>>> Hi,
>>>>
>>>> My company's wireless driver is a part of the latest 3.15-rc kernel.
>>>> My question is pertaining to the backports project. How does the
>>>> procedure at backports work? Will my driver be picked up and
>>>> backported by the backports group now that it is part of the kernel or
>>>> the owner of the driver needs to backport the driver [for various
>>>> kernels] and provide it on to this mailing list initially?
>>>
>>>
>>> The backport repo does not hold a backported driver, but a framework to
>>> create a package of the latest drivers which can be automatically
>>> backported to various kernels.
>>>
>>> When you check out the backports repository on kernel.org there is a
>>> copy-list file which lists everything that is copied from the kernel
>>> tree to be included in the backport package. First step would be to add
>>> you driver to that list. If you are lucky that might be sufficient.
>>
>>
>> However, a quick try over here shows not :-p
>>
>> /tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.c: In function
>> rsi_mac80211_attach:
>> /tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.c:988:2: error:
>> implicit declaration of function ether_addr_copy
>> [-Werror=implicit-function-declaration]
>> cc1: some warnings being treated as errors
>> make[7]: ***
>> [/tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.o] Error 1
>>
>> Regards,
>> Arend
>>
>>
>>> Regards,
>>> Arend
>>>
>>>> Regards,
>>>> Fariya
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
>

