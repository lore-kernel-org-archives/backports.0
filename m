Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58444 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab3EVMCP (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 08:02:15 -0400
Message-ID: <1369224122.8207.3.camel@jlt4.sipsolutions.net> (sfid-20130522_140217_165094_012561E6)
Subject: Re: [PATCH 1/9] lib/bpgit.py: make git describe --long optional
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 22 May 2013 14:02:02 +0200
In-Reply-To: <1369222478-30577-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133455_410970_C278E6E9)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130522_133455_410970_C278E6E9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Why not do:
 
> -def describe(rev='HEAD', tree=None):
> -    process = subprocess.Popen(['git', 'describe', '--always', '--long', rev],
> +def describe(rev='HEAD', tree=None, get_long=False):
> +    cmd = ['git', 'describe', '--always']
> +
> +    if (get_long):
> +        cmd.append('--long')
> +
> +    cmd.append(rev)

def describe(rev='HEAD', tree=None, extra_args=[]):
    cmd = ['git', 'describe', '--always']
    cmd.extend(extra_args)
    if rev is not None:
        cmd.append(rev)
    process = ...

that way you can do

bpgit.describe(rev=None, extra_args=['--dirty'])

or

bpgit.describe(extra_args=['--long'])


and don't need two different patches.

johannes

