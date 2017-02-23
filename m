Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60428 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdBWHt5 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 23 Feb 2017 02:49:57 -0500
Message-ID: <1487836149.18380.0.camel@sipsolutions.net> (sfid-20170223_084958_789721_46515FA1)
Subject: Re: [PATCH] backports: add definitions S32_MAX and S32_MIN
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Thu, 23 Feb 2017 08:49:09 +0100
In-Reply-To: <1487801925-22641-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170222_232123_578777_C8CEDBF9)
References: <1487801925-22641-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170222_232123_578777_C8CEDBF9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-02-22 at 22:18 +0000, Arend van Spriel wrote:
> Since commit 20e32810bcf4 ("cfg80211: Accept multiple RSSI thresholds
> for CQM") the backports need to have S32_MAX and S32_MIN which were
> introduced in kernel.h since v3.14.
> 

Applied, thanks.

I really need to set up automation for this, to continuously monitor a
few trees ...

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
