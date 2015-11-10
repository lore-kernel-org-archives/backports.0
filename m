Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:33807 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbbKJMEL (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 10 Nov 2015 07:04:11 -0500
Message-ID: <5641DD38.4080806@broadcom.com> (sfid-20151110_130413_359667_61CAD563)
Date: Tue, 10 Nov 2015 13:04:08 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	<backports@vger.kernel.org>
Subject: Re: CONFIG_WLAN getting disabled - copy-list usage
References: <1446467807.3205.21.camel@sipsolutions.net>
In-Reply-To: <1446467807.3205.21.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/02/2015 01:36 PM, Johannes Berg wrote:
> FYI, if anyone's using backports with a copy-list file that restricts
> the wifi drivers to their own, and is working against a recent tree
> that includes the drivers/net/wireless/realtek/ move, then CONFIG_WLAN
> will end up getting disabled.
>
> To fix that for now modify your copy-list to include
> drivers/net/wireless/realtek/Makefile (and that file only).
>
> Once Kconfig changes go in and the Makefile statement
>
> obj-$(CONFIG_WLAN) += realtek/
>
> changes to
>
> obj-$(CONFIG_WLAN_REALTEK) += realtek/
>
> (or similar) this issue will go away.

Thanks. It worked for me. As Kalle intends to move more drivers into 
vendor subfolder, can we expect this will happen again. Can we fix up 
kconfig handling for this?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
