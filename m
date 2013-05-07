Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54292 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991Ab3EGNVw (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 09:21:52 -0400
Message-ID: <1367932900.8328.6.camel@jlt4.sipsolutions.net> (sfid-20130507_152154_902909_29E6B25D)
Subject: Re: [PATCH] backports: kref_get_unless_zero was merged to stable
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date: Tue, 07 May 2013 15:21:40 +0200
In-Reply-To: <1367829585-18509-1-git-send-email-johannes@sipsolutions.net> (sfid-20130506_105939_268659_F4FF8767)
References: <1367829585-18509-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130506_105939_268659_F4FF8767)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-06 at 10:39 +0200, Johannes Berg wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> 
> Mask the symbol so no matter where it was backported we can
> compile against that kernel tree.

Applied.

johannes

