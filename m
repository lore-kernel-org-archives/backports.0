Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:52395 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab3FCHwo (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 3 Jun 2013 03:52:44 -0400
Message-ID: <1370245958.8227.0.camel@jlt4.sipsolutions.net> (sfid-20130603_095246_302490_335A7949)
Subject: Re: [PATCH] backports: specify python2.7 for gentree.py
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas Pedersen <thomas@cozybit.com>
Cc: backports@vger.kernel.org
Date: Mon, 03 Jun 2013 09:52:38 +0200
In-Reply-To: <1370214733-29993-1-git-send-email-thomas@cozybit.com> (sfid-20130603_011619_699121_3245A68D)
References: <1370214733-29993-1-git-send-email-thomas@cozybit.com>
	 (sfid-20130603_011619_699121_3245A68D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-06-02 at 16:12 -0700, Thomas Pedersen wrote:
> Apparently gentree.py uses some python2.7 specific syntax. Fixes:
> 
> ./gentree.py -h
>   File "./gentree.py", line 72
>     except OSError, e:

This is curious, it already uses

except OSError as e:

in most places, just not this one.

I think we should just make this compatible with both 2.7+ and 3, which
shouldn't be too hard. I tried a bit and the patchlib is the biggest
issue, will try some more after all my meetings.

johannes

