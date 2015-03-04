Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59907 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932780AbbCDJPE (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 4 Mar 2015 04:15:04 -0500
Message-ID: <1425460498.1810.4.camel@sipsolutions.net> (sfid-20150304_101516_082089_67547D22)
Subject: Re: [PATCH] backports: add support for 4.x kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Luca Coelho <luca@coelho.fi>
Cc: backports@vger.kernel.org, arend@broadcom.com, mcgrof@suse.com
Date: Wed, 04 Mar 2015 10:14:58 +0100
In-Reply-To: <1425460010-16275-1-git-send-email-luca@coelho.fi>
References: <1424956829.1885.27.camel@sipsolutions.net>
	 <1425460010-16275-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-03-04 at 11:06 +0200, Luca Coelho wrote:

> -		kvers="$$kvers $$(seq 0 99 | sed 's/^/3./')"				;\
> +		kvers="$$kvers $$(seq 0 19 | sed 's/^/3./')"				;\
> +		kvers="$$kvers $$(seq 0 99 | sed 's/^/4./')"				;\

This seems to be the part I was concerned was missing in Arend's patch.

johannes

