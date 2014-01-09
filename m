Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60091 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbaAIVBf (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 9 Jan 2014 16:01:35 -0500
Message-ID: <52CF0E26.5040900@hauke-m.de> (sfid-20140109_220139_950136_11E9A603)
Date: Thu, 09 Jan 2014 22:01:26 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, mcgrof@kernel.org
CC: backports@vger.kernel.org
Subject: Re: [PATCH v3 02/11] backports: igb fixes for linux-3.9
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de> <1389177854-24292-3-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1389177854-24292-3-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/08/2014 11:44 AM, Stefan Assmann wrote:
> - add struct pci_sriov
> - add pci_vfs_assigned()
> - add PCI_SRIOV defines
> - add patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  backport/backport-include/linux/pci.h              | 33 +++++++++++++
>  backport/backport-include/linux/pci_regs.h         |  8 ++++
>  backport/compat/backport-3.10.c                    | 46 ++++++++++++++++++
>  .../82-ethernet/0001-igb_net_device_ops.patch      | 56 ++++++++++++++++++++++
>  4 files changed, 143 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
> 
> diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
> index 3a1815a..9083255 100644
> --- a/backport/backport-include/linux/pci.h
> +++ b/backport/backport-include/linux/pci.h
> @@ -178,4 +178,37 @@ bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
>  	.subvendor = (subvend), .subdevice = (subdev)
>  #endif /* PCI_DEVICE_SUB */
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
> +/* Taken from drivers/pci/pci.h */
> +struct pci_sriov {
> +	int pos;		/* capability position */
> +	int nres;		/* number of resources */
> +	u32 cap;		/* SR-IOV Capabilities */
> +	u16 ctrl;		/* SR-IOV Control */
> +	u16 total_VFs;		/* total VFs associated with the PF */
> +	u16 initial_VFs;	/* initial VFs associated with the PF */
> +	u16 num_VFs;		/* number of VFs available */
> +	u16 offset;		/* first VF Routing ID offset */
> +	u16 stride;		/* following VF stride */
> +	u32 pgsz;		/* page size for BAR alignment */
> +	u8 link;		/* Function Dependency Link */
> +	u16 driver_max_VFs;	/* max num VFs driver supports */
> +	struct pci_dev *dev;	/* lowest numbered PF */
> +	struct pci_dev *self;	/* this PF */
> +	struct mutex lock;	/* lock for VF bus */
> +	struct work_struct mtask; /* VF Migration task */
> +	u8 __iomem *mstate;	/* VF Migration State Array */
> +};
> +

Please add this here:
#define pci_vfs_assigned LINUX_BACKPORT(pci_vfs_assigned)

This renames the function in backport by adding a backport_ prefix. If a
distribution backports this function compat.ko would not load without
this prefix.

> +#ifdef CONFIG_PCI_IOV
> +int pci_vfs_assigned(struct pci_dev *dev);
> +#else
> +static inline int pci_vfs_assigned(struct pci_dev *dev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
> +
>  #endif /* _BACKPORT_LINUX_PCI_H */
> diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
> index 5cfa742..b52c4a5 100644
> --- a/backport/backport-include/linux/pci_regs.h
> +++ b/backport/backport-include/linux/pci_regs.h
> @@ -125,4 +125,12 @@
>  #define PCI_PM_CAP_PME_SHIFT	11
>  #endif
>  
> +#ifndef PCI_SRIOV_VF_DID
> +#define PCI_SRIOV_VF_DID	0x1a	/* VF Device ID */
> +#endif
> +
> +#ifndef PCI_SRIOV_CTRL_VFE
> +#define PCI_SRIOV_CTRL_VFE	0x01	/* VF Enable */
> +#endif
> +
>  #endif /* __BACKPORT_UAPI_PCI_REGS_H */
> diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
> index 07a8dac..a9f74ed 100644
> --- a/backport/compat/backport-3.10.c
> +++ b/backport/compat/backport-3.10.c
> @@ -14,6 +14,8 @@
>  #include <linux/proc_fs.h>
>  #include <linux/random.h>
>  #include <linux/tty.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
>  
>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
>  #include <linux/init.h>
> @@ -128,4 +130,48 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
>  }
>  EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
>  #endif /* CONFIG_TTY */
> +
> +#ifdef CONFIG_PCI_IOV
> +/*
> + * pci_vfs_assigned - returns number of VFs are assigned to a guest
> + * @dev: the PCI device
> + *
> + * Returns number of VFs belonging to this device that are assigned to a guest.
> + * If device is not a physical function returns -ENODEV.
> + */
> +int pci_vfs_assigned(struct pci_dev *dev)
> +{
> +	struct pci_dev *vfdev;
> +	unsigned int vfs_assigned = 0;
> +	unsigned short dev_id;
> +
> +	/* only search if we are a PF */
> +	if (!dev->is_physfn)
> +		return 0;
> +
> +	/*
> +	 * determine the device ID for the VFs, the vendor ID will be the
> +	 * same as the PF so there is no need to check for that one
> +	 */
> +	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_VF_DID, &dev_id);
> +
> +	/* loop through all the VFs to see if we own any that are assigned */
> +	vfdev = pci_get_device(dev->vendor, dev_id, NULL);
> +	while (vfdev) {
> +		/*
> +		 * It is considered assigned if it is a virtual function with
> +		 * our dev as the physical function and the assigned bit is set
> +		 */
> +		if (vfdev->is_virtfn && (vfdev->physfn == dev) &&
> +		    (vfdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED))
> +			vfs_assigned++;
> +
> +		vfdev = pci_get_device(dev->vendor, dev_id, vfdev);
> +	}
> +
> +	return vfs_assigned;
> +}
> +EXPORT_SYMBOL_GPL(pci_vfs_assigned);
> +#endif /* CONFIG_PCI_IOV */
> +
>  #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
> diff --git a/patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch b/patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
> new file mode 100644
> index 0000000..981b89e
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/82-ethernet/0001-igb_net_device_ops.patch
> @@ -0,0 +1,56 @@
> +diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> +index 14ad4c7..f2a5abf 100644
> +--- a/drivers/net/ethernet/intel/igb/igb_main.c
> ++++ b/drivers/net/ethernet/intel/igb/igb_main.c
> +@@ -161,8 +161,13 @@ static int igb_ioctl(struct net_device *, struct ifreq *, int cmd);
> + static void igb_tx_timeout(struct net_device *);
> + static void igb_reset_task(struct work_struct *);
> + static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features);
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
> + static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
> + static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
> ++#else
> ++static int igb_vlan_rx_add_vid(struct net_device *, u16);
> ++static int igb_vlan_rx_kill_vid(struct net_device *, u16);
> ++#endif
> + static void igb_restore_vlan(struct igb_adapter *);
> + static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
> + static void igb_ping_all_vfs(struct igb_adapter *);
> +@@ -6959,8 +6964,12 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
> + 	igb_rlpml_set(adapter);
> + }
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
> + static int igb_vlan_rx_add_vid(struct net_device *netdev,
> + 			       __be16 proto, u16 vid)
> ++#else
> ++static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
> ++#endif
> + {
> + 	struct igb_adapter *adapter = netdev_priv(netdev);
> + 	struct e1000_hw *hw = &adapter->hw;
> +@@ -6977,8 +6986,12 @@ static int igb_vlan_rx_add_vid(struct net_device *netdev,
> + 	return 0;
> + }
> + 
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
> + static int igb_vlan_rx_kill_vid(struct net_device *netdev,
> + 				__be16 proto, u16 vid)
> ++#else
> ++static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
> ++#endif
> + {
> + 	struct igb_adapter *adapter = netdev_priv(netdev);
> + 	struct e1000_hw *hw = &adapter->hw;
> +@@ -7004,7 +7017,11 @@ static void igb_restore_vlan(struct igb_adapter *adapter)
> + 	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
> + 
> + 	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
> ++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
> + 		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
> ++#else
> ++		igb_vlan_rx_add_vid(adapter->netdev, vid);
> ++#endif
> + }
> + 
> + int igb_set_spd_dplx(struct igb_adapter *adapter, u32 spd, u8 dplx)
> 

