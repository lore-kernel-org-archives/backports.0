Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60070 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3DJNWX (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:22:23 -0400
Message-ID: <1365600139.4235.4.camel@jlt4.sipsolutions.net> (sfid-20130410_152224_914982_7C4A5BC0)
Subject: Re: [PATCH 06/18] compat: backport ASYNC_DOMAIN_EXCLUSIVE()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:22:19 +0200
In-Reply-To: <1365593728-5720-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133605_827300_72FBDC00)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-7-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133605_827300_72FBDC00)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> For older kernels this is simply a matter of using
> LIST_HEAD.

Hmm, how is that useful if it will not have any effect?

johannes

