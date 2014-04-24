Return-path: <backports-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60652 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbaDXQiR (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 24 Apr 2014 12:38:17 -0400
Date: Thu, 24 Apr 2014 12:36:26 -0400 (EDT)
Message-Id: <20140424.123626.601551201909346659.davem@davemloft.net> (sfid-20140424_183820_726416_F121E9C3)
To: mcgrof@do-not-panic.com
Cc: alex.bluesman.smirnov@gmail.com, dbaryshkov@gmail.com,
	linux-zigbee-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, backports@vger.kernel.org,
	mcgrof@suse.com, johannes@sipsolutions.net
Subject: Re: [PATCH] 6lowpan: nuke net_ieee802154_lowpan() accessor when
 6lowpan is disabled
From: David Miller <davem@davemloft.net>
In-Reply-To: <1398193438-23805-1-git-send-email-mcgrof@do-not-panic.com>
References: <1398193438-23805-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 22 Apr 2014 12:03:58 -0700

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> Johannes noted this is not needed, all of the fragment
> accessors don't need CONFIG_NET_NS. This goes test compiled with
> CONFIG_BT_6LOWPAN=y and a disabled CONFIG_NET_NS.
> 
> CC: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: linux-zigbee-devel@lists.sourceforge.net
> Cc: David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>

Applied, thanks Luis.
