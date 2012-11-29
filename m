MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1354107152-28563-1-git-send-email-bkamatch@qca.qualcomm.com>
References: <1354107152-28563-1-git-send-email-bkamatch@qca.qualcomm.com>
Date: Wed, 28 Nov 2012 21:10:39 -0800
Message-ID: <CAB=NE6VPC0nzZT5jo3HN7ZRX6oWSroLSt74vcSxkG7L-wGNHRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] compat-drivers: Add a crap patch for AR9565
From: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To: Bala Shanmugam <bkamatch@qca.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Nov 28, 2012 at 4:52 AM, Bala Shanmugam
<bkamatch@qca.qualcomm.com> wrote:
> This patch is required to improve BT throughput to
> meet customer requirement.  This patch is a workaround
> to put WLAN to sleep during BT cycle and cannot be
> upstreamed.
>
> Signed-off-by: Bala Shanmugam <bkamatch@qca.qualcomm.com>

Thanks applied and pushed all, and new releases made:

http://wireless.kernel.org/en/users/Download/stable#compat-wireless_3.6_stable_releases

  Luis
