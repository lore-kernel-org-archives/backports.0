Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:46372 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab3HAMzU (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 1 Aug 2013 08:55:20 -0400
Message-ID: <51FA5AB1.3080208@fh-kl.de> (sfid-20130801_145522_971317_1CC40E3D)
Date: Thu, 1 Aug 2013 14:55:13 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [RFC v2 1/8] backports: disable PCI functions for kernels without
 PCI support
References: <cover.1375259597.git.patrick.ziegler@fh-kl.de> <51F8CD2A.2090101@fh-kl.de> <51F92183.2010203@hauke-m.de>
In-Reply-To: <51F92183.2010203@hauke-m.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 31.07.2013 16:38, Hauke Mehrtens wrote:
> Nice work,
> 
> what kernel version(s) without PCI support have you tested this against?

I'm using this with kernel version 2.6.24.7

> 
> There are also PCI(e) functions in backport/compat/compat-3.7.c and
> backport/compat/compat-2.6.27.c

That's true but they do not break the build. The functions which are called
inside these PCI(e) functions have already empty stub functions if PCI
support is not enabled.

> 
> On 07/31/2013 10:39 AM, Patrick Ziegler wrote:
>> Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
>> ---
>>  backport/compat/compat-2.6.25.c | 2 ++
>>  backport/compat/compat-2.6.28.c | 4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/backport/compat/compat-2.6.25.c b/backport/compat/compat-2.6.25.c
>> index b3597ea..37407a4 100644
>> --- a/backport/compat/compat-2.6.25.c
>> +++ b/backport/compat/compat-2.6.25.c
>> @@ -210,6 +210,7 @@ EXPORT_SYMBOL_GPL(sg_alloc_table);
>>   * to it. We implement a sloppy work around for backporting
>>   * this.
>>   */
>> +#ifdef CONFIG_PCI
>>  int pci_enable_device_mem(struct pci_dev *dev)
>>  {
>>  	int bars = pci_select_bars(dev, IORESOURCE_MEM);
>> @@ -217,6 +218,7 @@ int pci_enable_device_mem(struct pci_dev *dev)
>>  	return pci_enable_device_bars(dev, bars);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_enable_device_mem);
>> +#endif
>>  
>>  /**
>>   * The following things are out of ./lib/vsprintf.c
>> diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
>> index e47626b..9c21de8 100644
>> --- a/backport/compat/compat-2.6.28.c
>> +++ b/backport/compat/compat-2.6.28.c
>> @@ -238,6 +238,7 @@ EXPORT_SYMBOL_GPL(usb_anchor_empty);
>>  #endif /* CONFIG_USB */
>>  #endif
>>  
>> +#ifdef CONFIG_PCI
>>  void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
>>  {
>>  	/*
>> @@ -251,6 +252,7 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
>>  				     pci_resource_len(pdev, bar));
>>  }
>>  EXPORT_SYMBOL_GPL(pci_ioremap_bar);
>> +#endif
>>  
>>  static unsigned long round_jiffies_common(unsigned long j, int cpu,
>>  		bool force_up)
>> @@ -455,6 +457,7 @@ EXPORT_SYMBOL_GPL(n_tty_ioctl_helper);
>>   * generating PME# from both D3_hot and D3_cold, and the platform is unable to
>>   * enable wake-up power for it.
>>   */
>> +#ifdef CONFIG_PCI
>>  int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>>  {
>>  	return pci_pme_capable(dev, PCI_D3cold) ?
>> @@ -462,4 +465,5 @@ int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>>  			pci_enable_wake(dev, PCI_D3hot, enable);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_wake_from_d3);
>> +#endif
> 
> The mainline Linux kernel uses a empty pci_wake_from_d3() function if
> CONFIG_PCI is not set in include/linux/pci.h
> 

Indeed, I've just realized that an include of pci.h in compat-2.6.28.c is 
enough to make it work with kernel version 2.6.24. I will resend the patch with this change.

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
