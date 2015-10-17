Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:19806 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbJQUqm (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Oct 2015 16:46:42 -0400
Message-ID: <5622B3B0.6090203@broadcom.com> (sfid-20151017_224644_232319_F088DE31)
Date: Sat, 17 Oct 2015 22:46:40 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH] backports: provide backport for ktime_get_seconds()
References: <1444980843-16302-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1444980843-16302-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/16/2015 09:34 AM, Arend van Spriel wrote:
> Since commit 84b00607aeb8 ("mac80211: use ktime_get_seconds")
> mac80211 uses ktime_get_seconds(). This patch provide a backport
> using ktime_get_ts() for it.

That commit probably is for 4.4 kernel so guess it needs to be in a 
newly created backport-4.4.c, right?

Regards,
Arend

> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>   backport/backport-include/linux/ktime.h |  8 ++++++++
>   backport/compat/backport-4.3.c          | 10 ++++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
> index 6fbc6c6..2edacf9 100644
> --- a/backport/backport-include/linux/ktime.h
> +++ b/backport/backport-include/linux/ktime.h
> @@ -9,6 +9,14 @@ extern ktime_t ktime_get_raw(void);
>
>   #endif /* < 3.17 */
>
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
> +typedef __s64 time64_t;
> +#endif
> +#define ktime_get_seconds LINUX_BACKPORT(ktime_get_seconds)
> +extern time64_t ktime_get_seconds(void);
> +#endif /* < 3.19 */
> +
>   #ifndef ktime_to_timespec64
>   /* Map the ktime_t to timespec conversion to ns_to_timespec function */
>   #define ktime_to_timespec64(kt)		ns_to_timespec64((kt).tv64)
> diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
> index d15c92c..2797944 100644
> --- a/backport/compat/backport-4.3.c
> +++ b/backport/compat/backport-4.3.c
> @@ -11,6 +11,7 @@
>   #include <linux/seq_file.h>
>   #include <linux/export.h>
>   #include <linux/printk.h>
> +#include <linux/ktime.h>
>
>   static void seq_set_overflow(struct seq_file *m)
>   {
> @@ -57,3 +58,12 @@ void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
>   	}
>   }
>   EXPORT_SYMBOL_GPL(seq_hex_dump);
> +
> +time64_t ktime_get_seconds(void)
> +{
> +	struct timespec ts;
> +
> +	ktime_get_ts(&ts);
> +	return ts.tv_sec;
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_seconds);
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
