Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54240 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932558AbdIFOzd (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 10:55:33 -0400
Message-ID: <1504709729.23905.8.camel@sipsolutions.net> (sfid-20170906_165541_547829_535956F4)
Subject: Re: [PATCH 2/2] copy-list: remove st-nci.h and patch
From: Johannes Berg <johannes@sipsolutions.net>
To: AceLan Kao <acelan.kao@canonical.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org
Date: Wed, 06 Sep 2017 16:55:29 +0200
In-Reply-To: <1500001674-24553-2-git-send-email-acelan.kao@canonical.com> (sfid-20170714_050803_640070_8A45D056)
References: <1500001674-24553-1-git-send-email-acelan.kao@canonical.com>
         <1500001674-24553-2-git-send-email-acelan.kao@canonical.com>
         (sfid-20170714_050803_640070_8A45D056)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-07-14 at 11:07 +0800, AceLan Kao wrote:
> From below commit, st-nci.h has been removed
>    61a0410 NFC: st-nci: Get rid of platform data
> And we don't need st-nci-spi.patch, either. The patch is included in
> upstream kernel source.
> 
Both applied, but it'd have been nicer to split the second patch into
two since it's two very different things.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
