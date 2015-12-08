Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38325 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755998AbbLHJiF (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 8 Dec 2015 04:38:05 -0500
Message-ID: <1449567481.4154.9.camel@sipsolutions.net> (sfid-20151208_103821_290098_EB5D29B9)
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Tue, 08 Dec 2015 10:38:01 +0100
In-Reply-To: <5666A2C8.3070002@broadcom.com>
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
		 <563E301B.7090609@hauke-m.de> <56669864.3050404@broadcom.com>
		 (sfid-20151208_094430_942811_4B1A5954) <1449565444.4154.1.camel@sipsolutions.net>
		 (sfid-20151208_100442_655563_BC7335A1) <1449566082.4154.6.camel@sipsolutions.net>
	 <5666A2C8.3070002@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2015-12-08 at 10:28 +0100, Arend van Spriel wrote:
> 
> Basically the list would be the exported symbols from the backports 
> module, ie. compat.ko, right?
> 

Perhaps, I think it's slightly more complicated.

For one, we mostly prefix them with backport_, so just using as-is
won't work.

Secondly, we might sometimes intentionally do that, even though the
original function *does* exist, like with debugfs_create_bool() that
changed function signature.

I think it'd be safer to just do it one by one - but we might be able
to get rid of a lot of the RHEL/ubuntu/whatever ifdefs that way?

We might also be able to use them to ifdef some inlines that belong to
it? Overall it seems better to just do it by hand but as a better
mechanism than checking kernel versions?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
