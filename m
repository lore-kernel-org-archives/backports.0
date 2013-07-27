Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43253 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab3G0RL1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 13:11:27 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so3212344lbi.6
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 10:11:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369772615.8548.30.camel@jlt4.sipsolutions.net>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
 <1369224306.8207.7.camel@jlt4.sipsolutions.net> <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com>
 <1369322755.12002.21.camel@jlt4.sipsolutions.net> <CAB=NE6UwkAunmKGLutnHsUjSYXv34zQ2n1eVUc3jTsE=9vWejg@mail.gmail.com>
 <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com>
 <CAB=NE6Up+L2b_nQoLND4NrSD+J3ydKsnpP=178WhPFMSV4D6kQ@mail.gmail.com> <1369772615.8548.30.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 27 Jul 2013 10:11:06 -0700
Message-ID: <CAB=NE6WZzHH+DTfGk4fW5h+4X6uFWhoSLmER3KcOBfwnZEA+sg@mail.gmail.com> (sfid-20130727_191129_874584_12666E4E)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 28, 2013 at 1:23 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2013-05-28 at 13:14 -0700, Luis R. Rodriguez wrote:
>
>> Addressing RELMOD_TYPE seems easy with --git-revision, add arguments
>> additional arguments: -s -n -p -c -u as release mode specifications as
>> arguments to be passed to gentree.py either as:
>>
>>   a) standalone arguments, or;
>>   b) as a conglomeration of release modification types, ie something
>> like --rel-mod=snpcu
>
> I think this would fit better with the model of a separate tool, that
> calls the gentree code to generate internally. Then you'd have maybe
>
> ./devel/gen-and-kup.py -s -n -p -c -u ...
>
> or something? Overall, that seems cleaner than cluttering gentree.py
> with all these options, although gentree.py would probably (internally
> only?) have to learn about being able to take patches and the skeleton
> code from another directory to address the paranoia for the backport
> tree itself.

I no longer have a need for the above.

>> We just need a reasonable way to address RELMOD_UPDATE then.
>
> That's when you generate a new one for the same tag, due to updates,
> right?

Yeap.

> I don't really know how to handle this -- we don't really have a
> canonical database of what we've generated before.

The releases we made before had patterns but I've decided that the
additional patches mechanism in place before, while useful, made
release management a pain. A better alternative for now is to ignore
such additional patch mess under the new tree then and consider a
different architecture for these modifications and consider this later
with better thought if required.

  Luis
