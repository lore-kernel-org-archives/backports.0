Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:57168 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753352AbcFOIxr (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 Jun 2016 04:53:47 -0400
Message-ID: <1465980817.29614.136.camel@coelho.fi> (sfid-20160615_105350_759242_CF509E05)
From: Luca Coelho <luca@coelho.fi>
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Wed, 15 Jun 2016 11:53:37 +0300
In-Reply-To: <1465979938.2994.5.camel@sipsolutions.net>
References: <1463142983-17166-1-git-send-email-arend@broadcom.com>
	 (sfid-20160513_143629_166716_8F835081) <1465979938.2994.5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backports: netlink: add 64-bit aligned helper functions
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2016-06-15 at 10:38 +0200, Johannes Berg wrote:
> > 
> >  backport/compat/backport-4.7.c          | 113
> > 
> This patch is correct, Luca's is not because he erroneously added it
> to
> backport-4.6.c instead :)

Yes, and I already hit the first victim internally, who was trying to
build our driver with a 4.6 kernel and it didn't work... :(

I repent!

--
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
