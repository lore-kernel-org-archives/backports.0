Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:32841 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758909Ab3FMTiY (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Jun 2013 15:38:24 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so7794640lab.26
        for <backports@vger.kernel.org>; Thu, 13 Jun 2013 12:38:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJqaZwyhCxQRqEQ8wKjD96u0avs3Qjjda2u_oxTb3y-Vj7ie8g@mail.gmail.com>
References: <CAJqaZwyhCxQRqEQ8wKjD96u0avs3Qjjda2u_oxTb3y-Vj7ie8g@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 13 Jun 2013 12:38:00 -0700
Message-ID: <CAB=NE6V0so0NDQs1z2SCes9G6_jg0gKtM3Yjq6yyjzQ8gdRVOg@mail.gmail.com> (sfid-20130613_213832_665336_0C0D35B5)
Subject: Re: [PATCH] backports: re-introduce make uninstall
To: ASIC Felix <ic.felix@gmail.com>
Cc: do-not <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thanks! Some comments below

On Sat, Jun 8, 2013 at 5:17 PM, ASIC Felix <ic.felix@gmail.com> wrote:
> Re-introducing make uninstall. It works, but feel more than welcome to
> tidy it up.

Try to avoid development / iteration series comments on the commit
log, instead those could be put right below after the first three
dashes.

> Signed-off-by: Felix Bitterli <ic.felix@gmail.com>
> ---

Like here.

>  backport/Makefile.real        |   10 ++++++++++
>  backport/scripts/uninstall.sh |   26 ++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100755 backport/scripts/uninstall.sh
>
> diff --git a/backport/Makefile.real b/backport/Makefile.real
> index 2a1f640..40d91bd 100644
> --- a/backport/Makefile.real
> +++ b/backport/Makefile.real
> @@ -101,6 +101,16 @@ install: modules
>  .PHONY: modules_install
>  modules_install: install
>
> +.PHONY: uninstall
> +uninstall:
> +    @./scripts/uninstall.sh
> +    @/sbin/depmod -a
> +    @./scripts/update-initramfs.sh $(KLIB)
> +    @echo
> +    @echo Your backported driver modules should be uninstalled now.
> +    @echo Reboot.
> +    @echo
> +
>  .PHONY: clean
>  clean:
>      @$(MAKE) -f Makefile.build clean
> diff --git a/backport/scripts/uninstall.sh b/backport/scripts/uninstall.sh
> new file mode 100755
> index 0000000..4deb7c1
> --- /dev/null
> +++ b/backport/scripts/uninstall.sh
> @@ -0,0 +1,26 @@
> +#!/bin/bash
> +
> +set -e
> +
> +function mod_filename()
> +{
> +    which modinfo > /dev/null 2>&1
> +    if [[ $? -eq 0 ]]; then
> +        MOD_QUERY="modinfo -F filename"
> +    else
> +        MOD_QUERY="modprobe -l"
> +    fi
> +    mod_path="$($MOD_QUERY $1 | tail -1)"
> +    echo $(basename "$mod_path")
> +}

This is used twice now in two scripts as such perhaps best to stuff
this as a helper in a new file of script helpers,
scripts/mod_helpers.sh and then both this file and
scripts/compress_modules.sh would just:

source ./mod_helpers.sh

> +if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
> +    compr=".ko"

I think what was meant is compr=".gz"

> +else
> +    compr=""
> +fi
> +
> +for driver in $(find -type f -name *.ko); do

and here perhaps you forgot to apply the extension, and perhaps best
to just peg the path in the find from the start, otherwise we end up
removing other kernel's updates as well:

for driver in $(find $KLIB/$KMODDIR -type f -name *.ko${compress} ); do

so then no need for the next mod_name line:

> +    mod_name=$KLIB"updates/"$driver$compr

and instead of:

> +    rm -f $mod_name

rm -f $driver

  Luis
