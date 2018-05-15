Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48836 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeEOUak (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 15 May 2018 16:30:40 -0400
Message-ID: <1526416237.4450.17.camel@sipsolutions.net> (sfid-20180515_223042_217399_C215AB8D)
Subject: Re: How to use backports?
From: Johannes Berg <johannes@sipsolutions.net>
To: Patrick Doyle <wpdster@gmail.com>
Cc: backports@vger.kernel.org
Date: Tue, 15 May 2018 22:30:37 +0200
In-Reply-To: <CAF_dkJDB077igL5AiySBXo_aam=8wozCg=-Rc-9=7qMqFd4kKA@mail.gmail.com> (sfid-20180515_222647_549797_2BBD3148)
References: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com>
         <1526414646.4450.13.camel@sipsolutions.net>
         <CAF_dkJDB077igL5AiySBXo_aam=8wozCg=-Rc-9=7qMqFd4kKA@mail.gmail.com>
         (sfid-20180515_222647_549797_2BBD3148)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-05-15 at 16:26 -0400, Patrick Doyle wrote:
> It turns out, for my project, I would prefer to use the "kernel
> integration mode", since I would really like to turn off loadable
> modules (not needed for my space-constrained embedded target).  But if
> the "too hard" LED comes on, I can let that go.

You can try it I guess.

For the "loadable module" mode you just remove "--integrate" from the
command line and use a new (empty) directory for the output - the system
then leaves there a setup where you can use "make menuconfig" etc. for
out-of-tree module compilation.

> Anyway... am I looking in the wrong place for documentation?  Should I
> be looking elsewhere?

No, that seems about right, but nobody's maintaining it much.

> How do folks use backports anyway?

We use it with some of the devel/ scripts to make a git tree that
follows the upstream kernel tree, but that just uses gentree internally.

> OK, I'll try that.  Thanks.
> (that just failed to find a
> ../buildroot/build/linux-custom/backports/Kconfig... which smells a
> little like bitrot to me).

That's ... a bit strange, that's the file it should be creating there
for the integration?

> If folks don't tend to use this tool on Ubuntu LTS releases, what
> version of Linux do you use it on?  What is known to work?

I usually use one of Debian/testing or Fedora (currently F27 while I
wait for some things I can't upgrade).

We do run it one some kind of Ubuntu LTS at work, but I suspect they
also installed spatch by hand, no idea how though.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
