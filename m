Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:42484 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbECTti (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 3 May 2015 15:49:38 -0400
Message-ID: <55467BCF.8040705@broadcom.com> (sfid-20150503_214939_997709_11397E55)
Date: Sun, 3 May 2015 21:49:35 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] backports: mac80211: revert to old stats behaviour for
 older kernels
References: <1430487994-20598-1-git-send-email-arend@broadcom.com>	 (sfid-20150501_154642_126166_7597CA83) <1430680059.3276.1.camel@sipsolutions.net>
In-Reply-To: <1430680059.3276.1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/03/15 21:07, Johannes Berg wrote:
> On Fri, 2015-05-01 at 15:46 +0200, Arend van Spriel wrote:
>> Commit 5a490510ba5f ("mac80211: use per-CPU TX/RX statistics") introduced
>> the use of per-cpu statistics, ie. struct netdevice::tstats. This is not
>> supported in kernel 3.14 and older.
>>
>> Signed-off-by: Arend van Spriel<arend@broadcom.com>
>> ---
>> I am not entirely sure whether 3.14 is the correct version to check for. The
>> functionality seems introduced there but there were some subsequent patches
>> on the per-cpu netdev stats functionality.
>
> I don't really like just reverting to the old behaviour - that'll make
> this very hard to port.

I don't either, but I had a bunch of test systems that I wanted to get 
going.

> What part of this isn't supported? Is there no pointer whatsoever that
> we can use? We still implement the ndo_getstats64 [or whatever it's
> called] ourselves anyway, so we don't really use any API here apart from
>   * netdev_alloc_pcpu_stats, which is trivially backported
>   * dev->tstats, which is just a single pointer and we could use anything
> else,
>     even perhaps in sdata

I have to learn about the per-cpu operations someday so why not now 
while spending two weeks vacation ;-)

Thanks,
Arend
