Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45943 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeEPNZ3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 16 May 2018 09:25:29 -0400
Received: by mail-ot0-f194.google.com with SMTP id 15-v6so843912otn.12
        for <backports@vger.kernel.org>; Wed, 16 May 2018 06:25:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALLGbRL915L0uTyJnhD7eQFy2aBgQzRQMW_XiLgfypmbW-sHvw@mail.gmail.com>
References: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com>
 <1526414646.4450.13.camel@sipsolutions.net> <CAF_dkJDB077igL5AiySBXo_aam=8wozCg=-Rc-9=7qMqFd4kKA@mail.gmail.com>
 <1526416237.4450.17.camel@sipsolutions.net> <CALLGbRL915L0uTyJnhD7eQFy2aBgQzRQMW_XiLgfypmbW-sHvw@mail.gmail.com>
From: Patrick Doyle <wpdster@gmail.com>
Date: Wed, 16 May 2018 09:24:58 -0400
Message-ID: <CAF_dkJAe8m+BibjxQuTgapHCZAG436x8g+UPRkr7ra44-xccXg@mail.gmail.com> (sfid-20180516_152531_664595_3D0F3DCD)
Subject: Re: How to use backports?
To: Steve deRosier <derosier@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 15, 2018 at 6:19 PM, Steve deRosier <derosier@gmail.com> wrote:
> On Tue, May 15, 2018 at 1:31 PM Johannes Berg <johannes@sipsolutions.net>
> wrote:
> I usually run Ubuntu LTS (server, not desktop) for most of my Linux build
> systems. Like Johannes mentioned, I build coccinelle from source.  While
> I'm aware of the >= 1.0.6 patch that went in a few days ago, I haven't
> built with anything that modern yet. Fact is, since changing jobs recently,
> I'm not using backports as much as I used to since I'm stuck working on a
> vendor driver.
>
> Anyway, sorry I'm not that much help - I just wanted to answer your "does
> anyone use Ubuntu for backports building" question.  Answer is yes, it's
> possible to do so.
Thanks Steve.  That is a help.
I was just trying to decide if I should return from interrupt, or
declare a fault :-)

When too many things started going wrong (didn't have coccinelle
installed, have never heard of it, have no idea what it is, apt-get
installed it, was informed it was too old, git cloned it, installed
dependencies for building it, found that it would not compile, even
with the dependencies installed), the "too hard" LED came on and I
figured I should ask some questions.  I'll go find somebody I can ask
about compiling coccinelle (whatever that is) on Ubuntu 16.04, figure
out what's going on there, and return from interrupt now.

Then I'll either figure out what's going on with the --integrate flag
in backports, or decide to live with a loadable module.

Thanks for the help.

--wpd
--
To unsubscribe from this list: send the line "unsubscribe backports" in
