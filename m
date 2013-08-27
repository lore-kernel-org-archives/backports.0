Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:56361 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab3H0TNS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 15:13:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1VEOhZ-0002kk-NT
	for backports@vger.kernel.org; Tue, 27 Aug 2013 21:13:17 +0200
Message-ID: <1377630791.20012.12.camel@jlt4.sipsolutions.net> (sfid-20130827_211320_759206_A8408BC7)
Subject: kernel version management
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 27 Aug 2013 21:13:11 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

So ... I guess I succeeded in killing off 2.6.24 support, but I think we
should talk about when we drop which version?

http://en.wikipedia.org/wiki/Linux_kernel#Maintenance has a handy list
of which version was supported until when, telling us that the oldest
kernel still supported now is 2.6.32.

What do people think? What kernels do you use? How old is "really far
too old to worry about"?

johannes

