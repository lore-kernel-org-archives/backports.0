Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:41267 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833Ab3LITZI (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 9 Dec 2013 14:25:08 -0500
Message-ID: <1386617105.5042.0.camel@jlt4.sipsolutions.net> (sfid-20131209_202511_007518_CB71FBD1)
Subject: Re: [PATCH 1/3] backports: convert the 62-usb_driver_lpm patch
 series to SmPL
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, peter.senna@gmail.com,
	julia.lawall@lip6.fr, Gilles.Muller@lip6.fr
Date: Mon, 09 Dec 2013 20:25:05 +0100
In-Reply-To: <1386613665-11656-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20131209_192800_083965_BD70A433)
References: <1386613665-11656-1-git-send-email-mcgrof@do-not-panic.com>
	 <1386613665-11656-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20131209_192800_083965_BD70A433)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-12-09 at 19:27 +0100, Luis R. Rodriguez wrote:

> +++ b/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
> @@ -0,0 +1,9 @@
> +@@
> +identifier backport_driver;
> +@@
> +struct usb_driver backport_driver = {

You don't need "..." here?

> ++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> +	.disable_hub_initiated_lpm = 1,
> ++#endif
> +...
> +};

johannes

