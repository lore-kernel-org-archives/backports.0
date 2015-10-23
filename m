Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:14117 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbbJWJch (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 23 Oct 2015 05:32:37 -0400
Message-ID: <5629FEB3.6050905@broadcom.com> (sfid-20151023_113239_295482_F75BC0A3)
Date: Fri, 23 Oct 2015 11:32:35 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	<backports@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: add ktime_get_seconds()
References: <1445584991-11249-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1445584991-11249-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/23/2015 09:23 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>

Already submitted a patch for this. I just did not bother to introduce 
the timekeeping.h file. So yours may be preferred.

Regards,
Arend

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   backport/backport-include/linux/ktime.h       |  1 +
>   backport/backport-include/linux/timekeeping.h | 21 +++++++++++++++++++++
>   2 files changed, 22 insertions(+)
>   create mode 100644 backport/backport-include/linux/timekeeping.h
>
> diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
> index 6fbc6c6eb26c..33ed31caf01a 100644
> --- a/backport/backport-include/linux/ktime.h
> +++ b/backport/backport-include/linux/ktime.h
> @@ -1,6 +1,7 @@
>   #ifndef __BACKPORT_LINUX_KTIME_H
>   #define __BACKPORT_LINUX_KTIME_H
>   #include_next <linux/ktime.h>
> +#include <linux/timekeeping.h>
>   #include <linux/version.h>
>
>   #if  LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
> diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
> new file mode 100644
> index 000000000000..25ca76b5f802
> --- /dev/null
> +++ b/backport/backport-include/linux/timekeeping.h
> @@ -0,0 +1,21 @@
> +#ifndef __BACKPORT_TIMKEEPING_H
> +#define __BACKPORT_TIMKEEPING_H
> +#include <linux/version.h>
> +#include <linux/types.h>
> +
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
> +#include_next <linux/timekeeping.h>
> +#endif
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
> +static inline time_t ktime_get_seconds(void)
> +{
> +	struct timespec t;
> +
> +	ktime_get_ts(&t);
> +
> +	return t.tv_sec;
> +}
> +#endif
> +
> +#endif /* __BACKPORT_TIMKEEPING_H */
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
