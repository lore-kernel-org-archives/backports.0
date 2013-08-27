Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52369 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3H0Sxa (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 14:53:30 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so5225807pbb.13
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 11:53:28 -0700 (PDT)
Date: Tue, 27 Aug 2013 12:02:49 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Subject: Re: [PATCH 2/2] backports: do not depend on PCI functions when PCI
 is disabled in the kernel
Message-ID: <20130827190248.GH7485@garbanzo.do-not-panic.com> (sfid-20130827_205331_804188_A8323180)
References: <1377354539-9202-1-git-send-email-hauke@hauke-m.de>
 <1377354539-9202-2-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377354539-9202-2-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Aug 24, 2013 at 04:28:59PM +0200, Hauke Mehrtens wrote:
> This should prevent some compile errors when backports is used with a
> kernel without PCI support.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks, applied and pushed!

  Luis
