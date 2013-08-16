Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:40005 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3HPRf7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 16 Aug 2013 13:35:59 -0400
Message-ID: <1376674550.15299.27.camel@jlt4.sipsolutions.net> (sfid-20130816_193600_853042_2B7E2229)
Subject: Re: [PATCH 08/13] backports: revert the sysfs api change
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Date: Fri, 16 Aug 2013 19:35:50 +0200
In-Reply-To: <1376674003-5801-8-git-send-email-hauke@hauke-m.de> (sfid-20130816_192740_585582_63BCDE6E)
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
	 <1376674003-5801-8-git-send-email-hauke@hauke-m.de>
	 (sfid-20130816_192740_585582_63BCDE6E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-08-16 at 19:26 +0200, Hauke Mehrtens wrote:
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
> +#define BUS_ATTR_RW(_name)
> +#define BUS_ATTR_RO(_name)
> +#define DRIVER_ATTR_RW(_name)
> +#define DRIVER_ATTR_RO(_name)
> +#define CLASS_ATTR_RW(_name)
> +#define CLASS_ATTR_RO(_name)
> +#define DEVICE_ATTR_RW(_name)
> +#define DEVICE_ATTR_RO(_name)
> +#endif

Is that part really helpful? Seems you'd want it to fail, or am I
misunderstanding it?

johannes


