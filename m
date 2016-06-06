Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:37900 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbcFFJAu (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 6 Jun 2016 05:00:50 -0400
Message-ID: <1465203643.2304.1.camel@sipsolutions.net> (sfid-20160606_110051_994950_8AF8CB28)
Subject: Re: [PATCH 2/2] backports: patches: update devcoredump patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Mon, 06 Jun 2016 11:00:43 +0200
In-Reply-To: <59c87bb9-b92e-00a4-8876-97f1e7ea1957@broadcom.com> (sfid-20160606_105827_934771_104BC528)
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
	 <1465119005-4161-2-git-send-email-arend.vanspriel@broadcom.com>
	 <1465138846.2304.0.camel@sipsolutions.net>
	 <59c87bb9-b92e-00a4-8876-97f1e7ea1957@broadcom.com>
	 (sfid-20160606_105827_934771_104BC528)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> > I think, in order to make the new dev_coredumpsg() [or whatever
> > it's
> > called] function generally available, we have to also adjust the
> > kernel
> > version where the backported one gets used.
> True. As there are no users right now we could opt to remove the new
> function using devcoredump.patch. Or can we expect a driver using it
> soon.
> 

I have a patch for our driver to use it, which is basically only
waiting for this to get into backports :-)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
