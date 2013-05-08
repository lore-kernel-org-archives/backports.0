Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33978 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab3EHJFg (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 05:05:36 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so1520540lab.3
        for <backports@vger.kernel.org>; Wed, 08 May 2013 02:05:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368003661.8279.17.camel@jlt4.sipsolutions.net>
References: <1367997031-11574-1-git-send-email-johannes@sipsolutions.net>
 <1367997056.8279.10.camel@jlt4.sipsolutions.net> <CAB=NE6UiDwf4ojR=XaVF+QqttKxKnNHcLJ9otF2ud3kdkdoddQ@mail.gmail.com>
 <1368003661.8279.17.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Wed, 8 May 2013 02:05:14 -0700
Message-ID: <CAB=NE6UQtjEex53OYiF+u0WdB8Y2ZF0Zpp=D=c11ENyx704+3g@mail.gmail.com> (sfid-20130508_110544_882743_A5EB149C)
Subject: Re: [PATCH] backports: adjust snd_portid patch for nl80211 update
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 8, 2013 at 2:01 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-08 at 01:59 -0700, Luis R. Rodriguez wrote:
>
>
>> So that's next-20130428 but since that doesn't exist we want to easily
>> branch out into a linux-3.10.y branch by having at least:
>>
>>   * next-20130426
>>   * next-20130426
>>   * next-20130429
>>
>> Given that johill has likely time warped us to next-20130423 perhaps
>> its also good to have next-20130424. That would be the full set prior
>> to the merge window for v3.10 (or whatever $linux_deity wants to call
>> it).
>
> I haven't really, I just needed this particular patch for iwlwifi from
> wireless-testing.

Cookie time warp. Close enough. Eat the cookie Spock.

  Luis
