Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36699 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbcEDWeV (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 4 May 2016 18:34:21 -0400
Received: by mail-yw0-f175.google.com with SMTP id o66so121906789ywc.3
        for <backports@vger.kernel.org>; Wed, 04 May 2016 15:34:21 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 4 May 2016 15:34:00 -0700
Message-ID: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com> (sfid-20160505_003424_753851_BBB9D451)
Subject: Linux backports CII badge and run time testing
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

As per the Core Infrastructure Initiative guidelines we now meet the
requirements for a badge, the details of the submission is here:

https://bestpractices.coreinfrastructure.org/projects/111

A lot of it just required updating our documentation to enable folks
to report security issues. If there are things that need to be
adjusted please let me know. A lot of this follows the Linux kernel
submission for a lot of things:

https://bestpractices.coreinfrastructure.org/projects/34

Things we need to improve on though are automated tests specific to
backports against a series of kernels, and also providing a bit of a
description when we make new releases. I realize that is hard, but its
also hard for Linux, we have no reasons no to be able to do that as
well.

As for run time testing, we know folks out there in the industry
already use backports and do their own run time tests against drivers,
and this may be automated, we however need something more, at the very
least a boot.

Looking for something minimal to start off, how about this:

https://github.com/michal42/qemu-boot-test

This doesn't yet load modules but it should be possible to add support
for it. I suppose we'd need to backport some qemu related drivers, and
call it a day to start off with? Anyone oppose to that? Any other
ideas? I know we discussed the possibility of using 0-day somehow, but
0-day builds full kernels, not packages that provide modules, and our
issues also is we would need coverage of testing over a series of
kernels.

If you have further information about how you use backports to do any
regular run time testing, information on that would be appreciated.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
