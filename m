Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56370 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757139Ab3GOOOE (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jul 2013 10:14:04 -0400
Message-ID: <51E403A5.9060607@hauke-m.de> (sfid-20130715_161407_412386_7C4D9D41)
Date: Mon, 15 Jul 2013 16:13:57 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Ben Guthro <ben@guthro.net>
CC: backports@vger.kernel.org
Subject: Re: problems building backports-3.10-2
References: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com> <51E3FF49.50301@hauke-m.de> <CAOvdn6UmT+gaEgxfrhNt=fYDs-ikKykEJRJ-GbA3VJWdB3MPgg@mail.gmail.com>
In-Reply-To: <CAOvdn6UmT+gaEgxfrhNt=fYDs-ikKykEJRJ-GbA3VJWdB3MPgg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/15/2013 04:01 PM, Ben Guthro wrote:
> On Mon, Jul 15, 2013 at 9:55 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> On 07/15/2013 03:08 PM, Ben Guthro wrote:
>>> I'm struggling to integrate the backports-3.10-2 release into my
>>> build, and I'm hoping this is the proper venue to get some answers.
>>>
>>> 1. The build is complaining about ./gentree.py and local symbols. I
>>> did not see gentree.py anywhere in the code released.
>>>
>>> Even when removing this section of the Makefile, I am able to get a
>>> bit further, to try to do a 'make menuconfig'
>>> This does not present the options I expected - offering only the
>>> following options:
>>>
>>> Build all compat code
>>> Voltage and Current Regulator Support
>>>
>>>
>>> I also tried the some of the defconfigs (like iwlwifi) - but these
>>> seem to only build the compat.ko, and nothing else.
>>>
>>>
>>> Am I doing something wrong - or is something broken in this release?
>>
>> What source are you using?
> 
> I downloaded the released backports-3.10-2.tar.bz2 file from the
> stable releases page here:
> http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/
> 

Could you please post the error messages you get with a unmodified
version of backports-3.10-2.tar.bz2.

Hauke
