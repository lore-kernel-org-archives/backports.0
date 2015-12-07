Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:39419 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbbLGJAT (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Dec 2015 04:00:19 -0500
Message-ID: <56654A94.4060502@broadcom.com> (sfid-20151207_100023_675697_9CEC5F38)
Date: Mon, 7 Dec 2015 10:00:04 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>	 <5663458B.1070103@hauke-m.de> (sfid-20151205_211408_495778_1F398223) <1449412622.4040.0.camel@sipsolutions.net>
In-Reply-To: <1449412622.4040.0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/06/2015 03:37 PM, Johannes Berg wrote:
>
>> Is it ok to replace the b43, b43legacy and brcm80211 by this single
>> line?
>> drivers/net/wireless/broadcom/
>>
>
> You mean in a single patch? I generally considered each file (or at
> least driver) separately so you could restrict copy-list to it.

There is option to do:

drivers/net/wireless/broadcom/Kconfig
drivers/net/wireless/broadcom/Makefile
drivers/net/wireless/broadcom/b43
drivers/net/wireless/broadcom/b43legacy
drivers/net/wireless/broadcom/brcm80211

Or (as Hauke suggests):

drivers/net/wireless/broadcom/

To restrict the copy-list the first option would be preferred.

Regards,
Arend

> johannes
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
