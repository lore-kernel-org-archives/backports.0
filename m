Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:54435 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbdIEVlc (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 5 Sep 2017 17:41:32 -0400
Subject: Re: [PATCH 00/21] backports: multiple changes for kernel 3.13-rc6
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <20170821222817.17376-1-hauke@hauke-m.de>
 <1504602018.12380.3.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <edbd9333-79ed-7662-d29d-e93c2f64eb6a@hauke-m.de> (sfid-20170905_234159_448412_942DC1DA)
Date: Tue, 5 Sep 2017 23:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <1504602018.12380.3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/05/2017 11:00 AM, Johannes Berg wrote:
> Hi Hauke,
> 
>> This was build tested with kernel 3.18, 4.4 and 4.9. and runtime
>> tested with iwlwifi on kernel 4.9.
> 
> Cool.

I have some patches to use it in LEDE, and tried it there with ath9k and
ath10k, but hope to do some more testing.

>> Are you planing to to releases in a tar?
> 
> Not personally, no. I barely have time to do any maintenance here to
> start with, and still haven't set up any infrastructure to allow others
> to really help out significantly.
> 
>> Which kernel versions are currently support by backports?
> 
> I think we didn't really change anything, so should be 3.0+

I would prefer to drop everything < 3.10, or do not care about older
kernel versions. For LEDE I am only interested in 3.18 or 4.4 and more
recent.

>> patches/0079-netdev-destructor.cocci takes very long to apply, about
>> 3 times longer all others together.
> 
> I doubt we can do anything about that.
> 
>> Should we remove ssb and bcma from backports and use the in kernel 
>> versions instead? I do not expect so many changes any more affecting
>> the wifi drivers.
> 
> I have no opinion either way.

When I find some time I will check how much problems with will cause for
kernel >= 3.10.

>> Is the compat wireless build server still being used?
> 
> It's still *there*, but I haven't really used it in a long time. I was
> planning to set up some kind of auto-builder but haven't gotten around
> to it.
> 
> johannes
> 

How do we want to proceed with these patches?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
