Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39932 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbbKJMFz (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 10 Nov 2015 07:05:55 -0500
Message-ID: <1447157151.2421.8.camel@sipsolutions.net> (sfid-20151110_130557_667567_3D3C54F0)
Subject: Re: CONFIG_WLAN getting disabled - copy-list usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>, backports@vger.kernel.org
Date: Tue, 10 Nov 2015 13:05:51 +0100
In-Reply-To: <5641DD38.4080806@broadcom.com>
References: <1446467807.3205.21.camel@sipsolutions.net>
	 <5641DD38.4080806@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2015-11-10 at 13:04 +0100, Arend van Spriel wrote:
> On 11/02/2015 01:36 PM, Johannes Berg wrote:
> > FYI, if anyone's using backports with a copy-list file that
> > restricts
> > the wifi drivers to their own, and is working against a recent tree
> > that includes the drivers/net/wireless/realtek/ move, then
> > CONFIG_WLAN
> > will end up getting disabled.
> > 
> > To fix that for now modify your copy-list to include
> > drivers/net/wireless/realtek/Makefile (and that file only).
> > 
> > Once Kconfig changes go in and the Makefile statement
> > 
> > obj-$(CONFIG_WLAN) += realtek/
> > 
> > changes to
> > 
> > obj-$(CONFIG_WLAN_REALTEK) += realtek/
> > 
> > (or similar) this issue will go away.
> 
> Thanks. It worked for me. As Kalle intends to move more drivers into 
> vendor subfolder, can we expect this will happen again. Can we fix up
> kconfig handling for this?
> 

I asked Kalle and he's planning to also add per-vendor Kconfig, at
which point this will not be needed any more. Like ethernet has,
really.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
