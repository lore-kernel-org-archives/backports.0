Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:55281 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbJWLR0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 23 Oct 2015 07:17:26 -0400
Message-ID: <562A1743.9080406@broadcom.com> (sfid-20151023_131729_082416_E4188F5D)
Date: Fri, 23 Oct 2015 13:17:23 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] backports: add ktime_get_seconds()
References: <1445584991-11249-1-git-send-email-johannes@sipsolutions.net>	 <5629FEB3.6050905@broadcom.com> (sfid-20151023_113239_295482_F75BC0A3) <1445592856.1945.0.camel@sipsolutions.net>
In-Reply-To: <1445592856.1945.0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/23/2015 11:34 AM, Johannes Berg wrote:
> On Fri, 2015-10-23 at 11:32 +0200, Arend van Spriel wrote:
>> On 10/23/2015 09:23 AM, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Already submitted a patch for this. I just did not bother to
>> introduce the timekeeping.h file. So yours may be preferred.
>>
>
> Oh, missed that. Yours is better with time64_t though, so we should
> probably merge them...

Be my guest ;-)

> Adding the timekeeping.h file might be required if, in the future,
> somebody includes only it instead of ktime.h

Yeah. I got the impression that timekeeping.h should not be included 
directly, but that might not stop people from doing it anyway.

Regards,
Arend

--
To unsubscribe from this list: send the line "unsubscribe backports" in
