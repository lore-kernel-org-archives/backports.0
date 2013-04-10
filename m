Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:62079 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542Ab3DJRIH (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 13:08:07 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so761580lbh.4
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 10:08:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365599791.8388.16.camel@jlt4.sipsolutions.net>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
 <1365593728-5720-3-git-send-email-mcgrof@do-not-panic.com> <1365599791.8388.16.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 10 Apr 2013 10:07:44 -0700
Message-ID: <CAB=NE6XVe1UcpXozrpC62z750kveY2ACi_-oKVohSZcMNRxSPQ@mail.gmail.com> (sfid-20130410_190810_059831_A82B2300)
Subject: Re: [PATCH 02/18] compat: backport dev_level_ratelimited()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 10, 2013 at 6:16 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
>
> Applied.
>
>> +++ b/backport/include/linux/compat-3.5.h
>> @@ -10,6 +10,42 @@
>>
>>  #include <net/netlink.h>
>>
>> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
>> +#include <linux/ratelimit.h>
>
> I think, however, that it would be easier to understand if we started
> putting less stuff into compat-xyz.h and more into linux/feature.h?
> Needs more discussion though I guess.

Sure, lets what's the idea or do you want to do that on another thread?

  Luis
