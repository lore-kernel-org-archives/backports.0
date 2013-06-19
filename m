Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:61464 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934979Ab3FSV74 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 19 Jun 2013 17:59:56 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so5205841lbd.18
        for <backports@vger.kernel.org>; Wed, 19 Jun 2013 14:59:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJqaZwyOqP+2x7tfzd5Q=Ugt4c3Zn-JU_pjOH-6ypqpWdS--hg@mail.gmail.com>
References: <CAJqaZwyOqP+2x7tfzd5Q=Ugt4c3Zn-JU_pjOH-6ypqpWdS--hg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 19 Jun 2013 14:59:34 -0700
Message-ID: <CAB=NE6X17uSMo7B_Gf9uTBn4be45HBupvqwXfZHfiOrVxicF=A@mail.gmail.com> (sfid-20130619_235958_393252_1698FB80)
Subject: Re: [PATCH v2] backports: re-introduce make uninstall
To: ASIC Felix <ic.felix@gmail.com>
Cc: do-not <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Jun 16, 2013 at 4:52 PM, ASIC Felix <ic.felix@gmail.com> wrote:
> diff --git a/backport/scripts/uninstall.sh b/backport/scripts/uninstall.sh
> new file mode 100755
> index 0000000..2dcf4da
> --- /dev/null
> +++ b/backport/scripts/uninstall.sh
> @@ -0,0 +1,17 @@
> +#!/bin/bash
> +
> +set -e
> +
> +source ./scripts/mod_helpers.sh
> +
> +if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
> +       compr=".gz"
> +else
> +       compr=""
> +fi
> +
> +for driver in $(find -type f -name *.ko); do

Looks good except for the path here, as it is this would search from
the current path, no?

> +       mod_name=$KLIB"updates/"$driver$compr

and to make things clearer, can you do ${driver}${compr}

> +       echo UNINSTALLING $mod_name

No need for caps please.

  Luis
