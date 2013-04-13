Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44297 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DMX56 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:57:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1URAKT-000454-3j
	for backports@vger.kernel.org; Sun, 14 Apr 2013 01:57:57 +0200
Message-ID: <1365897475.1089.8.camel@jlt4.sipsolutions.net> (sfid-20130414_015828_709395_7AFBA399)
Subject: Re: [RFC/RFT 00/42] explode header files
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Sun, 14 Apr 2013 01:57:55 +0200
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015412_493914_07CF2B64)
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130414_015412_493914_07CF2B64)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The full diffstat is too long really, but the summary is this:

271 files changed, 6298 insertions(+), 9005 deletions(-)

Obviously the deletions are due to the pr_fmt patches getting killed.

This is also in my test branch:
http://git.sipsolutions.net/?p=backports.git;a=shortlog;h=refs/heads/test

johannes

