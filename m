Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:47821 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab3ERUsN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 16:48:13 -0400
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 18 May 2013 13:47:49 -0700
Message-ID: <CAB=NE6WmJKV0UhHBuOrwfvPuEdxbojRMx_eDutS-W3RaKoU9Hw@mail.gmail.com> (sfid-20130518_224818_029176_6AE8F828)
Subject: [ANN] compat-drivers renamed to backports
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Folks as you may already know compat-drivers was renamed to backports
to avoid any confusion with the in-kernel compat code that deals with
32/64 bit compat work and due to some huge amount of changes that went
into the project recently thanks mainly to Johannes. The new tree is
available here:

git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git

This tree doesn't have the old stable branches yet but I'll merge them
soon. Use the master branch for ongoing linux-next daily development.
We used to have compat and compat-drivers, with this new rework we
just use one tree.

Contrary to the old way to doing things you can't any longer use the
base tree to compile anything within the same directory. You're now
expected to take things out. The way to generate a new tree to compile
as an example:

./gentree.py /home/mcgrof/linux-next/ /home/mcgrof/build/backports-20130501

As it stands we have tested backports master up to next-20130502. This
leaves 11 more next tags to catch up to linux-next. We're behind given
the huge amount of work that went into this development cycle.
Fortunately though we're now caught up with Linus though and this
means a new branch for a stable release is due which I'll announce
next.

  Luis
