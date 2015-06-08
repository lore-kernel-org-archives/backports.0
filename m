Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48725 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbbFHUbP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Jun 2015 16:31:15 -0400
Message-ID: <1433795473.10172.3.camel@sipsolutions.net> (sfid-20150608_223116_930593_D59C0426)
Subject: Re: [PATCH] pycocci: sync pycocci with Coccinelle upstream
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, cocci@systeme.lip6.fr
Date: Mon, 08 Jun 2015 22:31:13 +0200
In-Reply-To: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150608_220416_878803_1B3AED69)
References: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20150608_220416_878803_1B3AED69)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-06-08 at 13:01 -0700, Luis R. Rodriguez wrote:
> pycocci is now part of Coccinelle upstream. Coccinelle has a plan
> to actually extend multithreaded support to enable us to not have
> to script this out. Until then pyccoci is used and I'll sync both
> solutions up as there is a bit of latency between a coccinelle release
> and what we may need from pycocci.

If it's upstream, do they ship it? If so it wouldn't be needed that we
have a copy, it seems?

johannes

