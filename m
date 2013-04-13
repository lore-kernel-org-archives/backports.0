Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44208 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab3DMXyI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:08 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1URAGl-0003nu-3w
	for backports@vger.kernel.org; Sun, 14 Apr 2013 01:54:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Subject: [RFC/RFT 00/42] explode header files
Date: Sun, 14 Apr 2013 01:53:20 +0200
Message-Id: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015412_493914_07CF2B64)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

As we discussed recently, it's better to explode our backport
header files into the names that the kernel uses instead of
pre-including half the world from the gcc command line. Doing
so is obviously a lot of work and can't really be done in a
way that would continue working inbetween the patch series,
so I'm doing it per kernel version (or rather compat-x.y.z
header.)

Before I rebased onto the media drivers this was pretty much
passing ckmake --allyesconfig, now minor issues could have
come up that I need to solve, but generally this should be
fine. I did solve the issues that I saw in ckmake before.

johannes

