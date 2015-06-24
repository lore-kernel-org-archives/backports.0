Return-path: <backports-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbbFXKSS (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 24 Jun 2015 06:18:18 -0400
Message-ID: <558A83E8.4070707@nod.at> (sfid-20150624_121821_050527_DFEC774A)
Date: Wed, 24 Jun 2015 12:18:16 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>	<55687D72.3070904@melag.de> <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com> <558A73D9.3060703@melag.de> <558A760B.2030600@nod.at> <558A7EA3.3040809@melag.de>
In-Reply-To: <558A7EA3.3040809@melag.de>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 24.06.2015 um 11:55 schrieb Enrico Weigelt, metux IT consult:
> Am 24.06.2015 um 11:19 schrieb Richard Weinberger:
> 
> Hi,
> 
>> Porting PREEMPT_RT is not that easy.
>> Did you ever?
> 
> I know.
> 
> OTOH, is backporting drivers to ancient kernels (where internal APIs
> often are _completely_ different) really easier ? Perhaps it might look
> so, if it's just one individual driver - but often it doesn't keep this
> way, sooner or later other things pop up.

At the end of the day customers will do what is less costly.
Sometimes backporting a driver is much less effort.
That's why we have the excellent backports project.

>> So, you rewrite all drivers and the board support from scratch?
> 
> Sometimes, if I have to. Because - on my own experience - what SoC
> vendors provide usually is pretty unusable, just a quick showcase.
> 
> Right now, I'm working on a project w/ some imx53-based board.
> What freescale provides here is practically unusable. Really ancient
> (last time I checked, it was an old 2.6.x), unsable and insecure
> (anybody had a closer look at their "kgsl" patch or their gst-plugin ?)
> 
> We'll have to drop the whole idea of using the GPUs, due to lack of
> support - the existing driver/libgl is known to be broken and insecure,
> no support from fsl whatsoever, we're lacking resources for a full
> reverse engineering, and moving to another SoC is out of question
> (at least for the forseeable future). So, it ends up in having no
> GPU, therefore no GL/GSL, therefore no QtQuick/QML.
> 
> 
> Pavel already mentioned the correct way to go: chip vendors should
> provide proper (mainline'able) patches, or at least full specs.

Sure, in a perfect world. But as of now we have to deal with that.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe backports" in
