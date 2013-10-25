Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:49075 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3JYIfA (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 25 Oct 2013 04:35:00 -0400
Message-ID: <1382690097.4461.0.camel@jlt4.sipsolutions.net> (sfid-20131025_103502_649474_B0E91337)
Subject: Re: [PATCH 1/5] backports: fix kernel dependencies for regulator
 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Date: Fri, 25 Oct 2013 10:34:57 +0200
In-Reply-To: <1382552852-15916-2-git-send-email-hauke@hauke-m.de> (sfid-20131023_202752_481575_D6A8F64C)
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
	 <1382552852-15916-2-git-send-email-hauke@hauke-m.de>
	 (sfid-20131023_202752_481575_D6A8F64C)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-10-23 at 20:27 +0200, Hauke Mehrtens wrote:
> These drivers are depending on changes of the regulator core driver
> which are not in the specific kernel versions.

These dependencies seem to continue moving forward - is it even worth
backporting?

johannes

