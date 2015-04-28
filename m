Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:16459 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964967AbbD1I1O (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Apr 2015 04:27:14 -0400
Message-ID: <553F4460.8000505@broadcom.com> (sfid-20150428_102719_561264_5B6C891A)
Date: Tue, 28 Apr 2015 10:27:12 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Mathy Vanhoef <vanhoefm@gmail.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] backports: fix high RC version parsing in dependency
 library
References: <553ECCC6.2060604@gmail.com>
In-Reply-To: <553ECCC6.2060604@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/28/15 01:56, Mathy Vanhoef wrote:
> This updates the dependency library to handle RC versions up to 39. For
> example, coccinelle version "1.0.0" is now correctly treated as being higher
> than version "1.0.0-rc24".

This one is duplicate to the patch Eliad submitted [1]. Any reason for 
choosing rc 40?

Regards,
Arend

[1] http://mid.gmane.org/1430126344-1068-1-git-send-email-eliad@wizery.com

> Signed-off-by: Mathy Vanhoef<vanhoefm@gmail.com>
> ---
>   lib/bpreqs.py |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bpreqs.py b/lib/bpreqs.py
> index 6c46670..4399c6d 100644
> --- a/lib/bpreqs.py
> +++ b/lib/bpreqs.py
> @@ -98,7 +98,7 @@ class Req:
>                   if (rc == ""):
>                       rc = 0
>                   else:
> -                    rc = int(rc) - 20
> +                    rc = int(rc) - 40
>                   extra = int(rc)
>               else:
>                   extra = int(rel_specs['EXTRAVERSION']) + 10

