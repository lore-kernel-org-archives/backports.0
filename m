Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:14312 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934795AbaDJLOf (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 10 Apr 2014 07:14:35 -0400
Message-ID: <53467D18.4000100@broadcom.com> (sfid-20140410_131437_954727_F092B2D7)
Date: Thu, 10 Apr 2014 13:14:32 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: ckmake build issue with undefined symbol mcount
References: <5342AED7.5080505@kpanic.de> <CAB=NE6WdU4fLKz9eMbVFqiD-r4YE2Hz8fo2cH9A18R7ap=hvDA@mail.gmail.com> <5343A7A8.6010508@kpanic.de> <534649D8.6040208@kpanic.de>
In-Reply-To: <534649D8.6040208@kpanic.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/10/14 09:35, Stefan Assmann wrote:
> On 08.04.2014 09:39, Stefan Assmann wrote:
>> On 08.04.2014 02:37, Luis R. Rodriguez wrote:
>>> On Mon, Apr 7, 2014 at 6:57 AM, Stefan Assmann<sassmann@kpanic.de>  wrote:
>>>> next-20140221
>>>
>>> Did you git reset --hard backports-20140221 ? The respective dated tag
>>> for backports must be used for a specific dated tag for linux-next.
>>> Likewise for the stable releases.
>>>
>>>    Luis
>>>
>>
>> My backports tree is at 8e946501aef6e3dd5bac12eb45d24df8248672b0 which
>> should be the same as backports-20140221.
>>
>>    Stefan
>>
>
> I tried the same again in a newly installed VM and don't see any issues
> there. Probably an issue with my build env then. Please ignore.

It may related to the used gcc version. I recall a similar issue with 
mcount when I had a kernel build with a different gcc than the driver 
module.

Regards,
Arend

>    Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

