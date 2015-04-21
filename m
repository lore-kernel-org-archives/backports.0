Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:42547 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264AbbDUGQy (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 21 Apr 2015 02:16:54 -0400
Message-ID: <1429597009.2045.0.camel@sipsolutions.net> (sfid-20150421_081657_290311_9CA38DBB)
Subject: Re: [PATCH 10/10] backports: require coccinelle version 1.0.0-rc24
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org,
	mcgrof@do-not-panic.com
Date: Tue, 21 Apr 2015 08:16:49 +0200
In-Reply-To: <55356F36.9070408@hauke-m.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
	 <1424874054-22956-11-git-send-email-sassmann@kpanic.de>
	 <55356F36.9070408@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-04-20 at 23:27 +0200, Hauke Mehrtens wrote:
> On 02/25/2015 03:20 PM, Stefan Assmann wrote:
> > The new more generic ethernet patches require spatch 1.0.0-rc24.

> do you need coccinelle 1.0.0-rc24 or would rc23 also work? Johannes
> added a patch raising minimum coccinelle to rc23.

I believe his changes do require rc24.

johannes

