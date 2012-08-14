MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1344970347-12440-1-git-send-email-gospo@redhat.com>
References: <1344970347-12440-1-git-send-email-gospo@redhat.com>
Date: Tue, 14 Aug 2012 16:04:05 -0700
Message-ID: <CAB=NE6UhXApCK62ebAj=uGzT+vPU4o8CW+6QnNpVPJtumbi0+w@mail.gmail.com>
Subject: Re: [PATCH] compat: only compile optional sdio code on 2.6.37 and later
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Andy Gospodarek <gospo@redhat.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Aug 14, 2012 at 11:52 AM, Andy Gospodarek <gospo@redhat.com> wrote:
> The pm_runtime routines in wlcore/sdio.c are not included in compat and
> the best alternative is to build them only on kernels 2.6.37 and later.
>
> Signed-off-by: Andy Gospodarek <andy@greyhouse.net>

Applied and pushed, thanks! I also propagated it to the linux-3.5.y branch.

  Luis
