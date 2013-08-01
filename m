Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:53352 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3HAToF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 15:44:05 -0400
Received: by mail-la0-f48.google.com with SMTP id hi8so1729468lab.35
        for <backports@vger.kernel.org>; Thu, 01 Aug 2013 12:44:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <007b01ce8eee$cca32e50$65e98af0$@gmail.com>
References: <000d01ce8e07$80a36430$81ea2c90$@gmail.com> <CAB=NE6WLPxLpGWOP6fj_FEWk_AA4Tz7UQay1tPxsMJfquRnSmg@mail.gmail.com>
 <007b01ce8eee$cca32e50$65e98af0$@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 1 Aug 2013 12:43:43 -0700
Message-ID: <CAB=NE6Xg_MHwZAaZHHkL841BHJxFzEeu2oMZJdXpqYoGSHjSgQ@mail.gmail.com> (sfid-20130801_214407_953270_876B32B8)
Subject: Re: Bug with the website: links are broken
To: Chris R <chrisrfq@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 1, 2013 at 12:39 PM, Chris R <chrisrfq@gmail.com> wrote:
>> Its back up...
>
> Thanks very much!
>
>> ...that page has ancient releases, why are you still using them?
>
> I'm stuck at kernel version 2.6.37.

So backports is designed so that you use a backports-3.11 say on
2.6.37. That is you don't have to use a backport-3.10 only on 3.10 in
fact that'd be pointless. We backport functionality from a kernel as a
base and that base is used as the version name for the release.

A few folks have reported misunderstanding this as well so I'm curious
apart from the documentation we have on the wiki [0] what else can we
do to help with this?

[0] https://backports.wiki.kernel.org

  Luis
