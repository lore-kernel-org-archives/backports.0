Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:42891 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbbLIWwa (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Dec 2015 17:52:30 -0500
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>,
	backports@vger.kernel.org
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
 <563E301B.7090609@hauke-m.de> <56669864.3050404@broadcom.com>
 <1449565444.4154.1.camel@sipsolutions.net>
 <1449566082.4154.6.camel@sipsolutions.net> <5666A2C8.3070002@broadcom.com>
 <1449567481.4154.9.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5668B0AC.2080602@hauke-m.de> (sfid-20151209_235239_550932_EA06C36D)
Date: Wed, 9 Dec 2015 23:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <1449567481.4154.9.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/08/2015 10:38 AM, Johannes Berg wrote:
> On Tue, 2015-12-08 at 10:28 +0100, Arend van Spriel wrote:
>>  
>> Basically the list would be the exported symbols from the backports 
>> module, ie. compat.ko, right?
>>
> 
> Perhaps, I think it's slightly more complicated.
> 
> For one, we mostly prefix them with backport_, so just using as-is
> won't work.
> 
> Secondly, we might sometimes intentionally do that, even though the
> original function *does* exist, like with debugfs_create_bool() that
> changed function signature.
> 
> I think it'd be safer to just do it one by one - but we might be able
> to get rid of a lot of the RHEL/ubuntu/whatever ifdefs that way?
> 
> We might also be able to use them to ifdef some inlines that belong to
> it? Overall it seems better to just do it by hand but as a better
> mechanism than checking kernel versions?
> 
> johannes

We could search backport/compat/*.c for EXPORT_SYMBOL() and create the
list based on that. Using compat.ko for that would mean we have to
compile first.
Based on this data we can check if the kernel would export this function
and create a "#define HAVE_FUNFION_NAME 1"

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
