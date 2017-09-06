Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54220 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932552AbdIFOyL (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 10:54:11 -0400
Message-ID: <1504709647.23905.7.camel@sipsolutions.net> (sfid-20170906_165447_512131_29F50FE9)
Subject: Re: [PATCH] backports: remove 802.15.4 entirely
From: Johannes Berg <johannes@sipsolutions.net>
To: AceLan Kao <acelan.kao@canonical.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org
Date: Wed, 06 Sep 2017 16:54:07 +0200
In-Reply-To: <1502198091-24156-2-git-send-email-acelan.kao@canonical.com> (sfid-20170808_151501_470313_B706A69F)
References: <1502198091-24156-1-git-send-email-acelan.kao@canonical.com>
         <1502198091-24156-2-git-send-email-acelan.kao@canonical.com>
         (sfid-20170808_151501_470313_B706A69F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-08-08 at 21:14 +0800, AceLan Kao wrote:
> 802.15.4 has been removed by this commit,
>    15a3df8 backports: remove 802.15.4 entirely
> but there are some files left behind.
> Remove them all.

Applied.

Please use a "PATCH v2" in the subject when you resend, that way I know
which one to take.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
