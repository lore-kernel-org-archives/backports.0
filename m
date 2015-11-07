Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52958 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGRJH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 12:09:07 -0500
Subject: Re: [PATCH] backports: add backport for
 of_platform_default_populate()
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1444904059-4082-1-git-send-email-arend@broadcom.com>
Cc: backports@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <563E3031.2050200@hauke-m.de> (sfid-20151107_180909_176753_D1593292)
Date: Sat, 7 Nov 2015 18:09:05 +0100
MIME-Version: 1.0
In-Reply-To: <1444904059-4082-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/15/2015 12:14 PM, Arend van Spriel wrote:
> Since commit 69b5f4da2636 ("bcma: add support for population subnodes
> also when build as module") the bcma driver uses the function
> of_platform_default_populate(). This patch provides the stub function.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  backport/backport-include/linux/of_platform.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
