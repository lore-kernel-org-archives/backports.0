Return-path: <backports-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:38933 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbaFEVaN (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 5 Jun 2014 17:30:13 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so175897vcb.24
        for <backports@vger.kernel.org>; Thu, 05 Jun 2014 14:30:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG+h2qjirPQYDnajR-3VBvZgr+TxBkMwS3q5xXUrNC+YQmfuog@mail.gmail.com>
References: <CAG+h2qgoudEKwwL7pwYAaSbwvtJw4efi3e_or1yq0YOLm98fuQ@mail.gmail.com>
	<53834533.8030800@broadcom.com>
	<53834C8E.5020903@broadcom.com>
	<CAG+h2qgsK5LMaK768sVgpv5e08dPdH0QLoBraRhPDxA7yV2Kfw@mail.gmail.com>
	<53874684.5070907@broadcom.com>
	<CAG+h2qjirPQYDnajR-3VBvZgr+TxBkMwS3q5xXUrNC+YQmfuog@mail.gmail.com>
Date: Fri, 6 Jun 2014 03:00:11 +0530
Message-ID: <CAG+h2qgi_bwyiC0YPSAkeXda7hTffVk6VbR8wA+gh5ztuTYQKQ@mail.gmail.com> (sfid-20140605_233015_576182_0E5B32AC)
Subject: Re: Procedure to make the driver into the backports project
From: Fariya <fariyaf@gmail.com>
To: Arend van Spriel <arend@broadcom.com>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

Thanks for answering all my queries so far. I just wanted to clarify
one important thing - The latest backport release is of the kernel
3.15-rc1-1. [http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/]
So this means I need to submit my patch(es) for this kernel or the
latest kernel available on kernel.org which is 3.15-rc8? Also, can I
send like a single patch which handles all kernels or do I need to
submit patches for each kernel from 3.0 to 3.14?

Regards,
Fariya


On Thu, Jun 5, 2014 at 3:57 AM, Fariya <fariyaf@gmail.com> wrote:

> On Thu, May 29, 2014 at 8:09 PM, Arend van Spriel <arend@broadcom.com> wrote:
>> On 05/29/14 12:03, Fariya wrote:
>>>
>>> Hello Arend,
>>>
>>> Thanks for the reply. I do have a few more questions:
>>> a) I kind of went through the existing drivers in the backport release
>>> and found that the framework that you are talking of is more of #ifdef
>>> LINUX_VERSION_CODE>= KERNEL_VERSION() handling for various kernels.
>>> Please correct me if I am wrong.
>>
>>
>> Kind of correct. A backport release is done taking a snapshot of
>> linux-stable and patch it with those ifdef and other tricks. The script
>> taking the snapshot and the patches is what is in the backport repo.
>>
>> Basically, the drivers are copied as is and the kernel functions these
>> driver use are subject to being backported when these functions are not
>> available in the older kernels.
>>
>>
>>> b) How do I ensure that my driver gets into backport repo. Do I need
>>> to send patches [the patch will contain code for various kernels,
>>> handled via the #ifdef LINUX_VERSION_CODE>= .... code?] for my latest
>>> driver onto this e-mail list?
>>
>>
>> The backport takes a snapshot from linux-stable and linux-next so anything
>> you send to John will end up in the backport releases. So you only need to
>> submit something if the backport driver code would not compile, which means
>> some function called in the driver needs backporting.
>>
>>
>>> c) Assuming my driver gets into the backport repo soon, I am wondering
>>> how the future versions of my driver will be backported? [considering
>>> that I would be submitting code compatible to the latest kernel onto
>>> the linux-wireless mailing list] Do I need to send a patch to the
>>> backports mailing list, for any submission that I make to the
>>> linux-wireless mailing list?
>>
>>
>> As mentioned above there is no need unless you want to contribute to the
>> code in the backports repo, ie. the stuff that creates the backport
>> releases.
>>
>> Regards,
>> Arend
>>
>>
>>> On Mon, May 26, 2014 at 7:45 PM, Arend van Spriel<arend@broadcom.com>
>>> wrote:
>>>>
>>>> On 05/26/14 15:44, Arend van Spriel wrote:
>>>>>
>>>>>
>>>>> On 05/26/14 11:47, Fariya wrote:
>>>>>>
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> My company's wireless driver is a part of the latest 3.15-rc kernel.
>>>>>> My question is pertaining to the backports project. How does the
>>>>>> procedure at backports work? Will my driver be picked up and
>>>>>> backported by the backports group now that it is part of the kernel or
>>>>>> the owner of the driver needs to backport the driver [for various
>>>>>> kernels] and provide it on to this mailing list initially?
>>>>>
>>>>>
>>>>>
>>>>> The backport repo does not hold a backported driver, but a framework to
>>>>> create a package of the latest drivers which can be automatically
>>>>> backported to various kernels.
>>>>>
>>>>> When you check out the backports repository on kernel.org there is a
>>>>> copy-list file which lists everything that is copied from the kernel
>>>>> tree to be included in the backport package. First step would be to add
>>>>> you driver to that list. If you are lucky that might be sufficient.
>>>>
>>>>
>>>>
>>>> However, a quick try over here shows not :-p
>>>>
>>>> /tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.c: In
>>>> function
>>>> rsi_mac80211_attach:
>>>> /tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.c:988:2:
>>>> error:
>>>> implicit declaration of function ether_addr_copy
>>>> [-Werror=implicit-function-declaration]
>>>> cc1: some warnings being treated as errors
>>>> make[7]: ***
>>>> [/tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.o] Error 1
>>>>
>>>> Regards,
>>>> Arend
>>>>
>>>>
>>>>> Regards,
>>>>> Arend
>>>>>
>>>>>> Regards,
>>>>>> Fariya
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe backports" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
>
>
>
> --
> -Fariya Fatima



-- 
-Fariya Fatima
