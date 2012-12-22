Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
References: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
Date: Sat, 22 Dec 2012 13:05:40 +0200
Message-ID: <CAFub=KQxO5gqkHAp7VCDE-_WMXskJ4Ahup9sgfFZA45MboAQcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] update-initramfs: Update comments, fix some typos
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Sat, Dec 22, 2012 at 1:04 PM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> update-initramfs is crucial for DRM drivers, let's clarify this.
>
> Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
> ---
>  scripts/update-initramfs | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/update-initramfs b/scripts/update-initramfs
> index e388df2..dcc1ee6 100755
> --- a/scripts/update-initramfs
> +++ b/scripts/update-initramfs
> @@ -1,12 +1,10 @@
>  #!/bin/bash
>  # Copyright 2009        Luis R. Rodriguez <mcgrof@gmail.com>
>  #
> -# Since we provide ssb, the Ethernet module b44 some people may
> -# rely on it to netboot, so update the initrafms for each
> -# distribution.
> -#
> -# Note that in the future people may want to wireless-boot
> -# so this will help with that as well.
> +# Since we provide ssb, ethernet modules and most importantly
> +# DRM drivers, people may want top update the initramfs image

grr can you change "top" to "to" while merging this :)
