MIME-Version: 1.0
In-Reply-To: <1345290414-20674-1-git-send-email-hauke@hauke-m.de>
References: <1345290414-20674-1-git-send-email-hauke@hauke-m.de>
Date: Mon, 20 Aug 2012 10:43:40 +0500
Message-ID: <CAB=NE6Xw0OKw=tw39xfqUO2uqO1x5zQXuvMoJyF6m0um-gMUUA@mail.gmail.com>
Subject: Re: [PATCH] compat: add tty_port_register_device
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Sat, Aug 18, 2012 at 3:46 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> tty_register_device was replaced by tty_port_register_device in this
> commit:
> commit 734cc1783816ae358cef45673a29bf7af974e147
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Tue Aug 7 21:47:47 2012 +0200
>
>     TTY: use tty_port_register_device
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied and pushed, thanks!

  Luis
