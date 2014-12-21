Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:48059 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbaLUN12 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 21 Dec 2014 08:27:28 -0500
Message-ID: <5496CABD.7060405@broadcom.com> (sfid-20141221_142729_558083_E893A124)
Date: Sun, 21 Dec 2014 14:27:25 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH 06/14] backport: add debugfs_create_devm_seqfile()
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de> <1419111577-22174-7-git-send-email-hauke@hauke-m.de> <549684B0.1000308@broadcom.com> <5496BD3F.5010500@hauke-m.de>
In-Reply-To: <5496BD3F.5010500@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/21/14 13:29, Hauke Mehrtens wrote:
> On 12/21/2014 09:28 AM, Arend van Spriel wrote:
>> On 12/20/14 22:39, Hauke Mehrtens wrote:
>>> This new functions is used by ath9k.
>>
>> Are you sure? In the driver-core repo the ath9k patch adding this was
>> reverted as I made a stupid mistake with driver data. I have the revised
>> patch ready, but it will be for 3.20.
>
> I was using the next-20141201 snapshot and there it was included.
> Thanks for the heads up, I will cherry pick your revert commit.
> This problem was in the ath9k driver and not in the code in
> fs/debugfs/file.c is that right?

Yeah, that is what I get from tweaking in drivers that I know next to 
nothing about ;-) So indeed the debugfs change is fine and I will start 
using it in the brcm80211 drivers as well for next release so no harm in 
keeping it.

Regards,
Arend

>> Regards,
>> Arend
>>
>>> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>
>
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

