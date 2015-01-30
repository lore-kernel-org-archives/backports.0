Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55999 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756264AbbA3UV4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 30 Jan 2015 15:21:56 -0500
Message-ID: <1422649309.1919.42.camel@sipsolutions.net> (sfid-20150130_212158_969698_EE3100E5)
Subject: Re: [PATCH 2/2] backport: add backport file for the next kernel
 release
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Date: Fri, 30 Jan 2015 21:21:49 +0100
In-Reply-To: <1422648758-31361-2-git-send-email-arend@broadcom.com> (sfid-20150130_211248_858610_757440B4)
References: <1422648758-31361-1-git-send-email-arend@broadcom.com>
	 <1422648758-31361-2-git-send-email-arend@broadcom.com>
	 (sfid-20150130_211248_858610_757440B4)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-01-30 at 21:12 +0100, Arend van Spriel wrote:

> --- /dev/null
> +++ b/backport/compat/backport-3.20.c
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>

Speaking of copy/paste errors ... :)

> + * Backport functionality introduced in Linux 3.19.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/export.h>
> +#include <linux/net.h>
> +
> +struct net *get_net_ns_by_fd(int fd)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +EXPORT_SYMBOL_GPL(get_net_ns_by_fd);

Interesting approach - you're relying on a previously existing
definition in some existing header file I guess? But does it always
exist?

I think it'd probably be better to have this in
backports-include/net/net_namespace.h, like so:

#define get_net_ns_by_fd LINUX_BACKPORT(get_net_ns_by_fd)
static inline struct net *get_net_ns_by_fd(int fd)
{
	return ERR_PTR(-EINVAL);
}

because that not only saves the huge EXPORT_SYMBOL thing (that's like a
few hundred bytes IIRC!) but also makes sure that the definition is
always really there?

Anyway as long as this was there on 3.0 already both approaches work, of
course.

johannes

