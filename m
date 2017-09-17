Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:41250 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdIQWIC (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 17 Sep 2017 18:08:02 -0400
Subject: Re: [PATCH 00/21] backports: multiple changes for kernel 3.13-rc6
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <1504602018.12380.3.camel@sipsolutions.net>
 <7ee0d9f0-1928-37b7-510e-a3d852ab64c4@broadcom.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5202f53f-8023-46fb-ec6c-e149b005d02f@hauke-m.de> (sfid-20170918_000805_291281_C469672B)
Date: Mon, 18 Sep 2017 00:07:56 +0200
MIME-Version: 1.0
In-Reply-To: <7ee0d9f0-1928-37b7-510e-a3d852ab64c4@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/13/2017 10:00 PM, Arend van Spriel wrote:
> 
> 
> On 05-09-17 11:00, Johannes Berg wrote:
>> Hi Hauke,
>>
> 
> [...]
> 
>>> patches/0079-netdev-destructor.cocci takes very long to apply, about
>>> 3 times longer all others together.
>>
>> I doubt we can do anything about that.
> 
> Not sure what is causing it. Might just be the amount of network device
> drivers. When discussing (parts of) this spatch Julia mentioned about
> use of disjunction vs expression:
> 
> """
> You can put a disjunction: \(fn1\|fn2\).  Another option is to make an
> identifier metavariable with an appropriate regular expression, but this
> would be less efficient than the disjuction option.  Coccinelle does
> some optimizations based on what is the pattern matching code, but not
> regular expression constraints.
> """
> 
> but I ended up using the disjunction:
> 
> RET = \(register_netdevice\|register_ndev\)(NDEV);
> if (<+... RET ...+>) {
> 
> so that can not be optimized further.
> 
>>> Should we remove ssb and bcma from backports and use the in kernel
>>> versions instead? I do not expect so many changes any more affecting
>>> the wifi drivers.
>>
>> I have no opinion either way.
> 
> There may be some new cores coming up in our wifi chips that BCMA would
> need to add, but also heard rumors about switching to new backplane type.

Isn't brcmfmac only using some header files from bcma and the rest is
implemented in firmware? We can still add the parts that are needed for
brcmfmac to backports. If there are new softmac devices planned and you
want to provide a driver for them then bcma is helpful.

In OpenWrt and LEDE bcma and ssb are compiled into the kernel because we
need it also for flash driver and other essential things to boot up.
Removing bcma and ssb from backports would bring it closer to the
version used in LEDE.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
