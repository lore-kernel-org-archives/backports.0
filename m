MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAB=NE6Ww8SVm51qph=iXNGS8BN1cWdsT-bvKWrDt4b9c7ea9sg@mail.gmail.com>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
	<1354144069-28611-7-git-send-email-hauke@hauke-m.de>
	<CAB=NE6Ww8SVm51qph=iXNGS8BN1cWdsT-bvKWrDt4b9c7ea9sg@mail.gmail.com>
Date: Thu, 29 Nov 2012 12:51:37 -0800
Message-ID: <CAB=NE6XiuZCzWXROi35no0nnU4F7-=d_FwX90xEKgSgFGVbfYg@mail.gmail.com>
Subject: Re: [PATCH 6/6] compat-drivers: do not use struct spinlock
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arend Van Spriel <arend@broadcom.com>, linux-wireless <linux-wireless@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>,
	Kyungmin Park <kyungmin.park@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alexander Stein <alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Nov 29, 2012 at 11:47 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Wed, Nov 28, 2012 at 3:07 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
> IMHO your patch should go upstream and a respective patch should be
> submitted as well as for these drivers:
>
> mcgrof@frijol ~/linux-next (git::master)$ git grep "struct spinlock" drivers/
> drivers/crypto/ux500/cryp/cryp.h:       struct spinlock ctx_lock;
> drivers/crypto/ux500/cryp/cryp.h:       struct spinlock power_state_spinlock;
> drivers/crypto/ux500/hash/hash_alg.h:   struct spinlock         ctx_lock;
> drivers/crypto/ux500/hash/hash_alg.h:   struct spinlock
> power_state_lock;
> drivers/gpu/drm/i915/i915_drv.h:        struct spinlock gt_lock;
> drivers/gpu/drm/i915/i915_drv.h:                struct spinlock lock;
> drivers/media/platform/s5p-fimc/mipi-csis.c:    struct spinlock slock;
> drivers/media/platform/s5p-jpeg/jpeg-core.h:    struct spinlock         slock;
> drivers/watchdog/ie6xx_wdt.c:   struct spinlock unlock_sequence;
>
> Alexander, please also add your driver to the MAINTAINERS file.

Hauke, I'll add your patch for now into compat-drivers until shit
catches up on linux-next if the series I just posted goes through.

  Luis
