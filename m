Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54302 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab3EGNYC (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 09:24:02 -0400
Message-ID: <1367933038.8328.8.camel@jlt4.sipsolutions.net> (sfid-20130507_152404_353835_B703F82C)
Subject: Re: [PATCH v2 4/4] ckmake: make --check-exports default
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Tue, 07 May 2013 15:23:58 +0200
In-Reply-To: <1367877266-11028-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130506_235434_633995_0DF1E162)
References: <1367877266-11028-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130506_235434_633995_0DF1E162)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-06 at 14:54 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> Remove --check-exports as an option and now just enable it by default.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  devel/ckmake |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/devel/ckmake b/devel/ckmake
> index 0b738e5..61f9864 100755
> --- a/devel/ckmake
> +++ b/devel/ckmake
> @@ -180,7 +180,7 @@ def process_kernel(num, kset, cmdline_args):
>  
>  		log_file.close()
>  		status = p.returncode
> -		if status == 0 and cmdline_args.check_exports:
> +		if status == 0

with that fixed (missing colon) of course

johannes

