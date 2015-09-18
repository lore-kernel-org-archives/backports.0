Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54491 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbbIRNLZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 18 Sep 2015 09:11:25 -0400
Message-ID: <1442581882.2168.13.camel@sipsolutions.net> (sfid-20150918_151127_226278_79D49942)
Subject: Re: [PATCH RFC 2/2] add script to enable audio backport
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Fri, 18 Sep 2015 15:11:22 +0200
In-Reply-To: <55FC0C72.20806@linux.intel.com>
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	 <1442526437-22392-3-git-send-email-pierre-louis.bossart@linux.intel.com>
	 (sfid-20150917_234743_628456_B160EAFA) <1442560633.2168.6.camel@sipsolutions.net>
	 <55FC0C72.20806@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-09-18 at 08:06 -0500, Pierre-Louis Bossart wrote:
> 
> "You can submit this part upstream btw - it'll just be disabled in 
> the
> default copy-list... unless you also submit that upstream"
> 
> If you are ok to take the patches and have the upstream copy-list 
> include the sound files then yes the script is not necessary. I just 
> wanted to have a first pass that isn't intrusive or breaks all the 
> backports, but simple enough for others to try and test.

Ah. Well I think that we'd probably wait until it compiles against all
kernels, but after that having them included in the upstream copy-list
isn't an issue at all.

And until then perhaps you'd just provide it as a separate tree or
patch somewhere, I don't think we should add it to backports like that.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
