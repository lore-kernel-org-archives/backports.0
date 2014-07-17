Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:47290 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbaGQV2P (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Jul 2014 17:28:15 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so2188215lab.6
        for <backports@vger.kernel.org>; Thu, 17 Jul 2014 14:28:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53C83544.7030306@hauke-m.de>
References: <1404999110-13791-1-git-send-email-sassmann@kpanic.de> <53C83544.7030306@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 17 Jul 2014 14:27:53 -0700
Message-ID: <CAB=NE6VYf61WM094=QaY9+wMe7z_mk8eZeZVgkhr9=9AWrNpFQ@mail.gmail.com> (sfid-20140717_232817_759173_1EB7C81A)
Subject: Re: [PATCH] backports: include gpio consumer.h
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Stefan Assmann <sassmann@kpanic.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jul 17, 2014 at 1:42 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 07/10/2014 03:31 PM, Stefan Assmann wrote:
>> While doing a make allmodconfig I noticed the following:
>>   CC [M]  /dev/shm/backports-next/drivers/media/i2c/adv7604.o
>> /dev/shm/backports-next/drivers/media/i2c/adv7604.c:31:33: fatal error: linux/gpio/consumer.h: No such file or directory
>>
>> Including the header fixes the error.
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  copy-list | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/copy-list b/copy-list
>> index 7ad8972..b52e9f2 100644
>> --- a/copy-list
>> +++ b/copy-list
>> @@ -107,6 +107,10 @@ drivers/net/ethernet/intel/Kconfig
>>  drivers/net/ethernet/intel/Makefile
>>  drivers/net/ethernet/intel/igb/
>>
>> +# gpio
>> +include/linux/gpio/
>> +include/linux/gpio/consumer.h
>> +
>>  # wwan drivers
>>  include/uapi/linux/usb/cdc.h
>>  include/uapi/linux/usb/cdc-wdm.h
>>
> Is this correct? backports does not provide the implementation of the
> functions in include/linux/gpio/consumer.h and it will result in hard to
> debug problems with some function signature is different in our version
> of consumer.h and the version in the kernel.
>
> I am against backporting this and would add an empty version of this header.

config GPIO_DEVRES
        def_bool y
        depends on HAS_IOMEM

Indeed, we can't backport this yet as we have no support for in-kernel
functionality to be backported yet.

Reverted.

 Luis
