Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54438 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932729AbdIFPNt (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 11:13:49 -0400
Message-ID: <1504710827.23905.18.camel@sipsolutions.net> (sfid-20170906_171442_910356_6C3842F4)
Subject: Re: [PATCH 21/21] copy-list: add quantenna qtnfmac driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Wed, 06 Sep 2017 17:13:47 +0200
In-Reply-To: <1504710640.23905.16.camel@sipsolutions.net> (sfid-20170906_171130_571276_1DEFF5F5)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-22-hauke@hauke-m.de>
         (sfid-20170822_002853_824683_59CC6C9B) <1504710640.23905.16.camel@sipsolutions.net>
         (sfid-20170906_171130_571276_1DEFF5F5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-09-06 at 17:10 +0200, Johannes Berg wrote:
> 
> And finally 19, it seems like we should be able to just add something
> like
> 
> config BPAUTO_REFCOUNT
> 	def_bool y
> 	#h-file linux/refcount.h

And perhaps that also needs
	#c-file lib/refcount.c

but even that seems reasonably self-contained?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
