Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40516 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3EHItT (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 04:49:19 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so1687379lbd.29
        for <backports@vger.kernel.org>; Wed, 08 May 2013 01:49:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367996285.8279.7.camel@jlt4.sipsolutions.net>
References: <CAB=NE6V7drWK18ij8Ue78J+GSDdVpTJWwqTt3+tVNk01EN4q6Q@mail.gmail.com>
 <CAB=NE6W3mT+fBZcG1x_VL2iQ3dH7dYVFnHJJDFbVBOd1FKJi+g@mail.gmail.com> <1367996285.8279.7.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 8 May 2013 01:48:57 -0700
Message-ID: <CAB=NE6UtFQz_5XRWL82=sTo1XQ03PofBrzRg_D+5N13H2t0-1A@mail.gmail.com> (sfid-20130508_104935_616957_FA1758DE)
Subject: Re: Backports project release tags for daily snapshots
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 7, 2013 at 11:58 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2013-05-07 at 17:36 -0700, Luis R. Rodriguez wrote:
>> On Tue, May 7, 2013 at 5:20 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>> > Now'also a good time to consider tagging efforts. I used to tag
>> > compat-drivers releases to match the same next tag from linux-next as
>> > we moved on with the only difference I used compat-drivers-2013-05-07
>> > dates instead  of next-20130507 and I also added a -1 or -2 if I
>> > bumped updates by sticking to the same linux-next target.
>> >
>> > Whatever we decide I'll just note that rel-html currently supports the
>> > scheme of dates that are split. I'll still have to update rel-html to
>> > support the project name change so perhaps its good for us to consider
>> > the tag use / practice. To be clear I only added a signed tag if and
>> > only if ckmake yielded good results on all supported kernels. Using
>> > git describe you'd be able to easily get the target next release tag.
>> >
>> > Thoughts, preferences?
>>
>> Here's an example:
>>
>> linux-next based releases:
>>   * backports-20130408 -- first release based on next-20130408
>>   * backports-20130408-2 -- update on the backports code still based
>> on next-20130408
>>   * etc
>>
>> linux-stable releases:
>>
>>   * backports-v3.10 - based on vanilla Linus-blessed v3.10
>>   * backports-v3.10-2 - update on the backports code still based on
>> vanilla v3.10
>>   * backports-v3.10.1 - based on vanila Greg-bless v3.10.1
>>   * backports-v3.10.1-2 - update on the backports code still based on
>> vanilla v3.10.1
>>
>> Thoughts? I should note I tried to stick to v3.10-1 convention for the
>> first release but it just totally slipped at times.
>
> I was kinda hoping you'd just clone my tree and push it somewhere else
> as the canonical tree, note that I haven't put it up on kernel.org but
> only my own website :-)

Well I think you're a better software asshole than I am but I know you
have bigger fish to fry so I was kind of expecting this.

> And to be honest, I don't really care. Tagging is nice for users, but
> doesn't affect me since the backports are another input for our work, we
> don't really have any use for backport releases.

I'll stick to what I propose suggest I hear otherwise then.

 Luis
