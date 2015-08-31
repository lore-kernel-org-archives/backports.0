Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51540 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbbHaOiY (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Aug 2015 10:38:24 -0400
Message-ID: <1441031901.13980.12.camel@sipsolutions.net> (sfid-20150831_163826_301472_FD89CC61)
Subject: Re: newbie questions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Mon, 31 Aug 2015 16:38:21 +0200
In-Reply-To: <55E46415.9040003@linux.intel.com>
References: <55E3A03D.6050607@linux.intel.com>
	 (sfid-20150831_023101_616135_D37C8DBB) <1441006988.13980.3.camel@sipsolutions.net>
	 <55E44DA7.3000209@linux.intel.com>
	 <1441025664.13980.8.camel@sipsolutions.net>
	 <55E454C9.5070302@linux.intel.com>
	 <1441028012.13980.10.camel@sipsolutions.net>
	 <55E46415.9040003@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-08-31 at 09:26 -0500, Pierre-Louis Bossart wrote:
> 
> What I was really looking for is the --integrate option that does 
> merge the backport into an existing tree.
> 

Ah. I'd suggest you not actually start with that though - it's more
complex and I'd think it's much easier to start getting all of this off
the ground as modules. Assuming the drivers you care about can be built
as modules, of course.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
