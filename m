Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44355 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DNAR0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 20:17:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1URAdI-0004L6-Gk
	for backports@vger.kernel.org; Sun, 14 Apr 2013 02:17:24 +0200
Message-ID: <1365898643.25020.3.camel@jlt4.sipsolutions.net> (sfid-20130414_021729_513471_C799BC04)
Subject: Re: [RFC/RFT 00/42] explode header files
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Sun, 14 Apr 2013 02:17:23 +0200
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015412_493914_07CF2B64)
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130414_015412_493914_07CF2B64)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> Before I rebased onto the media drivers this was pretty much
> passing ckmake --allyesconfig, now minor issues could have
> come up that I need to solve, but generally this should be
> fine. I did solve the issues that I saw in ckmake before.

Well, ckmake isn't quite happy, it's missing I2C_CLIENT_SCCB ... that
seems to be more of an issue with the media backport? Anyway, that'll be
trivial to fix.

johannes

