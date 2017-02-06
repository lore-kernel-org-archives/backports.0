Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36677 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBFWWZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 17:22:25 -0500
Received: by mail-wr0-f173.google.com with SMTP id k90so28204298wrc.3
        for <backports@vger.kernel.org>; Mon, 06 Feb 2017 14:22:24 -0800 (PST)
Subject: Re: [PATCH 2/3] backports: restrict group_attr spatch properly
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <20170206123956.20082-1-johannes@sipsolutions.net>
 <20170206123956.20082-2-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2e16b777-2ac5-023e-ba7f-03e5f11bc661@broadcom.com> (sfid-20170206_232227_904700_46BBECC5)
Date: Mon, 6 Feb 2017 23:22:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170206123956.20082-2-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 6-2-2017 13:39, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>

Maybe explain what went wrong here. I had email discussion with Julia
about this one (on cocci list), but glad you picked it up ;-)

Regards,
Arend

> Change-Id: I8881dab783fe69a85f833c96f0a4abd3ab062e84
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../0001-group-attr/0001-group_attr_class.cocci       | 18 ++++++++++++------
>  .../generic/0001-group-attr/0002-group_attr_bus.cocci | 19 ++++++++++++-------
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci b/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
> index ea2e7039f50c..a9c84651eedc 100644
> --- a/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
> +++ b/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
> @@ -33,9 +33,15 @@ declarer name ATTRIBUTE_GROUPS;
>  
>  ATTRIBUTE_GROUPS(group);
>  
> -@ class_group depends on attribute_group @
> +@script:python attribute_groups_name@
> +group << attribute_group.group;
> +groups;
> +@@
> +coccinelle.groups = group + "_groups"
> +
> +@ class_group @
>  identifier group_class;
> -expression groups;
> +identifier attribute_groups_name.groups;
>  fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
>  @@
>  
> @@ -47,9 +53,9 @@ struct class group_class = {
>  +#endif
>  };
>  
> -@ attribute_group_mod depends on attribute_group && class_group @
> +@ attribute_group_mod depends on class_group @
>  declarer name ATTRIBUTE_GROUPS_BACKPORT;
> -identifier group;
> +identifier attribute_group.group;
>  @@
>  
>  +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
> @@ -59,10 +65,10 @@ ATTRIBUTE_GROUPS(group);
>  +ATTRIBUTE_GROUPS_BACKPORT(group);
>  +#endif
>  
> -@ class_registering depends on class_group && attribute_group_mod @
> +@ class_registering @
>  identifier class_register, ret;
>  identifier class_group.group_class;
> -fresh identifier group_class_init = "init_" ## attribute_group_mod.group ## "_attrs";
> +fresh identifier group_class_init = "init_" ## attribute_group.group ## "_attrs";
>  @@
>  
>  (
> diff --git a/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci b/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
> index b01da875083b..c19e9d7f3eda 100644
> --- a/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
> +++ b/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
> @@ -31,9 +31,15 @@ declarer name ATTRIBUTE_GROUPS;
>  
>  ATTRIBUTE_GROUPS(group);
>  
> -@ bus_group depends on attribute_group @
> +@script:python attribute_groups_name@
> +group << attribute_group.group;
> +groups;
> +@@
> +coccinelle.groups = group + "_groups"
> +
> +@ bus_group @
>  identifier group_bus;
> -expression groups;
> +identifier attribute_groups_name.groups;
>  fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
>  @@
>  
> @@ -45,9 +51,9 @@ struct bus_type group_bus = {
>  +#endif
>  };
>  
> -@ attribute_group_mod depends on attribute_group && bus_group @
> +@ attribute_group_mod depends on bus_group @
>  declarer name ATTRIBUTE_GROUPS_BACKPORT;
> -identifier group;
> +identifier attribute_group.group;
>  @@
>  
>  +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
> @@ -57,10 +63,10 @@ ATTRIBUTE_GROUPS(group);
>  +ATTRIBUTE_GROUPS_BACKPORT(group);
>  +#endif
>  
> -@ bus_registering depends on bus_group && attribute_group_mod @
> +@ bus_registering @
>  identifier bus_register, ret;
>  identifier bus_group.group_bus;
> -fresh identifier group_bus_init = "init_" ## attribute_group_mod.group ## "_attrs";
> +fresh identifier group_bus_init = "init_" ## attribute_group.group ## "_attrs";
>  @@
>  
>  (
> @@ -70,4 +76,3 @@ fresh identifier group_bus_init = "init_" ## attribute_group_mod.group ## "_attr
>  +       group_bus_init();
>          ret = bus_register(&group_bus);
>  )
> -
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
