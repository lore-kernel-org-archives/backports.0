Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:42901 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbbLIW5V (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Dec 2015 17:57:21 -0500
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
To: Arend van Spriel <arend@broadcom.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>
 <5663458B.1070103@hauke-m.de> <1449412622.4040.0.camel@sipsolutions.net>
 <56654A94.4060502@broadcom.com> <1449478931.4040.1.camel@sipsolutions.net>
 <56654C02.8010005@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5668B1CF.6040301@hauke-m.de> (sfid-20151209_235729_434021_A1BA3F72)
Date: Wed, 9 Dec 2015 23:57:19 +0100
MIME-Version: 1.0
In-Reply-To: <56654C02.8010005@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/07/2015 10:06 AM, Arend van Spriel wrote:
> On 12/07/2015 10:02 AM, Johannes Berg wrote:
>> On Mon, 2015-12-07 at 10:00 +0100, Arend van Spriel wrote:
>>>
>>>>> drivers/net/wireless/broadcom/
>>
>>> drivers/net/wireless/broadcom/Kconfig
>>> drivers/net/wireless/broadcom/Makefile
>>> drivers/net/wireless/broadcom/b43
>>> drivers/net/wireless/broadcom/b43legacy
>>> drivers/net/wireless/broadcom/brcm80211
>>>
>>> Or (as Hauke suggests):
>>>
>>> drivers/net/wireless/broadcom/
>>>
>>> To restrict the copy-list the first option would be preferred.
>>>
>>
>> Oh, you meant for the copy-list?
>>
>> I thought upstream backports just shipped a single copy-list line
>> "ddrivers/net/wireless/"?
> 
> Nope. It is:
> 
> # 802.11
> drivers/net/wireless/Kconfig
> drivers/net/wireless/Makefile
> 
> It looks for subfolders and modifies the Kconfig and Makefile for the
> ones missing (comment out).
> 
> Regards,
> Arend
> 
>> johannes
>>

Arend is right I was asking if you would like:
drivers/net/wireless/broadcom/Kconfig
drivers/net/wireless/broadcom/Makefile
drivers/net/wireless/broadcom/b43
drivers/net/wireless/broadcom/b43legacy
drivers/net/wireless/broadcom/brcm80211

or this:
drivers/net/wireless/broadcom/

or this:
drivers/net/wireless/

for the copy-list file.

This is not just about the Broadcom driver I would do it in the same way
for all wifi driver.

Do both of you replace the copy-list file in your internal versions?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
