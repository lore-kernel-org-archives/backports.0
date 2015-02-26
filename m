Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52611 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbbBZNUg (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 26 Feb 2015 08:20:36 -0500
Message-ID: <1424956829.1885.27.camel@sipsolutions.net> (sfid-20150226_142043_227464_68B1A26F)
Subject: Re: [PATCH] backports: allow building backports package on 4.0+
 kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Thu, 26 Feb 2015 14:20:29 +0100
In-Reply-To: <54EF1D28.8020503@broadcom.com>
References: <1424954998-31984-1-git-send-email-arend@broadcom.com>
		 (sfid-20150226_135011_981321_0099BE5A) <1424955956.1885.23.camel@sipsolutions.net>
	 <54EF1C05.2000901@broadcom.com> <54EF1D28.8020503@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2015-02-26 at 14:18 +0100, Arend van Spriel wrote:

> Seems to be really enough for this (unlikely) scenario.

I think it'll be fine until somebody puts

SOME_SYMBOL 4.0

into the dependencies file.

I guess you could try that with some random symbol and see what happens?
I think it would never be selectable.

johannes

