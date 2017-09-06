Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54368 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932891AbdIFPKm (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 11:10:42 -0400
Message-ID: <1504710640.23905.16.camel@sipsolutions.net> (sfid-20170906_171130_571276_1DEFF5F5)
Subject: Re: [PATCH 21/21] copy-list: add quantenna qtnfmac driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Wed, 06 Sep 2017 17:10:40 +0200
In-Reply-To: <20170821222817.17376-22-hauke@hauke-m.de> (sfid-20170822_002853_824683_59CC6C9B)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-22-hauke@hauke-m.de>
         (sfid-20170822_002853_824683_59CC6C9B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Alright, I've also applied

 9 - 11
13 - 15
17, 18, 20, 21

As for 12, see the question there.

On 16 I'd like Arend to take a look.

And finally 19, it seems like we should be able to just add something
like

config BPAUTO_REFCOUNT
	def_bool y
	#h-file linux/refcount.h

to compat/Kconfig and the scripting should take care of everything
else?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
