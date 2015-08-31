Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51290 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbbHaNdf (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Aug 2015 09:33:35 -0400
Message-ID: <1441028012.13980.10.camel@sipsolutions.net> (sfid-20150831_153337_435486_78BB89FC)
Subject: Re: newbie questions
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Mon, 31 Aug 2015 15:33:32 +0200
In-Reply-To: <55E454C9.5070302@linux.intel.com>
References: <55E3A03D.6050607@linux.intel.com>
	 (sfid-20150831_023101_616135_D37C8DBB) <1441006988.13980.3.camel@sipsolutions.net>
	 <55E44DA7.3000209@linux.intel.com>
	 <1441025664.13980.8.camel@sipsolutions.net>
	 <55E454C9.5070302@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-08-31 at 08:21 -0500, Pierre-Louis Bossart wrote:
> > 
> > The *to* version is never relevant. A given backport will compile
> > against many different *to* versions.
> 
> I guess I completely missed the concept. I was thinking that the 
> gentree.py command would only port and adjust the delta between linux
> -next and the version I wanted. Looks like the backport is really an 
> add-on that will apply to multiple versions. Not sure I understand 
> how successive changes in the tree are handled if there is a single 
> backport.

Well, there's a single *from* version, as you say that was currently
"next-20150731" (or that was the one you used). The backport git
repository is maintained in lockstep with the *from* version (although
there's usually quite a bit of wiggle room)

The result, the output of backports, will/should compile against any
kernel starting from the earliest supported, all the way up to the
*from* version, right now I think that's 3.0 until 4.1 or so.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
