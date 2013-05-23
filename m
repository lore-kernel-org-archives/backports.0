Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:49153 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3EWAiF (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 20:38:05 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so2640852lab.13
        for <backports@vger.kernel.org>; Wed, 22 May 2013 17:38:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369224306.8207.7.camel@jlt4.sipsolutions.net>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com> <1369224306.8207.7.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 22 May 2013 17:37:42 -0700
Message-ID: <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com> (sfid-20130523_023807_543343_5F45C44D)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 22, 2013 at 5:05 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> This cleans sanitizes a source tree and ensures
>> no content is present from what was intended.
>
> All of this (including the previous patches) makes me think
> "--git-revision HEAD" should just be the default instead of trying to
> muck with the working directory of the kernel tree too much?

Not sure I follow, but in any case, I just want to start being able to
start making daily releases daily and fast, can we address this later?

  Luis
