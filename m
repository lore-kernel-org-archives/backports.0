Return-path: <backports-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:43945 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbE2Oxl convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 May 2015 10:53:41 -0400
Message-ID: <55687D72.3070904@melag.de> (sfid-20150529_165344_187627_D49A4807)
Date: Fri, 29 May 2015 16:53:38 +0200
From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
In-Reply-To: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 29.05.2015 um 04:54 schrieb Luis R. Rodriguez:

Hi,

<snip>

let me add some personal views for backports issue in general - or,
more precisely, the opposite - forward porting:

Silicon vendors often just provide drivers for very old kernels, even
worse: proprietary drivers, which need ugly kernel hacks (eg. Freescale
is one of the worst). So I'll have to forward-port drivers to newer
kernels - but I never had the practical need to backport one.

Actually, I really wonder why folks are sticking to ancient kernels on
newer hardware.


--mtx

--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur für einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschließlich für denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, dürfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrtümlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte löschen Sie in diesem Fall diese Nachricht und alle Anhänge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
