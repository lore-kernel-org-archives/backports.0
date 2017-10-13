Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:49816 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbdJMJkG (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:40:06 -0400
Received: by mail-wm0-f41.google.com with SMTP id b189so19725751wmd.4
        for <backports@vger.kernel.org>; Fri, 13 Oct 2017 02:40:05 -0700 (PDT)
Subject: Re: [PATCH] backports: no longer support kernels < 3.10
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20171013092641.9113-1-johannes@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <97250f48-ae56-e53a-fb57-1cbfc6470b77@broadcom.com> (sfid-20171013_114008_475433_62DE9875)
Date: Fri, 13 Oct 2017 11:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <20171013092641.9113-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 13-10-17 11:26, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since CRYPTO_CMAC was introduced in 3.10, and mac80211
> depends on it, we basically get nothing out of it anyway.
> 
> I'm not removing the support code (yet) since it actually
> compiles, and perhaps somebody has a need for (certain)
> kernel versions lower than 3.10.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   README                         |  2 +-
>   devel/backports-update-manager | 10 +++++++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 

[ trimming ]

> diff --git a/devel/backports-update-manager b/devel/backports-update-manager
> index 64df29bcea26..dc9697253e84 100755
> --- a/devel/backports-update-manager
> +++ b/devel/backports-update-manager

[ more trimming ]

> @@ -52,7 +54,7 @@ class backport_kernel_updater:
>   
>       @classmethod
>       def _get_ubuntu_ppa_mainline_kernels(cls):
> -        base = 'http://kernel.ubuntu.com/~kernel-ppa/mainline/'
> +        base = KPATH

I guess this is not directly related to this change, right?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
