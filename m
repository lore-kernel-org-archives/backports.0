Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:59530 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbbFDJIN (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 4 Jun 2015 05:08:13 -0400
Message-ID: <55701578.9030205@kpanic.de> (sfid-20150604_110817_225326_68B28345)
Date: Thu, 04 Jun 2015 11:08:08 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH 1/4] backports: replace igb skb->no_fcs patch with semantic
 patch
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de> <1433330756-22733-2-git-send-email-sassmann@kpanic.de> <556F5FD5.4070003@hauke-m.de>
In-Reply-To: <556F5FD5.4070003@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03.06.2015 22:13, Hauke Mehrtens wrote:
> On 06/03/2015 01:25 PM, Stefan Assmann wrote:
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch           | 14 --------------
>>  .../network/0035-skb_no_fcs/skb_no_fcs.cocci               |  7 +++++++
>>  2 files changed, 7 insertions(+), 14 deletions(-)
>>  delete mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
>>  create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci
>>
>> diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
>> deleted file mode 100644
>> index f659bfd..0000000
>> --- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> ---- a/drivers/net/ethernet/intel/igb/igb_main.c
>> -+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> -@@ -4782,9 +4782,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
>> - 	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
>> - 				 (E1000_ADVTXD_MAC_TSTAMP));
>> - 
>> -+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
>> - 	/* insert frame checksum */
>> - 	cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
>> --
>> -+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) */
>> - 	return cmd_type;
>> - }
>> - 
>> diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci b/patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci
>> new file mode 100644
>> index 0000000..703c227
>> --- /dev/null
>> +++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci
>> @@ -0,0 +1,7 @@
>> +@r1@
>> +expression E1,E2;
>> +struct sk_buff *skb;
>> +@@
>> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
>> + E1 ^= E2(..., skb->no_fcs, ...)
>> ++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) */
>>
> 
> Is it always save to just remove something which accesses skb->no_fcs in
> all cases? I think sometimes some special handling for older kernel
> version could be needed. This also looks very specific to the igb usage.
> 
> Hauke
> 

In this case I'd say this is fine, no_fcs is used to send out frames with
bad CRC for testing. So just commenting out related code shouldn't cause
any harm. Yes, the cocci code is very specific and will likely need to be
extended for other drivers when we pull them in. But you have to start
somewhere.

We always have the option to revert if something turns out to be a bad
idea.

  Stefan
