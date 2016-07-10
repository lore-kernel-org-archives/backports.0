Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56188 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757215AbcGJVQi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:16:38 -0400
Subject: Re: [PATCH 1/2] backports: add definition for USB_SPEED_SUPER_PLUS
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5c4fbb51-7c91-fab5-a9b4-cc39304aff6f@hauke-m.de> (sfid-20160710_231640_914653_F683E8FB)
Date: Sun, 10 Jul 2016 23:16:36 +0200
MIME-Version: 1.0
In-Reply-To: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/05/2016 11:30 AM, Arend van Spriel wrote:
> Speed definition for usb3.1 has been added in 4.6 kernel. Add
> definiton for older kernels.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  backport/backport-include/linux/usb/ch9.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
> index 135e24c..c42fc30 100644
> --- a/backport/backport-include/linux/usb/ch9.h
> +++ b/backport/backport-include/linux/usb/ch9.h
> @@ -21,4 +21,8 @@ static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
>  }
>  #endif /* < 3.2 */
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
> +#define USB_SPEED_SUPER_PLUS	(USB_SPEED_SUPER + 1)
> +#endif /* < 4.6 */
> +
>  #endif /* __BACKPORT__LINUX_USB_CH9_H */
> 

This is in a emum in the mainline kernel. I think this will cause some
warnings when backporting it this way.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
