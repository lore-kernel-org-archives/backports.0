Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:56486 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab3FMUHI (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Jun 2013 16:07:08 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so5274925lbd.15
        for <backports@vger.kernel.org>; Thu, 13 Jun 2013 13:07:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51BA24D8.4090805@broadcom.com>
References: <1370806659-2875-1-git-send-email-arend@broadcom.com>
 <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com> <51BA24D8.4090805@broadcom.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 13 Jun 2013 13:06:46 -0700
Message-ID: <CAB=NE6U61fDT58EY2ajfAUHC7fRU+ODhkxd8uh_b1iEXqForxw@mail.gmail.com> (sfid-20130613_220713_535128_36D30BCA)
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting brcmsmac
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jun 13, 2013 at 1:00 PM, Arend van Spriel <arend@broadcom.com> wrote:
> On 06/13/2013 09:39 PM, Luis R. Rodriguez wrote:
>> Thanks Arend but we're now using a new tree:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git
>>
> I was wondering about those, but the twiki still referred to the ones on
> github.

Which twiki ? You mean

https://backports.wiki.kernel.org/index.php/Main_Page

If so then yes, I've only had a chance to update the main page, the
rest need tons of updates and I haven't had time to update them, this
week I'm also incapacitated due to an injury [0] so just accepting
patches.

[0] http://bit.ly/190zMAT

> So you mean to say this change is already done in the kernel.org
> repo?

The compat-drivers tree is left stale, I considered doing a linear
update but Johannes had a boat load of updates and it was easier to
just work out of a new tree. Leaving the old data out also means we
get to leave behind older git pack data therefore trimming the tree
size. I'll keep the older trees around for reference.

  Luis
