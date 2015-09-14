Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36293 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbbINVZH (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 17:25:07 -0400
Subject: Re: [PATCH v2] git-tracker: read INPUT_HTTP[S]_PROXY environment
 variable
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1439976363.2089.2.camel@sipsolutions.net>
 (sfid-20150819_112609_092507_D1F11647)
 <1439977490.2089.5.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <55F73B2F.8000405@hauke-m.de> (sfid-20150914_232509_631392_D2BD2ED2)
Date: Mon, 14 Sep 2015 23:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <1439977490.2089.5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/19/2015 11:44 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This allows using a different HTTP[S] proxy for input and output
> trees, if necessary.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  devel/git-tracker.py | 22 ++++++++++++++++------
>  lib/bpgit.py         | 14 ++++++++------
>  2 files changed, 24 insertions(+), 12 deletions(-)
> 

Thank you for the patch, it was applied and pushed out.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
