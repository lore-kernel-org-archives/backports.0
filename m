Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:48852 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621Ab3JRQwn (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 18 Oct 2013 12:52:43 -0400
Message-ID: <1382115154.14393.18.camel@jlt4.sipsolutions.net> (sfid-20131018_185245_177909_119E917F)
Subject: Re: [RFC] backports: replace netlink portid by semantic patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Fri, 18 Oct 2013 18:52:34 +0200
In-Reply-To: <5261585F.8020000@hauke-m.de>
References: <1382110139-23344-1-git-send-email-johannes@sipsolutions.net>
	 <5261585F.8020000@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-10-18 at 17:48 +0200, Hauke Mehrtens wrote:

> There are two more patches doing the same thing for other subsystems, I
> hope we could also replace the patches with this semantic patch:
> 
> patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
> patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch

Indeed, those can just be deleted now.

> How fast would it be when one more semantic patch would be added would
> it increase in the same way? I am wondering if this is a constant
> increase or does it depend on the number of patches.

I believe it's # of patches because the slowest part seems to be
searching all files for matches.

We might be able to concatenate the patches, but ...

johannes

