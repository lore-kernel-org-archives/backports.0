Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:41928 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbaDGR1A (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 13:27:00 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so5092454lan.16
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 10:26:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396891524.6270.3.camel@jlt4.sipsolutions.net>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
 <1396701662-15165-27-git-send-email-mcgrof@do-not-panic.com>
 <1396866692.6270.0.camel@jlt4.sipsolutions.net> <CAB=NE6VWRcVwMjWJEJNVfHCuEwvA94u4p-W+JHEXOU74MtLtSA@mail.gmail.com>
 <1396891524.6270.3.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 7 Apr 2014 10:26:38 -0700
Message-ID: <CAB=NE6XQzqs5MfyAj8eUZm4n5ahTwCij3Cd+uCJoKS=28DfoqA@mail.gmail.com> (sfid-20140407_192702_124132_EE23BD09)
Subject: Re: [PATCH 26/27] backports: convert threaded IRQ suport into an SmPL patch
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 7, 2014 at 10:25 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Mon, 2014-04-07 at 10:19 -0700, Luis R. Rodriguez wrote:
>> On Mon, Apr 7, 2014 at 3:31 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
>> > On Sat, 2014-04-05 at 05:41 -0700, Luis R. Rodriguez wrote:
>> >
>> >> ++ret = compat_request_threaded_irq(&private->irq_compat,
>> >
>> > Whhy not go to backport namespace too?
>>
>> Sure, how about as a second patch?
>
> Sure, I was just wondering if there was a particular reason you didn't
> while you rewrote the whole thing anyway.

Well this patch didn't touch the header files, just the usage, that's all.

  Luis
