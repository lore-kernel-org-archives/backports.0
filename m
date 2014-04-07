Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:33470 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaDGKbw (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 06:31:52 -0400
Message-ID: <1396866692.6270.0.camel@jlt4.sipsolutions.net> (sfid-20140407_123154_387943_B25BF6A9)
Subject: Re: [PATCH 26/27] backports: convert threaded IRQ suport into an
 SmPL patch
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Date: Mon, 07 Apr 2014 12:31:32 +0200
In-Reply-To: <1396701662-15165-27-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_987470_7649D5E2)
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
	 <1396701662-15165-27-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20140405_144448_987470_7649D5E2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2014-04-05 at 05:41 -0700, Luis R. Rodriguez wrote:

> ++ret = compat_request_threaded_irq(&private->irq_compat,

Whhy not go to backport namespace too?

johannes

