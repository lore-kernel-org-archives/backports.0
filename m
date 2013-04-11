Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:35826 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936146Ab3DKOoV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 10:44:21 -0400
Message-ID: <1365691457.8272.64.camel@jlt4.sipsolutions.net> (sfid-20130411_164426_377228_CC52961A)
Subject: taking backports out of compat-*.h (was: [PATCH 02/18] compat:
 backport dev_level_ratelimited())
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 11 Apr 2013 16:44:17 +0200
In-Reply-To: <1365614155.4235.27.camel@jlt4.sipsolutions.net> (sfid-20130410_191605_116427_ECB60701)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-3-git-send-email-mcgrof@do-not-panic.com>
	 <1365599791.8388.16.camel@jlt4.sipsolutions.net>
	 <CAB=NE6XVe1UcpXozrpC62z750kveY2ACi_-oKVohSZcMNRxSPQ@mail.gmail.com>
	 (sfid-20130410_190809_555509_3F0894BA) <1365614155.4235.27.camel@jlt4.sipsolutions.net>
	 (sfid-20130410_191605_116427_ECB60701)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 19:15 +0200, Johannes Berg wrote:

> > Sure, lets what's the idea or do you want to do that on another thread?

Let me give it a different subject :-)

> It's kinda half-baked and I'm not completely sure it's a good idea
> (because we may have to follow header file renames, though they happen
> rarely), but I was basically thinking this:
> 
> Say there's
> 
> void my_foo_function(struct foo *f);
> 
> that we want to backport. Let's also say it's defined in <linux/foo.h>,
> and that it was usually present starting from kernel 3.0, but for now
> let's assume the "foo" subsystem always existed (i.e. <linux/foo.h>)
> 
> Typically, we'd therefore add it to <linux/compat-3.0.h> and declare it
> there, maybe with the LINUX_BACKPORT() wrapper, and then define it in
> compat/compat-3.0.c.
> 
> What I'm thinking is that we should maybe declare it in compat in
> include/linux/foo.h instead, maybe like this:
> 
> #ifndef __BACKPORT_FOO
> #define __BACKPORT_FOO
> #include_next <linux/foo.h>
> 
> #if LINUX_VERSION < 3.0
> #define my_foo_function LINUX_BACKPORT(my_foo_function)
> 
> void my_foo_function(struct foo *f);
> #endif
> 
> #endif /* __BACKPORT_FOO */
> 
> 
> 
> I'm a bit undecided. On the one hand I think it's nice that we can spot
> in one place what's backported where in all the
> include/linux/compat-xyz.h files, but on the other hand it's kinda
> becoming a messy jumble of features across different subsystems, and
> hard to determine what you have already and might need for a given
> header file?

In addition to what I said, I just realized that we should probably do
this, and do it consistently even for old things. That way, we can get
rid of all the pr_fmt patches.

The reason for the pr_fmt patches is that typically, a source file would
have

#define pr_fmt(fmt)           KBUILD_MODNAME ": " fmt
#include <whatever, including somehow getting printk.h>

Now that we force them to include compat-2.6.h at the very beginning of
the file, printk.h already gets included in some way through
compat-2.6.h (there are of course MANY MANY paths to it.)

To avoid redefine warnings, we thus patch everything to be

#undef pr_fmt
#define pr_fmt
...

which of course works, but it's pretty ugly (we have >1000 patchlines
for this!)


If we were able to get rid of compat-2.6.h and put all the backports
into their appropriate headers (linux/foo.h) we could only force an
include of compat_autoconf.h (which doesn't include printk.h of course)
and then we'd be able to get rid of all these patches.

johannes

