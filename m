Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:56103 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab3EMBbF (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 12 May 2013 21:31:05 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so5520986lab.26
        for <backports@vger.kernel.org>; Sun, 12 May 2013 18:31:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANq1E4RXkYU=PNd-acNT-cp1ARQPR6-2Rq-a8eJGseSbRLCLxg@mail.gmail.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com>
 <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
 <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com> <CANq1E4RXkYU=PNd-acNT-cp1ARQPR6-2Rq-a8eJGseSbRLCLxg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 12 May 2013 18:30:43 -0700
Message-ID: <CAB=NE6WyvXSUS2PUNFktBVUn4u0rcVwXGQ1sYDbL34d8iU2RYw@mail.gmail.com> (sfid-20130513_033108_435280_87A8967F)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp session-management
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, May 12, 2013 at 2:38 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> On Sun, May 12, 2013 at 9:33 PM, Luis R. Rodriguez
>> http://drvbp1.linux-foundation.org/~mcgrof/backport-tmp/backports-20130426.tar.bz2
>
> That one helped a lot, thx!

Great!

>> I think patch miserably guessed the hunks where to apply some of these
>> changes to. I tried to make sense of it but the rewrite was a bit big
>> so I was not sure where to places things correctly, hence me Cc'ing
>> you, I really appreciate you reviewing this.
>
> Yeah, it was really weird. I fixed it up how I think it should work.
> However, compiling kernels takes like 50min here (hurray, intel
> Atom!), so this isn't even compile-tested. I can do this later this
> week if you want.

No worries we have a crazy build box for the backports project that
lets us test compile these releases across 26 kernels (2.6.24-3.9) in
about 30 minutes using our script ckmake, all in RAM, so I just
integrated your changes and in 30 minutes we'll know if anything
broke, and I can provide the log then.

> The net/bluetooth/hidp/core.c file is attached. It is from the tarball
> you created above (2013-04-26). I fixed some other small issues.

Nice, can you provide me a Signed-off-by tag ? With it I'd just amend
it to my commit provided everything compiles fine.

> Can you tell me whether that works for you? The diff to linux-next is pretty small.

Indeed, I used the core.c file to generate the new diff by removing
first completely the patch in question. We'll now just wait for
compilation test results.

As for run time tests I'm personally on 3.2, I suppose what we can do
is if this compiles fine just let this move forward and then at a
later time ask on linux-blueooth list to see if anyone is on a kernel
older than or equal to 2.6.27 using bluetooth to be able to run time
test this. Is there any particular run time test anyone can do to test
if this worked ?

  Luis
