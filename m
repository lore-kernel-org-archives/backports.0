Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:63461 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543AbaDGRTz (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 13:19:55 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so5119652lbj.31
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 10:19:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396866692.6270.0.camel@jlt4.sipsolutions.net>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
 <1396701662-15165-27-git-send-email-mcgrof@do-not-panic.com> <1396866692.6270.0.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 7 Apr 2014 10:19:33 -0700
Message-ID: <CAB=NE6VWRcVwMjWJEJNVfHCuEwvA94u4p-W+JHEXOU74MtLtSA@mail.gmail.com> (sfid-20140407_192007_750045_1196791C)
Subject: Re: [PATCH 26/27] backports: convert threaded IRQ suport into an SmPL patch
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 7, 2014 at 3:31 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Sat, 2014-04-05 at 05:41 -0700, Luis R. Rodriguez wrote:
>
>> ++ret = compat_request_threaded_irq(&private->irq_compat,
>
> Whhy not go to backport namespace too?

Sure, how about as a second patch?

  Luis
