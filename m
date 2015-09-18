Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52829 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbbIRHRP (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 18 Sep 2015 03:17:15 -0400
Message-ID: <1442560633.2168.6.camel@sipsolutions.net> (sfid-20150918_091716_686998_B9316FCC)
Subject: Re: [PATCH RFC 2/2] add script to enable audio backport
From: Johannes Berg <johannes@sipsolutions.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	backports@vger.kernel.org
Date: Fri, 18 Sep 2015 09:17:13 +0200
In-Reply-To: <1442526437-22392-3-git-send-email-pierre-louis.bossart@linux.intel.com> (sfid-20150917_234743_628456_B160EAFA)
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	 <1442526437-22392-3-git-send-email-pierre-louis.bossart@linux.intel.com>
	 (sfid-20150917_234743_628456_B160EAFA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2015-09-17 at 16:47 -0500, Pierre-Louis Bossart wrote:
> bash enable_audio.sh will add the required files in copylist
> and patch some of the backport headers
> 
I don't think this should be part of backports - the code modifications
shouldn't be necessary, you can add everything to copy-list as it
should be (and run with your own copy-list for just sound), and provide
a defconfig file.

Scripting really shouldn't be there I think.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
