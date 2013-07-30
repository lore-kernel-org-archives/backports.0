Return-path: <backports-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:31595 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523Ab3G3VGp (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 17:06:45 -0400
Date: Tue, 30 Jul 2013 14:06:42 -0700
From: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [RFC 0/8] backports: add wwan device drivers
Message-ID: <20130730210642.GJ17130@pogo> (sfid-20130730_230647_257817_4433EF4D)
References: <51F7A86E.4040006@fh-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51F7A86E.4040006@fh-kl.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jul 30, 2013 at 01:50:06PM +0200, Patrick Ziegler wrote:
> This adds wwan drivers for mobile broadband devices.
> Patches 1 to 7 add missing stuff required for the wwan drivers.
> Patch 8 adds device drivers.
> 
> 
> Patrick Ziegler (8):
>   backports: disable PCI functions for kernels without PCI support
>   backports: add eth_prepare_mac_addr_change() and
>     eth_commit_mac_addr_change()
>   backports: define PM_EVENT_AUTO
>   backports: add usb_translate_errors()
>   backports: add usb_endpoint_maxp()
>   backports: include headers directly if math64 header is missing
>   backports: define phys_addr_t for ARM on kernel version < 2.6.25
>   backports: add wwan device drivers

Nice! Was this based on top of all my posted patches that take us
up to next-20130712 + my last RFCs that take us up to next-20130729 ?
If not any chance you can rebase? The patches that take us up to
next-20130712 are now merged upstream and the only missing ones are the
ones that take us up to next-20130729. You can skip my RFCs as I can
adjust those to yours. If you rebase to the master branch that'd be
good enough.

  Luis
