Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:54095 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbaEZOPo (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 26 May 2014 10:15:44 -0400
Message-ID: <53834C8E.5020903@broadcom.com> (sfid-20140526_161546_905133_A9DF5DDB)
Date: Mon, 26 May 2014 16:15:42 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Fariya <fariyaf@gmail.com>
CC: <backports@vger.kernel.org>
Subject: Re: Procedure to make the driver into the backports project
References: <CAG+h2qgoudEKwwL7pwYAaSbwvtJw4efi3e_or1yq0YOLm98fuQ@mail.gmail.com> <53834533.8030800@broadcom.com>
In-Reply-To: <53834533.8030800@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/26/14 15:44, Arend van Spriel wrote:
> On 05/26/14 11:47, Fariya wrote:
>> Hi,
>>
>> My company's wireless driver is a part of the latest 3.15-rc kernel.
>> My question is pertaining to the backports project. How does the
>> procedure at backports work? Will my driver be picked up and
>> backported by the backports group now that it is part of the kernel or
>> the owner of the driver needs to backport the driver [for various
>> kernels] and provide it on to this mailing list initially?
>
> The backport repo does not hold a backported driver, but a framework to
> create a package of the latest drivers which can be automatically
> backported to various kernels.
>
> When you check out the backports repository on kernel.org there is a
> copy-list file which lists everything that is copied from the kernel
> tree to be included in the backport package. First step would be to add
> you driver to that list. If you are lucky that might be sufficient.

However, a quick try over here shows not :-p

/tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.c: In 
function rsi_mac80211_attach:
/tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.c:988:2: 
error: implicit declaration of function ether_addr_copy 
[-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[7]: *** 
[/tmp/backporst-rsi/drivers/net/wireless/rsi/rsi_91x_mac80211.o] Error 1

Regards,
Arend

> Regards,
> Arend
>
>> Regards,
>> Fariya
>> --
>> To unsubscribe from this list: send the line "unsubscribe backports" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

