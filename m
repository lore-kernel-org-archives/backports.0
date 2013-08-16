Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:40058 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab3HPRsD (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 13:48:03 -0400
Message-ID: <1376675275.15299.28.camel@jlt4.sipsolutions.net> (sfid-20130816_194807_015919_646B00E6)
Subject: Re: [PATCH 04/13] backports: add missing include for
 is_valid_ether_addr()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org,
	Patrick Ziegler <patrick.ziegler@fh-kl.de>
Date: Fri, 16 Aug 2013 19:47:55 +0200
In-Reply-To: <1376674003-5801-4-git-send-email-hauke@hauke-m.de> (sfid-20130816_193909_420802_236C6E3A)
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
	 <1376674003-5801-4-git-send-email-hauke@hauke-m.de>
	 (sfid-20130816_193909_420802_236C6E3A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-08-16 at 19:26 +0200, Hauke Mehrtens wrote:
> is_valid_ether_addr() is used, but the header here it is declared was
> not included.

Thanks!

johannes

