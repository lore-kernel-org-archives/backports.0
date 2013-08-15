Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47865 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717Ab3HOL3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 Aug 2013 07:29:35 -0400
Message-ID: <520CBB96.6050608@hauke-m.de> (sfid-20130815_132937_683604_7E84ABE2)
Date: Thu, 15 Aug 2013 13:29:26 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH v2 4/9] backports: add usb_translate_errors()
References: <cover.1376467862.git.patrick.ziegler@fh-kl.de> <520B3D3B.1000104@fh-kl.de>
In-Reply-To: <520B3D3B.1000104@fh-kl.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/14/2013 10:18 AM, Patrick Ziegler wrote:
> This inline function is missing for version < 2.6.39 but required by em28xx
> and cdc-wdm device driver.
> 
> Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
> ---
>  backport/backport-include/linux/usb.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
> index 368da6c..49a5762 100644
> --- a/backport/backport-include/linux/usb.h
> +++ b/backport/backport-include/linux/usb.h
> @@ -145,4 +145,21 @@ extern void usb_unpoison_urb(struct urb *urb);
>  extern int usb_anchor_empty(struct usb_anchor *anchor);
>  #endif /* 2.6.23-2.6.27 */
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
> +#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)

This check for CONFIG_USB is not needed, remove it.

> +static inline int usb_translate_errors(int error_code)
> +{
> +	switch (error_code) {
> +	case 0:
> +	case -ENOMEM:
> +	case -ENODEV:
> +	case -EOPNOTSUPP:
> +		return error_code;
> +	default:
> +		return -EIO;
> +	}
> +}
> +#endif /* CONFIG_USB */
> +#endif /* < 2.6.39 */
> +
>  #endif /* __BACKPORT_USB_H */
> 

