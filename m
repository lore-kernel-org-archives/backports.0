Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:37669 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3LVM2N (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Dec 2013 07:28:13 -0500
Message-ID: <1387715284.4346.2.camel@jlt4.sipsolutions.net> (sfid-20131222_132819_129989_7E35071D)
Subject: Re: [PATCH] backports: random: add prandom_bytes macro for pre-3.8
 kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Sun, 22 Dec 2013 13:28:04 +0100
In-Reply-To: <1387713434-20109-1-git-send-email-arend@broadcom.com> (sfid-20131222_125724_927172_10481688)
References: <1387713434-20109-1-git-send-email-arend@broadcom.com>
	 (sfid-20131222_125724_927172_10481688)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-12-22 at 12:57 +0100, Arend van Spriel wrote:
> Map prandom_bytes() calls to get_random_bytes() for kernels before
> 3.8 kernel. This patch is needed by mac80211 rate control code
> since following:

> +/* use get_random_bytes() for lack of prandom_bytes() */
> +#define prandom_bytes(a, b)		get_random_bytes(a, b)

I don't think this is a good idea, it's a completely different interface
(get_random_bytes is much higher "quality".)

We had a different patch for this fairly recently and I thought Luis
applied it?

johannes

