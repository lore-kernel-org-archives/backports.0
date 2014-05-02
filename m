Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39591 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaEBBuX (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:50:23 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so3989971pdj.3
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:50:22 -0700 (PDT)
Date: Thu, 1 May 2014 18:50:17 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: select_queue patch: fix callback kernel
 version
Message-ID: <20140502015017.GA3994@garbanzo.do-not-panic.com> (sfid-20140502_035025_262929_4D616FD2)
References: <1398895825-18420-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398895825-18420-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 01, 2014 at 12:10:25AM +0200, Johannes Berg wrote:
> diff --git a/stack-auto.ini b/stack-auto.ini
> index 0412f8df60e4..4679a5cd52a7 100644
> --- a/stack-auto.ini
> +++ b/stack-auto.ini
> @@ -1,5 +1,5 @@
>  [DEFAULT]
> -cachedir = .
> +cachedir = /home/johannes/tmp/work/
>  
>  [iwlwifi]
>  

Thanks! I'll just ignore this hunk as it likely just slipped. Applied!

  Luis
