Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:53968 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111Ab3EWA2Z (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 20:28:25 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so2626716lab.14
        for <backports@vger.kernel.org>; Wed, 22 May 2013 17:28:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369224166.8207.4.camel@jlt4.sipsolutions.net>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-4-git-send-email-mcgrof@do-not-panic.com> <1369224166.8207.4.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 22 May 2013 17:28:04 -0700
Message-ID: <CAB=NE6UbyVPCXVPj=jMQ3MjanMtH653n3MMsrBz=BELpNBHUTw@mail.gmail.com> (sfid-20130523_022828_066079_97A148BD)
Subject: Re: [PATCH 3/9] lib/bpgit.py: add git status support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 22, 2013 at 5:02 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> We use --porcelain given that this spits out the results
>> in an easy-to-parse format for scripts and will remain stable
>> across git versions and regardless of user configuration.
>>
>> We will use this later.
>>
>> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
>> ---
>>  lib/bpgit.py |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/lib/bpgit.py b/lib/bpgit.py
>> index 40523f2..335cc9c 100644
>> --- a/lib/bpgit.py
>> +++ b/lib/bpgit.py
>> @@ -27,6 +27,18 @@ def rev_parse(rev='HEAD', tree=None):
>>          raise SHAError()
>>      return sha
>>
>> +def status(tree=None):
>> +    cmd = ['git', 'status', '--porcelain']
>> +
>> +    process = subprocess.Popen(cmd,
>> +                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
>> +                               close_fds=True, universal_newlines=True, cwd=tree)
>> +    stdout = process.communicate()[0]
>> +    process.wait()
>> +    _check(process)
>> +
>> +    return stdout.strip()
>
> I think it would make some sense to parse this here into something more
> "pythonic", like a list of tuples or so.

Sure.

  Luis
