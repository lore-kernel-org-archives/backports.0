Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59593 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbaFAWdA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 18:33:00 -0400
Message-ID: <538BAA15.7040407@hauke-m.de> (sfid-20140602_003301_692387_BA9B8A1A)
Date: Mon, 02 Jun 2014 00:32:53 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] gentree: remove stray print
References: <1399301918-30691-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1399301918-30691-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/05/2014 04:58 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> My previous commit to restrict the defconfig files left
> a debugging print statement, remove it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  gentree.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/gentree.py b/gentree.py
> index 8a8f6b6a22a4..5fe699650916 100755
> --- a/gentree.py
> +++ b/gentree.py
> @@ -808,7 +808,6 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
>                      line_ok = True
>                      break
>              if not line_ok:
> -                print dfbase, line
>                  copy_defconfig = False
>                  break
>          if copy_defconfig:
> 
Thank you for the patch, is was applied, pushed and is included in the
backports-20140501 release.

Hauke
