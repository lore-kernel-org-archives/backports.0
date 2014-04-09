Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:63329 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847AbaDISVv (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Apr 2014 14:21:51 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so1445071lab.4
        for <backports@vger.kernel.org>; Wed, 09 Apr 2014 11:21:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397044495.4964.5.camel@jlt4.sipsolutions.net>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6VzqUpt+SpuW8vB0HWmces8EMJpQr-L8RyG3P76WfAtUA@mail.gmail.com>
 <CAB=NE6Ut3YLiY_NhGJyVeS2ePiQyMuppDJ+1LjS_XFj=FBTBvQ@mail.gmail.com> <1397044495.4964.5.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 9 Apr 2014 11:21:30 -0700
Message-ID: <CAB=NE6USQiJdEQbwVbVM9b3q7euWdc802zSJKK7z5G5+DBSrNg@mail.gmail.com> (sfid-20140409_202153_932597_7DCA3FA1)
Subject: Re: [PATCH 00/12] backports: cath up to next-20140320
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 9, 2014 at 4:54 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Tue, 2014-04-08 at 18:26 -0700, Luis R. Rodriguez wrote:
>> On Tue, Apr 8, 2014 at 6:20 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>> >
>> > OK I had to address just one more change which I just posted. Since it
>> > compiles fine I'm going to push now. Tomorrow is release day.
>>
>> Alright, all pushed out. Please fetch.
>
> Can you clarify which tree you're using now? It seems you're updating
> mcgrof/backports.git but I thought the intent was to switch over to
> backports/backports.git so you can share maintenance with Hauke...

Yeap sorry just pushed onto the shared repo. The canonical repo therefore is:

git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

  Luis
