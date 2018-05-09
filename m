Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36559 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932701AbeEIOTn (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 10:19:43 -0400
Received: by mail-it0-f66.google.com with SMTP id e20-v6so20812091itc.1
        for <backports@vger.kernel.org>; Wed, 09 May 2018 07:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net> <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
 <1525770503.14830.2.camel@sipsolutions.net> <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
 <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com> <1525850665.6910.0.camel@sipsolutions.net>
 <1525852495.6910.2.camel@sipsolutions.net> <2f59e893-da45-f3e7-430b-1377518727bb@gmail.com>
 <1525853548.6910.3.camel@sipsolutions.net> <d54cd7c5-fb33-59dc-afd0-d48f36a7a06d@gmail.com>
 <1525856616.6910.7.camel@sipsolutions.net> <ba98f466-b6c0-4498-0597-57174b4f7fe5@gmail.com>
 <1525857931.6910.8.camel@sipsolutions.net>
In-Reply-To: <1525857931.6910.8.camel@sipsolutions.net>
From: Steve deRosier <derosier@gmail.com>
Date: Wed, 09 May 2018 14:19:04 +0000
Message-ID: <CALLGbR+20QS3dpG0xMae+4gtw4osdaucT0OYj_6qj3TMKtp6ag@mail.gmail.com> (sfid-20180509_161950_124999_7F112BEE)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
To: Johannes Berg <johannes@sipsolutions.net>
Cc: masashi.honma@gmail.com, backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 9, 2018 at 2:25 AM Johannes Berg <johannes@sipsolutions.net>
wrote:

> On Wed, 2018-05-09 at 18:24 +0900, Masashi Honma wrote:
> > On 2018/05/09 18:03, Johannes Berg wrote:
> > > We could also cherry-pick my trivial patch to the older branches I
> > > guess. That'd still be simpler?
> >
> > Oh, you already have a plan.
> > Then drop my plan.

> Well, I wasn't really planning on doing it, but I could? :)

> I guess it's easy enough though.


That'd be my vote.

I haven't looked at the docs in a long time - do we note a minimum required
version of coccinelle?

- Steve
--
To unsubscribe from this list: send the line "unsubscribe backports" in
