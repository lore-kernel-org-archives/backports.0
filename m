Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35189 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab3HAUUL (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 1 Aug 2013 16:20:11 -0400
Message-ID: <51FAC2EF.8080402@hauke-m.de> (sfid-20130801_222014_043575_A7EF835B)
Date: Thu, 01 Aug 2013 22:19:59 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: Chris R <chrisrfq@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Bug with the website: links are broken
References: <000d01ce8e07$80a36430$81ea2c90$@gmail.com> <CAB=NE6WLPxLpGWOP6fj_FEWk_AA4Tz7UQay1tPxsMJfquRnSmg@mail.gmail.com> <007b01ce8eee$cca32e50$65e98af0$@gmail.com> <CAB=NE6Xg_MHwZAaZHHkL841BHJxFzEeu2oMZJdXpqYoGSHjSgQ@mail.gmail.com>
In-Reply-To: <CAB=NE6Xg_MHwZAaZHHkL841BHJxFzEeu2oMZJdXpqYoGSHjSgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/01/2013 09:43 PM, Luis R. Rodriguez wrote:
> On Thu, Aug 1, 2013 at 12:39 PM, Chris R <chrisrfq@gmail.com> wrote:
>>> Its back up...
>>
>> Thanks very much!
>>
>>> ...that page has ancient releases, why are you still using them?
>>
>> I'm stuck at kernel version 2.6.37.
> 
> So backports is designed so that you use a backports-3.11 say on
> 2.6.37. That is you don't have to use a backport-3.10 only on 3.10 in
> fact that'd be pointless. We backport functionality from a kernel as a
> base and that base is used as the version name for the release.
> 
> A few folks have reported misunderstanding this as well so I'm curious
> apart from the documentation we have on the wiki [0] what else can we
> do to help with this?
> 
> [0] https://backports.wiki.kernel.org
> 
>   Luis

Users do not read any documentation. ;-)
I added it to multiple places in the wiki and still there are people in
the IRC with such problems.

We should make it fail if kernel version > backports version and we
should also take the minor version into account. If the major version is
the same we should print a big warning.

Hauke
