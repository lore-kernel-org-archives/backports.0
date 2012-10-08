MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1349725862-32284-1-git-send-email-kyle.manna@fuel7.com>
References: <1349725862-32284-1-git-send-email-kyle.manna@fuel7.com>
Date: Mon, 8 Oct 2012 14:48:56 -0700
Message-ID: <CAB=NE6UotKT6293T+63kfEeHoHMUrnmAg2xZoSiJ+bfTWLGjpA@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Fix typo for CONFIG_BT_HCIUART
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Kyle Manna <kyle.manna@fuel7.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Mon, Oct 8, 2012 at 12:51 PM, Kyle Manna <kyle.manna@fuel7.com> wrote:
> The config value should be set to a lowercase 'm' or the config is
> ignored and the associated module doesn't build.  Fix this.
>
> Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>

Thanks, I'ave applied this and pushed this down the linux-3.x.y
branches as well as they were also affected by this.

  Luis
