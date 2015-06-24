Return-path: <backports-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:54904 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbbFXJzu convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 24 Jun 2015 05:55:50 -0400
Message-ID: <558A7EA3.3040809@melag.de> (sfid-20150624_115553_326495_4EA1B9CA)
Date: Wed, 24 Jun 2015 11:55:47 +0200
From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
MIME-Version: 1.0
To: Richard Weinberger <richard@nod.at>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>	<55687D72.3070904@melag.de> <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com> <558A73D9.3060703@melag.de> <558A760B.2030600@nod.at>
In-Reply-To: <558A760B.2030600@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 24.06.2015 um 11:19 schrieb Richard Weinberger:

Hi,

 > Porting PREEMPT_RT is not that easy.
> Did you ever?

I know.

OTOH, is backporting drivers to ancient kernels (where internal APIs
often are _completely_ different) really easier ? Perhaps it might look
so, if it's just one individual driver - but often it doesn't keep this
way, sooner or later other things pop up.

> So, you rewrite all drivers and the board support from scratch?

Sometimes, if I have to. Because - on my own experience - what SoC
vendors provide usually is pretty unusable, just a quick showcase.

Right now, I'm working on a project w/ some imx53-based board.
What freescale provides here is practically unusable. Really ancient
(last time I checked, it was an old 2.6.x), unsable and insecure
(anybody had a closer look at their "kgsl" patch or their gst-plugin ?)

We'll have to drop the whole idea of using the GPUs, due to lack of
support - the existing driver/libgl is known to be broken and insecure,
no support from fsl whatsoever, we're lacking resources for a full
reverse engineering, and moving to another SoC is out of question
(at least for the forseeable future). So, it ends up in having no
GPU, therefore no GL/GSL, therefore no QtQuick/QML.


Pavel already mentioned the correct way to go: chip vendors should
provide proper (mainline'able) patches, or at least full specs.

And I'll add: those who dont, should simply be boycotted.


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur für einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschließlich für denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, dürfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrtümlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte löschen Sie in diesem Fall diese Nachricht und alle Anhänge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
