Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58790 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762185Ab3DEP3g (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 11:29:36 -0400
Message-ID: <515EEDD2.5040404@hauke-m.de> (sfid-20130405_172938_722293_2414F63E)
Date: Fri, 05 Apr 2013 17:29:22 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Thierry Escande <thierry.escande@linux.intel.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH] backports: Add NFC patches
References: <1365174812-2672-3-git-send-email-thierry.escande@linux.intel.com>
In-Reply-To: <1365174812-2672-3-git-send-email-thierry.escande@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/05/2013 05:13 PM, Thierry Escande wrote:
> These are NFC patches refreshed on next-20130328
> 
> Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> ---
>  .../0005-netlink-portid/net_nfc_netlink.patch      |   71 ++++++++++++++++++++
>  .../network/53-pr_fmt/net_nfc_core.patch           |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_command.patch    |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_core.patch       |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_hcp.patch        |   13 ++++
>  .../network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch  |   13 ++++
>  .../network/53-pr_fmt/net_nfc_llcp_commands.patch  |   13 ++++
>  .../network/53-pr_fmt/net_nfc_llcp_llcp.patch      |   13 ++++
>  .../network/53-pr_fmt/net_nfc_llcp_sock.patch      |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_core.patch       |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_data.patch       |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_ntf.patch        |   13 ++++
>  .../network/53-pr_fmt/net_nfc_nci_rsp.patch        |   12 ++++
>  .../network/53-pr_fmt/net_nfc_netlink.patch        |   13 ++++
>  .../network/53-pr_fmt/net_nfc_rawsock.patch        |   13 ++++
>  .../network/74-driver-core-constify-data/INFO      |    7 ++
>  .../net_nfc_core.patch                             |   14 ++++
>  .../network/75-module-alias-genl-family/INFO       |    7 ++
>  .../75-module-alias-genl-family/net_nfc_core.patch |   12 ++++
>  .../network/76-module-i2c-driver/INFO              |    7 ++
>  .../drivers_nfc_microread_i2c.patch                |   14 ++++
>  .../drivers_nfc_pn544_i2c.patch                    |   14 ++++
>  22 files changed, 327 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/0005-netlink-portid/net_nfc_netlink.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_core.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_command.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_core.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_hcp.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_hci_llc_shdlc.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_commands.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_llcp.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_llcp_sock.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_core.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_data.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_ntf.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_nci_rsp.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_netlink.patch
>  create mode 100644 patches/collateral-evolutions/network/53-pr_fmt/net_nfc_rawsock.patch
>  create mode 100644 patches/collateral-evolutions/network/74-driver-core-constify-data/INFO
>  create mode 100644 patches/collateral-evolutions/network/74-driver-core-constify-data/net_nfc_core.patch
>  create mode 100644 patches/collateral-evolutions/network/75-module-alias-genl-family/INFO
>  create mode 100644 patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch
>  create mode 100644 patches/collateral-evolutions/network/76-module-i2c-driver/INFO
>  create mode 100644 patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch
>  create mode 100644 patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch
> 

......

> --- /dev/null
> +++ b/patches/collateral-evolutions/network/75-module-alias-genl-family/INFO
> @@ -0,0 +1,7 @@
> +This backports:
> +
> +commit e9412c37082b5c932e83364aaed0c38c2ce33acb
> +Author: Neil Horman <nhorman@tuxdriver.com>
> +Date:   Tue May 29 09:30:41 2012 +0000
> +
> +    genetlink: Build a generic netlink family module alias
> diff --git a/patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch b/patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch
> new file mode 100644
> index 0000000..b3cdb7e
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/75-module-alias-genl-family/net_nfc_core.patch
> @@ -0,0 +1,12 @@
> +--- a/net/nfc/core.c
> ++++ b/net/nfc/core.c
> +@@ -941,4 +941,9 @@ MODULE_DESCRIPTION("NFC Core ver " VERSI
> + MODULE_VERSION(VERSION);
> + MODULE_LICENSE("GPL");
> + MODULE_ALIAS_NETPROTO(PF_NFC);
> ++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> + MODULE_ALIAS_GENL_FAMILY(NFC_GENL_NAME);
> ++#else
> ++MODULE_ALIAS("net-pf-" __stringify(PF_NETLINK) "-proto-" \
> ++__stringify(NETLINK_GENERIC) "-type-" NFC_GENL_NAME);
> ++#endif

I would prefer if you add #define MODULE_ALIAS_GENL_FAMILY() to
backport/include/linux/compat-*.h

It looks possible and something in backport/ is preferred over a patch.

> diff --git a/patches/collateral-evolutions/network/76-module-i2c-driver/INFO b/patches/collateral-evolutions/network/76-module-i2c-driver/INFO
> new file mode 100644
> index 0000000..04333a7
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/76-module-i2c-driver/INFO
> @@ -0,0 +1,7 @@
> +This backports:
> +
> +commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
> +Author: Lars-Peter Clausen <lars@metafoo.de>
> +Date:   Wed Nov 16 10:13:36 2011 +0100
> +
> +    I2C: Add helper macro for i2c_driver boilerplate
> diff --git a/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch
> new file mode 100644
> index 0000000..c84dcd3
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_microread_i2c.patch
> @@ -0,0 +1,14 @@
> +--- a/drivers/nfc/microread/i2c.c
> ++++ b/drivers/nfc/microread/i2c.c
> +@@ -334,7 +334,11 @@ static struct i2c_driver microread_i2c_d
> + 	.id_table	= microread_i2c_id,
> + };
> + 
> ++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
> + module_i2c_driver(microread_i2c_driver);
> ++#else
> ++module_driver(microread_i2c_driver, i2c_add_driver, i2c_del_driver)
> ++#endif

Add this to backport/include/linux/compat-*.h like it was done in:
commit 117e80b649819db203743fb8774a6f1e9c9f93c4
Author: Hauke Mehrtens <hauke@hauke-m.de>
Date:   Thu Mar 28 20:18:23 2013 +0100

    compat: add module_pcmcia_driver

> + 
> + MODULE_LICENSE("GPL");
> + MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch
> new file mode 100644
> index 0000000..45cba3b
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/76-module-i2c-driver/drivers_nfc_pn544_i2c.patch
> @@ -0,0 +1,14 @@
> +--- a/drivers/nfc/pn544/i2c.c
> ++++ b/drivers/nfc/pn544/i2c.c
> +@@ -464,7 +464,11 @@ static struct i2c_driver pn544_hci_i2c_d
> + 	.remove = pn544_hci_i2c_remove,
> + };
> + 
> ++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
> + module_i2c_driver(pn544_hci_i2c_driver);
> ++#else
> ++module_driver(pn544_hci_i2c_driver, i2c_add_driver, i2c_del_driver)
> ++#endif

same here

> + 
> + MODULE_LICENSE("GPL");
> + MODULE_DESCRIPTION(DRIVER_DESC);
> 

