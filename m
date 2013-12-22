Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45380 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab3LVS4p (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 22 Dec 2013 13:56:45 -0500
Message-ID: <52B735E4.5080309@hauke-m.de> (sfid-20131222_195651_311057_09650058)
Date: Sun, 22 Dec 2013 19:56:36 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH RFC v2 06/11] backports: igb fixes for linux-3.5
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de> <1387382905-14274-7-git-send-email-sassmann@kpanic.de> <52B206F9.3020702@hauke-m.de> <52B2C2AA.2070407@kpanic.de>
In-Reply-To: <52B2C2AA.2070407@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/19/2013 10:55 AM, Stefan Assmann wrote:
> On 18.12.2013 21:35, Hauke Mehrtens wrote:
>> On 12/18/2013 05:08 PM, Stefan Assmann wrote:
>>> - add EEE defines
>>> - add struct ethtool_eee
>>> - backport __skb_alloc_page and __skb_alloc_pages
>>> - add patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch
>>>
>>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>>> ---
>>>  backport/backport-include/linux/ethtool.h          | 31 +++++++++++++++
>>>  backport/backport-include/linux/gfp.h              | 10 +++++
>>>  backport/backport-include/linux/mdio.h             | 23 ++++++++++-
>>>  backport/backport-include/linux/skbuff.h           | 46 ++++++++++++++++++++++
>>>  .../network/82-ethernet/0006-igb_eee.patch         | 15 +++++++
>>>  5 files changed, 124 insertions(+), 1 deletion(-)
>>>  create mode 100644 backport/backport-include/linux/gfp.h
>>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0006-igb_eee.patch
>>>
>>> diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
>>> index 647fbf6..4f13cb9 100644
>>> --- a/backport/backport-include/linux/ethtool.h
>>> +++ b/backport/backport-include/linux/ethtool.h
>>> @@ -42,4 +42,35 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
>>>  }
>>>  #endif
>>>  
>>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
>>> +/**
>>> + * struct ethtool_eee - Energy Efficient Ethernet information
>>> + * @cmd: ETHTOOL_{G,S}EEE
>>> + * @supported: Mask of %SUPPORTED_* flags for the speed/duplex combinations
>>> + *	for which there is EEE support.
>>> + * @advertised: Mask of %ADVERTISED_* flags for the speed/duplex combinations
>>> + *	advertised as eee capable.
>>> + * @lp_advertised: Mask of %ADVERTISED_* flags for the speed/duplex
>>> + *	combinations advertised by the link partner as eee capable.
>>> + * @eee_active: Result of the eee auto negotiation.
>>> + * @eee_enabled: EEE configured mode (enabled/disabled).
>>> + * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
>>> + *	that eee was negotiated.
>>> + * @tx_lpi_timer: Time in microseconds the interface delays prior to asserting
>>> + *	its tx lpi (after reaching 'idle' state). Effective only when eee
>>> + *	was negotiated and tx_lpi_enabled was set.
>>> + */
>>> +struct ethtool_eee {
>>> +	__u32	cmd;
>>> +	__u32	supported;
>>> +	__u32	advertised;
>>> +	__u32	lp_advertised;
>>> +	__u32	eee_active;
>>> +	__u32	eee_enabled;
>>> +	__u32	tx_lpi_enabled;
>>> +	__u32	tx_lpi_timer;
>>> +	__u32	reserved[2];
>>> +};
>>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
>>
>> The get_eee and set_eee callbacks in struct ethtool_ops are not
>> available on this kernel, you could also add a #ifdef <kernel version>
>> around igb_get_eee() and igb_set_eee() and remove the struct here.
> 
> True, but that would result in more ifdefs in igb and I'd like to keep
> the number at a minimum. Results in less maintenance work if upstream
> changes.

Yes, but on the other side I am getting some build warnings, because
these function are static and not used. I do not think this will break
often because the order of function isn't changed often and if that is
the case it is easy to fix.

Hauke

  CC [M]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_main.o
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_main.c:7359:12:
warning: ‘igb_pci_sriov_configure’ defined but not used [-Wunused-function]
  CC [M]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.o
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2354:12:
warning: ‘igb_get_ts_info’ defined but not used [-Wunused-function]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2660:12:
warning: ‘igb_set_eee’ defined but not used [-Wunused-function]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2718:12:
warning: ‘igb_get_module_info’ defined but not used [-Wunused-function]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2760:12:
warning: ‘igb_get_module_eeprom’ defined but not used [-Wunused-function]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2810:12:
warning: ‘igb_get_rxfh_indir_size’ defined but not used [-Wunused-function]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2815:12:
warning: ‘igb_get_rxfh_indir’ defined but not used [-Wunused-function]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/igb_ethtool.c:2861:12:
warning: ‘igb_set_rxfh_indir’ defined but not used [-Wunused-function]
  CC [M]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/e1000_82575.o
  CC [M]
/home/hauke/compat-wireless/backports-20131206/drivers/net/ethernet/intel/igb/e1000_mac.o


