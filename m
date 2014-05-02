Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39844 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaEBA7H (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 20:59:07 -0400
Received: by mail-pd0-f169.google.com with SMTP id z10so2578598pdj.28
        for <backports@vger.kernel.org>; Thu, 01 May 2014 17:59:05 -0700 (PDT)
Date: Thu, 1 May 2014 17:59:00 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH 0/3] backports: fixes for RHEL7.0
Message-ID: <20140502005900.GB957@garbanzo.do-not-panic.com> (sfid-20140502_025909_412624_47960CC1)
References: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398410070-30529-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 25, 2014 at 09:14:27AM +0200, Stefan Assmann wrote:
> Get backports ready for RHEL7.0.
> 
> Stefan Assmann (3):
>   backports: wrap dma_set_mask_and_coherent in LINUX_BACKPORT()
>   backports: add linux/of_graph.h to copy-list
>   backports: ifdef code already present in RHEL7.0
> 
>  backport/backport-include/linux/device.h      | 2 +-
>  backport/backport-include/linux/dma-mapping.h | 1 +
>  backport/backport-include/linux/skbuff.h      | 2 +-
>  backport/compat/dma-shared-helpers.c          | 2 ++
>  copy-list                                     | 1 +
>  5 files changed, 6 insertions(+), 2 deletions(-)

Thanks, applied!

  Luis
