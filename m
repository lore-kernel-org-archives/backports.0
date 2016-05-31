Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41814 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbcEaODn (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 31 May 2016 10:03:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.87)
	(envelope-from <johannes@sipsolutions.net>)
	id 1b7kGd-00066Y-W4
	for backports@vger.kernel.org; Tue, 31 May 2016 16:03:36 +0200
Message-ID: <1464703413.3076.31.camel@sipsolutions.net> (sfid-20160531_160354_623754_71A86E25)
Subject: Re: [PATCH] backports: update devcoredump patch
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 31 May 2016 16:03:33 +0200
In-Reply-To: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net> (sfid-20160531_154909_169715_B72CDD75)
References: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20160531_154909_169715_B72CDD75)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2016-05-31 at 15:49 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Changed upstream by commit 522566376a3f ("devcoredump:
> add scatterlist support").
> 
This isn't working.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
