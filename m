Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54342 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098Ab3EGNbh (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 09:31:37 -0400
Message-ID: <1367933493.8328.13.camel@jlt4.sipsolutions.net> (sfid-20130507_153139_344612_771A8F95)
Subject: Re: [PATCH 2/2] ckmake: add support for kernel ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Tue, 07 May 2013 15:31:33 +0200
In-Reply-To: <1367917626-21870-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_110719_669025_E1428726)
References: <1367917626-21870-1-git-send-email-mcgrof@do-not-panic.com>
	 <1367917626-21870-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130507_110719_669025_E1428726)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-07 at 02:07 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> At times you may only want to test with ckmake a specific
> kernel range or target kernels. You can do that now. ckmake
> will use this list against what it finds on your system.
> 
> Examples:
> 
>   * ckmake --revs 3.3..3.4
>   * ckmake --revs 2.6.24,2.6.30,2.6.32..3.2,3.4

I don't really understand the computations you do, but hey, if it
works :-)

Applied both.

johannes

