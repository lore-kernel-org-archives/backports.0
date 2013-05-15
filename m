Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:53774 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983Ab3EOHnX (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 May 2013 03:43:23 -0400
Message-ID: <1368603799.8359.5.camel@jlt4.sipsolutions.net> (sfid-20130515_094325_251085_53860DF2)
Subject: Re: [PATCH 0/3] backports: take up up to next-20130426
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 15 May 2013 09:43:19 +0200
In-Reply-To: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130513_122443_741546_4F94889F)
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130513_122443_741546_4F94889F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-13 at 03:24 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This series takes us up to next-20130426. 

Also applied these.

> The next tag
> is next-20130429 and it seems that Linus took accepted
> code reflected there so for instance we'll need to
> complete the backport of these next:
> 
>   * remove_proc_subtree() 
>   * proc_set_size()
>   * ttm_bo_reference()
>   * ttm_bo_unref()
>   * ttm_kmap_obj_virtual()

I take it these are more problematic?

johannes

