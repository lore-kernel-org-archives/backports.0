Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:47390 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbDTV1V (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Apr 2015 17:27:21 -0400
Message-ID: <55356F36.9070408@hauke-m.de> (sfid-20150420_232723_991103_C6823FDB)
Date: Mon, 20 Apr 2015 23:27:18 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 10/10] backports: require coccinelle version 1.0.0-rc24
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de> <1424874054-22956-11-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1424874054-22956-11-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/25/2015 03:20 PM, Stefan Assmann wrote:
> The new more generic ethernet patches require spatch 1.0.0-rc24.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  gentree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gentree.py b/gentree.py
> index 8df3906..edff138 100755
> --- a/gentree.py
> +++ b/gentree.py
> @@ -625,7 +625,7 @@ def _main():
>      # Our binary requirements go here
>      req = reqs.Req()
>      req.require('git')
> -    req.coccinelle('1.0.0-rc21')
> +    req.coccinelle('1.0.0-rc24')
>      if not req.reqs_match():
>          sys.exit(1)
>  
> 
Hi Stefan,

do you need coccinelle 1.0.0-rc24 or would rc23 also work? Johannes
added a patch raising minimum coccinelle to rc23.

Hauke
