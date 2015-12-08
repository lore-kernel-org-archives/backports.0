Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38071 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755743AbbLHJEK (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 8 Dec 2015 04:04:10 -0500
Message-ID: <1449565444.4154.1.camel@sipsolutions.net> (sfid-20151208_100442_655563_BC7335A1)
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Tue, 08 Dec 2015 10:04:04 +0100
In-Reply-To: <56669864.3050404@broadcom.com> (sfid-20151208_094430_942811_4B1A5954)
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
	 <563E301B.7090609@hauke-m.de> <56669864.3050404@broadcom.com>
	 (sfid-20151208_094430_942811_4B1A5954)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2015-12-08 at 09:44 +0100, Arend van Spriel wrote:
> 
> I hit a duplicate export of this function against Fedora 22 kernel 
> (v4.0.4). So they apparently backported it in their kernel. So I 
> manually removed the function from backports tarball. Could this be 
> automated by looking at Module.symvers of the kernel we build
> against? I will explore that if you guys consider it useful.
> 

That's not a bad idea. We could have a script that creates some kind of
header file with #define HAVE_KTIME_GET_SECONDS and then we could use
that. We could even just do that for every single exported functions,
that will just be a few hundred lines but shouldn't matter much? :)

I once considered something similar but by actually test-compiling
something against the kernel - that worked (even for backported
inlines) but was awfully slow ...

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
