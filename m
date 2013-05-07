Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54298 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab3EGNXT (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 09:23:19 -0400
Message-ID: <1367932996.8328.7.camel@jlt4.sipsolutions.net> (sfid-20130507_152322_180792_9A3F5FDB)
Subject: Re: [PATCH v2 0/4] backports: fix final link errors
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Tue, 07 May 2013 15:23:16 +0200
In-Reply-To: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130506_235223_925793_4F77E4F3)
References: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130506_235223_925793_4F77E4F3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-06 at 14:52 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> OK this took a while but finally figured it out. This addresses
> the link errors introduced by adding the media and voltage
> regulator subsystems. We can now move on with life and hopefully
> cook a release right in time for v3.10. Now we just have to
> step slowly forward on linux-next tags up to where we are
> today (which hopefully will remain this way for another week).

Thanks Luis! Applied all 4 (actually 4/4 I applied the one you sent
later)

johannes

