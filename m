Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39671 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751291AbdBFMXG (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 07:23:06 -0500
Date: Mon, 6 Feb 2017 13:22:52 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: cocci <cocci@systeme.lip6.fr>,
        backports <backports@vger.kernel.org>
Subject: Re: [Cocci] matching a modified identifier?
In-Reply-To: <1486380902.5430.1.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1702061321500.8663@hadrien> (sfid-20170206_132325_865138_D74AB941)
References: <1486380902.5430.1.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-995527867-1486383772=:8663"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

--8323329-995527867-1486383772=:8663
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 6 Feb 2017, Johannes Berg wrote:

> Hi,
>
> In backports, we have the following spatch:
>
> @ attribute_group @
> identifier group;
> declarer name ATTRIBUTE_GROUPS;
> @@
>
> ATTRIBUTE_GROUPS(group);
>
> @ class_group depends on attribute_group @
> identifier group_class;
> identifier groups;
> fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
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
>
>
>
> But this isn't sufficient and falls over if there are multiple
> instances of ATTRIBUTE_GROUPS, it's essentially undefined which one
> gets picked.
>
> I tried to match a modified identifier like this:
>
> @ attribute_group @
> identifier group;
> fresh identifier groups = group ## "_groups";
> declarer name ATTRIBUTE_GROUPS;
> @@
>
> ATTRIBUTE_GROUPS(group);
>
> @ class_group depends on attribute_group @
> identifier group_class;
> identifier attribute_group.groups;
> fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
> @@
>
> struct class group_class = {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>         .dev_groups = groups,
> +#else
> +       .dev_attrs = group_dev_attr,
> +#endif
> };
>
> [...]
>
>
> but that doesn't work at all.

Use python between the two rules to construct the identifier you want.
You can see examples in coccinelle/demos/pythontococci.cocci

julia
--8323329-995527867-1486383772=:8663--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
