Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:46720 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab3FZQuU (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 26 Jun 2013 12:50:20 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so14050727lab.13
        for <backports@vger.kernel.org>; Wed, 26 Jun 2013 09:50:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJqaZwzigpvYhzw2i1b9exxXq9RE7KnMY8CzY_k1d1tYR=u1kA@mail.gmail.com>
References: <CAJqaZwyOqP+2x7tfzd5Q=Ugt4c3Zn-JU_pjOH-6ypqpWdS--hg@mail.gmail.com>
 <CAB=NE6X17uSMo7B_Gf9uTBn4be45HBupvqwXfZHfiOrVxicF=A@mail.gmail.com>
 <CAJqaZwxoKwwXX2ROh2XZ113Fbi+7GO_qnM03ZYvnoGmCBVdXNQ@mail.gmail.com> <CAJqaZwzigpvYhzw2i1b9exxXq9RE7KnMY8CzY_k1d1tYR=u1kA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 26 Jun 2013 09:49:56 -0700
Message-ID: <CAB=NE6VhhkRSkXRc1sYDkMXThYi9GDOa8JjRUVu=SgELUdDuQg@mail.gmail.com> (sfid-20130626_185023_240642_C12FFFDD)
Subject: Re: [PATCH v3] backports: re-introduce make uninstall
To: ASIC Felix <ic.felix@gmail.com>
Cc: do-not <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jun 20, 2013 at 10:02 PM, ASIC Felix <ic.felix@gmail.com> wrote:
> Signed-off-by: Felix Bitterli <ic.felix@gmail.com>

Great! I just adjusted the commit log with this below, applied and
pushed! Thanks!

    This approach only uninstalls modules you have built
    previously on your current build directory for backports.
    If this requires adjustments then we'll have to just have
    to use our own new backports KMODDIR.

  Luis
