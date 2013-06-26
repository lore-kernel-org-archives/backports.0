Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:37926 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3FZQdc (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 26 Jun 2013 12:33:32 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so14174531lab.27
        for <backports@vger.kernel.org>; Wed, 26 Jun 2013 09:33:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372157204-30109-1-git-send-email-johannes@sipsolutions.net>
References: <1372157204-30109-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 26 Jun 2013 09:33:10 -0700
Message-ID: <CAB=NE6Xc2X04m4gHyFrbV8eGbsf=ZQBFaN98t-UCWfpyvZMx+A@mail.gmail.com> (sfid-20130626_183343_904864_316B13C3)
Subject: Re: [PATCH] backport: include printk.h into backport-3.11.c
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 25, 2013 at 3:46 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> This is needed for pr_warn(), otherwise it's not defined on
> all kernels (it is sometimes pulled in by other headers.)
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis
