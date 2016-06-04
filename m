Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37131 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbcFDUXI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 4 Jun 2016 16:23:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id z87so32863262wmh.0
        for <backports@vger.kernel.org>; Sat, 04 Jun 2016 13:23:07 -0700 (PDT)
Subject: Re: [PATCH] backports: add page_ref backport
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1464703433-6026-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <575338A9.7070301@broadcom.com> (sfid-20160604_222310_848244_4B8208D0)
Date: Sat, 4 Jun 2016 22:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <1464703433-6026-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 31-05-16 16:03, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Currently, only page_ref_inc() is needed, so backport only that.
> 
> Change-Id: I7b4d7eb4ccccf61d0921ef28a40b6628e8f2c1f8

Guess the change-id is internal ;-) The patch works for me.

Regards,
Arend

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/linux/mm.h       |  1 +
>  backport/backport-include/linux/page_ref.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 backport/backport-include/linux/page_ref.h
> 
> diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
> index bac230364139..5b3cca6afb63 100644
> --- a/backport/backport-include/linux/mm.h
> +++ b/backport/backport-include/linux/mm.h
> @@ -1,6 +1,7 @@
>  #ifndef __BACKPORT_MM_H
>  #define __BACKPORT_MM_H
>  #include_next <linux/mm.h>
> +#include <linux/page_ref.h>
>  
>  #ifndef VM_NODUMP
>  /*
> diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
> new file mode 100644
> index 000000000000..0b890e9be415
> --- /dev/null
> +++ b/backport/backport-include/linux/page_ref.h
> @@ -0,0 +1,13 @@
> +#ifndef __BP_PAGE_REF_H
> +#define __BP_PAGE_REF_H
> +#include <linux/version.h>
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
> +#include_next <linux/page_ref.h>
> +#else
> +static inline void page_ref_inc(struct page *page)
> +{
> +	atomic_inc(&page->_count);
> +}
> +#endif
> +
> +#endif /* __BP_PAGE_REF_H */
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
