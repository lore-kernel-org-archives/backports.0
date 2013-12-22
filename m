Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:64433 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3LVR1G (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Dec 2013 12:27:06 -0500
Message-ID: <52B720E6.3070809@broadcom.com> (sfid-20131222_182711_900287_D07CE78C)
Date: Sun, 22 Dec 2013 18:27:02 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] backports: random: add prandom_bytes macro for pre-3.8
 kernels
References: <1387713434-20109-1-git-send-email-arend@broadcom.com>	 (sfid-20131222_125724_927172_10481688) <1387715284.4346.2.camel@jlt4.sipsolutions.net> <52B71E44.7040600@hauke-m.de>
In-Reply-To: <52B71E44.7040600@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/22/2013 06:15 PM, Hauke Mehrtens wrote:
> On 12/22/2013 01:28 PM, Johannes Berg wrote:
>> On Sun, 2013-12-22 at 12:57 +0100, Arend van Spriel wrote:
>>> Map prandom_bytes() calls to get_random_bytes() for kernels before
>>> 3.8 kernel. This patch is needed by mac80211 rate control code
>>> since following:
>>
>>> +/* use get_random_bytes() for lack of prandom_bytes() */
>>> +#define prandom_bytes(a, b)		get_random_bytes(a, b)
>>
>> I don't think this is a good idea, it's a completely different interface
>> (get_random_bytes is much higher "quality".)
>>
>> We had a different patch for this fairly recently and I thought Luis
>> applied it?
> 
> Yes a different patch is already in backports:
> https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=40ab1bac8c3680d726ee31fbdb590584ae99756f

I was looking at your github repo, because kernel.org did not work for
3.13 a while ago. Distributed version control can be a curse as well as
a blessing.

Gr. AvS

