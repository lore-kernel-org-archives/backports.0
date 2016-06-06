Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:37929 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcFFJMq (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 6 Jun 2016 05:12:46 -0400
Message-ID: <1465204361.2304.2.camel@sipsolutions.net> (sfid-20160606_111254_001077_DEE50654)
Subject: Re: [PATCH 2/2] backports: patches: update devcoredump patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Mon, 06 Jun 2016 11:12:41 +0200
In-Reply-To: <5f5554e0-11f5-f072-019d-f5195d2e0116@broadcom.com> (sfid-20160606_111036_675534_2E4E721F)
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
	 <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com>
	 <1465138846.2304.0.camel@sipsolutions.net>
	 <59c87bb9-b92e-00a4-8876-97f1e7ea1957@broadcom.com>
	 <1465203643.2304.1.camel@sipsolutions.net>
	 <5f5554e0-11f5-f072-019d-f5195d2e0116@broadcom.com>
	 (sfid-20160606_111036_675534_2E4E721F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> > I have a patch for our driver to use it, which is basically only
> > waiting for this to get into backports :-)
> So how about incorporating lib/scatterlist.c in backports?
> 

We need the whole thing? I haven't really had time to look into this,
sorry.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
