Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39190 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbaJ2Rog (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Oct 2014 13:44:36 -0400
Message-ID: <1414604671.1827.30.camel@jlt4.sipsolutions.net> (sfid-20141029_184438_096928_C5D7942B)
Subject: Re: build backports-20140905 against 2.6.39 kernel failure
From: Johannes Berg <johannes@sipsolutions.net>
To: Eyal Ben-Sasson <eyal@trego.co.il>
Cc: backports@vger.kernel.org
Date: Wed, 29 Oct 2014 18:44:31 +0100
In-Reply-To: <5451179D.6020009@trego.co.il> (sfid-20141029_173700_652943_FC9D8B2D)
References: <5451179D.6020009@trego.co.il>
	 (sfid-20141029_173700_652943_FC9D8B2D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-10-29 at 18:36 +0200, Eyal Ben-Sasson wrote:

> I understand the backports is tested against 2.6.39 successfully. Where 
> can I see the 2.6.39 .config file?

This is no longer the case, the oldest supported kernel is now 3.0.

johannes

