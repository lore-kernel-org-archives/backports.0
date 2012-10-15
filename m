MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1350307338-8133-1-git-send-email-bkamatch@qca.qualcomm.com>
References: <1350307338-8133-1-git-send-email-bkamatch@qca.qualcomm.com>
Date: Mon, 15 Oct 2012 14:28:09 -0700
Message-ID: <CAB=NE6UpXjb9mp0ttJs08bKXmAJdS=Ndf=m9NNO75xEcFfTnMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Patches for compat-drivers/linux-3.6.y
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Bala Shanmugam <bkamatch@qca.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, backports@vger.kernel.org,
	Senthil Balasubramanian <senthilb@qca.qualcomm.com>, Sujith Manoharan <c_manoha@qca.qualcomm.com>,
	Rajkumar Manoharan <rmanohar@qca.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Mon, Oct 15, 2012 at 6:22 AM, Bala Shanmugam
<bkamatch@qca.qualcomm.com> wrote:
> Hi,
>
> These patches are for linux-3.6.y branch and has BT coex
> fixes for AR9565.
>
> Bala Shanmugam (3):
>   compat-drivers: Update pending stable patches.
>   compat-drivers: Move next-pending patches to cherry-picks.
>   compat-drivers: Add new cherry-pick and next-pending  patches

Thanks, I've applied this, made a few changes to adapt to v3.6.2 and
have made 5 tarballs for this release:

http://wireless.kernel.org/en/users/Download/stable#compat-wireless_3.6_stable_releases

http://www.orbit-lab.org/kernel/compat-wireless-3-stable/v3.6/compat-wireless-3.6.2-1-snpc.tar.bz2
http://www.orbit-lab.org/kernel/compat-wireless-3-stable/v3.6/compat-wireless-3.6.2-1-snp.tar.bz2
http://www.orbit-lab.org/kernel/compat-wireless-3-stable/v3.6/compat-wireless-3.6.2-1-sn.tar.bz2
http://www.orbit-lab.org/kernel/compat-wireless-3-stable/v3.6/compat-wireless-3.6.2-1-s.tar.bz2
http://www.orbit-lab.org/kernel/compat-wireless-3-stable/v3.6/compat-wireless-3.6.2-1.tar.bz2

  Luis
