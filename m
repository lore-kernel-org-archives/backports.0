Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f196.google.com ([209.85.223.196]:34320 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbbFISrk (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 14:47:40 -0400
Received: by iebtr6 with SMTP id tr6so3256480ieb.1
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 11:47:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55768BD6.1000305@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
 <1433330756-22733-2-git-send-email-sassmann@kpanic.de> <556F5FD5.4070003@hauke-m.de>
 <55701578.9030205@kpanic.de> <CAB=NE6UYbXqyo-O5Dj-FBTzhQ+LjRH86-fbgAQaqreVAoctQjg@mail.gmail.com>
 <55768BD6.1000305@kpanic.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Jun 2015 11:24:37 -0700
Message-ID: <CAB=NE6UPfPf3KMZjUzmE-yVbX3bo_fX37gB0_B1d2udEtGS4Jg@mail.gmail.com> (sfid-20150609_204743_262481_18A86031)
Subject: Re: [PATCH 1/4] backports: replace igb skb->no_fcs patch with
 semantic patch
To: Stefan Assmann <sassmann@kpanic.de>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jun 8, 2015 at 11:46 PM, Stefan Assmann <sassmann@kpanic.de> wrote:
> On 09.06.2015 00:09, Luis R. Rodriguez wrote:
>> On Thu, Jun 4, 2015 at 2:08 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
>>> On 03.06.2015 22:13, Hauke Mehrtens wrote:
>>>> Is it always save to just remove something which accesses skb->no_fcs in
>>>> all cases? I think sometimes some special handling for older kernel
>>>> version could be needed. This also looks very specific to the igb usage.
>>>
>>> In this case I'd say this is fine, no_fcs is used to send out frames with
>>> bad CRC for testing. So just commenting out related code shouldn't cause
>>> any harm. Yes, the cocci code is very specific and will likely need to be
>>> extended for other drivers when we pull them in. But you have to start
>>> somewhere.
>>>
>>> We always have the option to revert if something turns out to be a bad
>>> idea.
>>
>> I'm fine with merging now but please note the discussion, Hauke was
>> curious about the generality over the Coccinelle patch replacement
>> over a patch series. In order to help maintainers make a proper
>> assessment over whether or not we can merge an SmPL patch to replace a
>> patch series it is extremely useful to annotate the SmPL patch with
>> header comments which track:
>>
>> a) The respective upstream commit and kernel version which introduced
>> the collateral evolution for which you are generalizing
>> b) A good description which explains your understanding as to why this
>> should work and will not break run time
>>
>> a) is easy, b) is hard but it is the least we can do and I think we
>> will remain sane if we put this as a litmus test for future SmPL patch
>> replacements. Its not easy but please see my own SmPL patches and
>> review the description. Its pretty lengthy but these discussions can
>> be avoided if we had someone do the full homework.
>>
>> If we want to scale we need this. Are you folks OK with requiring a)
>> and b) on future SmPL patch replacements? Best effort at least. Keep
>> in mind reason for this is also I believe there are some further
>> generalizations we can reach if we follow these best practices which I
>> think will have further beneficial gains to us.
>
> Adding that info to the git commit log sounds like added value. I'll try
> to provide it in my next patchset. If I get you right, this is somewhat
> similar to what's in the INFO files, correct?

The commit log can use it, but indeed it'd be useful if we keep track
of it also in the INFO files as well. In practice if its one file (one
patch or one cocci file) at the top as a comment is used as well for
info... The INFO file thing came about from the fact that Johannes
long ago streamlined the practice of splitting up patch series into
separate files, one for each affected module / component. This was
done to enable being able to skip patch files which you do not carry
on your copy target. So say you only want to provide backports tarball
that carried in only one device driver, one patch series might affect
all drivers but with this strategy the patching sequence would
continue after only applying the one patch for that series that is
applicable to that driver. Its redudnant to copy the same commit log /
verbose message to all patches so Johannes figured to extract that and
put it on a single INFO file.

Come to think of it, even if we have one file for a series whether its
regular patches or cocci patches perhaps its best we embrace the
practice of using the INFO strategy. This would help for example in
enabling evaluation of number of lines of patch series and cocci files
by just using 'wc -l', instead of having to first extract the info
somehow. I'll go ahead and make these changes, unless I hear
otherwise. Moving forward if we can stick to this that'd be great.

  Luis
