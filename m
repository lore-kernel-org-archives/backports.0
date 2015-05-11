Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49143 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbbEKV5h (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 May 2015 17:57:37 -0400
Message-ID: <555125CF.6090004@hauke-m.de> (sfid-20150511_235738_441273_3F022752)
Date: Mon, 11 May 2015 23:57:35 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>,
	Johannes Berg <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: problem with enabling config options
References: <554B4966.5090808@kpanic.de>	 (sfid-20150507_131558_070018_C564096D) <1430999320.11214.0.camel@sipsolutions.net> <554B586D.8070805@kpanic.de>
In-Reply-To: <554B586D.8070805@kpanic.de>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/07/2015 02:19 PM, Stefan Assmann wrote:
> On 07.05.2015 13:48, Johannes Berg wrote:
>> On Thu, 2015-05-07 at 13:15 +0200, Stefan Assmann wrote:
>>> I'm looking into enabling more wired network drivers and ran into the
>>> issue that I could not enable CONFIG_E1000 for example. The problem
>>> seems to be that because CONFIG_E100 is disabled you cannot enable
>>> anything CONFIG_E100*. It looks like a bug in gentree.py, but my python
>>> foo didn't suffice to get it sorted out. Problem should be located
>>> somewhere around line 1060 where the CONFIG variable regex stuff
>>> happens.
>>
>> I think you can try to add \W to the very end of the regex there.
>>
>> johannes
>>
> 
> Thanks Johannes, that worked. Proposing patch and Cc Hauke.
> 
>   Stefan
> 
> From da662be25373468dac47234f2f164fcc8503ebb4 Mon Sep 17 00:00:00 2001
> From: Stefan Assmann <sassmann@kpanic.de>
> Date: Thu, 7 May 2015 14:08:56 +0200
> Subject: [PATCH] backports: fix incorrect disabling of CONFIG options
> 
> gentree.py incorrectly disabled CONFIG options that share part of the
> name with another already disabled CONFIG option.
> For example if CONFIG_E100 was disabled you no longer could enable
> CONFIG_E1000 or CONFIG_E1000E.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  gentree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Thank you for the patch, it was applied and pushed out.

Hauke
