Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35318 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbDQSDn (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 Apr 2015 14:03:43 -0400
Received: by igbyr2 with SMTP id yr2so18246400igb.0
        for <backports@vger.kernel.org>; Fri, 17 Apr 2015 11:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1429291720.1885.5.camel@sipsolutions.net>
References: <20150417133004.GC16380@vorel-pc> <5531314D.1000706@lwfinger.net> <1429291720.1885.5.camel@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 17 Apr 2015 11:03:22 -0700
Message-ID: <CAB=NE6X=-PQR3=uxmHZL+Jf8muX6QmmTjKkBnKXUWDk1Bkeccw@mail.gmail.com> (sfid-20150417_200345_537662_DA1414AC)
Subject: Re: Possible to build-in backports modules into kernel
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Petr Vorel <petr.vorel@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 17, 2015 at 10:28 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Technically this is not true any more - the backports gentree.py script
> now supports kernel integration where it copies the backport into
> another kernel tree :)

Indeed:

https://backports.wiki.kernel.org/index.php/Documentation/integration

 Luis
