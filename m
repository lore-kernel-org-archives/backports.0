Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56242 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009Ab3GON4V (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Jul 2013 09:56:21 -0400
Message-ID: <51E3FF49.50301@hauke-m.de> (sfid-20130715_155623_066395_ADDB137F)
Date: Mon, 15 Jul 2013 15:55:21 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Ben Guthro <ben@guthro.net>
CC: backports@vger.kernel.org
Subject: Re: problems building backports-3.10-2
References: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com>
In-Reply-To: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/15/2013 03:08 PM, Ben Guthro wrote:
> I'm struggling to integrate the backports-3.10-2 release into my
> build, and I'm hoping this is the proper venue to get some answers.
> 
> 1. The build is complaining about ./gentree.py and local symbols. I
> did not see gentree.py anywhere in the code released.
> 
> Even when removing this section of the Makefile, I am able to get a
> bit further, to try to do a 'make menuconfig'
> This does not present the options I expected - offering only the
> following options:
> 
> Build all compat code
> Voltage and Current Regulator Support
> 
> 
> I also tried the some of the defconfigs (like iwlwifi) - but these
> seem to only build the compat.ko, and nothing else.
> 
> 
> Am I doing something wrong - or is something broken in this release?

What source are you using? It looks to me like you are using the code
from the git repository, this code is there to *generate* a new tar, but
it contains no driver or wireless code, that is fetched by gentree.py
from the linux kernel source code. If you just want some code backported
from 3.10 take the release [0]. If you want to create your own tar
please consult the wiki [1].

Hauke

[0]:
https://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.10/
[1]:
https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking
