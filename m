Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:47068 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab3HSOni (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 19 Aug 2013 10:43:38 -0400
Message-ID: <52122F1B.1070005@fh-kl.de> (sfid-20130819_164341_286366_091630C0)
Date: Mon, 19 Aug 2013 16:43:39 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: <backports@vger.kernel.org>
Subject: Re: [PATCH v2 03/19] backports: add missing include for is_valid_ether_addr()
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de> <1376869084-16513-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1376869084-16513-4-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 19.08.2013 01:37, Hauke Mehrtens wrote:
> is_valid_ether_addr() is used, but the header here it is declared was
> not included.
> 
> This fixes a problem introduced in commit:
> commit 521acfd92f168fc9b8b6a1cefe9a165243f3d872
> Author: Patrick Ziegler <patrick.ziegler@fh-kl.de>
> Date:   Thu Aug 15 14:40:09 2013 +0200
> 
>     backports: add eth_prepare_mac_addr_change() and eth_commit_mac_addr_change()
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Patrick Ziegler <patrick.ziegler@fh-kl.de>
> ---
>  backport/compat/compat-3.9.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/backport/compat/compat-3.9.c b/backport/compat/compat-3.9.c
> index ba8e3cf..d85a79f 100644
> --- a/backport/compat/compat-3.9.c
> +++ b/backport/compat/compat-3.9.c
> @@ -15,6 +15,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/if.h>
>  #include <linux/if_ether.h>
> +#include <linux/etherdevice.h>
>  
>  #ifdef __sg_page_iter_next
>  
> 


Thanks for fixing this issue (and the others based on my patches).

I guess linux/netdevice.h and linux/if_ether.h is redundant in this case.

Patrick

-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
