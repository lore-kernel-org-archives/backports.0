Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51803 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757500AbbLBJEw (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 2 Dec 2015 04:04:52 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <johannes@sipsolutions.net>)
	id 1a43LH-0006b7-9A
	for backports@vger.kernel.org; Wed, 02 Dec 2015 10:04:51 +0100
Message-ID: <1449047089.2449.1.camel@sipsolutions.net> (sfid-20151202_100530_823363_45AB3A68)
Subject: Re: [PATCH v2] backports: add ktime_get_boot_ns()
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Wed, 02 Dec 2015 10:04:49 +0100
In-Reply-To: <1449046985.2449.0.camel@sipsolutions.net> (sfid-20151202_100312_233801_691AC5CB)
References: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20151202_095640_670832_C3102C13) <1449046985.2449.0.camel@sipsolutions.net>
	 (sfid-20151202_100312_233801_691AC5CB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-12-02 at 10:03 +0100, Johannes Berg wrote:
> On Wed, 2015-12-02 at 09:56 +0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > This small helper inline was added in 3.17, we want to use it now
> > so need to backport it.
> > 
> And now I see that you'd already done this - sorry!
> 

No, you didn't - not the boot one...

But you did say that including hrtimer didn't work - it does for me,
but if you need to change it then feel free.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
