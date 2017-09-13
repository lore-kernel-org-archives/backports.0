Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:46262 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbdIMUA2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 13 Sep 2017 16:00:28 -0400
Received: by mail-wm0-f47.google.com with SMTP id i189so15075222wmf.1
        for <backports@vger.kernel.org>; Wed, 13 Sep 2017 13:00:27 -0700 (PDT)
Subject: Re: [PATCH 00/21] backports: multiple changes for kernel 3.13-rc6
To: Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <1504602018.12380.3.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7ee0d9f0-1928-37b7-510e-a3d852ab64c4@broadcom.com> (sfid-20170913_220029_903009_8C2EBF15)
Date: Wed, 13 Sep 2017 22:00:25 +0200
MIME-Version: 1.0
In-Reply-To: <1504602018.12380.3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 05-09-17 11:00, Johannes Berg wrote:
> Hi Hauke,
> 

[...]

>> patches/0079-netdev-destructor.cocci takes very long to apply, about
>> 3 times longer all others together.
> 
> I doubt we can do anything about that.

Not sure what is causing it. Might just be the amount of network device 
drivers. When discussing (parts of) this spatch Julia mentioned about 
use of disjunction vs expression:

"""
You can put a disjunction: \(fn1\|fn2\).  Another option is to make an
identifier metavariable with an appropriate regular expression, but this
would be less efficient than the disjuction option.  Coccinelle does 
some optimizations based on what is the pattern matching code, but not 
regular expression constraints.
"""

but I ended up using the disjunction:

RET = \(register_netdevice\|register_ndev\)(NDEV);
if (<+... RET ...+>) {

so that can not be optimized further.

>> Should we remove ssb and bcma from backports and use the in kernel
>> versions instead? I do not expect so many changes any more affecting
>> the wifi drivers.
> 
> I have no opinion either way.

There may be some new cores coming up in our wifi chips that BCMA would 
need to add, but also heard rumors about switching to new backplane type.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
