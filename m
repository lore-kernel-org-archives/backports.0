Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:49940 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934064Ab3DGRXA (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 7 Apr 2013 13:23:00 -0400
Message-ID: <1365355372.9172.1.camel@jlt4.sipsolutions.net> (sfid-20130407_192304_166156_39659473)
Subject: Re: [PATCH 4/9] compat: backport EPROBE_DEFER value
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Sun, 07 Apr 2013 19:22:52 +0200
In-Reply-To: <1365301322-19327-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042226_233475_AF88C7EE)
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365301322-19327-4-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130407_042226_233475_AF88C7EE)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-04-06 at 19:21 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> Grant added the ability to the driver core to return
> EPROBE_DEFER at device driver probe time and for that to
> trigger a later deferred probe through a workqueue. It
> seems we could in theory backport this functionality but
> that requires quite a bit of work. For now just pass on
> the EPROBE_DEFER definition safely and for older kernels
> than 3.4 the EPROBE_DEFER would be treated as a regular
> probe error.

> +#define EPROBE_DEFER   517     /* Driver requests probe retry */

I'm not convinced this is useful, particularly not with that error
number?

If a driver returns -EPROBE_DEFER it will not work correctly, so why not
just require it to be disabled (via the dependencies list) for kernels
before 3.4?

Also, if you return -517 userspace might get somewhat confused?

johannes

