Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59698 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754280AbbLGJCV (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Dec 2015 04:02:21 -0500
Message-ID: <1449478931.4040.1.camel@sipsolutions.net> (sfid-20151207_100225_319926_BBAEFCDB)
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Mon, 07 Dec 2015 10:02:11 +0100
In-Reply-To: <56654A94.4060502@broadcom.com>
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>
		 <5663458B.1070103@hauke-m.de>
	 (sfid-20151205_211408_495778_1F398223) <1449412622.4040.0.camel@sipsolutions.net>
	 <56654A94.4060502@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-12-07 at 10:00 +0100, Arend van Spriel wrote:
> 
> > > drivers/net/wireless/broadcom/

> drivers/net/wireless/broadcom/Kconfig
> drivers/net/wireless/broadcom/Makefile
> drivers/net/wireless/broadcom/b43
> drivers/net/wireless/broadcom/b43legacy
> drivers/net/wireless/broadcom/brcm80211
> 
> Or (as Hauke suggests):
> 
> drivers/net/wireless/broadcom/
> 
> To restrict the copy-list the first option would be preferred.
> 

Oh, you meant for the copy-list?

I thought upstream backports just shipped a single copy-list line
"ddrivers/net/wireless/"?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
