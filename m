Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:62453 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670AbaJ2Rr5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 Oct 2014 13:47:57 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so3030893lab.28
        for <backports@vger.kernel.org>; Wed, 29 Oct 2014 10:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
References: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 29 Oct 2014 10:47:35 -0700
Message-ID: <CAB=NE6WiR0SnfQxr36wPFnA=xbbJR8-sGFS_kexrAoyt45qvug@mail.gmail.com> (sfid-20141029_184835_728832_0610356B)
Subject: Re: [PATCH] backports: fix mconf compilation on Ubuntu
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Oct 29, 2014 at 12:49 AM, Emmanuel Grumbach
<emmanuel.grumbach@intel.com> wrote:
> Since
>
> commit de427857852e7194b9ae80571425ba0d2c29ef55
> Author: Luis R. Rodriguez <mcgrof@suse.com>
> Date:   Sun Sep 14 06:05:29 2014 -0700
>
>     backports: fix mconf compilation library assumptions
>
> I can't compile mconf on my Ubuntu trusty machine.
> This fixes that by making Luis's patch conditional.
>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
>  backport/kconf/Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
> index dfd793a..8398f35 100644
> --- a/backport/kconf/Makefile
> +++ b/backport/kconf/Makefile
> @@ -3,7 +3,15 @@ CFLAGS=-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer
>  LXDIALOG := lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o
>
>  conf: conf.o zconf.tab.o
> -mconf: LDFLAGS = -Wl,--no-as-needed $(shell ./lxdialog/check-lxdialog.sh -ldflags $(CC))
> +
> +RELEASE=$(shell lsb_release -si)

I think we'll need to have this work for cases where lsb_release does
not exist too. Since you're issue is with gcc 4.8.2 on ubuntu and
since I know gcc 4.8.3 (opensuse) and gcc 4.9.1-15 (debian testing)
works with the solution I provided I say we use the options I
specified in the original patch as the default. If someone has a gcc
older than or equal than gcc 4.8.2 but not on Ubuntu it'd be good to
know if this issue is there as well as then we could just match this
to the gcc version.

 Luis
