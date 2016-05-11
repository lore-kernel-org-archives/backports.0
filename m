Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57971 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbcEKXdq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 May 2016 19:33:46 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E6D7720142
	for <backports@vger.kernel.org>; Wed, 11 May 2016 23:33:44 +0000 (UTC)
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com [209.85.161.175])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7D5D1201BB
	for <backports@vger.kernel.org>; Wed, 11 May 2016 23:33:42 +0000 (UTC)
Received: by mail-yw0-f175.google.com with SMTP id t10so65374088ywa.0
        for <backports@vger.kernel.org>; Wed, 11 May 2016 16:33:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <572DCDE0.5040605@hauke-m.de>
References: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
 <572DCDE0.5040605@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 11 May 2016 16:33:22 -0700
Message-ID: <CAB=NE6UK+O0DuV+KzjzRqFCBUuWkxaHPccFYS4=HbEeuMBEAFQ@mail.gmail.com> (sfid-20160512_013348_962754_E776A20E)
Subject: Re: Linux backports CII badge and run time testing
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, May 7, 2016 at 4:13 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Hi Luis,
>
> Did you apply for this? What are the benefits of this?

Yes -- the benefits are that you push the software project under
application under an honest heavy scrutiny with best practices advised
by Core Infrastructure Initiative (CII). That sounds vague but, the
skinny is, to help reduce attack surfaces in FOSS. To understand the
CII intentions one has to understand how it got spawned... The
heartbleed bug was one trigger that made us start questioning -- WTF
!? How can we do better. The Best Practices are an empirical response
lead through a serious n academic evaluation. I applied for this as a
proactive measure to see where we stand as a project. IMHO every FOSS
should apply and strive to meet the criteria for the badge.
Mathematically, if you really are honest, if you get the badge --
we're in a better place in the community.

> On 05/05/2016 12:34 AM, Luis R. Rodriguez wrote:
>> As per the Core Infrastructure Initiative guidelines we now meet the
>> requirements for a badge, the details of the submission is here:
>>
>> https://bestpractices.coreinfrastructure.org/projects/111
>>
>> A lot of it just required updating our documentation to enable folks
>> to report security issues. If there are things that need to be
>> adjusted please let me know. A lot of this follows the Linux kernel
>> submission for a lot of things:
>>
>> https://bestpractices.coreinfrastructure.org/projects/34
>>
>> Things we need to improve on though are automated tests specific to
>> backports against a series of kernels, and also providing a bit of a
>> description when we make new releases. I realize that is hard, but its
>> also hard for Linux, we have no reasons no to be able to do that as
>> well.
>
> Doing predictable releases cost some constant effort. I do not know if
> we have the resources to do predictable releases.

Same can be said about Linux but hey 0-day came around :D

Now granted for us its different as we also have an array of
kernels... so that Linux * number of kernels we support that needs
testing, but as I noted to Jouni, we really only need certain sanity
tests, and with time perhaps we can zero in further.

> Security support could also be a problem because then we have to react
> pretty fast when someone sees a problem in one of the drivers we ship.

You're right but security-wise the main attack surface really is
Linux, so a security issue that *is* part of Linux, belongs upstream
on Linux, and not backports. So for instance, just as Linus has put
down the law on asking stable fixes to go through him first before any
stable kernels, I think we should also just require security / fixes
to go always upstream, and we never carry any delta, best we can do is
wait for upstream integration to a new release of Linux, or a new
stable release.

The still is a small gap in terms of security that we should cover
though, and that is that about 1-2% of actual backport code we mend
Linux for. If a security issues lies in there *we* should have a
policy for letting people privately report and for us to fix in a
timely manner. That's some room for improvement. Given the attack
surface is about 1-2% of code, and based on an empirical evaluation of
our bugs on kernel.org bugzilla -- I don't think this is a huge
burden, correct me if I'm wrong. Thoughts?

That is to say: I don't see this requiring much effort, specially if
we keep trimming older kernels as we did last time,

> Otherwise fixing the security problems should not be a big deal as I
> assume that most security problems will be already fixed in upstream
> Linux kernel.

Indeed.

>> As for run time testing, we know folks out there in the industry
>> already use backports and do their own run time tests against drivers,
>> and this may be automated, we however need something more, at the very
>> least a boot.
>
> Build testing and testing with simulated drivers like mac80211_hwsim
> should be doable, but testing all the device drivers which serve real
> hardware is nearly impossible.

Agreed.

>> Looking for something minimal to start off, how about this:
>>
>> https://github.com/michal42/qemu-boot-test
>
> yes that should be doable to have a qemu boot test which also checks if
> loading the modules and unloading works.

Cool!

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
