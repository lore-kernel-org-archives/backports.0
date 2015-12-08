Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38253 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756107AbbLHJOq (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 8 Dec 2015 04:14:46 -0500
Message-ID: <1449566082.4154.6.camel@sipsolutions.net> (sfid-20151208_101450_060065_DD89F6BF)
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Tue, 08 Dec 2015 10:14:42 +0100
In-Reply-To: <1449565444.4154.1.camel@sipsolutions.net> (sfid-20151208_100442_655563_BC7335A1)
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
	 <563E301B.7090609@hauke-m.de> <56669864.3050404@broadcom.com>
	 (sfid-20151208_094430_942811_4B1A5954) <1449565444.4154.1.camel@sipsolutions.net>
	 (sfid-20151208_100442_655563_BC7335A1)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2015-12-08 at 10:04 +0100, Johannes Berg wrote:
> 
> That's not a bad idea. We could have a script that creates some kind
> of
> header file with #define HAVE_KTIME_GET_SECONDS and then we could use
> that. We could even just do that for every single exported functions,
> that will just be a few hundred lines but shouldn't matter much? :)
> 

Ok maybe not - on a very small test configuration for me that's
actually something like 6.5k lines...

I guess then we could ship a list of functions we want to look at, like
a file that simply lists one function per line:

symbols-check:
>>>
ktime_get_seconds
<<<

and then we can do something like

grep -f symbols-check /path/to/Module.symvers | \
	cut -f2 | \
	tr 'a-z' 'A-Z' | \
	sed 's/^/#define HAVE_/;s/$/ 1/' \
	> backport-include/backport/existing-symbols.h

and include that in the right place?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
