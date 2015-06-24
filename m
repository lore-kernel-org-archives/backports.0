Return-path: <backports-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbFXJTL (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 24 Jun 2015 05:19:11 -0400
Message-ID: <558A760B.2030600@nod.at> (sfid-20150624_111914_533940_8564B43C)
Date: Wed, 24 Jun 2015 11:19:07 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>	<55687D72.3070904@melag.de> <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com> <558A73D9.3060703@melag.de>
In-Reply-To: <558A73D9.3060703@melag.de>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 24.06.2015 um 11:09 schrieb Enrico Weigelt, metux IT consult:
> Am 29.05.2015 um 17:01 schrieb Richard Weinberger:
> 
> Hi,
> 
>> On Fri, May 29, 2015 at 4:53 PM, Enrico Weigelt, metux IT consult
>> <weigelt@melag.de> wrote:
>>> Am 29.05.2015 um 04:54 schrieb Luis R. Rodriguez:
>>> Actually, I really wonder why folks are sticking to ancient kernels on
>>> newer hardware.
>>
>> Enterprise distribution kernels.
> 
> hmm, by "enterprise" you mean distros like RHEL, which even can't get a
> dist-upgrade right ? ;-p

Please send such prepubescent flames to /dev/null.

> In that case, it's the duty of the dist vendor, to port their (often
> horrible) vendor patches. I wouldn't run those distros bare-metal
> anyways, so the need for new kernel features (eg. drivers) wouldn't
> that huge.
> 
>> Or "special" kernels like PREEMPT_RT.
> 
> PREEMPT_RT is pretty close to upstream.
> There're at 4.0.5 right now, and 4.1 is still very fresh.
> 
> If I'd have the need for it (actually was already considering it for our
> project), I'd rather port it to 4.1. (as our BSP already is at 4.1)

Porting PREEMPT_RT is not that easy.
Did you ever?

>> Sometimes the vendor BSP is that horrid that a customer cannot afford
>> to forward port it but wants recent stuff. So you need to backport...
> 
> By "vendor BSP", you perhaps mean certain soc or board manufacturer
> stuff ? Just dont use it, it's usually horrible crap anyways. These
> usually are fire-and-forget showcases, not suited for production use.
> Waste of resources.

So, you rewrite all drivers and the board support from scratch?
Interesting. I'd love to meet your customers they seem to have
a lot of money and time. ;-)

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe backports" in
