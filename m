Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53975 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935708Ab3DHUZE (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 16:25:04 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1UPIcg-0004g5-3D
	for backports@vger.kernel.org; Mon, 08 Apr 2013 22:25:02 +0200
Message-ID: <1365452698.25475.24.camel@jlt4.sipsolutions.net> (sfid-20130408_222508_537124_3270B337)
Subject: Re: [PATCH] backport: allow using backported drivers w/o LEDs
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Mon, 08 Apr 2013 22:24:58 +0200
In-Reply-To: <1365452641-30374-1-git-send-email-johannes@sipsolutions.net> (sfid-20130408_222413_628476_F6C25146)
References: <1365452641-30374-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130408_222413_628476_F6C25146)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-04-08 at 22:24 +0200, Johannes Berg wrote:

> This passes allyesconfig (except for some stupid rtlwifi
> issue) with next-20130405 against a 3.8 kernel that has
> all the LED options disabled.

And ckmake, of course.

johannes

