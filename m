Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:18162 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233AbbLHIoX (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 8 Dec 2015 03:44:23 -0500
Message-ID: <56669864.3050404@broadcom.com> (sfid-20151208_094430_942811_4B1A5954)
Date: Tue, 8 Dec 2015 09:44:20 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	<backports@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net> <563E301B.7090609@hauke-m.de>
In-Reply-To: <563E301B.7090609@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/07/2015 06:08 PM, Hauke Mehrtens wrote:
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
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> ---
>>   backport/backport-include/linux/ktime.h       |  1 +
>>   backport/backport-include/linux/timekeeping.h | 21 +++++++++++++++++++++
>>   backport/backport-include/linux/types.h       | 10 ++++++++++
>>   3 files changed, 32 insertions(+)
>>   create mode 100644 backport/backport-include/linux/timekeeping.h
>>   create mode 100644 backport/backport-include/linux/types.h
>>
> Thank you for the patch, it was applied.

Hi Hauke, Johannes,

I hit a duplicate export of this function against Fedora 22 kernel 
(v4.0.4). So they apparently backported it in their kernel. So I 
manually removed the function from backports tarball. Could this be 
automated by looking at Module.symvers of the kernel we build against? I 
will explore that if you guys consider it useful.

Regards,
Arend

--
To unsubscribe from this list: send the line "unsubscribe backports" in
