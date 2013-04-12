Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:41943 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab3DLKnm (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 06:43:42 -0400
Received: by mail-la0-f49.google.com with SMTP id fs12so2331906lab.8
        for <backports@vger.kernel.org>; Fri, 12 Apr 2013 03:43:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365760927-7379-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365760927-7379-1-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 12 Apr 2013 03:43:20 -0700
Message-ID: <CAB=NE6WCw=C+N6nodHSV1orxDwrfmR65mscsCeA7uM5zcSMf0w@mail.gmail.com> (sfid-20130412_124344_867802_8C388C13)
Subject: Re: [PATCH] backports: add support for backport_srctree
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 12, 2013 at 3:02 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>
> The Linux kernel uses srctree to help prefix header files
> and scripts. When backporting we want to be able to override
> driver's Makefiles' usage of srctree with our own. Since we
> can't easily and sanely override the srctree itself without
> causing a lot of issues just use the python generator to
> do the change for us on the target Makefiles. This addresses
> the srctree usage case and where ccflags was used without
> prefixing any parent directory when used with drivers, the
> kernel tends to fix that with addtree command.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>
> Running ckmake now too so you can either apply or wait.
>
>  backport/Makefile.kernel |    2 ++
>  gentree.py               |    4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
> index 91e7dd6..76202f8 100644
> --- a/backport/Makefile.kernel
> +++ b/backport/Makefile.kernel
> @@ -15,6 +15,8 @@ NOSTDINC_FLAGS := \
>         $(BACKPORTS_GIT_TRACKER_DEF) \
>         $(CFLAGS)
>
> +backport_srctree = $(M)

this needs to be just srctree as the gen script will add the backport
prefix for us.

ckmake test 1 failed :)

  Luis
