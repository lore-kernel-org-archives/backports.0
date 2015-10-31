Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:4978 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbJaWDG (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 31 Oct 2015 18:03:06 -0400
Message-ID: <56353A97.9010909@broadcom.com> (sfid-20151031_230309_063065_4BDE2E04)
Date: Sat, 31 Oct 2015 23:03:03 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	<backports@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net> <56313B75.4000406@broadcom.com>
In-Reply-To: <56313B75.4000406@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/28/2015 10:17 PM, Arend van Spriel wrote:
> On 10/23/2015 01:52 PM, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Since commit 84b00607aeb8 ("mac80211: use ktime_get_seconds")
>> mac80211 uses ktime_get_seconds(). This patch provide a backport
>> using ktime_get_ts() for it.
>>
>> [commit message and time64_t taken from Arend's patch]
>>
>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>
> Looks good. Thanks.

Actually got feedback internally that ubuntu kernel 3.19.0-30-generic 
does not need this patch so should we extend this with 
UTS_UBUNTU_RELEASE_ABI check?

Regards,
Arend

> Regards,
> Arend
>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> ---
>>   backport/backport-include/linux/ktime.h       |  1 +
>>   backport/backport-include/linux/timekeeping.h | 21
>> +++++++++++++++++++++
>>   backport/backport-include/linux/types.h       | 10 ++++++++++
>>   3 files changed, 32 insertions(+)
>>   create mode 100644 backport/backport-include/linux/timekeeping.h
>>   create mode 100644 backport/backport-include/linux/types.h
>>
>> diff --git a/backport/backport-include/linux/ktime.h
>> b/backport/backport-include/linux/ktime.h
>> index 6fbc6c6eb26c..33ed31caf01a 100644
>> --- a/backport/backport-include/linux/ktime.h
>> +++ b/backport/backport-include/linux/ktime.h
>> @@ -1,6 +1,7 @@
>>   #ifndef __BACKPORT_LINUX_KTIME_H
>>   #define __BACKPORT_LINUX_KTIME_H
>>   #include_next <linux/ktime.h>
>> +#include <linux/timekeeping.h>
>>   #include <linux/version.h>
>>
>>   #if  LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
>> diff --git a/backport/backport-include/linux/timekeeping.h
>> b/backport/backport-include/linux/timekeeping.h
>> new file mode 100644
>> index 000000000000..4fb39b2c0119
>> --- /dev/null
>> +++ b/backport/backport-include/linux/timekeeping.h
>> @@ -0,0 +1,21 @@
>> +#ifndef __BACKPORT_TIMKEEPING_H
>> +#define __BACKPORT_TIMKEEPING_H
>> +#include <linux/version.h>
>> +#include <linux/types.h>
>> +
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
>> +#include_next <linux/timekeeping.h>
>> +#endif
>> +
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
>> +static inline time64_t ktime_get_seconds(void)
>> +{
>> +    struct timespec t;
>> +
>> +    ktime_get_ts(&t);
>> +
>> +    return t.tv_sec;
>> +}
>> +#endif
>> +
>> +#endif /* __BACKPORT_TIMKEEPING_H */
>> diff --git a/backport/backport-include/linux/types.h
>> b/backport/backport-include/linux/types.h
>> new file mode 100644
>> index 000000000000..d68e39c54325
>> --- /dev/null
>> +++ b/backport/backport-include/linux/types.h
>> @@ -0,0 +1,10 @@
>> +#ifndef __BACKPORT_TYPES
>> +#define __BACKPORT_TYPES
>> +#include <linux/version.h>
>> +#include_next <linux/types.h>
>> +
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
>> +typedef __s64 time64_t;
>> +#endif
>> +
>> +#endif /* __BACKPORT_TYPES */
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in

--
To unsubscribe from this list: send the line "unsubscribe backports" in
