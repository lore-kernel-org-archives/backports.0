Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39755 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882AbbE2Sr7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 29 May 2015 14:47:59 -0400
Message-ID: <1432925275.16701.1.camel@sipsolutions.net> (sfid-20150529_204801_447943_F2BB98C6)
Subject: Re: Uses of Linux backports in the industry
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 29 May 2015 20:47:55 +0200
In-Reply-To: <CAB=NE6UZBmYLEEXHMTt7WJt7ZKiDAE1LUDwkf13Gb43RbwzNYw@mail.gmail.com> (sfid-20150529_183351_026211_667B5D27)
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
	 <1432882836.2104.1.camel@sipsolutions.net>
	 <CAB=NE6UZBmYLEEXHMTt7WJt7ZKiDAE1LUDwkf13Gb43RbwzNYw@mail.gmail.com>
	 (sfid-20150529_183351_026211_667B5D27)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-05-29 at 09:33 -0700, Luis R. Rodriguez wrote:

> > We've just published one of our internal git trees that is actually
> > based on backports:
> > https://git.kernel.org/cgit/linux/kernel/git/iwlwifi/backport-iwlwifi.git/
> 
> Great thanks! Any chance you can elaborate a bit on how its used? Some
> verbiage we can use perhaps to explain, in the context from silicon
> manufacturing / testing / production, etc.

Err, it's just a driver. Everything you need a driver for, you use this.

johannes

