Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36813 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbbE2HAj (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 29 May 2015 03:00:39 -0400
Message-ID: <1432882836.2104.1.camel@sipsolutions.net> (sfid-20150529_090040_772261_8AB015ED)
Subject: Re: Uses of Linux backports in the industry
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 29 May 2015 09:00:36 +0200
In-Reply-To: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com> (sfid-20150529_045521_094351_3FF15D30)
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
	 (sfid-20150529_045521_094351_3FF15D30)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

-lkml, that list is overfull anyway ...

On Thu, 2015-05-28 at 19:54 -0700, Luis R. Rodriguez wrote:
> Me and Julia are working on a paper which evaluates use of Coccinelle
> on backports, a preliminary draft of such paper can be found on github
> [0]. We are making some tweaks to this, one of which is covering the
> uses of Linux backports [1] in the industry, for this we'd like to try
> to get feedback as to where and how folks are using backports. Please
> let me and Julia know -- or if the information is not sensitive please
> feel free to just reply to this thread and share with others. All
> feedback is greatly appreciated. If you are OK in having us list or
> generalize your usage please indicate so.

We've just published one of our internal git trees that is actually
based on backports:
https://git.kernel.org/cgit/linux/kernel/git/iwlwifi/backport-iwlwifi.git/

johannes

