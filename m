Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:49665 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753649AbbLIXIq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Dec 2015 18:08:46 -0500
Message-ID: <1449702521.22495.3.camel@sipsolutions.net> (sfid-20151210_000848_045776_F47F47D2)
Subject: Re: [PATCH] patches: fix path in name_assign_type patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Thu, 10 Dec 2015 00:08:41 +0100
In-Reply-To: <5668B1CF.6040301@hauke-m.de>
References: <1448884387-20806-1-git-send-email-arend@broadcom.com>
	 <5663458B.1070103@hauke-m.de> <1449412622.4040.0.camel@sipsolutions.net>
	 <56654A94.4060502@broadcom.com> <1449478931.4040.1.camel@sipsolutions.net>
	 <56654C02.8010005@broadcom.com> <5668B1CF.6040301@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-12-09 at 23:57 +0100, Hauke Mehrtens wrote:
> 
> Do both of you replace the copy-list file in your internal versions?
> 

I think Arend said he did, and I certainly do that too. I actually just
have my own and run the gentree/git-tracker scripts with the right
commandline parameter.

So I think

drivers/net/wireless/

makes most sense since that requires no maintenance?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
