Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54204 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932562AbdIFOwd (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 10:52:33 -0400
Message-ID: <1504709551.23905.6.camel@sipsolutions.net> (sfid-20170906_165236_375139_C8CB2CBE)
Subject: Re: [PATCH] backport: fix netdev destructor backport for v4.11.9
From: Johannes Berg <johannes@sipsolutions.net>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Wed, 06 Sep 2017 16:52:31 +0200
In-Reply-To: <20170905065039.25808-1-luca@coelho.fi> (sfid-20170905_085047_421946_CCC9B604)
References: <20170905065039.25808-1-luca@coelho.fi>
         (sfid-20170905_085047_421946_CCC9B604)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-09-05 at 09:50 +0300, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The patch that changed the netdev destructor code was backported to
> v4.11.9, so handle that in the backport.

Applied, since it was so obvious.

> Change-Id: I21a64c84d1c46771d9436341537d946e5ae64c1b

Without that though :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
