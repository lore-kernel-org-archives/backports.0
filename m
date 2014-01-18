Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54025 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbaARPxB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 10:53:01 -0500
Message-ID: <52DAA352.5010009@hauke-m.de> (sfid-20140118_165309_608685_1E275448)
Date: Sat, 18 Jan 2014 16:52:50 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] gentree: combine spatches (unless using --gitdebug)
References: <1388605033-18318-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1388605033-18318-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/01/2014 08:37 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since spatch is rather slow, but can handle multiple spatches
> concatenated in a single file, just do that and run it only
> once rather than for each spatch. That shaves off some of the
> runtime (startup etc. and finding affected files.)
> 
> On my system, I go from
> 
> real    9m42.616s
> user    8m48.352s
> sys     0m22.884s
> 
> to
> 
> real    9m1.948s
> user    8m40.108s
> sys     0m12.088s
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  gentree.py | 72 +++++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
> 
Thank you for the patch, it was applied.

Hauke

