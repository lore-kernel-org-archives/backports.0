Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:42872 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753164AbdC2IwP (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 29 Mar 2017 04:52:15 -0400
Message-ID: <1490777532.7948.15.camel@sipsolutions.net> (sfid-20170329_105543_346370_0C07DAE7)
Subject: Re: Question of backports
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=90=B3=E9=87=8D=E6=AF=85?= <uranus0206@gmail.com>,
        backports@vger.kernel.org
Date: Wed, 29 Mar 2017 10:52:12 +0200
In-Reply-To: <CAN+BLYH=tkxSxJSv995+n83Zon0kqweNb6X8nWeKuLFtCepSmQ@mail.gmail.com> (sfid-20170324_113721_904132_74122683)
References: <CAN+BLYH=tkxSxJSv995+n83Zon0kqweNb6X8nWeKuLFtCepSmQ@mail.gmail.com>
         (sfid-20170324_113721_904132_74122683)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-03-24 at 18:36 +0800, 吳重毅 wrote:
> Hi:
> I am confuse with backports' parameter. First i found the mail list
> of
> http://lists.infradead.org/pipermail/ath10k/2017-March/009458.html
> And i follow the attachment to patch backports' git.
> I am success full create the backports-output, but some parameters
> confused me.
> The parameter "--git-revision next-20170310". Is it says i am using
> tag next-20170310 of source linux-next?
> Currently my git of backports is point at master.
> When i use the command in maillist to generate backport-output.
> What target of kernel version am i going to backport to ?
> kernel of tag next-20170310(linux-next) to which kernel version?
> If my backports git is point at tag v4.4.2 and --git-version is point
> at v4.11. Can i say i am backporting from 4.11 to 4.4.2?

--git-revision is for the kernel source you want to use.

backports has its own tagging/branching, intended to match the *source*
kernel.

the *target* kernel, the one you compile against, shouldn't matter at
all and support (roughly) 3.0-current.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
