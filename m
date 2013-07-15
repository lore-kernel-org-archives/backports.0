Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:38958 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601Ab3GOOBH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Jul 2013 10:01:07 -0400
Received: by mail-ve0-f181.google.com with SMTP id db10so9951180veb.12
        for <backports@vger.kernel.org>; Mon, 15 Jul 2013 07:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51E3FF49.50301@hauke-m.de>
References: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com>
	<51E3FF49.50301@hauke-m.de>
Date: Mon, 15 Jul 2013 10:01:06 -0400
Message-ID: <CAOvdn6UmT+gaEgxfrhNt=fYDs-ikKykEJRJ-GbA3VJWdB3MPgg@mail.gmail.com> (sfid-20130715_160110_503209_38D22411)
Subject: Re: problems building backports-3.10-2
From: Ben Guthro <ben@guthro.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jul 15, 2013 at 9:55 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 07/15/2013 03:08 PM, Ben Guthro wrote:
>> I'm struggling to integrate the backports-3.10-2 release into my
>> build, and I'm hoping this is the proper venue to get some answers.
>>
>> 1. The build is complaining about ./gentree.py and local symbols. I
>> did not see gentree.py anywhere in the code released.
>>
>> Even when removing this section of the Makefile, I am able to get a
>> bit further, to try to do a 'make menuconfig'
>> This does not present the options I expected - offering only the
>> following options:
>>
>> Build all compat code
>> Voltage and Current Regulator Support
>>
>>
>> I also tried the some of the defconfigs (like iwlwifi) - but these
>> seem to only build the compat.ko, and nothing else.
>>
>>
>> Am I doing something wrong - or is something broken in this release?
>
> What source are you using?

I downloaded the released backports-3.10-2.tar.bz2 file from the
stable releases page here:
http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/



> It looks to me like you are using the code
> from the git repository, this code is there to *generate* a new tar, but
> it contains no driver or wireless code, that is fetched by gentree.py
> from the linux kernel source code. If you just want some code backported
> from 3.10 take the release [0]. If you want to create your own tar
> please consult the wiki [1].

This is not the case.

Thank you for your response.

Ben

>
> Hauke
>
> [0]:
> https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.10/
> [1]:
> https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking
