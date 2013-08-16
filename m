Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40929 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3HPC6M (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 15 Aug 2013 22:58:12 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so1620633pdj.36
        for <backports@vger.kernel.org>; Thu, 15 Aug 2013 19:58:12 -0700 (PDT)
Date: Thu, 15 Aug 2013 20:07:16 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Solomon Peachy <pizza@shaftnet.org>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backports:  Add patch for cw1200_sdio with
 kernels < 3.2
Message-ID: <20130816030715.GB9574@garbanzo.do-not-panic.com> (sfid-20130816_045815_475724_7E318464)
References: <1376571357-16506-1-git-send-email-pizza@shaftnet.org>
 <1376571357-16506-2-git-send-email-pizza@shaftnet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376571357-16506-2-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 15, 2013 at 08:55:57AM -0400, Solomon Peachy wrote:
> Without this patch, the hardware *will* hang on <3.2 kernels when a
> 512-byte SDIO transfer occurs.
> 
> 3.2-rc added an SDIO quirk to work around this, so this code was
> stripped from the driver when committed to the mainline.
> 
> Signed-off-by: Solomon Peachy <pizza@shaftnet.org>

Thanks, applied both and pushed!

  Luis
