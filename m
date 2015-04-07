Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:37277 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbbDGHFs (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Apr 2015 03:05:48 -0400
Message-ID: <1428390344.1841.2.camel@sipsolutions.net> (sfid-20150407_090550_713227_7D48A499)
Subject: Re: [PATCH 3/7] patches: add missing import to rhashtable
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Tue, 07 Apr 2015 09:05:44 +0200
In-Reply-To: <1428272000-19929-4-git-send-email-hauke@hauke-m.de> (sfid-20150406_001336_749552_2B4E59FD)
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
	 <1428272000-19929-4-git-send-email-hauke@hauke-m.de>
	 (sfid-20150406_001336_749552_2B4E59FD)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2015-04-06 at 00:13 +0200, Hauke Mehrtens wrote:
> lib-rhashtable.c misses a #include <linux/export.h> on some kernel
> versions.

Should perhaps send that upstream?

johannes

