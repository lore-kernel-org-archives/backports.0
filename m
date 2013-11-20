Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:56032 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750834Ab3KTL0s (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 Nov 2013 06:26:48 -0500
Message-ID: <528C9C76.8060108@kpanic.de> (sfid-20131120_122650_308506_7B5FE515)
Date: Wed, 20 Nov 2013 12:26:46 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org,
	backports@vger.kernel.org
Subject: Re: [PATCH] backports: remove obsolete linux/bitops.h header
References: <1384784803-16935-1-git-send-email-sassmann@kpanic.de>	 <528BEB63.3080600@hauke-m.de> <528C7302.5030501@kpanic.de> <1384936585.14295.2.camel@jlt4.sipsolutions.net>
In-Reply-To: <1384936585.14295.2.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 20.11.2013 09:36, Johannes Berg wrote:
> On Wed, 2013-11-20 at 09:29 +0100, Stefan Assmann wrote:
>> On 19.11.2013 23:51, Hauke Mehrtens wrote:
>>> On 11/18/2013 03:26 PM, Stefan Assmann wrote:
>>>> The header seems to be obsolete. Removing it and running devel/ckmake didn't
>>>> reveal any errors. Missing parts can always be re-added in the new
>>>> include_next fashion if necessary.
>>>>
>>>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>>>
>>> Some of these functions are needed, because they are not provided by old
>>> kernel versions.
>>
>> Let me know what's a good way of figuring out what's still needed and
>> I'll replace the old header the way that Johannes suggested.
> 
> Easiest is probably to try compiling against the oldest kernel we still
> support - that would be 2.6.25 - until all the drivers compile :)
> 
> johannes
> 

OK, to get started I tried:
./gentree.py --clean --git-revision v2.6.25 ~/linux /dev/shm/2.6.25
Get original source files from git ...
Apply patches ...
Failed to apply changes from collateral-evolutions/network/0001-netdev_ops/bluetooth_bnep.patch
 patching file net/bluetooth/bnep/netdev.c
 Hunk #1 FAILED at 223.
 1 out of 1 hunk FAILED -- saving rejects to file net/bluetooth/bnep/netdev.c.rej

Sorry if I'm missing something there. Or do I have to do it another way?

  Stefan
