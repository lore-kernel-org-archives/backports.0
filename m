Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60111 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758741Ab3DJNnY (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:43:24 -0400
Message-ID: <1365601400.4235.14.camel@jlt4.sipsolutions.net> (sfid-20130410_154328_179777_99056F8D)
Subject: Re: [PATCH 15/18] backports: add check_depmod to look for module
 search path
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:43:20 +0200
In-Reply-To: <1365593728-5720-16-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133704_904616_FC5B3BFD)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-16-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133704_904616_FC5B3BFD)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This backports project relies on you being able to update
> your Linux distribution modules by looking at an updates
> search path, if one is not found we update depmod to look
> for the new path for you.

Looks good, but I guess it's not going to apply by itself without the
previosu patches.

johannes

