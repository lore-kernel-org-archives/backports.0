MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1348824541-12396-1-git-send-email-xiong@qca.qualcomm.com>
References: <1348824541-12396-1-git-send-email-xiong@qca.qualcomm.com>
Date: Tue, 2 Oct 2012 17:47:20 -0700
Message-ID: <CAB=NE6UsbbXdhQh9hqRxByAVqtskpE4xW0Kz9ascip_8-K56ag@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: update ethernet driver alx in crap dir
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: xiong@qca.qualcomm.com
Cc: mcgrof@kernel.org, backports@vger.kernel.org, nic-devel@qualcomm.com,
	Ren Cloud <cjren@qca.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Sep 28, 2012 at 2:29 AM,  <xiong@qca.qualcomm.com> wrote:
> From: xiong <xiong@qca.qualcomm.com>
>
> 1. support new device id 0x10A0/0x10A1
> 2. add DEBUG_FS interface for diag/swoi interface
>
> Signed-off-by: Ren Cloud <cjren@qca.qualcomm.com>
> Signed-off-by: xiong <xiong@qca.qualcomm.com>
> ---
>  ...-QCA-ethernet-driver-which-supercedes-atl.patch |13498 --------------------
>  crap/network/0002-backport-alx.patch               |   40 +-
>  2 files changed, 19 insertions(+), 13519 deletions(-)
>  delete mode 100644 crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch

Xiong,

You are deleting the file
crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
here and then you are updating the
crap/network/0002-backport-alx.patch file. What you likely wanted to
do was to remove the original
crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
file and then git add a new crap/network/0001-something.patch which
you likely forgot to do.

Can you resend? Also if you'd like this applied to a stable branch
please send a separate patch for that once you first send a patch that
does apply onto the master branch.

  Luis
