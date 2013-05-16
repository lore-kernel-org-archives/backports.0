Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:64628 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab3EPQ6c (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 12:58:32 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so3213434lab.6
        for <backports@vger.kernel.org>; Thu, 16 May 2013 09:58:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368703552.8387.4.camel@jlt4.sipsolutions.net>
References: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com>
 <1368692610-24662-5-git-send-email-mcgrof@do-not-panic.com> <1368703552.8387.4.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 16 May 2013 09:58:11 -0700
Message-ID: <CAB=NE6XPYWQVLuEDDR7L5An2CS+ZHtGcOH6OOWVYMK7H3g77nA@mail.gmail.com> (sfid-20130516_185836_445577_F5EED60C)
Subject: Re: [PATCH v2 4/4] gentree.py: do not skip /dev/null patches
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 16, 2013 at 4:25 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2013-05-16 at 01:23 -0700, Luis R. Rodriguez wrote:
>
>> --- a/gentree.py
>> +++ b/gentree.py
>> @@ -368,7 +368,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
>>          # assume the patch needs to be applied -- otherwise continue
>>          patched_file = '/'.join(p.items[0].source.split('/')[1:])
>>          fullfn = os.path.join(args.outdir, patched_file)
>> -        if not os.path.exists(fullfn):
>> +        if ((patched_file != "null") and (not os.path.exists(fullfn))):
>
> Do you actually have patches adding completely new files? That seems a
> bit odd to me?

For nouveau I did during some of my tests but no, I don't now.

  Luis
