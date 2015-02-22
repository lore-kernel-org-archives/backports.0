Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58795 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbbBVCGa (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 21:06:30 -0500
Message-ID: <54E939A3.5050202@hauke-m.de> (sfid-20150222_030631_464597_AB21F692)
Date: Sun, 22 Feb 2015 03:06:27 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 1/2] backport: small copy&paste error fixed
References: <1422648758-31361-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1422648758-31361-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/30/2015 09:12 PM, Arend van Spriel wrote:
> Changed the version number in the file header comment.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  backport/compat/backport-3.19.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
> index c633f38..0b59bef 100644
> --- a/backport/compat/backport-3.19.c
> +++ b/backport/compat/backport-3.19.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
>   *
> - * Backport functionality introduced in Linux 3.18.
> + * Backport functionality introduced in Linux 3.19.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> 

Thank you for the patch, it was applied to backports, somehow I missed
the second one I will take care of it later.

Hauke
