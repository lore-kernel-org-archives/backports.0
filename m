Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48590 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936087Ab3DKO4l (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Apr 2013 10:56:41 -0400
Message-ID: <5166CF1F.6050808@hauke-m.de> (sfid-20130411_165644_812093_1AC32D56)
Date: Thu, 11 Apr 2013 16:56:31 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: taking backports out of compat-*.h
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>  <1365593728-5720-3-git-send-email-mcgrof@do-not-panic.com>  <1365599791.8388.16.camel@jlt4.sipsolutions.net>  <CAB=NE6XVe1UcpXozrpC62z750kveY2ACi_-oKVohSZcMNRxSPQ@mail.gmail.com>  (sfid-20130410_190809_555509_3F0894BA) <1365614155.4235.27.camel@jlt4.sipsolutions.net>  (sfid-20130410_191605_116427_ECB60701) <1365691457.8272.64.camel@jlt4.sipsolutions.net>
In-Reply-To: <1365691457.8272.64.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/11/2013 04:44 PM, Johannes Berg wrote:
> On Wed, 2013-04-10 at 19:15 +0200, Johannes Berg wrote:
> 
>>> Sure, lets what's the idea or do you want to do that on another thread?
> 
> Let me give it a different subject :-)
> 
>> It's kinda half-baked and I'm not completely sure it's a good idea
>> (because we may have to follow header file renames, though they happen
>> rarely), but I was basically thinking this:
>>
>> Say there's
>>
>> void my_foo_function(struct foo *f);
>>
>> that we want to backport. Let's also say it's defined in <linux/foo.h>,
>> and that it was usually present starting from kernel 3.0, but for now
>> let's assume the "foo" subsystem always existed (i.e. <linux/foo.h>)
>>
>> Typically, we'd therefore add it to <linux/compat-3.0.h> and declare it
>> there, maybe with the LINUX_BACKPORT() wrapper, and then define it in
>> compat/compat-3.0.c.
>>
>> What I'm thinking is that we should maybe declare it in compat in
>> include/linux/foo.h instead, maybe like this:
>>
>> #ifndef __BACKPORT_FOO
>> #define __BACKPORT_FOO
>> #include_next <linux/foo.h>
>>
>> #if LINUX_VERSION < 3.0
>> #define my_foo_function LINUX_BACKPORT(my_foo_function)
>>
>> void my_foo_function(struct foo *f);
>> #endif
>>
>> #endif /* __BACKPORT_FOO */
>>
>>
>>
>> I'm a bit undecided. On the one hand I think it's nice that we can spot
>> in one place what's backported where in all the
>> include/linux/compat-xyz.h files, but on the other hand it's kinda
>> becoming a messy jumble of features across different subsystems, and
>> hard to determine what you have already and might need for a given
>> header file?
> 
> In addition to what I said, I just realized that we should probably do
> this, and do it consistently even for old things. That way, we can get
> rid of all the pr_fmt patches.
> 
> The reason for the pr_fmt patches is that typically, a source file would
> have
> 
> #define pr_fmt(fmt)           KBUILD_MODNAME ": " fmt
> #include <whatever, including somehow getting printk.h>
> 
> Now that we force them to include compat-2.6.h at the very beginning of
> the file, printk.h already gets included in some way through
> compat-2.6.h (there are of course MANY MANY paths to it.)
> 
> To avoid redefine warnings, we thus patch everything to be
> 
> #undef pr_fmt
> #define pr_fmt
> ...
> 
> which of course works, but it's pretty ugly (we have >1000 patchlines
> for this!)
> 
> 
> If we were able to get rid of compat-2.6.h and put all the backports
> into their appropriate headers (linux/foo.h) we could only force an
> include of compat_autoconf.h (which doesn't include printk.h of course)
> and then we'd be able to get rid of all these patches.

I had a similar same idea a year ago, but haven't found the time to
complete it, see [0]. I am still for this solution.

If linux/foo.h does not exist in recent kernel versions we have to add
it anyway, because the new code references it, so this is not a problem.

With this solution we would clean up the includes used when compiling
and we do not need the pr_fmt patch any more and hopefully some more.

Hauke

[0]:
https://lists.linuxfoundation.org/pipermail/lf_driver_backport/2012-April/000972.html
