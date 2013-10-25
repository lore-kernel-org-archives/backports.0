Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45945 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab3JYVcI (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Oct 2013 17:32:08 -0400
Message-ID: <526AE34E.5020300@hauke-m.de> (sfid-20131025_233210_538657_32BA4E41)
Date: Fri, 25 Oct 2013 23:31:58 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH 1/5] backports: fix kernel dependencies for regulator
 drivers
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>	 <1382552852-15916-2-git-send-email-hauke@hauke-m.de>	 (sfid-20131023_202752_481575_D6A8F64C) <1382690097.4461.0.camel@jlt4.sipsolutions.net>
In-Reply-To: <1382690097.4461.0.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/25/2013 10:34 AM, Johannes Berg wrote:
> On Wed, 2013-10-23 at 20:27 +0200, Hauke Mehrtens wrote:
>> These drivers are depending on changes of the regulator core driver
>> which are not in the specific kernel versions.
> 
> These dependencies seem to continue moving forward - is it even worth
> backporting?
> 
> johannes
> 
Yes moving the dependencies is easier than backporting the code which
does not work any more. ;-) The problem here is that the regulator core
can not be backported, because it is always build into the kernel and
not as a module.

I am also think if it is worth backporting this stuff, I think it is
only used on embedded devices and there it is probably easier to just
patch the kernel with the driver updates you need, I am for dropping this.

Are there any users of the regulator drivers?

Hauke
