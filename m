Return-path: <backports-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:62551 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbbFXKNc convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 24 Jun 2015 06:13:32 -0400
Message-ID: <558A82C5.4030900@melag.de> (sfid-20150624_121345_400188_C758DC50)
Date: Wed, 24 Jun 2015 12:13:25 +0200
From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
MIME-Version: 1.0
To: Felix Fietkau <nbd@openwrt.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com> <556CA991.7030302@openwrt.org>
In-Reply-To: <556CA991.7030302@openwrt.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 01.06.2015 um 20:50 schrieb Felix Fietkau:

> We support many different platforms, and sometimes it takes a
> while to update the kernel on them.

Just curious: what makes these platforms so different from each other,
so it takes so much time to port to new kernel ? Are there things so
special, that they can't go into mainline ?

In a few weeks, I'll (hopefully) have a few weeks off and plan to play
around w/ some spare DSL routers. Maybe we can have a talk on how to
get more things mainlined, if you wish :)

> Using backports significantly reduces the amount of effort that we need
> to put into maintaining the wireless drivers.
> When making changes to wireless drivers or mac80211, which I submit
> upstream, I also develop them in our most recent backports snapshot
> first (typically generated from wireless-testing). When they are done, I
> port them to a proper git tree and submit them from there.

How much has changed from your old baseline compared to current
mainline ? I could imagine, in your area it might not be as much
as in others (eg. graphics or v4l subsystem).

> In OpenWrt, we typically update the backports snapshot outside of the
> normal kernel release cycle (always to latest wireless-testing) and
> stabilize that by cherry-picking individual patches on top of it.

Can you estimate the required workforce ?
Some statistics on that would be really nice.


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur für einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschließlich für denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, dürfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrtümlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte löschen Sie in diesem Fall diese Nachricht und alle Anhänge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
