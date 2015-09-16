Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41986 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbbIPOJv (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 16 Sep 2015 10:09:51 -0400
Message-ID: <1442412584.2280.7.camel@sipsolutions.net> (sfid-20150916_160953_673582_09740BAE)
Subject: Re: parse-integer support
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Arend van Spriel <arend@broadcom.com>,
	backports@vger.kernel.org
Date: Wed, 16 Sep 2015 16:09:44 +0200
In-Reply-To: <55F97611.30809@linux.intel.com>
References: <55F8E3E9.9090901@linux.intel.com>
	 (sfid-20150916_053717_657974_49EDAFEA) <1442383450.2280.2.camel@sipsolutions.net>
	 <55F92480.50004@broadcom.com> <1442391470.2280.4.camel@sipsolutions.net>
	 <55F97611.30809@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-09-16 at 09:00 -0500, Pierre-Louis Bossart wrote:
> On 9/16/15 3:17 AM, Johannes Berg wrote:
> > On Wed, 2015-09-16 at 10:12 +0200, Arend van Spriel wrote:
> > > 
> > > Probably it is not in because it was tagged as crap and not 
> > > merged
> > 
> > 
> > Oh, that thing. I actually saw that but didn't remember it was 
> > called
> > 'parse-integer' :)
> 
> It is part of next-20150818, include/linux/parse-integer.h
> It's also used by quite a few drivers now...

I guess you should wait until it's dropped from there ... or use a
snapshot from before when it was in. Perhaps it's already dropped,
since you're working on a month-old snapshot?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
