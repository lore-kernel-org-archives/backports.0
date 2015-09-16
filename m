Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39613 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbbIPGEP (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 16 Sep 2015 02:04:15 -0400
Message-ID: <1442383450.2280.2.camel@sipsolutions.net> (sfid-20150916_080420_740092_79358D21)
Subject: Re: parse-integer support
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Wed, 16 Sep 2015 08:04:10 +0200
In-Reply-To: <55F8E3E9.9090901@linux.intel.com> (sfid-20150916_053717_657974_49EDAFEA)
References: <55F8E3E9.9090901@linux.intel.com>
	 (sfid-20150916_053717_657974_49EDAFEA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

> I've progressed a bit in my endeavor to backport the sound drivers with 
> only a few compilation errors but I've reached a blocking point. The 
> audio drivers were converted to use parse_integer this summer but I 
> can't figure out how to back port this.

Err, I can't even figure out what "parse_integer" is? Such a function
doesn't exist in my kernel

> If I add include/linux/parse-integer to copy-list then there are tons of 
> redeclations.

Neither does a file called include/linux/parse-integer(.h)

If you can point out what you really meant here then I'm sure this is
easy to fix, but without looking at the code (which clearly I can't)
there's not much I can do.


johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
