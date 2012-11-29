MIME-Version: 1.0
In-Reply-To: <50B7D7C9.9020804@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
	<1354144069-28611-4-git-send-email-hauke@hauke-m.de>
	<CAB=NE6Vpqo4D6ieSHpekGkAp1=R+keLA+8x2nrwi7HrycLdUgA@mail.gmail.com>
	<alpine.DEB.2.02.1211292235550.1999@localhost6.localdomain6>
	<50B7D7C9.9020804@hauke-m.de>
Date: Thu, 29 Nov 2012 13:53:51 -0800
Message-ID: <CAB=NE6WeqFX1Eh0WmbD2Q_MWwDCUbC7gBftc=h5mNHp1Li=aQA@mail.gmail.com>
Subject: Re: [PATCH 3/6] compat-drivers: build RTL8723AE
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Nov 29, 2012 at 1:46 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 11/29/2012 10:36 PM, Julia Lawall wrote:
>>>> +-static const struct dev_pm_ops rtlwifi_pm_ops = {
>>>> +-      .suspend = rtl_pci_suspend,
>>>> +-      .resume = rtl_pci_resume,
>>>> +-      .freeze = rtl_pci_suspend,
>>>> +-      .thaw = rtl_pci_resume,
>>>> +-      .poweroff = rtl_pci_suspend,
>>>> +-      .restore = rtl_pci_resume,
>>>> +-};
>>
>> So it often happens that eg all of suspend, freeze, and poweroff have
>> the same value?
>>
>> julia
>
> I will send a patch to replace them with SIMPLE_DEV_PM_OPS() upstream
> for the wireless drivers, so this part of the patch will not be needed
> any more in the future.

Well that solves that :) look at that a new 802.11 driver magically
would be backported across releases with 0 changes required.

  Luis
