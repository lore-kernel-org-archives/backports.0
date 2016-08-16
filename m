Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33963 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbcHPTNR (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 16 Aug 2016 15:13:17 -0400
Received: by mail-pf0-f180.google.com with SMTP id p64so30358367pfb.1
        for <backports@vger.kernel.org>; Tue, 16 Aug 2016 12:12:52 -0700 (PDT)
Subject: Re: [PATCH] backports: genetlink: define GENL_UNS_ADMIN_PERM as
 GENL_ADMIN_PERM
To: Luca Coelho <luca@coelho.fi>, hauke@hauke-m.de
References: <1471339244-12868-1-git-send-email-luca@coelho.fi>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d6080ced-2956-5b96-9d03-31be637ac47b@broadcom.com> (sfid-20160816_211348_273096_75F80E01)
Date: Tue, 16 Aug 2016 21:12:47 +0200
MIME-Version: 1.0
In-Reply-To: <1471339244-12868-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 16-8-2016 11:20, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> Older kernels don't have support for GENL_UNS_ADMIN_PERM.  So, if it
> is not defined, use the previous GENL_ADMIN_PERM permission instead.

I posted a patch for this May 17.

> Change-Id: I4c845de0d5b326aff8400df22a23595ef9cd12aa

and this is gerrit noise :-)

Gr. AvS

ps: Gr. are Greetings. Not Growling here.

> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  backport/backport-include/uapi/linux/genetlink.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 backport/backport-include/uapi/linux/genetlink.h
> 
> diff --git a/backport/backport-include/uapi/linux/genetlink.h b/backport/backport-include/uapi/linux/genetlink.h
> new file mode 100644
> index 0000000..5292892
> --- /dev/null
> +++ b/backport/backport-include/uapi/linux/genetlink.h
> @@ -0,0 +1,9 @@
> +#ifndef __BACKPORT_UAPI_LINUX_GENETLINK_H
> +#define __BACKPORT_UAPI_LINUX_GENETLINK_H
> +#include_next <uapi/linux/genetlink.h>
> +
> +#ifndef GENL_UNS_ADMIN_PERM
> +#define GENL_UNS_ADMIN_PERM GENL_ADMIN_PERM
> +#endif
> +
> +#endif /* __BACKPORT_UAPI_LINUX_GENETLINK_H */
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
