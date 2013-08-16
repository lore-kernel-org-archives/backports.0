Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:38654 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab3HPJ4K (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 05:56:10 -0400
Message-ID: <1376646844.15299.0.camel@jlt4.sipsolutions.net> (sfid-20130816_115612_466953_70D9F0FC)
Subject: Re: [PATCH v3 02/10] backports: add eth_prepare_mac_addr_change()
 and eth_commit_mac_addr_change()
From: Johannes Berg <johannes@sipsolutions.net>
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Fri, 16 Aug 2013 11:54:04 +0200
In-Reply-To: <520CCC29.5020007@fh-kl.de> (sfid-20130815_144017_696556_ABF7BBF6)
References: <cover.1376569949.git.patrick.ziegler@fh-kl.de>
	 <520CCC29.5020007@fh-kl.de> (sfid-20130815_144017_696556_ABF7BBF6)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-08-15 at 14:40 +0200, Patrick Ziegler wrote:
> These functions are required by qmi_wwan device driver.

This patch is broken.

> --- a/backport/backport-include/linux/etherdevice.h
> +++ b/backport/backport-include/linux/etherdevice.h
...

> --- a/backport/compat/compat-3.9.c
> +++ b/backport/compat/compat-3.9.c
> @@ -12,6 +12,9 @@
>  #include <linux/scatterlist.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/netdevice.h>
> +#include <linux/if.h>
> +#include <linux/if_ether.h>

Need to include linux/etherdevice.h here.

johannes

