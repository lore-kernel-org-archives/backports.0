Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52486 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbbBZNGH (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 26 Feb 2015 08:06:07 -0500
Message-ID: <1424955956.1885.23.camel@sipsolutions.net> (sfid-20150226_140610_614298_04263E55)
Subject: Re: [PATCH] backports: allow building backports package on 4.0+
 kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Thu, 26 Feb 2015 14:05:56 +0100
In-Reply-To: <1424954998-31984-1-git-send-email-arend@broadcom.com> (sfid-20150226_135011_981321_0099BE5A)
References: <1424954998-31984-1-git-send-email-arend@broadcom.com>
	 (sfid-20150226_135011_981321_0099BE5A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2015-02-26 at 13:49 +0100, Arend van Spriel wrote:
> When attempting to build backport package the error message
> "Kernel version parse failed" popped up. Realizing the machine
> was already running a 4.0-rc1 kernel, this patch fixes the
> issue. At least until kernel 9.x it will.

Is this really enough? we also generate those kernel version Kconfig
symbols for dependencies - I htink that needs to be adjusted as well.

johannes

