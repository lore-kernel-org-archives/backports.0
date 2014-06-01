Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59650 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbaFAWft (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Jun 2014 18:35:49 -0400
Message-ID: <538BAAC0.5000607@hauke-m.de> (sfid-20140602_003550_856633_441884AA)
Date: Mon, 02 Jun 2014 00:35:44 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] git-tracker: remove shortlog for empty changes
References: <1400658283-28439-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1400658283-28439-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/21/2014 09:44 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When the input tree had changes but the output doesn't get
> any changes at all, then the shortlog was being generated
> over all commits since no files were specified.
> 
> Catch this special case and instead of generating a shortlog
> just add a note that no commits changed generated code.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  devel/git-tracker.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 

Thank you for the patch, it was applied, pushed and is included in the
backports-20140501 release.

Hauke

