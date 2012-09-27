MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1348716514-8151-1-git-send-email-xiong@qca.qualcomm.com>
References: <1348716514-8151-1-git-send-email-xiong@qca.qualcomm.com>
Date: Thu, 27 Sep 2012 10:57:17 -0700
Message-ID: <CAB=NE6Ufi40QeKRBQZrT2Oi=2PfDW_dszcceBzsqdZs9NT3THQ@mail.gmail.com>
Subject: Re: [PATCH] net: add new QCA alx ethernet driver
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: xiong@qca.qualcomm.com
Cc: mcgrof@kernel.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Sep 26, 2012 at 8:28 PM,  <xiong@qca.qualcomm.com> wrote:
> This driver support AR813x/AR815x/AR816x/AR817x ethernet chipsets.
>
> Qualcomm Atheros(QCA) is committing to fix all bugs found on this
> driver.
> This driver is also permissively licensed thereby enabling developers of
> ohter OSes to cherry pick this driver to port to their OS.
>
> The version for upstream is also revising. after it's accepted by the
> community, the user can use it for AR816x/AR817x.
>
> This driver and patch also have addressed all sparse and checkpatch
> warnings.
>
> Signed-off-by: Cloud Ren <cjren@qca.qualcomm.com>
> Tested-by: David Liu <dwliu@qca.qualcomm.com>
> Signed-off-by: xiong <xiong@qca.qualcomm.com>
> Signed-off-by: Luis R. Rodriguez <rodrigue@qca.qualcomm.com>
> ---
>  drivers/net/ethernet/atheros/Kconfig           |   21 +
>  drivers/net/ethernet/atheros/Makefile          |    1 +
>  drivers/net/ethernet/atheros/alx/Makefile      |    7 +

The way you are sending me this patch is treating compat-drivers as if
it were an upstream tree. You should rename the subject of your commit
log, search for other crap commit logs. You then also need to send me
this driver as a patch file. You want to replace the existing set of
alx patches under crap/.

  Luis
