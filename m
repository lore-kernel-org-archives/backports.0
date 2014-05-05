Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:41336 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932743AbaEEO74 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 5 May 2014 10:59:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <johannes@sipsolutions.net>)
	id 1WhKN1-0001a3-Kx
	for backports@vger.kernel.org; Mon, 05 May 2014 16:59:55 +0200
Message-ID: <1399301983.22235.18.camel@jlt4.sipsolutions.net> (sfid-20140505_165958_548685_64591A26)
Subject: Re: [PATCH] backports: provide net_ieee802154_lowpan only when
 needed
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Mon, 05 May 2014 16:59:43 +0200
In-Reply-To: <1399293971-8037-1-git-send-email-johannes@sipsolutions.net> (sfid-20140505_144619_709539_92A43EE0)
References: <1399293971-8037-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20140505_144619_709539_92A43EE0)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2014-05-05 at 14:46 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If 802.15.4 isn't configured, there's no need to provide the
> network namespace support for it, so don't.

>  #include <net/netns/ieee802154_6lowpan.h>

More to the point - I didn't want to require this in the copy-list if
nothing requires it.

johannes

