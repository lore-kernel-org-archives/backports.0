Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:57659 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3EMKF0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 06:05:26 -0400
Received: by mail-la0-f41.google.com with SMTP id lx15so3496747lab.0
        for <backports@vger.kernel.org>; Mon, 13 May 2013 03:05:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368438795.8300.15.camel@jlt4.sipsolutions.net>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
 <1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com>
 <CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
 <CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com>
 <CANq1E4RXkYU=PNd-acNT-cp1ARQPR6-2Rq-a8eJGseSbRLCLxg@mail.gmail.com>
 <CAB=NE6WyvXSUS2PUNFktBVUn4u0rcVwXGQ1sYDbL34d8iU2RYw@mail.gmail.com>
 <CAB=NE6V0CywQoS0Xn5Xc2-biWeU34HGr7k9F2g+7+0wMZNCNFg@mail.gmail.com> <1368438795.8300.15.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 13 May 2013 03:05:03 -0700
Message-ID: <CAB=NE6WKOqAM3Zj+S7U3y=j7Kjosq5ef=zcOksc=SYZFfSW5Nw@mail.gmail.com> (sfid-20130513_120532_614532_C651063F)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp session-management
To: Johannes Berg <johannes@sipsolutions.net>
Cc: David Herrmann <dh.herrmann@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, May 13, 2013 at 2:53 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Sun, 2013-05-12 at 19:36 -0700, Luis R. Rodriguez wrote:
>
>> >> The net/bluetooth/hidp/core.c file is attached. It is from the tarball
>> >> you created above (2013-04-26). I fixed some other small issues.
>> >
>> > Nice, can you provide me a Signed-off-by tag ? With it I'd just amend
>> > it to my commit provided everything compiles fine.
>
> You're going to send a new version of patch 11 then?

Sure, sent.

  Luis
