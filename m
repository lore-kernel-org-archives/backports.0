Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:51304 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755519Ab3HOLo2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 Aug 2013 07:44:28 -0400
Message-ID: <520CBF0C.0@fh-kl.de> (sfid-20130815_134430_162549_D42201A2)
Date: Thu, 15 Aug 2013 13:44:12 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH v2 9/9] backports: add wwan device drivers
References: <cover.1376467862.git.patrick.ziegler@fh-kl.de> <520B3D66.4080208@fh-kl.de> <520CBD1F.6060106@hauke-m.de>
In-Reply-To: <520CBD1F.6060106@hauke-m.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 15.08.2013 13:35, Hauke Mehrtens wrote:
> On 08/14/2013 10:18 AM, Patrick Ziegler wrote:
>> Add cdc_mbim, cdc_ncm, sierra_net, qmi_wwan device drivers.
>>
>> Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
>> ---
>>  backport/Kconfig                                           |  2 ++
>>  backport/Makefile.kernel                                   |  3 +++
>>  copy-list                                                  | 14 ++++++++++++++
>>  .../network/0001-netdev_ops/qmi_wwan.patch                 | 11 +++++++++++
>>  .../network/0001-netdev_ops/sierra_net.patch               | 11 +++++++++++
>>  .../62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch       | 12 ++++++++++++
>>  .../62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch        | 12 ++++++++++++
>>  .../62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch       | 12 ++++++++++++
>>  .../62-usb_driver_lpm/drivers_net_usb_sierra_net.patch     | 12 ++++++++++++
>>  .../62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch      | 12 ++++++++++++
>>  10 files changed, 101 insertions(+)
>>  create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
>>  create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
>>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
>>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
>>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
>>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
>>  create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
> 
> Please add a defconfig/wwan file which activates these drivers.
> 

Thanks for reviewing. I will implement your comments.

Patrick

-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
