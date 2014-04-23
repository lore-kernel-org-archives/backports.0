Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:46581 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaDWKmZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 06:42:25 -0400
Message-ID: <1398249715.4173.3.camel@jlt4.sipsolutions.net> (sfid-20140423_124238_271545_1B490183)
Subject: Re: cocci: multiple versions of function with different arguments
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Assmann <sassmann@kpanic.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 23 Apr 2014 12:41:55 +0200
In-Reply-To: <53579593.40306@kpanic.de> (sfid-20140423_122737_920373_E36F87A8)
References: <53579593.40306@kpanic.de>
	 (sfid-20140423_122737_920373_E36F87A8)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-04-23 at 12:27 +0200, Stefan Assmann wrote:

> I'm trying to generate a patch to define a function with different
> arguments depending on the kernel version. I'm having some difficulties,
> maybe you can tell me what's wrong with the following approach.

I can't answer that, but given the premise

> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
>         vlan_rx_add_vid_func(a, b, c)
> +#else
> +       vlan_rx_add_vid_func(a, c)
> +#endif

and the fact that later kernel versions add an argument, wouldn't it be
much easier to provide a macro in the appropriate header file:

#define vlan_rx_add_vid_func(a,b,c) vlan_rx_add_vid_func(a,c)

johannes

