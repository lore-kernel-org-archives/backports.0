Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:54868 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751738Ab3LSI4t (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 19 Dec 2013 03:56:49 -0500
Message-ID: <52B2B4CE.1080207@kpanic.de> (sfid-20131219_095652_010374_15D50B14)
Date: Thu, 19 Dec 2013 09:56:46 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH RFC v2 02/11] backports: igb fixes for linux-3.9
References: <1387382905-14274-1-git-send-email-sassmann@kpanic.de> <1387382905-14274-3-git-send-email-sassmann@kpanic.de> <52B2034D.3020100@hauke-m.de>
In-Reply-To: <52B2034D.3020100@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 18.12.2013 21:19, Hauke Mehrtens wrote:
> On 12/18/2013 05:08 PM, Stefan Assmann wrote:
>> - add struct pci_sriov
>> - add pci_vfs_assigned()
>> - add PCI_SRIOV defines
>> - add patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  backport/backport-include/linux/pci.h              | 25 ++++++++++
>>  backport/backport-include/linux/pci_regs.h         |  8 ++++
>>  backport/compat/backport-3.10.c                    | 46 ++++++++++++++++++
>>  .../82-ethernet/0001-igb_net_device_ops.patch      | 56 ++++++++++++++++++++++
>>  4 files changed, 135 insertions(+)
>>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
>>
>> diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
>> index 3a1815a..b56761f 100644
>> --- a/backport/backport-include/linux/pci.h
>> +++ b/backport/backport-include/linux/pci.h
>> @@ -178,4 +178,29 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
>>  	.subvendor = (subvend), .subdevice = (subdev)
>>  #endif /* PCI_DEVICE_SUB */
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
>> +/* Taken from drivers/pci/pci.h */
>> +struct pci_sriov {
>> +	int pos;		/* capability position */
>> +	int nres;		/* number of resources */
>> +	u32 cap;		/* SR-IOV Capabilities */
>> +	u16 ctrl;		/* SR-IOV Control */
>> +	u16 total_VFs;		/* total VFs associated with the PF */
>> +	u16 initial_VFs;	/* initial VFs associated with the PF */
>> +	u16 num_VFs;		/* number of VFs available */
>> +	u16 offset;		/* first VF Routing ID offset */
>> +	u16 stride;		/* following VF stride */
>> +	u32 pgsz;		/* page size for BAR alignment */
>> +	u8 link;		/* Function Dependency Link */
>> +	u16 driver_max_VFs;	/* max num VFs driver supports */
>> +	struct pci_dev *dev;	/* lowest numbered PF */
>> +	struct pci_dev *self;	/* this PF */
>> +	struct mutex lock;	/* lock for VF bus */
>> +	struct work_struct mtask; /* VF Migration task */
>> +	u8 __iomem *mstate;	/* VF Migration State Array */
>> +};
> 
> where is this struct used?

/dev/shm/next/compat/backport-3.10.c: In function pci_vfs_assigned:
/dev/shm/next/compat/backport-3.10.c:156: error: dereferencing pointer to incomplete type
pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_VF_DID, &dev_id);

> 
>> +extern int pci_vfs_assigned(struct pci_dev *dev);
> The extern is not needed.

Yes, my bad. Going to fix that.

> 
> If CONFIG_PCI_IOV is not set backports will not include the
> implementation of this function, you should add something like this in
> the header:
> 
> #ifdef CONFIG_PCI_IOV
> int pci_vfs_assigned(struct pci_dev *dev);
> #else
> static inline int pci_vfs_assigned(struct pci_dev *dev)
> {
> 	return 0;
> }
> #endif

Agreed.

  Stefan
