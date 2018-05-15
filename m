Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:37941 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOWUA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 15 May 2018 18:20:00 -0400
Received: by mail-it0-f65.google.com with SMTP id q4-v6so5954605ite.3
        for <backports@vger.kernel.org>; Tue, 15 May 2018 15:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com>
 <1526414646.4450.13.camel@sipsolutions.net> <CAF_dkJDB077igL5AiySBXo_aam=8wozCg=-Rc-9=7qMqFd4kKA@mail.gmail.com>
 <1526416237.4450.17.camel@sipsolutions.net>
In-Reply-To: <1526416237.4450.17.camel@sipsolutions.net>
From: Steve deRosier <derosier@gmail.com>
Date: Tue, 15 May 2018 15:19:22 -0700
Message-ID: <CALLGbRL915L0uTyJnhD7eQFy2aBgQzRQMW_XiLgfypmbW-sHvw@mail.gmail.com> (sfid-20180516_002002_694128_E8A8C174)
Subject: Re: How to use backports?
To: Johannes Berg <johannes@sipsolutions.net>
Cc: wpdster@gmail.com, backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 15, 2018 at 1:31 PM Johannes Berg <johannes@sipsolutions.net>
wrote:
> > If folks don't tend to use this tool on Ubuntu LTS releases, what
> > version of Linux do you use it on?  What is known to work?

> I usually use one of Debian/testing or Fedora (currently F27 while I
> wait for some things I can't upgrade).

> We do run it one some kind of Ubuntu LTS at work, but I suspect they
> also installed spatch by hand, no idea how though.


I usually run Ubuntu LTS (server, not desktop) for most of my Linux build
systems. Like Johannes mentioned, I build coccinelle from source.  While
I'm aware of the >= 1.0.6 patch that went in a few days ago, I haven't
built with anything that modern yet. Fact is, since changing jobs recently,
I'm not using backports as much as I used to since I'm stuck working on a
vendor driver.

Anyway, sorry I'm not that much help - I just wanted to answer your "does
anyone use Ubuntu for backports building" question.  Answer is yes, it's
possible to do so.

- Steve
--
To unsubscribe from this list: send the line "unsubscribe backports" in
