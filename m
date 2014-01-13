Return-path: <backports-owner@vger.kernel.org>
Received: from mailout-40-32.xlhost.de ([84.200.40.32]:34234 "EHLO
	app1b.xlhost.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750771AbaAMHqA (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 Jan 2014 02:46:00 -0500
Message-ID: <52D39879.2010909@kpanic.de> (sfid-20140113_084602_166931_86338469)
Date: Mon, 13 Jan 2014 08:40:41 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH v3 04/11] backports: igb fixes for linux-3.7
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de> <1389177854-24292-5-git-send-email-sassmann@kpanic.de> <52CF1100.7090708@hauke-m.de>
In-Reply-To: <52CF1100.7090708@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09.01.2014 22:13, Hauke Mehrtens wrote:
> On 01/08/2014 11:44 AM, Stefan Assmann wrote:
>> - add pci_sriov_set_totalvfs()
>> - add patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  backport/backport-include/linux/pci.h              |  5 +-
>>  backport/compat/compat-3.8.c                       | 34 +++++++++++++
>>  .../82-ethernet/0002-igb_pci_sriov_configure.patch | 57 ++++++++++++++++++++++
>>  3 files changed, 95 insertions(+), 1 deletion(-)
>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0002-igb_pci_sriov_configure.patch
>>
>> diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
>> index 9083255..65a76a1 100644
>> --- a/backport/backport-include/linux/pci.h
>> +++ b/backport/backport-include/linux/pci.h
>> @@ -178,6 +178,10 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
>>  	.subvendor = (subvend), .subdevice = (subdev)
>>  #endif /* PCI_DEVICE_SUB */
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
> 
> Please add this here:
> #define pci_sriov_set_totalvfs LINUX_BACKPORT(pci_sriov_set_totalvfs)

Hi Hauke,

thanks for the comments. Any chance for you to apply the series and I'll
post follow up patch to fix up the remaining small issues. Rebasing the
patches is time consuming, especially since the latest cocci changes.

  Stefan
