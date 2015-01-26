Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54424 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbbAZIkV (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 26 Jan 2015 03:40:21 -0500
Message-ID: <1422261618.1890.11.camel@sipsolutions.net> (sfid-20150126_094023_034807_AE7627E2)
Subject: Re: [PATCH 2/3] header: add linux/hdmi.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Mon, 26 Jan 2015 09:40:18 +0100
In-Reply-To: <1422055240-4753-3-git-send-email-hauke@hauke-m.de> (sfid-20150124_002050_356021_E7A9E878)
References: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
	 <1422055240-4753-3-git-send-email-hauke@hauke-m.de>
	 (sfid-20150124_002050_356021_E7A9E878)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2015-01-24 at 00:20 +0100, Hauke Mehrtens wrote:
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  backport/backport-include/linux/hdmi.h | 41 ++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 backport/backport-include/linux/hdmi.h
> 
> diff --git a/backport/backport-include/linux/hdmi.h b/backport/backport-include/linux/hdmi.h
> new file mode 100644
> index 0000000..a6d6880
> --- /dev/null
> +++ b/backport/backport-include/linux/hdmi.h

Would it make sense to automatically copy & slightly patch this file in
case it gets extended later?

johannes

