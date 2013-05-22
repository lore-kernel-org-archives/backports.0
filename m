Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:39040 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab3EVVuU (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 17:50:20 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so2478312lab.26
        for <backports@vger.kernel.org>; Wed, 22 May 2013 14:50:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369224122.8207.3.camel@jlt4.sipsolutions.net>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-2-git-send-email-mcgrof@do-not-panic.com> <1369224122.8207.3.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 22 May 2013 14:49:58 -0700
Message-ID: <CAB=NE6X5NC8dgGKgS211hYJOD-T-dDSWemkQYFRHYD8UoBsP9A@mail.gmail.com> (sfid-20130522_235023_661744_F6DFB90B)
Subject: Re: [PATCH 1/9] lib/bpgit.py: make git describe --long optional
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 22, 2013 at 5:02 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Why not do:
>
>> -def describe(rev='HEAD', tree=None):
>> -    process = subprocess.Popen(['git', 'describe', '--always', '--long', rev],
>> +def describe(rev='HEAD', tree=None, get_long=False):
>> +    cmd = ['git', 'describe', '--always']
>> +
>> +    if (get_long):
>> +        cmd.append('--long')
>> +
>> +    cmd.append(rev)
>
> def describe(rev='HEAD', tree=None, extra_args=[]):
>     cmd = ['git', 'describe', '--always']
>     cmd.extend(extra_args)
>     if rev is not None:
>         cmd.append(rev)
>     process = ...
>
> that way you can do
>
> bpgit.describe(rev=None, extra_args=['--dirty'])
>
> or
>
> bpgit.describe(extra_args=['--long'])
>
>
> and don't need two different patches.

Although probably overkill for git describe given that I don't foresee
us adding more options I can see this being good practice for anything
else we'll add so sure, I'll make these changes.

  Luis
