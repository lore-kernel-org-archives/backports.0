Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:6506 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932522AbbLHJ2n (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 8 Dec 2015 04:28:43 -0500
Message-ID: <5666A2C8.3070002@broadcom.com> (sfid-20151208_102847_876978_85CDBA46)
Date: Tue, 8 Dec 2015 10:28:40 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>, <backports@vger.kernel.org>
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>	 <563E301B.7090609@hauke-m.de> <56669864.3050404@broadcom.com>	 (sfid-20151208_094430_942811_4B1A5954) <1449565444.4154.1.camel@sipsolutions.net>	 (sfid-20151208_100442_655563_BC7335A1) <1449566082.4154.6.camel@sipsolutions.net>
In-Reply-To: <1449566082.4154.6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/08/2015 10:14 AM, Johannes Berg wrote:
> On Tue, 2015-12-08 at 10:04 +0100, Johannes Berg wrote:
>>
>> That's not a bad idea. We could have a script that creates some kind
>> of
>> header file with #define HAVE_KTIME_GET_SECONDS and then we could use
>> that. We could even just do that for every single exported functions,
>> that will just be a few hundred lines but shouldn't matter much? :)
>>
>
> Ok maybe not - on a very small test configuration for me that's
> actually something like 6.5k lines...
>
> I guess then we could ship a list of functions we want to look at, like
> a file that simply lists one function per line:

Basically the list would be the exported symbols from the backports 
module, ie. compat.ko, right?

Gr. AvS

> symbols-check:
>>>>
> ktime_get_seconds
> <<<
>
> and then we can do something like
>
> grep -f symbols-check /path/to/Module.symvers | \
> 	cut -f2 | \
> 	tr 'a-z' 'A-Z' | \
> 	sed 's/^/#define HAVE_/;s/$/ 1/' \
> 	> backport-include/backport/existing-symbols.h
>
> and include that in the right place?
>
> johannes
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
