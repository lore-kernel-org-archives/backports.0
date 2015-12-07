Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:41970 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbbLGIzi (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Dec 2015 03:55:38 -0500
Message-ID: <56654988.9080800@broadcom.com> (sfid-20151207_095549_961562_7B607D25)
Date: Mon, 7 Dec 2015 09:55:36 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
References: <1448884387-20806-1-git-send-email-arend@broadcom.com> <5663458B.1070103@hauke-m.de>
In-Reply-To: <5663458B.1070103@hauke-m.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/05/2015 09:14 PM, Hauke Mehrtens wrote:
> On 11/30/2015 12:53 PM, Arend van Spriel wrote:
>> Patch for brcmfmac need update path as it now resides under
>> the broadcom vendor directory.
>>
>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>> ---
>>   .../network/0055-name_assign_type/brcmfmac.patch                      | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
>> index c68e9d0..bcbac24 100644
>> --- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
>> +++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
>> @@ -1,5 +1,5 @@
>> ---- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
>> -+++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
>> +--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> ++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>>   @@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
>>    	}
>>
>>
> I will do this for all patches at once, but thanks.
>
> Is it ok to replace the b43, b43legacy and brcm80211 by this single line?
> drivers/net/wireless/broadcom/

Fine by me. I have my own copy-list to only deal with brcm80211.

Regards,
Arend

> Hauke
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
