Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37179 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKXm6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:42:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1UQR8p-0007a2-Ty
	for backports@vger.kernel.org; Fri, 12 Apr 2013 01:42:56 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Subject: [RFC/WIP 00/24] backports: disentangle header file mess
Date: Fri, 12 Apr 2013 01:42:27 +0200
Message-Id: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014300_855740_7E6FD345)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

As we were discussing, let's disentangle the header file mess
and the various random includes all over the place and instead
provide each header file that needs something backported with
those backported things and and #include_next.

The list.h stuff was a bit tricky, but not really a big issue
thanks to Hauke's idea.

I'm also removing compatibility with < 2.6.24 ... it just doesn't
seem worth it any more.

Up until patch 22 it passes ckmake --allyesconfig, but then after
that I haven't tried and clearly with patch 24 it won't, that one
can only work for kernels 3.5 and up or so since not all of the
compat headers are dissolved yet.

One of the nice things is that we can get rid of the pr_fmt mess,
that's a huge patch removal. But overall, this is also nicer as
it will better replicate the include structure of the kernel.

johannes

