MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <B0824BA06BBF0C4AA3F9BE696B46CC8C060BEA01@POCITMSEXMB01.LntUniverse.com>
References: <B0824BA06BBF0C4AA3F9BE696B46CC8C060BEA01@POCITMSEXMB01.LntUniverse.com>
Date: Wed, 5 Sep 2012 13:21:53 -0700
Message-ID: <CAB=NE6UnZ9wO-5ngVYSB54jH9N-6MBwAkhbC3G+LSvT7tq7qQg@mail.gmail.com>
Subject: Re: [PATCH] compat-2.6: Supoprt ARM Architecture while back porting
 for linux2.6.28 kernel
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Mridula Prakash <Mridula.Prakash@lnties.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Aug 28, 2012 at 4:38 AM, Mridula Prakash
<Mridula.Prakash@lnties.com> wrote:
> Hi,
>
> This adds support for ARM Architectures while back porting for linux-2.6.28 kernel. The "atomic.h" file is part of the 2.6.28 kernel for ARM Architectures.
>
> Signed-off-by: Mridula Prakash<Mridula.Prakash@lnties.com>
>

Good catch, I've changed the commit log to this though:


commit 169203f10a669d1f4735090380351186b763fbd8
Author: Mridula Prakash <Mridula.Prakash@lnties.com>
Date:   Wed Sep 5 13:17:29 2012 -0700

    compat: fix ARM architecture support for atomic_t and atomic64_t changes

    This ammends the patch below to extend support for ARM.

    commit e079e9b66ea06373a3be82f9bed1702082a69310
    Author: Luis R. Rodriguez <mcgrof@frijolero.org>
    Date:   Tue Feb 7 19:22:02 2012 -0800

        compat: backport making atomic_t and atomic64_t universal

        mcgrof@tux ~/linux-next (git::master)$ \
            git describe --contains ea435467500612636f8f4fb639ff6e76b2496e4b
        v2.6.29-rc1~390

        This commit moved atomic_t and atomic64_t to a generic
        place, but some archs already had it defined. Just include
        that header for the archs that had it.

        Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>

    ARM also had atomic.h before that commit upstream.

    Signed-off-by: Mridula Prakash <Mridula.Prakash@lnties.com>
    Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>

Applied and pushed!

  Luis
