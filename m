Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:30003 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbEDIFH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 4 May 2015 04:05:07 -0400
Message-ID: <55472830.5030905@broadcom.com> (sfid-20150504_100511_180682_53453057)
Date: Mon, 4 May 2015 10:05:04 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] backports: mac80211: revert to old stats behaviour for
 older kernels
References: <1430487994-20598-1-git-send-email-arend@broadcom.com>		 (sfid-20150501_154642_126166_7597CA83) <1430680059.3276.1.camel@sipsolutions.net>	 <55467BCF.8040705@broadcom.com> <1430725394.2013.5.camel@sipsolutions.net>
In-Reply-To: <1430725394.2013.5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/04/15 09:43, Johannes Berg wrote:
> On Sun, 2015-05-03 at 21:49 +0200, Arend van Spriel wrote:
>
>> I don't either, but I had a bunch of test systems that I wanted to get
>> going.
>
> While on vacation? :)

It happened just before as such things tend to do. There is probably 
some law for this ;-)

>>> What part of this isn't supported? Is there no pointer whatsoever that
>>> we can use? We still implement the ndo_getstats64 [or whatever it's
>>> called] ourselves anyway, so we don't really use any API here apart from
>>>    * netdev_alloc_pcpu_stats, which is trivially backported
>>>    * dev->tstats, which is just a single pointer and we could use anything
>>> else,
>>>      even perhaps in sdata
>>
>> I have to learn about the per-cpu operations someday so why not now
>> while spending two weeks vacation ;-)
>
> Heh. Go enjoy your vacation, I can handle this :)

no doubt.

> I think you arrived at kernel 3.14 due to 8f84985fec10d. However, I
> think we can just do the following
>
>   * backport "struct pcpu_sw_netstats" (needed on<  3.14)
>   * backport "netdev_alloc_pcpu_stats" (needed on<  3.15)
>   * make an spatch replacing dev->tstats with ((struct pcpu_sw_netstats *)dev->ml_priv)
>     (since ml_priv has existed for a long time, and they're in a union)

That will work. Guess you will drop the mac80211 patch I sent using 
sdata instead. Fine by me.

Regards,
Arend
