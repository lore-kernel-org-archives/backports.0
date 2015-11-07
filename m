Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52938 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGRHi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 12:07:38 -0500
Subject: Re: [PATCH] gentree: fix Makefile symbol disabling
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1446797770-32354-1-git-send-email-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <563E2FD8.3050208@hauke-m.de> (sfid-20151107_180739_890355_71AC1E49)
Date: Sat, 7 Nov 2015 18:07:36 +0100
MIME-Version: 1.0
In-Reply-To: <1446797770-32354-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/06/2015 09:16 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Currently, a Makefile line like this:
> 
>     obj-$(CONFIG_IPW2100) += ipw2x00/
> 
> will get mangled into
> 
>     #obj-$(CONFIG_IPW2100+= ipw2x00/
> 
> when disabled by the gentree script. Fix the regular
> expression to contain the entire match as the first
> group, so it gets all preserved when replaced later
> by "#\1" using expression.sub().
> 
> This then makes it come out as
> 
>     #obj-$(CONFIG_IPW2100) += ipw2x00/
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  gentree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Thank you for the patch, it was applied.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
