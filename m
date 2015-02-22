Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:58298 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbbBVHg1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Feb 2015 02:36:27 -0500
Message-ID: <54E986F8.8030608@broadcom.com> (sfid-20150222_083630_039049_9951B605)
Date: Sun, 22 Feb 2015 08:36:24 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH 1/2] backport: small copy&paste error fixed
References: <1422648758-31361-1-git-send-email-arend@broadcom.com> <54E939A3.5050202@hauke-m.de>
In-Reply-To: <54E939A3.5050202@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/22/15 03:06, Hauke Mehrtens wrote:
> On 01/30/2015 09:12 PM, Arend van Spriel wrote:
>> Changed the version number in the file header comment.
>>
>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>> ---
>>   backport/compat/backport-3.19.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
>> index c633f38..0b59bef 100644
>> --- a/backport/compat/backport-3.19.c
>> +++ b/backport/compat/backport-3.19.c
>> @@ -1,7 +1,7 @@
>>   /*
>>    * Copyright (c) 2014  Hauke Mehrtens<hauke@hauke-m.de>
>>    *
>> - * Backport functionality introduced in Linux 3.18.
>> + * Backport functionality introduced in Linux 3.19.
>>    *
>>    * This program is free software; you can redistribute it and/or modify
>>    * it under the terms of the GNU General Public License version 2 as
>>
>
> Thank you for the patch, it was applied to backports, somehow I missed
> the second one I will take care of it later.

I think I cause confusion renaming the patch subject to "backport: add 
backport for get_net_ns_by_fd()" [1].

Regards,
Arend

[1] http://mid.gmane.org/1422659632-8673-1-git-send-email-arend@broadcom.com
