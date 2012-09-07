MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1347004574-80506-1-git-send-email-nbd@openwrt.org>
References: <1347004574-80506-1-git-send-email-nbd@openwrt.org>
Date: Fri, 7 Sep 2012 02:04:37 -0700
Message-ID: <CAB=NE6V6vAdsVQyjKyaMYnPRQdJLc+Gt=nqiS5cN9mWU3vz7aQ@mail.gmail.com>
Subject: Re: [PATCH] compat: drop const to fix compiler warnings
From: "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
To: Felix Fietkau <nbd@openwrt.org>
Cc: linux-wireless@vger.kernel.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Sep 7, 2012 at 12:56 AM, Felix Fietkau <nbd@openwrt.org> wrote:
> When calling pci_find_capability and pci_read_config_word, struct pci_dev
> needs to be passed without const.

Thanks! I guess because at certain kernel version pci_dev was const ?

  Luis
