Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:55056 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935117Ab3DJT6D (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 15:58:03 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so659952wey.31
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 12:58:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365600903.4235.10.camel@jlt4.sipsolutions.net>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
 <1365593728-5720-14-git-send-email-mcgrof@do-not-panic.com> <1365600903.4235.10.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 10 Apr 2013 12:57:40 -0700
Message-ID: <CAB=NE6UEUcszkUMBtpwJQnWjAj5p15j_kf158697rSfVmwQM4A@mail.gmail.com> (sfid-20130410_215806_307534_2A39AFCF)
Subject: Re: [PATCH 13/18] backports: add blacklist module support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 10, 2013 at 6:35 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
>> +rm -f $BLACKLIST_CONF
>> +
>> +echo "# To be used when using backported drivers" >> $BLACKLIST_CONF
>
> Or you could just use > instead of >> on this first line ;-)

Doh, yes.

>> +for i in $(grep -v ^# $BLACKLIST_MAP | cut -f 2); do
>
> What happens if the blacklist map contains empty lines? Might want to
> allow that.

That's magically taken care of, I tested even with a line with just
just empty lines but also spaces. For some reason awk works more
reliably for the field cutting so I'll switch it.

>> +     MODULE="${i}.ko"
>> +     MODULE_UPDATE="$(grep -v ^# $BLACKLIST_MAP | grep $i | cut -f 1 | head -1).ko"
>> +
>> +     COUNT=$(find $MODULE_DIR -type f -name ${MODULE} -or -name ${MODULE}.gz | wc -l)
>> +     COUNT_REPLACE=$(find $MODULE_UPDATES -type f -name ${MODULE_UPDATE} -or -name ${MODULE_UPDATE}.gz | wc -l)
>> +
>> +     if [ $COUNT -ne 0 ]; then
>> +             if [ $COUNT_REPLACE -ne 0 ]; then
>> +                     echo "Blacklisting $MODULE ..."
>> +                     echo blacklist $i >> $BLACKLIST_CONF
>> +             fi
>
> So you do mean "# new-driver old-driver", but then shouldn't the iwlwifi
> lines be reversed?

You would know better, sorry I thought iwlagn replaces those, I'll swap.

  Luis
