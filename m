Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35606 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756348Ab3FMVH4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 13 Jun 2013 17:07:56 -0400
Message-ID: <51BA349F.90003@hauke-m.de> (sfid-20130613_230757_862970_6823AB91)
Date: Thu, 13 Jun 2013 23:07:43 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>
CC: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting brcmsmac
References: <1370806659-2875-1-git-send-email-arend@broadcom.com> <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com> <51BA24D8.4090805@broadcom.com> <51BA25FD.4000704@broadcom.com>
In-Reply-To: <51BA25FD.4000704@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/13/2013 10:05 PM, Arend van Spriel wrote:
> On 06/13/2013 10:00 PM, Arend van Spriel wrote:
>> On 06/13/2013 09:39 PM, Luis R. Rodriguez wrote:
>>> On Sun, Jun 9, 2013 at 12:37 PM, Arend van Spriel <arend@broadcom.com>
>>> wrote:
>>>> The brcmsmac driver depends on the bcma bus driver these days. However,
>>>> the driver-select script disabled bcma when selecting brcmsmac (or
>>>> the brcm80211 driver group). This leads to mismatch between kernel
>>>> bcma and backport brcmsmac. For the 3.9 backport this result in:
>>>>
>>>> [10298.323094] brcmsmac: Unknown symbol bcma_pmu_spuravoid_pllupdate
>>>> (err 0)
>>>>
>>>> as this function was added to bcma.
>>>>
>>>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>>>
>>> Thanks Arend but we're now using a new tree:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git
>>>
>>>    Luis
>>>
>>
>> I was wondering about those, but the twiki still referred to the ones on
>> github. So you mean to say this change is already done in the kernel.org
>> repo?
>>
>> There are a couple of repositories: backports, compat-drivers, and
>> compat. I followed the backports twiki and it does not mention the
>> backports one or did I overlook?
> 
> Yikes. cloned that one and I guess you made a major overhaul, right? Any
> pointers, step-by-step instructions, or how-to article to get me started.

I just wrote a wiki page for backports based on an old one for
compat-drivers.

https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking

Feel free to fix or extend it.

Hauke
