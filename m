Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59575 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaFAWcm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 18:32:42 -0400
Message-ID: <538BAA01.9030602@hauke-m.de> (sfid-20140602_003244_714382_E43DB4A7)
Date: Mon, 02 Jun 2014 00:32:33 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?= <richard.rojfors@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] backports: backport-3.15: Include fix
References: <1399125923.28281.3.camel@lillan>
In-Reply-To: <1399125923.28281.3.camel@lillan>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/03/2014 04:05 PM, Richard Röjfors wrote:
> Include string.h to avoid compile issues if warnings are treated as errors:
> 
> backports-3.14-1/compat/backport-3.15.c: In function 'backport_devm_kstrdup':
> backports-3.14-1/compat/backport-3.15.c:33:2: error: implicit declaration of function 'strlen' [-Werror=implicit-function-declaration]
>    size = strlen(s) + 1;
>    ^
> backports-3.14-1/compat/backport-3.15.c:33:9: warning: incompatible implicit declaration of built-in function 'strlen' [enabled by default]
>    size = strlen(s) + 1;
>           ^
> backports-3.14-1/compat/backport-3.15.c:36:3: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
>     memcpy(buf, s, size);
>     ^
> backports-3.14-1/compat/backport-3.15.c:36:3: warning: incompatible implicit declaration of built-in function 'memcpy' [enabled by default]
> 
> Signed-off-by: Richard Röjfors <richard@puffinpack.se>
> ---
> --- a/compat/backport-3.15.c	2014-05-03 15:43:46.229481458 +0200
> +++ b/compat/backport-3.15.c	2014-05-03 15:43:59.541481079 +0200
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/device.h>
>  #include <linux/of.h>
> +#include <string.h>
>  
>  /**
>   * devm_kstrdup - Allocate resource managed space and

Thank you for the patch, is was applied, pushed and is included in the
backports-20140501 release.

Next time you should base your patch on top of the git repository at [0]
and on the mater branch and no some release branch.

Hauke

[0]: https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/
