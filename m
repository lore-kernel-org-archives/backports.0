Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38507 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbFIWMy (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 18:12:54 -0400
Received: by igblz2 with SMTP id lz2so20944571igb.1
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 15:12:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55775EAF.3060503@hauke-m.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
 <1433330756-22733-2-git-send-email-sassmann@kpanic.de> <556F5FD5.4070003@hauke-m.de>
 <55701578.9030205@kpanic.de> <CAB=NE6UYbXqyo-O5Dj-FBTzhQ+LjRH86-fbgAQaqreVAoctQjg@mail.gmail.com>
 <55768BD6.1000305@kpanic.de> <CAB=NE6UPfPf3KMZjUzmE-yVbX3bo_fX37gB0_B1d2udEtGS4Jg@mail.gmail.com>
 <55775EAF.3060503@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Jun 2015 15:12:33 -0700
Message-ID: <CAB=NE6VjO1p_6gg1rSyq6jP3oAQcJ28Z2hBHka7UxPnTzK0YqQ@mail.gmail.com> (sfid-20150610_001257_477915_5B542083)
Subject: Re: [PATCH 1/4] backports: replace igb skb->no_fcs patch with
 semantic patch
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Stefan Assmann <sassmann@kpanic.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 9, 2015 at 2:46 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 06/09/2015 08:24 PM, Luis R. Rodriguez wrote:
>> On Mon, Jun 8, 2015 at 11:46 PM, Stefan Assmann <sassmann@kpanic.de> wrote:
>>> On 09.06.2015 00:09, Luis R. Rodriguez wrote:
>>>> On Thu, Jun 4, 2015 at 2:08 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
>>>>> On 03.06.2015 22:13, Hauke Mehrtens wrote:
>>>>>> Is it always save to just remove something which accesses skb->no_fcs in
>>>>>> all cases? I think sometimes some special handling for older kernel
>>>>>> version could be needed. This also looks very specific to the igb usage.
>>>>>
>>>>> In this case I'd say this is fine, no_fcs is used to send out frames with
>>>>> bad CRC for testing. So just commenting out related code shouldn't cause
>>>>> any harm. Yes, the cocci code is very specific and will likely need to be
>>>>> extended for other drivers when we pull them in. But you have to start
>>>>> somewhere.
>>>>>
>>>>> We always have the option to revert if something turns out to be a bad
>>>>> idea.
>>>>
>>>> I'm fine with merging now but please note the discussion, Hauke was
>>>> curious about the generality over the Coccinelle patch replacement
>>>> over a patch series. In order to help maintainers make a proper
>>>> assessment over whether or not we can merge an SmPL patch to replace a
>>>> patch series it is extremely useful to annotate the SmPL patch with
>>>> header comments which track:
>>>>
>>>> a) The respective upstream commit and kernel version which introduced
>>>> the collateral evolution for which you are generalizing
>>>> b) A good description which explains your understanding as to why this
>>>> should work and will not break run time
>>>>
>>>> a) is easy, b) is hard but it is the least we can do and I think we
>>>> will remain sane if we put this as a litmus test for future SmPL patch
>>>> replacements. Its not easy but please see my own SmPL patches and
>>>> review the description. Its pretty lengthy but these discussions can
>>>> be avoided if we had someone do the full homework.
>>>>
>>>> If we want to scale we need this. Are you folks OK with requiring a)
>>>> and b) on future SmPL patch replacements? Best effort at least. Keep
>>>> in mind reason for this is also I believe there are some further
>>>> generalizations we can reach if we follow these best practices which I
>>>> think will have further beneficial gains to us.
>>>
>>> Adding that info to the git commit log sounds like added value. I'll try
>>> to provide it in my next patchset. If I get you right, this is somewhat
>>> similar to what's in the INFO files, correct?
>>
>> The commit log can use it, but indeed it'd be useful if we keep track
>> of it also in the INFO files as well. In practice if its one file (one
>> patch or one cocci file) at the top as a comment is used as well for
>> info... The INFO file thing came about from the fact that Johannes
>> long ago streamlined the practice of splitting up patch series into
>> separate files, one for each affected module / component. This was
>> done to enable being able to skip patch files which you do not carry
>> on your copy target. So say you only want to provide backports tarball
>> that carried in only one device driver, one patch series might affect
>> all drivers but with this strategy the patching sequence would
>> continue after only applying the one patch for that series that is
>> applicable to that driver. Its redudnant to copy the same commit log /
>> verbose message to all patches so Johannes figured to extract that and
>> put it on a single INFO file.
>>
>> Come to think of it, even if we have one file for a series whether its
>> regular patches or cocci patches perhaps its best we embrace the
>> practice of using the INFO strategy. This would help for example in
>> enabling evaluation of number of lines of patch series and cocci files
>> by just using 'wc -l', instead of having to first extract the info
>> somehow. I'll go ahead and make these changes, unless I hear
>> otherwise. Moving forward if we can stick to this that'd be great.
>
> I think it would be easier to put the description into the semantic
> patch. When I open a semantic patch I have the description right there
> and do not have to open an other file to get the description, this
> applies for reading and also for updating the description.

OK works with me. So for patch series use INFO, for semantic patches
with just one file just put the description stuff and justification at
the top as a comment.

A good example:

https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/tree/patches/collateral-evolutions/network/0031-sk_data_ready.cocci

> I think we
> should put generating statistics to a very low priority.

Sure. My idea with this was to eventually just add support into
gentree.py with --gitdebug is used some minor statistics in the
temporary git tree created when applying each Coccinelle patch. For
instance over time Ethernet SmPL patches will increase their coverage
of what files they apply to as we add more Ethernet drivers, it'd be
great to find out exactly how many lines of code in terms of impact an
SmPL patch might have over time. With this being added into the commit
log when --gitdebug is used folks who want to generate stats could use
that option when doing a review of stats.

> The problem with semantic patches is that it is not obvious to which
> file they are applied like it is with normal patches, so I think a
> better description is needed.

Indeed - although its not obvious to what files an SmPL patch applies
the grammar used should narrow the scope of applicability, its why I
tend to use a needle-in-a-hay-stack approach for my first rules: first
I set a rule to narrow exactly what type of device I want to apply the
grammar patch to, and then I use this to zero in on the are I wish to
change.

> I wanted to raise the problem that semantic patches are probably fine
> and tested with one driver, but it would also apply to other drivers and
> could also apply to them later, when some driver introduces this feature
> later on, so you do not know where your semantic patch will be applied
> when sending it.

Indeed, so although at first glance its seen as a problem, in practice
a properly written SmPL backport -- one where the backporter took the
time to review the broad grammatical application of the patch over an
entire tree and its implications, as well as consider a possible
needle-in-the-haystack approach -- should yield *proper* new automatic
extensions of the backport onto other drivers. This is a benefit, not
a drawback of using Coccinelle, if done right (TM).

> This is not a problem with this specific semantic patch
> as you said removing the feature should not cause any harm in general.

Its an example of where upon review of the broad application is
determined and vetted to be logically OK. That's certainly we want
folks doing over each and every SmPL patch added to backports, we want
that documentation as well.

  Luis
