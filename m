Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:49920 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbbHaHnO (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Aug 2015 03:43:14 -0400
Message-ID: <1441006988.13980.3.camel@sipsolutions.net> (sfid-20150831_094316_531236_BBF56070)
Subject: Re: newbie questions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Mon, 31 Aug 2015 09:43:08 +0200
In-Reply-To: <55E3A03D.6050607@linux.intel.com> (sfid-20150831_023101_616135_D37C8DBB)
References: <55E3A03D.6050607@linux.intel.com>
	 (sfid-20150831_023101_616135_D37C8DBB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

> question1: is there a way the list of packages can be selected? I'd 
> like to use the backports infrastructure only for what I care about 
> (media, usb, audio). It'd be really nice if I could limit the updates 
> to the parts I care about (media, usb, sound) and remove all the 
> networking part I don't really have a use for. It's fine if the 
> releases include everything, I only want to limit the changes in my 
> own workspace.

In general, this is possible. Check out the copy-list file. You can
edit this, and it'll copy only what's listed there.

In order to add sound though, you'll also have to at least change
backport/Makefile.kernel and backport/Kconfig.sources to include the
sound directory in the kconfig and build.

The existing semantic patches will be applied to it automatically, but
it seems fairly unlikely that it'll all compile cleanly without more
effort.

> question2: I am not sure I understand how the code is generated. 
> Nothing seems to work/compile even without my changes... If I use 
> linux-next with the next-20150731 tag and the latest backport code, I 
> get:
> 
> ~/backports$ ./gentree.py --clean --verbose --gitdebug --git-revision
>   v4.1.6  ../linux-next ../linux-next-backport

You're not using next-20150731 tag? You're using v4.1.6 tag. If you
checked out linux-next in ../linux-next, then you can simply remove the
"--git-revision ..." argument and make the script a bit faster even.

> Exception: Patch failed

This is because you're not using the right tag.

> Now if I use branch origin/linux-4.1.y, the tree is generated but 
> usually doesn't compile (random options selected)
> 
> Can anyone help with a known config that works?
> 
> 
> question 3: how exactly does ckmake work and what am I missing?
> :~/backports$ ./devel/ckmake 
> [snip] backports/Makefile does not exist
> 

Don't worry about it for now. It's just a test tool to compile against
a lot of trees - you need to run it on the result of backport.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
