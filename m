Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:46555 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750875Ab3LSJu6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 19 Dec 2013 04:50:58 -0500
Message-ID: <52B2C17F.9080409@kpanic.de> (sfid-20131219_105101_466929_790645EE)
Date: Thu, 19 Dec 2013 10:50:55 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/11] backports: igb fixes for linux-3.6
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de> <1387382905-14274-6-git-send-email-sassmann@kpanic.de> <52B20530.2040204@hauke-m.de>
In-Reply-To: <52B20530.2040204@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 18.12.2013 21:27, Hauke Mehrtens wrote:
> On 12/18/2013 05:08 PM, Stefan Assmann wrote:
>> - backport ethtool_cmd
>> - backport ethtool_ops
>> - backport mmd_eee_adv_to_ethtool_adv_t
>> - add patches/collateral-evolutions/network/82-ethernet/0003-igb_ptp.patch
>> - add patches/collateral-evolutions/network/82-ethernet/0004-igb_err_handler.patch
>> - add patches/collateral-evolutions/network/82-ethernet/0005-igb_mdi.patch
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  backport/backport-include/linux/mdio.h             | 35 ++++++++++++++++
>>  .../network/82-ethernet/0003-igb_ptp.patch         | 17 ++++++++
>>  .../network/82-ethernet/0004-igb_err_handler.patch | 16 +++++++
>>  .../network/82-ethernet/0005-igb_mdi.patch         | 49 ++++++++++++++++++++++
>>  4 files changed, 117 insertions(+)
>>  create mode 100644 backport/backport-include/linux/mdio.h
>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0003-igb_ptp.patch
>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0004-igb_err_handler.patch
>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0005-igb_mdi.patch
>>
>> diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
>> new file mode 100644
>> index 0000000..2a38121
>> --- /dev/null
>> +++ b/backport/backport-include/linux/mdio.h
>> @@ -0,0 +1,35 @@
>> +#ifndef __BACKPORT_LINUX_MDIO_H
>> +#define __BACKPORT_LINUX_MDIO_H
>> +#include_next <linux/mdio.h>
>> +
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
>> +/**
>> + * mmd_eee_adv_to_ethtool_adv_t
>> + * @eee_adv: value of the MMD EEE Advertisement/Link Partner Ability registers
>> + *
>> + * A small helper function that translates the MMD EEE Advertisment (7.60)
>> + * and MMD EEE Link Partner Ability (7.61) bits to ethtool advertisement
>> + * settings.
>> + */
>> +static inline u32 mmd_eee_adv_to_ethtool_adv_t(u16 eee_adv)
>> +{
>> +	u32 adv = 0;
>> +
>> +	if (eee_adv & MDIO_EEE_100TX)
>> +		adv |= ADVERTISED_100baseT_Full;
>> +	if (eee_adv & MDIO_EEE_1000T)
>> +		adv |= ADVERTISED_1000baseT_Full;
>> +	if (eee_adv & MDIO_EEE_10GT)
>> +		adv |= ADVERTISED_10000baseT_Full;
>> +	if (eee_adv & MDIO_EEE_1000KX)
>> +		adv |= ADVERTISED_1000baseKX_Full;
>> +	if (eee_adv & MDIO_EEE_10GKX4)
>> +		adv |= ADVERTISED_10000baseKX4_Full;
>> +	if (eee_adv & MDIO_EEE_10GKR)
>> +		adv |= ADVERTISED_10000baseKR_Full;
>> +
>> +	return adv;
>> +}
>> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
>> +
>> +#endif /* __BACKPORT_LINUX_MDIO_H */
>> diff --git a/patches/collateral-evolutions/network/82-ethernet/0003-igb_ptp.patch b/patches/collateral-evolutions/network/82-ethernet/0003-igb_ptp.patch
>> new file mode 100644
>> index 0000000..9799466
>> --- /dev/null
>> +++ b/patches/collateral-evolutions/network/82-ethernet/0003-igb_ptp.patch
>> @@ -0,0 +1,17 @@
>> +diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> +index 5a54e3d..97bb1cf 100644
>> +--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>> ++++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> +@@ -802,8 +802,12 @@ void igb_ptp_init(struct igb_adapter *adapter)
>> + 		wr32(E1000_IMS, E1000_IMS_TS);
>> + 	}
>> + 
>> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
>> + 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
>> + 						&adapter->pdev->dev);
>> ++#else
>> ++	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps);
>> ++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
> 
> This could be replaced with in a header file:
> #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
> #define ptp_clock_register(info,parent) ptp_clock_register(info)
> #endif

Yes that's better, going to be included in next version.

  Stefan
