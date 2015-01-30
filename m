Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:3328 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbbA3U2Z (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 30 Jan 2015 15:28:25 -0500
Message-ID: <54CBE966.7030600@broadcom.com> (sfid-20150130_212827_372895_EBF94334)
Date: Fri, 30 Jan 2015 21:28:22 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH 2/2] backport: add backport file for the next kernel release
References: <1422648758-31361-1-git-send-email-arend@broadcom.com>	 <1422648758-31361-2-git-send-email-arend@broadcom.com>	 (sfid-20150130_211248_858610_757440B4) <1422649309.1919.42.camel@sipsolutions.net>
In-Reply-To: <1422649309.1919.42.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/30/15 21:21, Johannes Berg wrote:
> On Fri, 2015-01-30 at 21:12 +0100, Arend van Spriel wrote:
>
>> --- /dev/null
>> +++ b/backport/compat/backport-3.20.c
>> @@ -0,0 +1,17 @@
>> +/*
>> + * Copyright (c) 2014  Hauke Mehrtens<hauke@hauke-m.de>
>
> Speaking of copy/paste errors ... :)

Hah! :-D Will fix that and the year.

>> + * Backport functionality introduced in Linux 3.19.

And this one.

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#include<linux/export.h>
>> +#include<linux/net.h>
>> +
>> +struct net *get_net_ns_by_fd(int fd)
>> +{
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +EXPORT_SYMBOL_GPL(get_net_ns_by_fd);
>
> Interesting approach - you're relying on a previously existing
> definition in some existing header file I guess? But does it always
> exist?
>
> I think it'd probably be better to have this in
> backports-include/net/net_namespace.h, like so:
>
> #define get_net_ns_by_fd LINUX_BACKPORT(get_net_ns_by_fd)
> static inline struct net *get_net_ns_by_fd(int fd)
> {
> 	return ERR_PTR(-EINVAL);
> }

This was indeed the trick that I was looking for.

> because that not only saves the huge EXPORT_SYMBOL thing (that's like a
> few hundred bytes IIRC!) but also makes sure that the definition is
> always really there?

Is that a question? Guess not. I will make a V2.

Regards,
Arend

> Anyway as long as this was there on 3.0 already both approaches work, of
> course.
