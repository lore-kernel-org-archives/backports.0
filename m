Return-path: <backports-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:57418 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbbFXJJu convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 24 Jun 2015 05:09:50 -0400
Message-ID: <558A73D9.3060703@melag.de> (sfid-20150624_111014_494127_823C8373)
Date: Wed, 24 Jun 2015 11:09:45 +0200
From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
MIME-Version: 1.0
To: Richard Weinberger <richard.weinberger@gmail.com>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>	<55687D72.3070904@melag.de> <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com>
In-Reply-To: <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 29.05.2015 um 17:01 schrieb Richard Weinberger:

Hi,

> On Fri, May 29, 2015 at 4:53 PM, Enrico Weigelt, metux IT consult
> <weigelt@melag.de> wrote:
>> Am 29.05.2015 um 04:54 schrieb Luis R. Rodriguez:
>> Actually, I really wonder why folks are sticking to ancient kernels on
>> newer hardware.
>
> Enterprise distribution kernels.

hmm, by "enterprise" you mean distros like RHEL, which even can't get a
dist-upgrade right ? ;-p

In that case, it's the duty of the dist vendor, to port their (often
horrible) vendor patches. I wouldn't run those distros bare-metal
anyways, so the need for new kernel features (eg. drivers) wouldn't
that huge.

 > Or "special" kernels like PREEMPT_RT.

PREEMPT_RT is pretty close to upstream.
There're at 4.0.5 right now, and 4.1 is still very fresh.

If I'd have the need for it (actually was already considering it for our
project), I'd rather port it to 4.1. (as our BSP already is at 4.1)

> Sometimes the vendor BSP is that horrid that a customer cannot afford
> to forward port it but wants recent stuff. So you need to backport...

By "vendor BSP", you perhaps mean certain soc or board manufacturer
stuff ? Just dont use it, it's usually horrible crap anyways. These
usually are fire-and-forget showcases, not suited for production use.
Waste of resources.


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur für einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschließlich für denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, dürfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrtümlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte löschen Sie in diesem Fall diese Nachricht und alle Anhänge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
