Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58448 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab3EVMDN (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 08:03:13 -0400
Message-ID: <1369224190.8207.5.camel@jlt4.sipsolutions.net> (sfid-20130522_140314_295176_CD51B45A)
Subject: Re: [PATCH 4/9] lib/bpgit.py: add git clean support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 22 May 2013 14:03:10 +0200
In-Reply-To: <1369222478-30577-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133508_690811_8F433DA8)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-5-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130522_133508_690811_8F433DA8)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> We'll use this later.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  lib/bpgit.py |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/lib/bpgit.py b/lib/bpgit.py
> index 335cc9c..51ba72e 100644
> --- a/lib/bpgit.py
> +++ b/lib/bpgit.py
> @@ -27,6 +27,18 @@ def rev_parse(rev='HEAD', tree=None):
>          raise SHAError()
>      return sha
>  
> +def clean(tree=None):
> +    cmd = ['git', 'clean', '-f', '-x', '-d']

why not add -q

> +    process = subprocess.Popen(cmd,
> +                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
> +                               close_fds=True, universal_newlines=True, cwd=tree)
> +    stdout = process.communicate()[0]
> +    process.wait()
> +    _check(process)
> +
> +    return stdout.strip()

Do you really care about its output?

johannes

