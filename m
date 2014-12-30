Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43364 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaL3KEP (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 30 Dec 2014 05:04:15 -0500
Message-ID: <54A2789C.7050407@hauke-m.de> (sfid-20141230_110418_103655_500B8D6D)
Date: Tue, 30 Dec 2014 11:04:12 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Ash Charles <ashcharles@gmail.com>, backports@vger.kernel.org
Subject: Re: Providing Platform Data to Backported Module
References: <CAK8F28=6-rCCbAwA20OvW3VMFG8yBV7oZpvgRcNL1s=snR33Sg@mail.gmail.com>
In-Reply-To: <CAK8F28=6-rCCbAwA20OvW3VMFG8yBV7oZpvgRcNL1s=snR33Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/30/2014 02:54 AM, Ash Charles wrote:
> Hello,
> 
> I'm trying to get add support for a wl18xx wireless device to my
> omap3-based board running a 3.2 kernel.  Using backports (package, not
> direct integration), I can compile the required drivers and load them
> onto my system.  The driver needs some platform-specific data to
> control the wireless device.  Normally, I'd pass this as platform data
> from a board file (I'm not using device tree on this 3.2 kernel) but
> as the required structures come from the backport, I can't.  How can I
> provide this data to the module?
> 
> Things that come to mind but don't seem quite right:
> 1. Hard-code this setup data into the driver for my particular board
> (seem a little heavy-handed)
> 2. Add a backport to support a board file/pdata-quirks. (nothing else
> in the arch tree is backported...seems to indicate this is not the
> right way)
> 3. Use the backports with direct integration as I think I could just
> make the changes to the board file directly in this case (I'm using a
> TI backport tree that doesn't support integration yet)
> 4. Add a device tree blob or some shim such that the target kernel can
> provide the module the data.
> 
> Many thanks in advance for any advice or insight.

You could remove the platform data header file from backports and use
the one from your kernel, just delete the header file in backports. If
this version does not have all the needed members just copy the header
file from backpots into your kernel. Then you can register the device
like any other device in your board file and fill the platform data with
the needed data.

Hauke
