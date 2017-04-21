Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36728 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423853AbdDUSuy (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Apr 2017 14:50:54 -0400
Received: by mail-wr0-f171.google.com with SMTP id c55so59845238wrc.3
        for <backports@vger.kernel.org>; Fri, 21 Apr 2017 11:50:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] backports: add the necessary backports for netlink
 extack
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <20170421104722.21538-1-johannes@sipsolutions.net>
 <20170421104722.21538-2-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d79056c4-ff9d-0e16-ed84-03fae4cdee83@broadcom.com> (sfid-20170421_205109_944586_78043FD9)
Date: Fri, 21 Apr 2017 20:50:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170421104722.21538-2-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 21-4-2017 12:47, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>

I did not follow everything about this extack thing, but does it impose
a version requirement on the libnl used in user-space?

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/netlink.h | 17 ++++++++
>  backport/backport-include/net/genetlink.h | 24 +++++++++++
>  backport/backport-include/net/netlink.h   | 69 +++++++++++++++++++++++++++++++
>  patches/0078-genl-extack.cocci            |  5 +++
>  4 files changed, 115 insertions(+)
>  create mode 100644 patches/0078-genl-extack.cocci

[...]

> +/* this is for patches we apply */

Guess the comment is inspired by the one below ;-) but would it not be a
bit more clear to say:

/* this is for files patched using 0078-genl-extack.cocci */

> +static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
> +{
> +#if LINUX_VERSION_IS_GEQ(4,12,0)
> +	return info->extack;
> +#else
> +	return NULL;
> +#endif
> +}
> +
>  /* this is for patches we apply */
>  #if LINUX_VERSION_IS_LESS(3,7,0)
>  #define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
