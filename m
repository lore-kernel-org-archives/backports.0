Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:45316 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbaBJKjG (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 10 Feb 2014 05:39:06 -0500
Message-ID: <1392028742.4128.3.camel@jlt4.sipsolutions.net> (sfid-20140210_113914_740259_B7DAF94A)
Subject: Re: [PATCH 3/5] backports: always access net/ieee802154/ with make
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@do-not-panic.com, backports@vger.kernel.org
Date: Mon, 10 Feb 2014 11:39:02 +0100
In-Reply-To: <1390595932-21877-4-git-send-email-hauke@hauke-m.de> (sfid-20140124_213946_472946_AF302766)
References: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
	 <1390595932-21877-4-git-send-email-hauke@hauke-m.de>
	 (sfid-20140124_213946_472946_AF302766)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-01-24 at 21:38 +0100, Hauke Mehrtens wrote:
> In the kernel make will always access net/ieee802154/, we should do the
> same.

> --- a/backport/Makefile.kernel
> +++ b/backport/Makefile.kernel
> @@ -34,7 +34,7 @@ obj-$(CPTCFG_NFC) += drivers/nfc/
>  obj-$(CPTCFG_REGULATOR) += drivers/regulator/
>  obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
>  
> -obj-$(CPTCFG_IEEE802154) += net/ieee802154/
> +obj-y += net/ieee802154/

This is problematic for me, as I don't copy the 802.15.4 stack in my
backport, so this change is essentially breaking the copy-list
behaviour.

I think we should revert this, and instead do the following:

obj-$(CPTCFG_IEEE802154) += net/ieee802154/
obj-$(CPTCFG_BT) += net/ieee802154/

(essentially manually resolving what Dmitry did there in his patch)

johannes

