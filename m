Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39440 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbbDCVhv (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 17:37:51 -0400
Message-ID: <551F082C.5060802@hauke-m.de> (sfid-20150403_233752_778549_6A002BD6)
Date: Fri, 03 Apr 2015 23:37:48 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] git-tracker: ask for verbose messages from per-commit
 processing
References: <1425284362-5250-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1425284362-5250-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/02/2015 09:19 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The messages are only printed if something fails anyway, so
> better ask for verbose messages to be able to better identify
> what failed.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  devel/git-tracker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for the patch it was applied to backports.

Hauke

