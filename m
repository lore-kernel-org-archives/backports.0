Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40876 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933124AbbFPI4b (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 16 Jun 2015 04:56:31 -0400
Message-ID: <1434444988.2337.11.camel@sipsolutions.net> (sfid-20150616_105639_197692_AD504E51)
Subject: Re: [PATCH 07/21] backports: add backport for new AEAD crypto API
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Tue, 16 Jun 2015 10:56:28 +0200
In-Reply-To: <1434292162-2261-8-git-send-email-hauke@hauke-m.de> (sfid-20150614_162945_019275_3F6B4430)
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
	 <1434292162-2261-8-git-send-email-hauke@hauke-m.de>
	 (sfid-20150614_162945_019275_3F6B4430)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2015-06-14 at 16:29 +0200, Hauke Mehrtens wrote:
> mac80211 makes use of the new AEAD crypto api since commit 957e0fe629.
> This patch provides a backport layer which converts the new API to the
> old one used in older kernel versions. This backport is based on this
> mainline commit: 996d98d85.

This looks right to me.

johannes

