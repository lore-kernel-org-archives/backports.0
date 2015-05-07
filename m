Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:35571 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbbEGLsq (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 May 2015 07:48:46 -0400
Message-ID: <1430999320.11214.0.camel@sipsolutions.net> (sfid-20150507_134847_773087_3749A601)
Subject: Re: problem with enabling config options
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 07 May 2015 13:48:40 +0200
In-Reply-To: <554B4966.5090808@kpanic.de> (sfid-20150507_131558_070018_C564096D)
References: <554B4966.5090808@kpanic.de>
	 (sfid-20150507_131558_070018_C564096D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2015-05-07 at 13:15 +0200, Stefan Assmann wrote:
> I'm looking into enabling more wired network drivers and ran into the
> issue that I could not enable CONFIG_E1000 for example. The problem
> seems to be that because CONFIG_E100 is disabled you cannot enable
> anything CONFIG_E100*. It looks like a bug in gentree.py, but my python
> foo didn't suffice to get it sorted out. Problem should be located
> somewhere around line 1060 where the CONFIG variable regex stuff
> happens.

I think you can try to add \W to the very end of the regex there.

johannes

