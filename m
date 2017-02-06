Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35765 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdBFWhD (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 17:37:03 -0500
Received: by mail-wm0-f42.google.com with SMTP id b65so140232997wmf.0
        for <backports@vger.kernel.org>; Mon, 06 Feb 2017 14:37:02 -0800 (PST)
Subject: Re: [PATCH 3/3] backports: support class_groups
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <20170206123956.20082-1-johannes@sipsolutions.net>
 <20170206123956.20082-3-johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <445404f1-7231-fb2f-0faf-5093b69926ae@broadcom.com> (sfid-20170206_233705_198112_9B6CF8A7)
Date: Mon, 6 Feb 2017 23:36:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170206123956.20082-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 6-2-2017 13:39, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Add a new semantic patch just like for dev_groups to
> support class_groups.
> 
> Change-Id: I114e1a6ed8db901b3aa738a5052721d1da45cae4

Does it make sense to keep the Change-Id: things here?

> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  .../0001-group-attr/0003-class_groups.cocci        | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci
> 
> diff --git a/patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci b/patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci
> new file mode 100644
> index 000000000000..a4694dd75763
> --- /dev/null
> +++ b/patches/collateral-evolutions/generic/0001-group-attr/0003-class_groups.cocci
> @@ -0,0 +1,54 @@
> +/* see upstream commit ced6473e74867 */
> +
> +@ attribute_group @
> +identifier group;
> +declarer name ATTRIBUTE_GROUPS;
> +@@
> +
> +ATTRIBUTE_GROUPS(group);
> +
> +@script:python attribute_groups_name@
> +group << attribute_group.group;
> +groups;
> +@@
> +coccinelle.groups = group + "_groups"
> +
> +@ class_group @
> +identifier group_class;
> +identifier attribute_groups_name.groups;
> +fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";

So how will this work wrt naming scheme. Can we be sure all class_attrs
occurrences in the files we copy are named as such, ie. with _dev_attrs
post-fix?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
