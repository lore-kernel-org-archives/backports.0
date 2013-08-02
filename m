Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:60946 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab3HBL0H (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 2 Aug 2013 07:26:07 -0400
Message-ID: <51FB9748.1020602@fh-kl.de> (sfid-20130802_132609_502172_D9CD8442)
Date: Fri, 2 Aug 2013 13:26:00 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [RFC v3 0/9] backports: add wwan device drivers
References: <51FA85B9.7050502@fh-kl.de> <20130801171044.GK17130@pogo>
In-Reply-To: <20130801171044.GK17130@pogo>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 01.08.2013 19:10, Luis R. Rodriguez wrote:
> On Thu, Aug 01, 2013 at 05:58:49PM +0200, Patrick Ziegler wrote:
>> This adds wwan drivers for mobile broadband devices.
>> Patches 1 to 8 add missing stuff required for the wwan drivers.
>> Patch 9 adds device drivers.
>>
>> Changes v2:
>>  - rebased on last RFCs for next-20130729
>>
>> Changes v3:
>>  - add new patch to add missing USB_SPEED_SUPER
>>  - fix PCI build errors in a better way
> 
> Nice! Looks good to me except for just export symbol stuff. Let me know
> if you want to respin or want me to try to merge these with the symbol
> change. Up to you.
> 

Thanks your having a look on these patches. I will fix that issue and resend.

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
