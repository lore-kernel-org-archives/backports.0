Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45380 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3EHIuS (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 04:50:18 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so1661686lbh.20
        for <backports@vger.kernel.org>; Wed, 08 May 2013 01:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367996357.8279.8.camel@jlt4.sipsolutions.net>
References: <1367925800-18555-1-git-send-email-mcgrof@do-not-panic.com>
 <1367925800-18555-2-git-send-email-mcgrof@do-not-panic.com>
 <1367929330.8328.4.camel@jlt4.sipsolutions.net> <CAB=NE6VEzLRPumquo-2MnJ3txvAUKsWQfSh3y9wuYOh1ds-keg@mail.gmail.com>
 <CAB=NE6WXt0eyO3UAV_utFtZmFuPRM-2cRx3nufwKv=w6wST9sg@mail.gmail.com> <1367996357.8279.8.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 8 May 2013 01:49:56 -0700
Message-ID: <CAB=NE6XCh79O3FK+422zft9WoSd=FmuugPkdA6C2Qk6bmtuobw@mail.gmail.com> (sfid-20130508_105021_074986_A159ED80)
Subject: Re: [PATCH 2/2] backports: refresh patches for next-20130403
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 7, 2013 at 11:59 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2013-05-07 at 15:21 -0700, Luis R. Rodriguez wrote:
>> On Tue, May 7, 2013 at 12:25 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>> > On Tue, May 7, 2013 at 5:22 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
>> >> Did you mean next-20130503? I was already on next-20130405.
>> >
>> > Sorry it seems I was behind you so that's good. I'll jump to next-20130405.
>>
>> Well so this is odd, with next-20130405 I get:
>>
>> == ckmake-report.log ==
>>
>> 1   2.6.24              [  FAIL  ]
>
> Odd. I was almost certain I had done this, but I guess I didn't or
> something. Sorry.

Cosmic rays or new driver that didn't meet your config.

 Luis
