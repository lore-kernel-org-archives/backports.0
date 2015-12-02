Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:53187 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbbLBKd3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 2 Dec 2015 05:33:29 -0500
Message-ID: <565EC8F7.4030800@broadcom.com> (sfid-20151202_113331_803739_B501D6E3)
Date: Wed, 2 Dec 2015 11:33:27 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH v2] backports: add ktime_get_boot_ns()
References: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net>	 (sfid-20151202_095640_670832_C3102C13) <1449046985.2449.0.camel@sipsolutions.net>	 (sfid-20151202_100312_233801_691AC5CB) <1449047089.2449.1.camel@sipsolutions.net>
In-Reply-To: <1449047089.2449.1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/02/2015 10:04 AM, Johannes Berg wrote:
> On Wed, 2015-12-02 at 10:03 +0100, Johannes Berg wrote:
>> On Wed, 2015-12-02 at 09:56 +0100, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>>
>>> This small helper inline was added in 3.17, we want to use it now
>>> so need to backport it.
>>>
>> And now I see that you'd already done this - sorry!
>>
>
> No, you didn't - not the boot one...
>
> But you did say that including hrtimer didn't work - it does for me,
> but if you need to change it then feel free.

Got a feeling I missing a side of this story. Still got a feeling you 
need more coffee ;-)

Gr. AvS

--
To unsubscribe from this list: send the line "unsubscribe backports" in
