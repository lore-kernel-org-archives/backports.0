Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51799 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbbLBJDI (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 2 Dec 2015 04:03:08 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <johannes@sipsolutions.net>)
	id 1a43Jb-0006ZZ-1Y
	for backports@vger.kernel.org; Wed, 02 Dec 2015 10:03:07 +0100
Message-ID: <1449046985.2449.0.camel@sipsolutions.net> (sfid-20151202_100312_233801_691AC5CB)
Subject: Re: [PATCH v2] backports: add ktime_get_boot_ns()
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Wed, 02 Dec 2015 10:03:05 +0100
In-Reply-To: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net> (sfid-20151202_095640_670832_C3102C13)
References: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20151202_095640_670832_C3102C13)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-12-02 at 09:56 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This small helper inline was added in 3.17, we want to use it now
> so need to backport it.
> 
And now I see that you'd already done this - sorry!

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
