Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:51838 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUNL0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 21 Nov 2017 08:11:26 -0500
Message-ID: <1511269884.2030.49.camel@sipsolutions.net> (sfid-20171121_141128_318719_8145B248)
Subject: Re: [PATCH] backports: fix nlmsg_type on responses with extack
 backport
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, backports@vger.kernel.org
Date: Tue, 21 Nov 2017 14:11:24 +0100
In-Reply-To: <20171120180132.12531-1-nbd@nbd.name> (sfid-20171120_190138_725650_9A898143)
References: <20171120180132.12531-1-nbd@nbd.name>
         (sfid-20171120_190138_725650_9A898143)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-11-20 at 19:01 +0100, Felix Fietkau wrote:
> This is filled with family->id, which needs to be set after registering
> the copy.

Applied, thanks. Not sure how I missed this?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
