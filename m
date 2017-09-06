Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48156 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdIFHXp (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 03:23:45 -0400
Message-ID: <1504682623.12380.25.camel@sipsolutions.net> (sfid-20170906_092347_052170_C8DFE816)
Subject: Re: [PATCH 00/21] backports: multiple changes for kernel 3.13-rc6
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Wed, 06 Sep 2017 09:23:43 +0200
In-Reply-To: <edbd9333-79ed-7662-d29d-e93c2f64eb6a@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <1504602018.12380.3.camel@sipsolutions.net>
         <edbd9333-79ed-7662-d29d-e93c2f64eb6a@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-09-05 at 23:41 +0200, Hauke Mehrtens wrote:
> 
> I would prefer to drop everything < 3.10, or do not care about older
> kernel versions. For LEDE I am only interested in 3.18 or 4.4 and
> more recent.

I think internally we still might care about some older versions, not
sure though.

There's also still a 3.2 and 3.4 LTS kernel on kernel.org, with the
former (3.2) having been updated just a week ago or so.

Perhaps we should phase out older non-LTS kernels, but how much effort
would that be, and how much effort is going into those older kernels
anyway?

> How do we want to proceed with these patches?

I just got back from sabbatical, but once I have some more time I'll go
ahead and review/apply them, and hopefully also start working on some
auto-building infrastructure.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
