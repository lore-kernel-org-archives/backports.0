Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49663 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759479AbbDYOFw (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 10:05:52 -0400
Message-ID: <553B9F3D.6050605@hauke-m.de> (sfid-20150425_160603_078427_E00B6485)
Date: Sat, 25 Apr 2015 16:05:49 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] backports: backport recent wext change
References: <1425286112-6369-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1425286112-6369-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/02/2015 09:48 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> backport the commit 36ef906ee8fefbfac3844206e66d8450e6221c69
> ("wext: add checked wrappers for adding events/points to streams")
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/backport-include/net/iw_handler.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 backport/backport-include/net/iw_handler.h
> 
Thank you for the patch, it was applied and pushed some time ago.

Hauke

