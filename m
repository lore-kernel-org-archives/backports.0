Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46337 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbKAX4T (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Nov 2015 18:56:19 -0500
Message-ID: <5636A6A1.6080108@hauke-m.de> (sfid-20151102_005627_368381_0ECD5149)
Date: Mon, 02 Nov 2015 00:56:17 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] bpgit: ignore stderr
References: <1445585012-11300-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1445585012-11300-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/23/2015 09:23 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In order to make it possible to use GIT_TRACE, ignore stderr
> in the bpgit scripting.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  lib/bpgit.py | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
Thank you for the patch, I applied it, but had to fix a problem manually.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
