Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36297 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbaJ2ICb (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Oct 2014 04:02:31 -0400
Message-ID: <1414569744.1827.0.camel@jlt4.sipsolutions.net> (sfid-20141029_090236_109541_5480F150)
Subject: Re: failure to build backports on ubuntu
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 29 Oct 2014 09:02:24 +0100
In-Reply-To: <CAB=NE6Wh=yhFnxbsTwKun2t8SCbatHYGNYb95sk5ro9qdVGn3A@mail.gmail.com> (sfid-20141028_212131_516929_4FA8FF11)
References: <0BA3FCBA62E2DC44AF3030971E174FB31B55873E@hasmsx107.ger.corp.intel.com>
	 <CAB=NE6XBgHMNyLLS3wwYUh70sugbY0+YrKoBckk5O-tXF68t4Q@mail.gmail.com>
	 <0BA3FCBA62E2DC44AF3030971E174FB31B5587F6@hasmsx107.ger.corp.intel.com>
	 <CAB=NE6Wh=yhFnxbsTwKun2t8SCbatHYGNYb95sk5ro9qdVGn3A@mail.gmail.com>
	 (sfid-20141028_212131_516929_4FA8FF11)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-10-28 at 13:21 -0700, Luis R. Rodriguez wrote:

> The kernel solution to this uses an internal kernel variables to
> prefix flags for the linker,

Can't we just figure out how the kernel derives that variable and do the
same?

After all, the kernel doesn't do magic ... not more than we do in
backports anyway :)

johannes

