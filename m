Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36474 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcEOJvE (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 15 May 2016 05:51:04 -0400
Received: by mail-pf0-f170.google.com with SMTP id c189so59253388pfb.3
        for <backports@vger.kernel.org>; Sun, 15 May 2016 02:51:03 -0700 (PDT)
Subject: Re: wireless_nlevent_flush backported to stable kernels
To: Emmanuel Grumbach <egrumbach@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
References: <CANUX_P1i8MYwsbcnvjbqrHZ77aMOZHZ6ug3VzHvn=3pUU_czyw@mail.gmail.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5738467E.4020005@broadcom.com> (sfid-20160515_115109_089094_3A0AC8CB)
Date: Sun, 15 May 2016 11:50:54 +0200
MIME-Version: 1.0
In-Reply-To: <CANUX_P1i8MYwsbcnvjbqrHZ77aMOZHZ6ug3VzHvn=3pUU_czyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 15-5-2016 8:25, Emmanuel Grumbach wrote:
> Hi,
> 
> Johanne's patch:
> 
> commit cb150b9d23be6ee7f3a0fff29784f1c5b5ac514d
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Jan 27 13:29:34 2016 +0100
> 
>     cfg80211/wext: fix message ordering
> 
> 
> has been backported to more stable kernels and hence backport needs to
> take that into account.
> I am using Ubuntu's wily kernel (4.2 based) and apparently, they
> backported Johanne's fix as well.
> 
> On my system, I fixed it with the patch below, but it is surely not good enough.

In general this is avoided by preceeding the stub function with:

#define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)

This way you will use the stub and not the in-kernel function. There has
been discussions about adding a mechanism to avoid backport if kernel
has the function available. No actual work in that area has been done yet.

Regards,
Arend

> diff --git a/backport-include/net/iw_handler.h
> b/backport-include/net/iw_handler.h
> index e205d1e..b9c0144 100644
> --- a/backport-include/net/iw_handler.h
> +++ b/backport-include/net/iw_handler.h
> @@ -25,7 +25,8 @@ iwe_stream_add_point_check(struct iw_request_info
> *info, char *stream,
>         return res;
>  }
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,6)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,6) &&      \
> +    LINUX_VERSION_CODE < KERNEL_VERSION(4,1,21)
>  static inline void wireless_nlevent_flush(void) {}
>  #endif
>  #endif /* __BACKPORT_IW_HANDLER_H */
> 
> 
> Emmanuel Grumbach
> egrumbach@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
