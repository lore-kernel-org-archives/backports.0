Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:50810 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708Ab3GaIPd (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 31 Jul 2013 04:15:33 -0400
Message-ID: <51F8C79E.8080804@fh-kl.de> (sfid-20130731_101538_478600_872E39D5)
Date: Wed, 31 Jul 2013 10:15:26 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [RFC 0/8] backports: add wwan device drivers
References: <51F7A86E.4040006@fh-kl.de> <20130730210642.GJ17130@pogo>
In-Reply-To: <20130730210642.GJ17130@pogo>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 30.07.2013 23:06, Luis R. Rodriguez wrote:
> On Tue, Jul 30, 2013 at 01:50:06PM +0200, Patrick Ziegler wrote:
>> This adds wwan drivers for mobile broadband devices.
>> Patches 1 to 7 add missing stuff required for the wwan drivers.
>> Patch 8 adds device drivers.
>>
>>
>> Patrick Ziegler (8):
>>   backports: disable PCI functions for kernels without PCI support
>>   backports: add eth_prepare_mac_addr_change() and
>>     eth_commit_mac_addr_change()
>>   backports: define PM_EVENT_AUTO
>>   backports: add usb_translate_errors()
>>   backports: add usb_endpoint_maxp()
>>   backports: include headers directly if math64 header is missing
>>   backports: define phys_addr_t for ARM on kernel version < 2.6.25
>>   backports: add wwan device drivers
> 
> Nice! Was this based on top of all my posted patches that take us
> up to next-20130712 + my last RFCs that take us up to next-20130729 ?
> If not any chance you can rebase? The patches that take us up to
> next-20130712 are now merged upstream and the only missing ones are the
> ones that take us up to next-20130729. You can skip my RFCs as I can
> adjust those to yours. If you rebase to the master branch that'd be
> good enough.
> 

This is based on top of the current master branch fe8230e (refresh 
patches for next-20130712). But I will prepare a new patch series based
on your latest RFC (next-20130729)

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
