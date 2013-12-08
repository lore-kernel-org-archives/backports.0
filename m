Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38077 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758807Ab3LHOqL (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 09:46:11 -0500
Message-ID: <52A48629.6050905@hauke-m.de> (sfid-20131208_154614_420988_A63100AD)
Date: Sun, 08 Dec 2013 15:46:01 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH 1/3] backports: backport ktime_to_ms()
References: <1386354570-23940-1-git-send-email-mcgrof@do-not-panic.com> <1386354570-23940-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1386354570-23940-2-git-send-email-mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/06/2013 07:29 PM, Luis R. Rodriguez wrote:
> This backports ktime_to_ms()
> 
> mcgrof@cerro ~/linux-next (git::master)$ git describe --contains f56916b9
> v2.6.35-rc1~490^2~16
> 
> commit f56916b97fe2031761ca611f0a342efd913afb33
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Fri May 7 13:34:37 2010 -0400
> 
>     ktime: introduce ktime_to_ms()
> 
>     To report ktime statistics to user space in milliseconds, a new helper
>     is required.
> 
>     When considering how to do this conversion, I didn't immediately see
>     why the extra step of converting ktime to a timeval was needed.  To
>     make that more clear, introduce a couple of large comments.
> 
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  backport/backport-include/linux/ktime.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 backport/backport-include/linux/ktime.h
> 
> diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
> new file mode 100644
> index 0000000..741be25
> --- /dev/null
> +++ b/backport/backport-include/linux/ktime.h
> @@ -0,0 +1,14 @@
> +#ifndef __BACKPORT_LINUX_KTIME_H
> +#define __BACKPORT_LINUX_KTIME_H
> +#include_next <linux/ktime.h>
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)

Add this line here, otherwise we get problems with RHEL.
#define ktime_to_ms LINUX_BACKPORT(ktime_to_ms)

> +static inline s64 ktime_to_ms(const ktime_t kt)
> +{
> +	struct timeval tv = ktime_to_timeval(kt);
> +	return (s64) tv.tv_sec * MSEC_PER_SEC + tv.tv_usec / USEC_PER_MSEC;
> +}
> +#endif /* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35) */
> +
> +#endif
> 

