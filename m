Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57714 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3EPLZ4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 07:25:56 -0400
Message-ID: <1368703552.8387.4.camel@jlt4.sipsolutions.net> (sfid-20130516_132558_781129_4B5D9C4F)
Subject: Re: [PATCH v2 4/4] gentree.py: do not skip /dev/null patches
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Thu, 16 May 2013 13:25:52 +0200
In-Reply-To: <1368692610-24662-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_102356_806104_2369DBE5)
References: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368692610-24662-5-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130516_102356_806104_2369DBE5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-05-16 at 01:23 -0700, Luis R. Rodriguez wrote:

> --- a/gentree.py
> +++ b/gentree.py
> @@ -368,7 +368,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
>          # assume the patch needs to be applied -- otherwise continue
>          patched_file = '/'.join(p.items[0].source.split('/')[1:])
>          fullfn = os.path.join(args.outdir, patched_file)
> -        if not os.path.exists(fullfn):
> +        if ((patched_file != "null") and (not os.path.exists(fullfn))):

Do you actually have patches adding completely new files? That seems a
bit odd to me?

johannes

