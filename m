Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:47085 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750962AbdILVjn (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 12 Sep 2017 17:39:43 -0400
Subject: Re: [PATCH 6/8] header: add pm_system_wakeup()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <20170910221020.13067-1-hauke@hauke-m.de>
 <20170910221020.13067-7-hauke@hauke-m.de>
 <1505208953.1974.5.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <a5a744b1-a7fe-0015-5f09-5463100407db@hauke-m.de> (sfid-20170912_233944_487410_CB0B418B)
Date: Tue, 12 Sep 2017 23:39:39 +0200
MIME-Version: 1.0
In-Reply-To: <1505208953.1974.5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/12/2017 11:35 AM, Johannes Berg wrote:
> On Mon, 2017-09-11 at 00:10 +0200, Hauke Mehrtens wrote:
>>
>> +#if LINUX_VERSION_IS_LESS(3,18,0)
>> +static inline void pm_system_wakeup(void)
>> +{
>> +	freeze_wake();
>> +}
>> +#endif
> 
> freeze_wake() was also "only" added around 3.10 or something like that,
> so perhaps we should just not backport this at all but version-guard
> the drivers needing it? I'm not super comfortable with the reduced
> functionality anyway.

Hi,

This is only used by mwifiex so I am also fine with making mwifiex
depend on kernel 3.18 or higher.

Will you create a patch and revert mine?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
