Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:56568 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753522AbdBGM3L (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 7 Feb 2017 07:29:11 -0500
Message-ID: <1486470543.25609.0.camel@sipsolutions.net> (sfid-20170207_132913_068768_E791D2ED)
Subject: Re: [PATCH] backports: restore config_enabled() macro
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Tue, 07 Feb 2017 13:29:03 +0100
In-Reply-To: <1486466124-31640-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170207_121541_911512_C145DFDA)
References: <1486466124-31640-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170207_121541_911512_C145DFDA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-02-07 at 11:15 +0000, Arend van Spriel wrote:
> Attempted a backport to FC25 4.9.5 kernel and hit issue with
> IS_BUILTIN()
> using config_enabled() macro in backport-include/linux/kconfig.h. Fix
> this
> by using #ifndef.

Hah, very timely - I just had a problem with IS_REACHABLE that this
should solve nicely :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
