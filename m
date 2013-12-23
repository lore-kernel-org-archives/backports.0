Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48622 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab3LWN6z (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Dec 2013 08:58:55 -0500
Message-ID: <52B84193.4060000@hauke-m.de> (sfid-20131223_145857_187735_23FC74B3)
Date: Mon, 23 Dec 2013 14:58:43 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH RFC v2 07/11] backports: igb fixes for linux-3.4
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de> <1387382905-14274-8-git-send-email-sassmann@kpanic.de> <52B221A6.6070109@hauke-m.de> <52B2CC7D.60602@kpanic.de>
In-Reply-To: <52B2CC7D.60602@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/19/2013 11:37 AM, Stefan Assmann wrote:
> On 18.12.2013 23:28, Hauke Mehrtens wrote:
>> On 12/18/2013 05:08 PM, Stefan Assmann wrote:
>>> - add struct ethtool_ts_info
>>> - add struct ethtool_modinfo
>>> - add struct timestamp_event_queue
>>> - add struct ptp_clock
>>> - add ptp_clock_index()
>>> - add patches/collateral-evolutions/network/82-ethernet/0007-igb_ethtool_ops.patch
>>>
>>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>>> ---
>>>  backport/backport-include/linux/ethtool.h          | 48 ++++++++++++++++++++++
>>>  backport/backport-include/linux/ptp_clock_kernel.h | 35 ++++++++++++++++
>>>  backport/compat/compat-3.5.c                       | 11 +++++
>>>  .../network/82-ethernet/0007-igb_ethtool_ops.patch | 24 +++++++++++
>>>  4 files changed, 118 insertions(+)
>>>  create mode 100644 backport/backport-include/linux/ptp_clock_kernel.h
>>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0007-igb_ethtool_ops.patch
>>>
>>> diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
>>> index 4f13cb9..38882de 100644
>>> --- a/backport/backport-include/linux/ethtool.h
>>> +++ b/backport/backport-include/linux/ethtool.h
>>> @@ -42,6 +42,54 @@ static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
>>>  }
>>>  #endif
>>>  
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
>>> +/* EEPROM Standards for plug in modules */
>>> +#define ETH_MODULE_SFF_8079		0x1
>>> +#define ETH_MODULE_SFF_8079_LEN		256
>>> +#define ETH_MODULE_SFF_8472		0x2
>>> +#define ETH_MODULE_SFF_8472_LEN		512
>>> +
>>> +/**
>>> + * struct ethtool_ts_info - holds a device's timestamping and PHC association
>>> + * @cmd: command number = %ETHTOOL_GET_TS_INFO
>>> + * @so_timestamping: bit mask of the sum of the supported SO_TIMESTAMPING flags
>>> + * @phc_index: device index of the associated PHC, or -1 if there is none
>>> + * @tx_types: bit mask of the supported hwtstamp_tx_types enumeration values
>>> + * @rx_filters: bit mask of the supported hwtstamp_rx_filters enumeration values
>>> + *
>>> + * The bits in the 'tx_types' and 'rx_filters' fields correspond to
>>> + * the 'hwtstamp_tx_types' and 'hwtstamp_rx_filters' enumeration values,
>>> + * respectively.  For example, if the device supports HWTSTAMP_TX_ON,
>>> + * then (1 << HWTSTAMP_TX_ON) in 'tx_types' will be set.
>>> + */
>>> +struct ethtool_ts_info {
>>> +	__u32	cmd;
>>> +	__u32	so_timestamping;
>>> +	__s32	phc_index;
>>> +	__u32	tx_types;
>>> +	__u32	tx_reserved[3];
>>> +	__u32	rx_filters;
>>> +	__u32	rx_reserved[3];
>>> +};
>>> +
>>> +/**
>>> + * struct ethtool_modinfo - plugin module eeprom information
>>> + * @cmd: %ETHTOOL_GMODULEINFO
>>> + * @type: Standard the module information conforms to %ETH_MODULE_SFF_xxxx
>>> + * @eeprom_len: Length of the eeprom
>>> + *
>>> + * This structure is used to return the information to
>>> + * properly size memory for a subsequent call to %ETHTOOL_GMODULEEEPROM.
>>> + * The type code indicates the eeprom data format
>>> + */
>>> +struct ethtool_modinfo {
>>> +	__u32   cmd;
>>> +	__u32   type;
>>> +	__u32   eeprom_len;
>>> +	__u32   reserved[8];
>>> +};
>>> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
>>> +
>>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
>>>  /**
>>>   * struct ethtool_eee - Energy Efficient Ethernet information
>>> diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
>>> new file mode 100644
>>> index 0000000..b455517
>>> --- /dev/null
>>> +++ b/backport/backport-include/linux/ptp_clock_kernel.h
>>> @@ -0,0 +1,35 @@
>>> +#ifndef __BACKPORT_PTP_CLOCK_KERNEL_H
>>> +#define __BACKPORT_PTP_CLOCK_KERNEL_H
>>> +#include_next <linux/ptp_clock_kernel.h>
>>> +
>>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
>>> +#include <linux/posix-clock.h>
>>> +
>>> +#define PTP_MAX_TIMESTAMPS 128
>>> +#define PTP_BUF_TIMESTAMPS 30
>>> +
>>> +struct timestamp_event_queue {
>>> +	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
>>> +	int head;
>>> +	int tail;
>>> +	spinlock_t lock;
>>> +};
>>> +
>>> +struct ptp_clock {
>>> +	struct posix_clock clock;
>>> +	struct device *dev;
>>> +	struct ptp_clock_info *info;
>>> +	dev_t devid;
>>> +	int index; /* index into clocks.map */
>>> +	struct pps_device *pps_source;
>>> +	long dialed_frequency; /* remembers the frequency adjustment */
>>> +	struct timestamp_event_queue tsevq; /* simple fifo for time stamps */
>>> +	struct mutex tsevq_mux; /* one process at a time reading the fifo */
>>> +	wait_queue_head_t tsev_wq;
>>> +	int defunct; /* tells readers to go away when clock is being removed */
>>> +};
>>> +
>>> +extern int ptp_clock_index(struct ptp_clock *ptp);
>>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
>>> +
>>> +#endif /* __BACKPORT_PTP_CLOCK_KERNEL_H */
>>> diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
>>> index 95f52b9..0a4aaba 100644
>>> --- a/backport/compat/compat-3.5.c
>>> +++ b/backport/compat/compat-3.5.c
>>> @@ -12,6 +12,9 @@
>>>  #include <linux/highuid.h>
>>>  #include <linux/ktime.h>
>>>  #include <linux/hrtimer.h>
>>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0)
>>> +#include <linux/ptp_clock_kernel.h>
>>> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) */
>>>  
>>>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
>>>  #include <linux/device.h>
>>> @@ -64,3 +67,11 @@ int overflowgid = DEFAULT_OVERFLOWGID;
>>>  EXPORT_SYMBOL_GPL(overflowuid);
>>>  EXPORT_SYMBOL_GPL(overflowgid);
>>>  #endif
>>> +
>>> +#ifdef CONFIG_PTP_1588_CLOCK
>>> +int ptp_clock_index(struct ptp_clock *ptp)
>>> +{
>>> +	return ptp->index;
>>> +}
>>> +EXPORT_SYMBOL(ptp_clock_index);
>>
>> ptp_clock_index() is only used in igb_get_ts_info() which which is never
>> called in kernel < 3.5 because this operation does not exist in
>> ethtool_ops there.
>> Backporting this is not so easy as it looks here, because you added
>> struct ptp_clock here and there is also a version in the kernel, if they
>> differ it could be that this index does not point to the same offset the
>> kernel used as index variable. I would also ifdef the igb_get_ts_info()
>> itself and remove the stuff related to ptp_clock_index(), you are seeing
>> a unused function warning as well.
> 
> So how about we take the original struct ptp_clock? There's only been
> one single change introduced in 3.7 to the struct. No harm should come
> from that code then.

Yes adding that struct should work.

> As stated earlier I'm trying to keep the changes to igb itself as small
> as possible and the unused function warnings are also a good indicator
> for what is actually missing in the driver. There's already a bunch of
> them if you compile against 3.0:
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_main.c:7643: warning: igb_ndo_set_vf_spoofchk defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_main.c:7359: warning: igb_pci_sriov_configure defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2354: warning: igb_get_ts_info defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2448: warning: igb_get_rxnfc defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2573: warning: igb_set_rxnfc defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2660: warning: igb_set_eee defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2718: warning: igb_get_module_info defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2760: warning: igb_get_module_eeprom defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2810: warning: igb_get_rxfh_indir_size defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2815: warning: igb_get_rxfh_indir defined but not used
> /dev/shm/next/drivers/net/ethernet/intel/igb/igb_ethtool.c:2861: warning: igb_set_rxfh_indir defined but not used
> The bottom line is, I'd like to keep them if you're not strictly opposed
> to it.

These warnings do no harm, but it could be that we will miss some
serious warnings. Could you eliminate these warnings please.

By the way, with which kernel versions have you done runtime tests?

Hauke
