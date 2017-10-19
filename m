Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:54170 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751118AbdJSFhe (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 19 Oct 2017 01:37:34 -0400
Message-ID: <1508391450.5497.177.camel@coelho.fi> (sfid-20171019_073736_708281_20E2AD3E)
From: Luca Coelho <luca@coelho.fi>
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Thu, 19 Oct 2017 08:37:30 +0300
In-Reply-To: <20171013103157.26545-1-johannes@sipsolutions.net>
References: <20171013103157.26545-1-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backports: remove CRYPTO_CCM backport
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-10-13 at 12:31 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This never actually worked properly as far as I can tell,
> and now it looks like it won't even compile due to the
> real crypto_memneq() backport.
> 
> Just remove it - distro kernels have it enabled and all
> others should just enable it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/compat/Kconfig     | 11 -------
>  backport/compat/Makefile    |  1 -
>  backport/compat/backports.h | 10 ------
>  backport/compat/main.c      |  9 +-----
>  patches/crypto-ccm.patch    | 78 ---------------------------------
> ------------
>  5 files changed, 1 insertion(+), 108 deletions(-)
>  delete mode 100644 patches/crypto-ccm.patch
> 
> diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
> index 542cf0cca781..492efbfc7d9f 100644
> --- a/backport/compat/Kconfig
> +++ b/backport/compat/Kconfig
> @@ -102,17 +102,6 @@ config BPAUTO_USERSEL_BUILD_ALL
>  	  It's only really useful for compat testing, so
>  	  you probably shouldn't enable it.
>  
> -config BPAUTO_CRYPTO_CCM
> -	depends on CRYPTO_AEAD
> -	depends on CRYPTO_CTR
> -	bool
> -
> -config BPAUTO_BUILD_CRYPTO_CCM
> -	bool
> -	default n if CRYPTO_CCM
> -	default y if BPAUTO_CRYPTO_CCM
> -	#c-file crypto/ccm.c
> -
>  config BPAUTO_CRYPTO_SKCIPHER
>  	tristate
>  	depends on KERNEL_4_3

Should backports then depend on CRYPTO_CCM? It didn't really work in
the past and I got a few reports of broken backport with old kernels
due to missing CRYPTO_CCM in the kernel config.

--
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
