Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44708 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429Ab3HMBc5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 12 Aug 2013 21:32:57 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1436528pbb.5
        for <backports@vger.kernel.org>; Mon, 12 Aug 2013 18:32:56 -0700 (PDT)
Date: Mon, 12 Aug 2013 18:41:56 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: fix device_release_driver
Message-ID: <20130813014155.GE6439@garbanzo.do-not-panic.com> (sfid-20130813_033300_338077_3EAF543C)
References: <1375868409-26906-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375868409-26906-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Aug 07, 2013 at 11:40:09AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The new macro, introduced by
> 
> commit 9f5876fa9cfb8cd6f450c200043ca7e31915f976
> Author: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> Date:   Thu Jul 18 16:40:55 2013 -0700
> 
>     backports: backport drvdata = NULL core driver fixes
> 
> evaluates its argument multiple times, causing crashes as
> there are potential side-effects of the called code and/or
> the arguments.
> 
> Fix this by converting it to static inlines.
> 
> Also remove the driver_probe_device() macro that has the
> same issue, but tries to wrap a function that isn't even
> available outside the driver core code in any kernel.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis
