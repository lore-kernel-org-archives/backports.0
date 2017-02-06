Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39110 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdBFLzV (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 6 Feb 2017 06:55:21 -0500
Message-ID: <1486382119.5430.2.camel@sipsolutions.net> (sfid-20170206_125523_096724_CEBAE506)
Subject: Re: matching a modified identifier?
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci <cocci@systeme.lip6.fr>
Cc: backports <backports@vger.kernel.org>
Date: Mon, 06 Feb 2017 12:55:19 +0100
In-Reply-To: <1486380902.5430.1.camel@sipsolutions.net> (sfid-20170206_123508_512386_8466ADBF)
References: <1486380902.5430.1.camel@sipsolutions.net>
         (sfid-20170206_123508_512386_8466ADBF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> @ attribute_group @
> identifier group;
> fresh identifier groups = group ## "_groups";
> declarer name ATTRIBUTE_GROUPS;
> @@
> 
> ATTRIBUTE_GROUPS(group);

If I add a dummy here:
+ATTRIBUTE_GROUPS_NAME(groups);

> @ class_group depends on attribute_group @
> identifier group_class;
> identifier attribute_group.groups;
> fresh identifier group_dev_attr = attribute_group.group ##
> "_dev_attrs";
> @@
> 
> struct class group_class = {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>         .dev_groups = groups,
> +#else
> +       .dev_attrs = group_dev_attr,
> +#endif
> };
> 
> [...]

Then the whole thing works - I guess I can live with that.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
