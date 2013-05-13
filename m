Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:46728 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab3EMJxV (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 05:53:21 -0400
Message-ID: <1368438795.8300.15.camel@jlt4.sipsolutions.net> (sfid-20130513_115323_429313_4C3365A4)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp
 session-management
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: David Herrmann <dh.herrmann@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 13 May 2013 11:53:15 +0200
In-Reply-To: <CAB=NE6V0CywQoS0Xn5Xc2-biWeU34HGr7k9F2g+7+0wMZNCNFg@mail.gmail.com> (sfid-20130513_043647_119351_DD4C5694)
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com>
	 <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
	 <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com>
	 <CANq1E4RXkYU=PNd-acNT-cp1ARQPR6-2Rq-a8eJGseSbRLCLxg@mail.gmail.com>
	 <CAB=NE6WyvXSUS2PUNFktBVUn4u0rcVwXGQ1sYDbL34d8iU2RYw@mail.gmail.com>
	 <CAB=NE6V0CywQoS0Xn5Xc2-biWeU34HGr7k9F2g+7+0wMZNCNFg@mail.gmail.com>
	 (sfid-20130513_043647_119351_DD4C5694)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-05-12 at 19:36 -0700, Luis R. Rodriguez wrote:

> >> The net/bluetooth/hidp/core.c file is attached. It is from the tarball
> >> you created above (2013-04-26). I fixed some other small issues.
> >
> > Nice, can you provide me a Signed-off-by tag ? With it I'd just amend
> > it to my commit provided everything compiles fine.

You're going to send a new version of patch 11 then?

johannes

