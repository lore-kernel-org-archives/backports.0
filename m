Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58634 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaASRHR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 12:07:17 -0500
Message-ID: <52DC063B.4070801@hauke-m.de> (sfid-20140119_180720_012738_EE2F3704)
Date: Sun, 19 Jan 2014 18:07:07 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
CC: Peter Senna <peter.senna@gmail.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [PATCH 2/2] backports: add support for testing only a single
 Coccinelle SmPL patch
References: <1386851914-5241-1-git-send-email-mcgrof@do-not-panic.com> <1386851914-5241-2-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1386851914-5241-2-git-send-email-mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/12/2013 01:38 PM, Luis R. Rodriguez wrote:
> You can just pass now one cocci file with the --test-cocci to test
> only that single Coccinelle SmPL patch.
> 
> On my Chromebook Pixel:
> 
> $ time ./gentree.py --clean --verbose --test-cocci \
> 	patches/collateral-evolutions/network/11-dev-pm-ops.cocci \
> 	/home/mcgrof/linux-next/ \
> 	/home/mcgrof/build/backports-20131206
> 
> real    5m39.361s
> user    5m24.148s
> sys     0m7.772s
> 
> Note run time with --profile-cocci on the same system:
> 
> real    6m25.778s
> user    6m4.912s
> sys     0m8.060s
> 
> The an original copy of the souce directory will be kept under the
> target directory, renamed with .orig.
> 
> Cc: Peter Senna <peter.senna@gmail.com>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---

Hi Luis,

these patches are conflicting with a patch from Johannes [0] and I
haven't applied it.

[0]: http://www.spinics.net/lists/backports/msg02188.html

Hauke
