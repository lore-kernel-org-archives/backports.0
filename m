Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:42400 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991Ab3HAUsF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 16:48:05 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so1777265lab.13
        for <backports@vger.kernel.org>; Thu, 01 Aug 2013 13:48:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51FAC2EF.8080402@hauke-m.de>
References: <000d01ce8e07$80a36430$81ea2c90$@gmail.com> <CAB=NE6WLPxLpGWOP6fj_FEWk_AA4Tz7UQay1tPxsMJfquRnSmg@mail.gmail.com>
 <007b01ce8eee$cca32e50$65e98af0$@gmail.com> <CAB=NE6Xg_MHwZAaZHHkL841BHJxFzEeu2oMZJdXpqYoGSHjSgQ@mail.gmail.com>
 <51FAC2EF.8080402@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 1 Aug 2013 13:47:43 -0700
Message-ID: <CAB=NE6XetLDnDSVmkWioNN4RCniqmmpdgSy+oPhAhjcAyhZ3aA@mail.gmail.com> (sfid-20130801_224807_760764_ECEFFA8B)
Subject: Re: Bug with the website: links are broken
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris R <chrisrfq@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 1, 2013 at 1:19 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Users do not read any documentation. ;-)
> I added it to multiple places in the wiki and still there are people in
> the IRC with such problems.
>
> We should make it fail if kernel version > backports version and we
> should also take the minor version into account. If the major version is
> the same we should print a big warning.

I like the idea :D

  Luis
