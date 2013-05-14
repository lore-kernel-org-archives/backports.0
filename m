Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:50297 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330Ab3ENHcb (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 May 2013 03:32:31 -0400
Message-ID: <1368516745.12858.0.camel@jlt4.sipsolutions.net> (sfid-20130514_093243_627015_3B0A8C57)
Subject: Re: [PATCH 01/12] backports: make compat module use
 subsys_initcall()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Paul Stewart <pstew@chromium.org>
Date: Tue, 14 May 2013 09:32:25 +0200
In-Reply-To: <CAB=NE6U=rTR2ZKXexPDeyv6VBi8k74wpj5f6SnS3rxQHaDwB0A@mail.gmail.com> (sfid-20130514_083544_822603_18C952B3)
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com>
	 <1368446524.8300.22.camel@jlt4.sipsolutions.net>
	 <CAB=NE6U1VbZTogeXVmwFN8WxHCHcWN+Ofn5SwiW1ceg2V3ujdQ@mail.gmail.com>
	 <1368512752.8252.3.camel@jlt4.sipsolutions.net>
	 <CAB=NE6U=rTR2ZKXexPDeyv6VBi8k74wpj5f6SnS3rxQHaDwB0A@mail.gmail.com>
	 (sfid-20130514_083544_822603_18C952B3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-13 at 23:35 -0700, Luis R. Rodriguez wrote:
> On Mon, May 13, 2013 at 11:25 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > why not just keep module_exit()?
> 
> Sure.

This one works, applied. In fact it makes no difference in code
generation at all, as I thought.

johannes

