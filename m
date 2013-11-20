Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56949 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab3KTLhG (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 Nov 2013 06:37:06 -0500
Message-ID: <528C9ED5.2070103@hauke-m.de> (sfid-20131120_123708_781739_FB9A8142)
Date: Wed, 20 Nov 2013 12:36:53 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>,
	Johannes Berg <johannes@sipsolutions.net>
CC: mcgrof@kernel.org, backports@vger.kernel.org
Subject: Re: [PATCH] backports: remove obsolete linux/bitops.h header
References: <1384784803-16935-1-git-send-email-sassmann@kpanic.de>	 <528BEB63.3080600@hauke-m.de> <528C7302.5030501@kpanic.de> <1384936585.14295.2.camel@jlt4.sipsolutions.net> <528C9C76.8060108@kpanic.de>
In-Reply-To: <528C9C76.8060108@kpanic.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/20/2013 12:26 PM, Stefan Assmann wrote:
> On 20.11.2013 09:36, Johannes Berg wrote:
>> On Wed, 2013-11-20 at 09:29 +0100, Stefan Assmann wrote:
>>> On 19.11.2013 23:51, Hauke Mehrtens wrote:
>>>> On 11/18/2013 03:26 PM, Stefan Assmann wrote:
>>>>> The header seems to be obsolete. Removing it and running devel/ckmake didn't
>>>>> reveal any errors. Missing parts can always be re-added in the new
>>>>> include_next fashion if necessary.
>>>>>
>>>>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>>>>
>>>> Some of these functions are needed, because they are not provided by old
>>>> kernel versions.
>>>
>>> Let me know what's a good way of figuring out what's still needed and
>>> I'll replace the old header the way that Johannes suggested.
>>
>> Easiest is probably to try compiling against the oldest kernel we still
>> support - that would be 2.6.25 - until all the drivers compile :)
>>
>> johannes
>>
> 
> OK, to get started I tried:
> ./gentree.py --clean --git-revision v2.6.25 ~/linux /dev/shm/2.6.25
> Get original source files from git ...
> Apply patches ...
> Failed to apply changes from collateral-evolutions/network/0001-netdev_ops/bluetooth_bnep.patch
>  patching file net/bluetooth/bnep/netdev.c
>  Hunk #1 FAILED at 223.
>  1 out of 1 hunk FAILED -- saving rejects to file net/bluetooth/bnep/netdev.c.rej
> 
> Sorry if I'm missing something there. Or do I have to do it another way?
> 
>   Stefan
> 

You should generate a release based on linux-next like:
./gentree.py --clean --git-revision next-20131113 ~/linux /dev/shm/next

and test compile that against kernel 2.6.25.

make KLIB=/home/XXXX/kernels/linux-2.6.25

Hauke
