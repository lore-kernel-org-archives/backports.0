Return-Path: <hauke@hauke-m.de>
Message-ID: <50B7D7C9.9020804@hauke-m.de>
Date: Thu, 29 Nov 2012 22:46:49 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>
CC: "Luis R. Rodriguez" <mcgrof@gmail.com>, backports@vger.kernel.org
Subject: Re: [PATCH 3/6] compat-drivers: build RTL8723AE
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de> <1354144069-28611-4-git-send-email-hauke@hauke-m.de> <CAB=NE6Vpqo4D6ieSHpekGkAp1=R+keLA+8x2nrwi7HrycLdUgA@mail.gmail.com> <alpine.DEB.2.02.1211292235550.1999@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1211292235550.1999@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

On 11/29/2012 10:36 PM, Julia Lawall wrote:
>>> +-static const struct dev_pm_ops rtlwifi_pm_ops = {
>>> +-      .suspend = rtl_pci_suspend,
>>> +-      .resume = rtl_pci_resume,
>>> +-      .freeze = rtl_pci_suspend,
>>> +-      .thaw = rtl_pci_resume,
>>> +-      .poweroff = rtl_pci_suspend,
>>> +-      .restore = rtl_pci_resume,
>>> +-};
> 
> So it often happens that eg all of suspend, freeze, and poweroff have
> the same value?
> 
> julia

I will send a patch to replace them with SIMPLE_DEV_PM_OPS() upstream
for the wireless drivers, so this part of the patch will not be needed
any more in the future.

Hauke
