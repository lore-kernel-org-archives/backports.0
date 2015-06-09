Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34679 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932294AbbFIWXP (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 18:23:15 -0400
Received: by iebmu5 with SMTP id mu5so22830994ieb.1
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 15:23:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VEd=tVfhWWheCWpOVd-kUNdQnivW-e8Jr=aPZq1iY7tg@mail.gmail.com>
References: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com>
 <1433795473.10172.3.camel@sipsolutions.net> <CAB=NE6W68eikvWE+YKKSUC3_S_pTLY-cJq5hGeRkKp2mx9dRMA@mail.gmail.com>
 <1433831373.1892.0.camel@sipsolutions.net> <CAB=NE6VEd=tVfhWWheCWpOVd-kUNdQnivW-e8Jr=aPZq1iY7tg@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Jun 2015 15:22:54 -0700
Message-ID: <CAB=NE6UgLUgDecjr0PomjgJnw03H0i4qeAcEbZxQZ7y7HOEvJA@mail.gmail.com> (sfid-20150610_002327_252937_8B96D257)
Subject: Re: [PATCH] pycocci: sync pycocci with Coccinelle upstream
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 9, 2015 at 3:20 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Mon, Jun 8, 2015 at 11:29 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>> On Mon, 2015-06-08 at 13:43 -0700, Luis R. Rodriguez wrote:
>>> On Mon, Jun 8, 2015 at 1:31 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
>>> > On Mon, 2015-06-08 at 13:01 -0700, Luis R. Rodriguez wrote:
>>> >> pycocci is now part of Coccinelle upstream. Coccinelle has a plan
>>> >> to actually extend multithreaded support to enable us to not have
>>> >> to script this out. Until then pyccoci is used and I'll sync both
>>> >> solutions up as there is a bit of latency between a coccinelle release
>>> >> and what we may need from pycocci.
>>> >
>>> > If it's upstream, do they ship it? If so it wouldn't be needed that we
>>> > have a copy, it seems?
>>>
>>> Indeed, Coccinelle 1.0 has pycocci except for this last patch I just
>>> mentioned. I think it is important enough for our sake that the errors
>>> are reported well, I think its fair to drop this in backports once
>>> Coccinelle 1.1 is released and we can reasonably expect users to have
>>> it installed.
>>
>> Not sure I see the point in applying it now - clearly we haven't had any
>> issues here that required this change, so why bother?
>
> Well, I had issues with it :P its why I fixed it.

Coccinelle now supports -j option so after proper testing we should
just remove pycocci now.

 Luis
