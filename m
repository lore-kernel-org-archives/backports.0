Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:47090 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932713Ab3DFU7h (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 16:59:37 -0400
Message-ID: <1365281972.8313.2.camel@jlt4.sipsolutions.net> (sfid-20130406_225939_633524_1FFA66F9)
Subject: Re: [PATCH v3 4/8] backport module_i2c_driver helper macro
From: Johannes Berg <johannes@sipsolutions.net>
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: backports@vger.kernel.org
Date: Sat, 06 Apr 2013 22:59:32 +0200
In-Reply-To: <1365196842-12992-4-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_232054_849178_BC2537E9)
References: <1365196842-12992-4-git-send-email-thierry.escande@linux.intel.com>
	 (sfid-20130405_232054_849178_BC2537E9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-05 at 23:20 +0200, Thierry Escande wrote:

> --- a/backport/include/linux/compat-3.7.h
> +++ b/backport/include/linux/compat-3.7.h
 
> +/* This backports:
> + *
> + * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4

That commit seems to have gone into 3.3, yet you backport for anything <
3.7?

johannes


