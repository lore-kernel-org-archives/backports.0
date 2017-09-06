Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:48030 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753900AbdIFPoX (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Sep 2017 11:44:23 -0400
Message-ID: <1504712656.5400.84.camel@coelho.fi> (sfid-20170906_174448_930364_E0508030)
From: Luca Coelho <luca@coelho.fi>
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Date: Wed, 06 Sep 2017 18:44:16 +0300
In-Reply-To: <1504709551.23905.6.camel@sipsolutions.net>
References: <20170905065039.25808-1-luca@coelho.fi>
         (sfid-20170905_085047_421946_CCC9B604) <1504709551.23905.6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: fix netdev destructor backport for v4.11.9
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-09-06 at 16:52 +0200, Johannes Berg wrote:
> On Tue, 2017-09-05 at 09:50 +0300, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > The patch that changed the netdev destructor code was backported to
> > v4.11.9, so handle that in the backport.
> 
> Applied, since it was so obvious.
> 
> > Change-Id: I21a64c84d1c46771d9436341537d946e5ae64c1b
> 
> Without that though :)

Oops, sorry! I learned to systematically remove those from kernel
patches, but for some reason I left it in this patch.

--
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
