Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:46594 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab3HANE5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 1 Aug 2013 09:04:57 -0400
Message-ID: <51FA5CF4.5080704@fh-kl.de> (sfid-20130801_150459_432942_9D6AB0B8)
Date: Thu, 1 Aug 2013 15:04:52 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [RFC v2 0/8] backports: add wwan device drivers
References: <51F8CD1B.8010909@fh-kl.de>
In-Reply-To: <51F8CD1B.8010909@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


On 31.07.2013 10:38, Patrick Ziegler wrote:
> This adds wwan drivers for mobile broadband devices.
> Patches 1 to 7 add missing stuff required for the wwan drivers.
> Patch 8 adds device drivers.
> 
> Changes v2: rebased on last RFCs for next-20130729
> 

Unfortunately I forgot to add a new change for next-20130729. It was
necessary to fix the build against kernel versions < 2.6.30 (USB_SPEED_SUPER
is not defined).

I will resend the patches.

Patrick
-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
