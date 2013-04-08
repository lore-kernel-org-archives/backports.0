Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:39020 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935573Ab3DHTbH (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:31:07 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so5746033lab.19
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 12:31:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365416773-12836-7-git-send-email-thierry.escande@linux.intel.com>
References: <1365416773-12836-7-git-send-email-thierry.escande@linux.intel.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 12:30:46 -0700
Message-ID: <CAB=NE6X5D-yvoxJUqLTK74ngj2nLuxOmmK-QSKgbbA1se3pxLQ@mail.gmail.com> (sfid-20130408_213129_281505_E94458CA)
Subject: Re: [PATCH v3 6/8] backports: add NFC patches
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
<thierry.escande@linux.intel.com> wrote:
> These are NFC patches refreshed on next-20130404
>
> Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> ---
>  .../nfc/01-netlink-portid/INFO                     |   42 +++++
>  .../nfc/01-netlink-portid/net_nfc_netlink.patch    |   71 ++++++++
>  patches/collateral-evolutions/nfc/02-pr_fmt/INFO   |    6 +
>  .../nfc/02-pr_fmt/net_nfc.patch                    |  181 ++++++++++++++++++++
>  .../nfc/03-driver-core-constify-data/INFO          |    7 +
>  .../net_nfc_core.patch                             |   14 ++
>  6 files changed, 321 insertions(+)
>  create mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/INFO
>  create mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
>  create mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/INFO
>  create mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
>  create mode 100644 patches/collateral-evolutions/nfc/03-driver-core-constify-data/INFO
>  create mode 100644 patches/collateral-evolutions/nfc/03-driver-core-constify-data/net_nfc_core.patch
>
> diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/INFO b/patches/collateral-evolutions/nfc/01-netlink-portid/INFO
> new file mode 100644
> index 0000000..e49ac3b
> --- /dev/null
> +++ b/patches/collateral-evolutions/nfc/01-netlink-portid/INFO
> @@ -0,0 +1,42 @@
> +The patch:
> +
> +commit 15e473046cb6e5d18a4d0057e61d76315230382b
> +Author: Eric W. Biederman <ebiederm@xmission.com>
> +Date:   Fri Sep 7 20:12:54 2012 +0000
> +
> +    netlink: Rename pid to portid to avoid confusion
> +
> +    It is a frequent mistake to confuse the netlink port identifier with a
> +    process identifier.  Try to reduce this confusion by renaming fields
> +    that hold port identifiers portid instead of pid.
> +
> +    I have carefully avoided changing the structures exported to
> +    userspace to avoid changing the userspace API.
> +
> +    I have successfully built an allyesconfig kernel with this change.
> +
> +    Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> +    Acked-by: Stephen Hemminger <shemminger@vyatta.com>
> +    Signed-off-by: David S. Miller <davem@davemloft.net>
> +
> +Changed the struct members:
> +
> +struct netlink_notify->pid    to
> +struct netlink_notify->portid
> +
> +struct genl_info->snd_pid     to
> +struct genl_info->snd_portid
> +
> +To help backport this and not have to #ifdef around it against
> +kernel versions compat has introduced two helpers for us to
> +simply do the backport with two macro helpers:
> +
> +genl_info_snd_portid()
> +netlink_notify_portid()
> +
> +This takes care of the work for us requiring only one
> +single line change. If we get another patch thrown into
> +this file then I suspect we can extract SMPL out of it
> +and use it to backport further collateral evolutions like
> +this one should other drivers / subsystem need this change.

Here's one example where using SmPL would make sense given we now have
two subsystems using these changes. I'm fine with this going in as-is
though.

  Luis
