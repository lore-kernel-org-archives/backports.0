Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:2619 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbbIINhZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Sep 2015 09:37:25 -0400
Message-ID: <55F03612.6040809@broadcom.com> (sfid-20150909_153729_680825_45483DBC)
Date: Wed, 9 Sep 2015 15:37:22 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: backport devcoredump
References: <55EFEEF2.2060205@broadcom.com>	 <1441788585.3316.2.camel@sipsolutions.net> <55F02021.3060603@broadcom.com> <1441801810.3316.6.camel@sipsolutions.net> <55F02882.5080207@broadcom.com>
In-Reply-To: <55F02882.5080207@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/09/2015 02:39 PM, Arend van Spriel wrote:
> On 09/09/2015 02:30 PM, Johannes Berg wrote:
>> On Wed, 2015-09-09 at 14:03 +0200, Arend van Spriel wrote:
>>>
>>>> I guess I'll need to run that - are you using a special copy-list?
>>>
>>> I do and maybe that is causing it. I attached it.
>>>
>>
>> Unlikely. However, I can't reproduce your issue - if I just add "select
>> WANT_DEV_COREDUMP" to your driver (brcmsmac) in my tree and compile
>> with that I do get it enabled.

I guess the WANT_DEV_COREDUMP must be in the source tree to generate 
drivers-base-devcoredump.c etc. I used backports generated tree using my 
copy-list so not driver selects WANT_DEV_COREDUMP, because I applied the 
brcmfmac devcoredump patch on the backports generated tree.

Gr. AvS

> Thanks for checking.
>
>> Can you share your driver changes for it?
>
> I will dig a bit deeper here. It must be something trivial. If I run
> with backports/master I do get drivers-base-devcoredump.c in compat
> folder so it must be in my branch which includes the copy-list change.
>
> Gr. AvS
>
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in

--
To unsubscribe from this list: send the line "unsubscribe backports" in
