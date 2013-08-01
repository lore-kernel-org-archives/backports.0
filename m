Return-path: <backports-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:34491 "EHLO
	sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3HARKr (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 13:10:47 -0400
Date: Thu, 1 Aug 2013 10:10:45 -0700
From: "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
To: Patrick Ziegler <patrick.ziegler@fh-kl.de>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [RFC v3 0/9] backports: add wwan device drivers
Message-ID: <20130801171044.GK17130@pogo> (sfid-20130801_191050_261649_FFF8F001)
References: <51FA85B9.7050502@fh-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <51FA85B9.7050502@fh-kl.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 01, 2013 at 05:58:49PM +0200, Patrick Ziegler wrote:
> This adds wwan drivers for mobile broadband devices.
> Patches 1 to 8 add missing stuff required for the wwan drivers.
> Patch 9 adds device drivers.
> 
> Changes v2:
>  - rebased on last RFCs for next-20130729
> 
> Changes v3:
>  - add new patch to add missing USB_SPEED_SUPER
>  - fix PCI build errors in a better way

Nice! Looks good to me except for just export symbol stuff. Let me know
if you want to respin or want me to try to merge these with the symbol
change. Up to you.

  Luis
