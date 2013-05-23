Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34399 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3EWA3M (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 20:29:12 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so2598964lab.4
        for <backports@vger.kernel.org>; Wed, 22 May 2013 17:29:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369224190.8207.5.camel@jlt4.sipsolutions.net>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-5-git-send-email-mcgrof@do-not-panic.com> <1369224190.8207.5.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 22 May 2013 17:28:50 -0700
Message-ID: <CAB=NE6WM0Dbx5tROyyZESKYL5ezifT1wRj8FZzzrKjE+_ac3=w@mail.gmail.com> (sfid-20130523_022913_698304_D1329687)
Subject: Re: [PATCH 4/9] lib/bpgit.py: add git clean support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 22, 2013 at 5:03 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> We'll use this later.
>>
>> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
>> ---
>>  lib/bpgit.py |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/lib/bpgit.py b/lib/bpgit.py
>> index 335cc9c..51ba72e 100644
>> --- a/lib/bpgit.py
>> +++ b/lib/bpgit.py
>> @@ -27,6 +27,18 @@ def rev_parse(rev='HEAD', tree=None):
>>          raise SHAError()
>>      return sha
>>
>> +def clean(tree=None):
>> +    cmd = ['git', 'clean', '-f', '-x', '-d']
>
> why not add -q

Sure.

>> +    process = subprocess.Popen(cmd,
>> +                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
>> +                               close_fds=True, universal_newlines=True, cwd=tree)
>> +    stdout = process.communicate()[0]
>> +    process.wait()
>> +    _check(process)
>> +
>> +    return stdout.strip()
>
> Do you really care about its output?

Nah, I'll trash it.

  Luis
