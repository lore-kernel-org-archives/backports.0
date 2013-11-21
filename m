Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:50406 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab3KUO4r (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 21 Nov 2013 09:56:47 -0500
Message-ID: <1385045801.14273.7.camel@jlt4.sipsolutions.net> (sfid-20131121_155649_101491_7341DE59)
Subject: Re: [PATCH v2] backports: replace linux/bitops.h header
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: mcgrof@kernel.org, backports@vger.kernel.org, hauke@hauke-m.de
Date: Thu, 21 Nov 2013 15:56:41 +0100
In-Reply-To: <1385045517-15868-1-git-send-email-sassmann@kpanic.de>
References: <1385045517-15868-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-11-21 at 15:51 +0100, Stefan Assmann wrote:
> Instead of copying bitops.h from upstream just add what's missing in
> older kernel.

Looks good to me.

johannes

