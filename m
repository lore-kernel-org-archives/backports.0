Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:60225 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab3FFEl7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 6 Jun 2013 00:41:59 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so2607654lbh.24
        for <backports@vger.kernel.org>; Wed, 05 Jun 2013 21:41:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370274874-31049-1-git-send-email-johannes@sipsolutions.net>
References: <1370274874-31049-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 5 Jun 2013 21:41:36 -0700
Message-ID: <CAB=NE6VJvQr_zjv2981-MqSSZ080NzOBT_9YgZkWd0f16zLj3g@mail.gmail.com> (sfid-20130606_064201_210461_2A3ABF6C)
Subject: Re: [PATCH] backports: use check-lxdialog.sh
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jun 3, 2013 at 8:54 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> We ship it, so we should use it. This should fix issues
> like one distro needing "-lncurses -ltinfo" and others
> requiring just "-lncurses" and not having "tinfo".
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis
