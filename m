Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57019 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3EHHK7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 03:10:59 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1UZyWf-0002G1-Ay
	for backports@vger.kernel.org; Wed, 08 May 2013 09:10:57 +0200
Message-ID: <1367997056.8279.10.camel@jlt4.sipsolutions.net> (sfid-20130508_091101_291633_2DA97432)
Subject: Re: [PATCH] backports: adjust snd_portid patch for nl80211 update
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Wed, 08 May 2013 09:10:56 +0200
In-Reply-To: <1367997031-11574-1-git-send-email-johannes@sipsolutions.net> (sfid-20130508_091041_345759_FBA0FAA9)
References: <1367997031-11574-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130508_091041_345759_FBA0FAA9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-08 at 09:10 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The new code for the "critical protocol indication" uses
> snd_portid and must be adjusted in the backport patches.

This will be needed starting from next-20130423.

johannes

