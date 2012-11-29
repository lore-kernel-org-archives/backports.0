Return-Path: <julia.lawall@lip6.fr>
Date: Thu, 29 Nov 2012 22:36:42 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Subject: Re: [PATCH 3/6] compat-drivers: build RTL8723AE
In-Reply-To: <CAB=NE6Vpqo4D6ieSHpekGkAp1=R+keLA+8x2nrwi7HrycLdUgA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1211292235550.1999@localhost6.localdomain6>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de> <1354144069-28611-4-git-send-email-hauke@hauke-m.de> <CAB=NE6Vpqo4D6ieSHpekGkAp1=R+keLA+8x2nrwi7HrycLdUgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <backports@vger.kernel.org>

>> +-static const struct dev_pm_ops rtlwifi_pm_ops = {
>> +-      .suspend = rtl_pci_suspend,
>> +-      .resume = rtl_pci_resume,
>> +-      .freeze = rtl_pci_suspend,
>> +-      .thaw = rtl_pci_resume,
>> +-      .poweroff = rtl_pci_suspend,
>> +-      .restore = rtl_pci_resume,
>> +-};

So it often happens that eg all of suspend, freeze, and poweroff have the 
same value?

julia
