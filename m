Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:2365 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbbLGJGM (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Dec 2015 04:06:12 -0500
Message-ID: <56654C02.8010005@broadcom.com> (sfid-20151207_100615_879967_E40D6828)
Date: Mon, 7 Dec 2015 10:06:10 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>		 <5663458B.1070103@hauke-m.de>	 (sfid-20151205_211408_495778_1F398223) <1449412622.4040.0.camel@sipsolutions.net>	 <56654A94.4060502@broadcom.com> <1449478931.4040.1.camel@sipsolutions.net>
In-Reply-To: <1449478931.4040.1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/07/2015 10:02 AM, Johannes Berg wrote:
> On Mon, 2015-12-07 at 10:00 +0100, Arend van Spriel wrote:
>>
>>>> drivers/net/wireless/broadcom/
>
>> drivers/net/wireless/broadcom/Kconfig
>> drivers/net/wireless/broadcom/Makefile
>> drivers/net/wireless/broadcom/b43
>> drivers/net/wireless/broadcom/b43legacy
>> drivers/net/wireless/broadcom/brcm80211
>>
>> Or (as Hauke suggests):
>>
>> drivers/net/wireless/broadcom/
>>
>> To restrict the copy-list the first option would be preferred.
>>
>
> Oh, you meant for the copy-list?
>
> I thought upstream backports just shipped a single copy-list line
> "ddrivers/net/wireless/"?

Nope. It is:

# 802.11
drivers/net/wireless/Kconfig
drivers/net/wireless/Makefile

It looks for subfolders and modifies the Kconfig and Makefile for the 
ones missing (comment out).

Regards,
Arend

> johannes
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
