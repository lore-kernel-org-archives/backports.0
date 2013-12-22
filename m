Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45175 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018Ab3LVRP5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 22 Dec 2013 12:15:57 -0500
Message-ID: <52B71E44.7040600@hauke-m.de> (sfid-20131222_181559_505789_1BE46C79)
Date: Sun, 22 Dec 2013 18:15:48 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH] backports: random: add prandom_bytes macro for pre-3.8
 kernels
References: <1387713434-20109-1-git-send-email-arend@broadcom.com>	 (sfid-20131222_125724_927172_10481688) <1387715284.4346.2.camel@jlt4.sipsolutions.net>
In-Reply-To: <1387715284.4346.2.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/22/2013 01:28 PM, Johannes Berg wrote:
> On Sun, 2013-12-22 at 12:57 +0100, Arend van Spriel wrote:
>> Map prandom_bytes() calls to get_random_bytes() for kernels before
>> 3.8 kernel. This patch is needed by mac80211 rate control code
>> since following:
> 
>> +/* use get_random_bytes() for lack of prandom_bytes() */
>> +#define prandom_bytes(a, b)		get_random_bytes(a, b)
> 
> I don't think this is a good idea, it's a completely different interface
> (get_random_bytes is much higher "quality".)
> 
> We had a different patch for this fairly recently and I thought Luis
> applied it?

Yes a different patch is already in backports:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=40ab1bac8c3680d726ee31fbdb590584ae99756f

Hauke
