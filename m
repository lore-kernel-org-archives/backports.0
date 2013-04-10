Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60055 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab3DJNSY (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:18:24 -0400
Message-ID: <1365599899.8388.17.camel@jlt4.sipsolutions.net> (sfid-20130410_151826_630687_182DA00C)
Subject: Re: [PATCH 05/18] compat: backport GPIOF_OPEN_DRAIN definition
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:18:19 +0200
In-Reply-To: <1365593728-5720-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133601_535265_2A22A3FA)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-6-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133601_535265_2A22A3FA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This functionality will just be ignored, later we'll
> just port the full gpiolib.

That seems a bit dangerous? If the driver expects to be able to set the
pin this way, do we really want to stop it?

johannes

