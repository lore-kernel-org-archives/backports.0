Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:37022 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750828AbdA1Ku0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 28 Jan 2017 05:50:26 -0500
Message-ID: <1485600612.26003.20.camel@coelho.fi> (sfid-20170128_115034_513410_48DF4C3B)
From: Luca Coelho <luca@coelho.fi>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sat, 28 Jan 2017 12:50:12 +0200
In-Reply-To: <79134735-3833-5b38-e7b8-e311ad1e925b@broadcom.com>
References: <118eb454-703f-9de9-6fc4-5326de6592ca@broadcom.com>
         <79134735-3833-5b38-e7b8-e311ad1e925b@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: issue with devcoredump.patch
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hey Arend,

On Tue, 2017-01-10 at 21:39 +0100, Arend Van Spriel wrote:
> Turns out that at line 70 of the patch file there is no single space
> before the tab, which lib/patch.py marks as an error. With that fixed
> the fun really starts as I get following code:
> 
> static CLASS_ATTR_RW(disabled);
> 
> static struct attribute *devcd_class_attrs[] = {
>         &class_attr_disabled.attr,
>         NULL,
> };
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
> ATTRIBUTE_GROUPS(devcd_class);
> #else
> #define BP_ATTR_GRP_STRUCT device_attribute
> ATTRIBUTE_GROUPS_BACKPORT(devcd_class);
> #endif
> 
> static struct class devcd_class = {
>         .name           = "devcoredump",
>         .owner          = THIS_MODULE,
>         .dev_release    = devcd_dev_release,
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>         .dev_groups     = devcd_dev_groups,
> #else
>         .dev_attrs = devcd_class_dev_attrs,
> #endif
> #endif
> #if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
>         .class_attrs    = devcd_class_attrs,
> #else
>         .class_groups   = devcd_class_groups,
> #endif
> };
> 
> This is because the new devcoredump.c in 4.10-rc1 now triggers a
> Coccinelle script to kick in, ie.
> patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci.
> It seems to kick in because of the ATTRIBUTE_GROUPS(devcd_class) macro.

Did you ever get this to work? I'm getting this warnings:

home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:197:3: warning: initialization from incompatible pointer type [enabled by default]
   .class_attrs = devcd_class_attrs,
   ^
/home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:197:3: warning: (near initialization for ‘devcd_class.class_attrs’) [enabled by default]
In file included from /home/luca/iwlwifi/stack-dev/backport-include/linux/sysfs.h:3:0,
                 from include/linux/kobject.h:21,
                 from include/linux/module.h:17,
                 from /home/luca/iwlwifi/stack-dev/backport-include/linux/module.h:3,
                 from /home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:27:
/home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:179:18: warning: ‘devcd_class_groups’ defined but not used [-Wunused-variable]
 ATTRIBUTE_GROUPS(devcd_class);
                  ^
include/linux/sysfs.h:131:38: note: in definition of macro ‘__ATTRIBUTE_GROUPS’
 static const struct attribute_group *_name##_groups[] = { \
                                      ^
/home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:179:1: note: in expansion of macro ‘ATTRIBUTE_GROUPS’
 ATTRIBUTE_GROUPS(devcd_class);
 ^

Any idea how to fix it?

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
