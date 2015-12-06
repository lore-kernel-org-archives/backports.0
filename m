Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54949 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbbLFOhL (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 09:37:11 -0500
Message-ID: <1449412622.4040.0.camel@sipsolutions.net> (sfid-20151206_153713_415888_56BE952C)
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Sun, 06 Dec 2015 15:37:02 +0100
In-Reply-To: <5663458B.1070103@hauke-m.de> (sfid-20151205_211408_495778_1F398223)
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>
	 <5663458B.1070103@hauke-m.de> (sfid-20151205_211408_495778_1F398223)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> Is it ok to replace the b43, b43legacy and brcm80211 by this single
> line?
> drivers/net/wireless/broadcom/
> 

You mean in a single patch? I generally considered each file (or at
least driver) separately so you could restrict copy-list to it.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
