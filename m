Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:37332 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752758AbcDSTPq (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Apr 2016 15:15:46 -0400
Message-ID: <1461093340.16778.81.camel@coelho.fi> (sfid-20160419_211548_136881_4A59840D)
From: Luca Coelho <luca@coelho.fi>
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Tue, 19 Apr 2016 22:15:40 +0300
In-Reply-To: <1454928135-8154-1-git-send-email-arend@broadcom.com>
References: <1454928135-8154-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: add empty inline for wireless_nlevent_flush()
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Arend,

On Mon, 2016-02-08 at 11:42 +0100, Arend van Spriel wrote:
> The function was added in v4.5 kernel. As it can not be backported
> it is provided for older kernels as an empty inline.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> Not sure whether LINUX_BACKPORT() macro should be used. Let me
> know if that is needed.
> 
> Regards,
> Arend
> ---
>  backport/backport-include/net/iw_handler.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/backport/backport-include/net/iw_handler.h
> b/backport/backport-include/net/iw_handler.h
> index 11135c8..03a4fd1 100644
> --- a/backport/backport-include/net/iw_handler.h
> +++ b/backport/backport-include/net/iw_handler.h
> @@ -25,4 +25,7 @@ iwe_stream_add_point_check(struct iw_request_info
> *info, char *stream,
>  	return res;
>  }
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)

This function was added to stable 4.4.6, so we should change this #if
accordingly.


> +static inline void wireless_nlevent_flush(void) {}
> +#endif
>  #endif /* __BACKPORT_IW_HANDLER_H */

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
