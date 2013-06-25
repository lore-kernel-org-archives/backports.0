Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:39353 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3FYH5F (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 25 Jun 2013 03:57:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1UrO7Y-0005kP-01
	for backports@vger.kernel.org; Tue, 25 Jun 2013 09:57:00 +0200
Message-ID: <1372147016.8372.0.camel@jlt4.sipsolutions.net> (sfid-20130625_095707_368228_C5CE37C5)
Subject: Re: [PATCH] backports: update output template .gitignore for
 kconfig move
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 25 Jun 2013 09:56:56 +0200
In-Reply-To: <1369858414-4066-1-git-send-email-johannes@sipsolutions.net> (sfid-20130529_221341_963629_4BC3E537)
References: <1369858414-4066-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130529_221341_963629_4BC3E537)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-29 at 22:13 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> I clearly forgot this during the Kconfig move, the .gitignore
> that is in the output template directory (and used with the
> git-tracker) needs to be updated for the kconf directory move.

Luis, any reason you haven't applied this?

johannes

