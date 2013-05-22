Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58447 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab3EVMCt (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 08:02:49 -0400
Message-ID: <1369224166.8207.4.camel@jlt4.sipsolutions.net> (sfid-20130522_140250_679027_96A25D46)
Subject: Re: [PATCH 3/9] lib/bpgit.py: add git status support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 22 May 2013 14:02:46 +0200
In-Reply-To: <1369222478-30577-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133505_156212_DDCE0432)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-4-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130522_133505_156212_DDCE0432)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> We use --porcelain given that this spits out the results
> in an easy-to-parse format for scripts and will remain stable
> across git versions and regardless of user configuration.
> 
> We will use this later.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  lib/bpgit.py |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/lib/bpgit.py b/lib/bpgit.py
> index 40523f2..335cc9c 100644
> --- a/lib/bpgit.py
> +++ b/lib/bpgit.py
> @@ -27,6 +27,18 @@ def rev_parse(rev='HEAD', tree=None):
>          raise SHAError()
>      return sha
>  
> +def status(tree=None):
> +    cmd = ['git', 'status', '--porcelain']
> +
> +    process = subprocess.Popen(cmd,
> +                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
> +                               close_fds=True, universal_newlines=True, cwd=tree)
> +    stdout = process.communicate()[0]
> +    process.wait()
> +    _check(process)
> +
> +    return stdout.strip()

I think it would make some sense to parse this here into something more
"pythonic", like a list of tuples or so.

johannes

