Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:60899 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758397AbcEFV2v (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 May 2016 17:28:51 -0400
Subject: Re: [PATCH] backport-include: fix abs definition in kernel.h
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1459542927-17174-1-git-send-email-arend@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <572D0C91.8000408@hauke-m.de> (sfid-20160506_232852_684232_20762513)
Date: Fri, 6 May 2016 23:28:49 +0200
MIME-Version: 1.0
In-Reply-To: <1459542927-17174-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/01/2016 10:35 PM, Arend van Spriel wrote:
> The definition of abs should be within include protection to avoid
> following build issue:
> 
> In file included from /tmp/bp-test/backport-include/linux/kernel.h:3:0,
>                  from include/linux/cache.h:4,
>                  from include/linux/time.h:4,
>                  from /tmp/bp-test/backport-include/linux/time.h:3,
>                  from include/linux/stat.h:18,
>                  from include/linux/module.h:10,
>                  from /tmp/bp-test/backport-include/linux/module.h:3,
>                  from /tmp/bp-test/net/wireless/nl80211.c:10:
> include/linux/kernel.h:179:0: warning: "abs" redefined [enabled by default]
> error, forbidden warning: kernel.h:179
> make[6]: *** [/tmp/bp-test/net/wireless/nl80211.o] Error 1
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  backport/backport-include/linux/kernel.h | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 


Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
