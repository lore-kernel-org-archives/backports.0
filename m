Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47922 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307Ab3HOLgG (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 Aug 2013 07:36:06 -0400
Message-ID: <520CBD1F.6060106@hauke-m.de> (sfid-20130815_133609_298322_3A799C97)
Date: Thu, 15 Aug 2013 13:35:59 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH v2 9/9] backports: add wwan device drivers
References: <cover.1376467862.git.patrick.ziegler@fh-kl.de> <520B3D66.4080208@fh-kl.de>
In-Reply-To: <520B3D66.4080208@fh-kl.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/14/2013 10:18 AM, Patrick Ziegler wrote:
> Add cdc_mbim, cdc_ncm, sierra_net, qmi_wwan device drivers.
> 
> Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
> ---
>  backport/Kconfig                                           |  2 ++
>  backport/Makefile.kernel                                   |  3 +++
>  copy-list                                                  | 14 ++++++++++++++
>  .../network/0001-netdev_ops/qmi_wwan.patch                 | 11 +++++++++++
>  .../network/0001-netdev_ops/sierra_net.patch               | 11 +++++++++++
>  .../62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch       | 12 ++++++++++++
>  .../62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch        | 12 ++++++++++++
>  .../62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch       | 12 ++++++++++++
>  .../62-usb_driver_lpm/drivers_net_usb_sierra_net.patch     | 12 ++++++++++++
>  .../62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch      | 12 ++++++++++++
>  10 files changed, 101 insertions(+)
>  create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
>  create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch

Please add a defconfig/wwan file which activates these drivers.

Hauke
