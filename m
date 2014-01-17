Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51574 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812AbaAQVbd (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 17 Jan 2014 16:31:33 -0500
Message-ID: <52D9A12C.5080500@hauke-m.de> (sfid-20140117_223136_988524_43C19DFC)
Date: Fri, 17 Jan 2014 22:31:24 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?= <richard.rojfors@gmail.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH] compat.3.7, compat.3.8: Adds missing of.h include
References: <1386689770.5956.4.camel@asus>
In-Reply-To: <1386689770.5956.4.camel@asus>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/10/2013 04:36 PM, Richard Röjfors wrote:
> This applies to 3.13-rc2
> 
> The compat-3.7.c och compat-3.8.c uses of-functions if supported by the
> kernel, but there is a missing include for linux/of.h.
> 
> This patch fixes the compile error which looks like this:
> 
> | NOTE: make -j 8 ARCH=arm KLIB_BUILD=/path/usr/src/kernel KLIB=/path/image
> |   CC [M]  /path/backports-3.13-rc2-1/compat/compat-3.7.o
> | /path/backports-3.13-rc2-1/compat/compat-3.7.c: In function 'of_get_child_by_name':
> | /path/backports-3.13-rc2-1/compat/compat-3.7.c:274:1: error: unknown type name 'z'
> | /path/backports-3.13-rc2-1/compat/compat-3.7.c:276:3: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'if'
> | make[6]: *** [/path/backports-3.13-rc2-1/compat/compat-3.7.o] Error 1
> | make[5]: *** [/path/backports-3.13-rc2-1/compat] Error 2
> | make[4]: *** [_module_/path/backports/3.13-rc2-1-r0/backports-3.13-rc2-1] Error 2
> | make[3]: *** [modules] Error 2
> | make[2]: *** [modules] Error 2
> | make[1]: *** [modules] Error 2
> | make: *** [default] Error 2
> 
> Signed-off-by: Richard Röjfors <richard.rojfors@gmail.com>
> ---
> --- backports-3.13-rc2-1.org/compat/compat-3.7.c	2013-12-05 12:19:56.161016836 +0100
> +++ backports-3.13-rc2-1.new/compat/compat-3.7.c	2013-12-05 12:18:40.257012431 +0100
> @@ -256,6 +256,8 @@
>  
>  #ifdef CONFIG_OF
>  #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
> +#include <linux/of.h>
> +
>  /**
>   *	of_get_child_by_name - Find the child node by name for a given parent
>   *	@node:	parent node
> --- backports-3.13-rc2-1.org/compat/compat-3.8.c	2013-12-05 12:17:53.093009694 +0100
> +++ backports-3.13-rc2-1.new/compat/compat-3.8.c	2013-12-05 12:18:42.745012576 +0100
> @@ -420,6 +420,8 @@
>  EXPORT_SYMBOL_GPL(vm_iomap_memory);
>  
>  #ifdef CONFIG_OF
> +#include <linux/of.h>
> +
>  /**
>   * of_find_property_value_of_size
>   *
> 
In backports-20131206 linux/of.h already gets included in
compat/compat-3.7.c and compat/compat-3.8.c.

Could you check if this work for you.

Hauke

