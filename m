Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:59804 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759749Ab3DBKvF (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 06:51:05 -0400
Message-ID: <1364899857.8204.2.camel@jlt4.sipsolutions.net> (sfid-20130402_125108_557037_52EBCF97)
Subject: Re: [PATCH] compat: backport kernel dma-buf implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, sumit.semwal@linaro.org,
	rob.clark@linaro.org
Date: Tue, 02 Apr 2013 12:50:57 +0200
In-Reply-To: <CAB=NE6XuzPq+JOWRLH=VPZ+MvX0T37ZNeYB3bduTEivECoio9Q@mail.gmail.com> (sfid-20130402_122544_068110_BC928AE1)
References: <1364865614-31844-1-git-send-email-mcgrof@do-not-panic.com>
	 <1364888940.8204.1.camel@jlt4.sipsolutions.net>
	 <CAB=NE6XuzPq+JOWRLH=VPZ+MvX0T37ZNeYB3bduTEivECoio9Q@mail.gmail.com>
	 (sfid-20130402_122544_068110_BC928AE1)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-04-02 at 03:25 -0700, Luis R. Rodriguez wrote:

> Did you see the usage of LINUX_BACKPORT() on the header file? That
> would rename the exported symbols, and the header we carry makes sure
> the kernel's original is not used, that means that our DRM code would
> use our backport_*() symbols instead. Not sure, perhaps I'm missing
> something?

Ah no, I missed that, sorry.

johannes

