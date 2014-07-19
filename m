Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:51381 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281AbaGSQRS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 19 Jul 2014 12:17:18 -0400
Message-ID: <53CA9A08.8020809@hauke-m.de> (sfid-20140719_181723_415323_15591055)
Date: Sat, 19 Jul 2014 18:17:12 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] backports: include gpio consumer.h
References: <1404999110-13791-1-git-send-email-sassmann@kpanic.de> <53C83544.7030306@hauke-m.de> <CAB=NE6VYf61WM094=QaY9+wMe7z_mk8eZeZVgkhr9=9AWrNpFQ@mail.gmail.com> <53C8CFBE.1030208@kpanic.de>
In-Reply-To: <53C8CFBE.1030208@kpanic.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/18/2014 09:41 AM, Stefan Assmann wrote:
> On 17.07.2014 23:27, Luis R. Rodriguez wrote:
>> On Thu, Jul 17, 2014 at 1:42 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>> On 07/10/2014 03:31 PM, Stefan Assmann wrote:
>>>> While doing a make allmodconfig I noticed the following:
>>>>    CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
>>>> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal
>>>> error: linux/gpio/consumer.h: No such file or directory
>>>>
>>>> Including the header fixes the error.
>>>>
>>>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>>>> ---
>>>>   copy-list | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/copy-list b/copy-list
>>>> index 7ad8972..b52e9f2 100644
>>>> --- a/copy-list
>>>> +++ b/copy-list
>>>> @@ -107,6 +107,10 @@ drivers/net/ethernet/intel/Kconfig
>>>>   drivers/net/ethernet/intel/Makefile
>>>>   drivers/net/ethernet/intel/igb/
>>>>
>>>> +# gpio
>>>> +include/linux/gpio/
>>>> +include/linux/gpio/consumer.h
>>>> +
>>>>   # wwan drivers
>>>>   include/uapi/linux/usb/cdc.h
>>>>   include/uapi/linux/usb/cdc-wdm.h
>>>>
>>> Is this correct? backports does not provide the implementation of the
>>> functions in include/linux/gpio/consumer.h and it will result in hard to
>>> debug problems with some function signature is different in our version
>>> of consumer.h and the version in the kernel.
>>>
>>> I am against backporting this and would add an empty version of this
>>> header.
>>
>> config GPIO_DEVRES
>>          def_bool y
>>          depends on HAS_IOMEM
>>
>> Indeed, we can't backport this yet as we have no support for in-kernel
>> functionality to be backported yet.
>>
>> Reverted.
> 
> So, with just an empty header we get:
>   CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c: In function
> ‘adv7604_set_hpd’:
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:613:3: error:
> implicit declaration of function ‘gpiod_set_value_cansleep’
> [-Werror=implicit-function-declaration]
>    gpiod_set_value_cansleep(state->hpd_gpio[i], hpd & BIT(i));
>    ^
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c: In function
> ‘adv7604_probe’:
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:2797:4: error:
> implicit declaration of function ‘devm_gpiod_get_index’
> [-Werror=implicit-function-declaration]
>     devm_gpiod_get_index(&client->dev, "hpd", i);
>     ^
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:2796:22: warning:
> assignment makes pointer from integer without a cast [enabled by default]
>    state->hpd_gpio[i] =
>                       ^
> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:2801:3: error:
> implicit declaration of function ‘gpiod_direction_output’
> [-Werror=implicit-function-declaration]
>    gpiod_direction_output(state->hpd_gpio[i], 0);
> 
> If we can't backport these, what do we do? Disable the module for now?
> 
>   Stefan

Hi,

if you do not need this driver removing it or make it depend on kernel
3.13 in which the header was added should be fine.

Hauke
