Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36042 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdA3I2C (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 30 Jan 2017 03:28:02 -0500
Received: by mail-wm0-f48.google.com with SMTP id c85so203455471wmi.1
        for <backports@vger.kernel.org>; Mon, 30 Jan 2017 00:27:38 -0800 (PST)
Subject: Re: issue with devcoredump.patch
To: Luca Coelho <luca@coelho.fi>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <118eb454-703f-9de9-6fc4-5326de6592ca@broadcom.com>
 <79134735-3833-5b38-e7b8-e311ad1e925b@broadcom.com>
 <1485600612.26003.20.camel@coelho.fi>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8f4f34d7-50c5-1aa8-a617-6daad3b90bd2@broadcom.com> (sfid-20170130_092804_760075_73A60754)
Date: Mon, 30 Jan 2017 09:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <1485600612.26003.20.camel@coelho.fi>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 28-1-2017 11:50, Luca Coelho wrote:
> Hey Arend,
> 
> On Tue, 2017-01-10 at 21:39 +0100, Arend Van Spriel wrote:
>> Turns out that at line 70 of the patch file there is no single space
>> before the tab, which lib/patch.py marks as an error. With that fixed
>> the fun really starts as I get following code:
>>
>> static CLASS_ATTR_RW(disabled);
>>
>> static struct attribute *devcd_class_attrs[] = {
>>         &class_attr_disabled.attr,
>>         NULL,
>> };
>> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>> ATTRIBUTE_GROUPS(devcd_class);
>> #else
>> #define BP_ATTR_GRP_STRUCT device_attribute
>> ATTRIBUTE_GROUPS_BACKPORT(devcd_class);
>> #endif
>>
>> static struct class devcd_class = {
>>         .name           = "devcoredump",
>>         .owner          = THIS_MODULE,
>>         .dev_release    = devcd_dev_release,
>> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>>         .dev_groups     = devcd_dev_groups,
>> #else
>>         .dev_attrs = devcd_class_dev_attrs,
>> #endif
>> #endif
>> #if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
>>         .class_attrs    = devcd_class_attrs,
>> #else
>>         .class_groups   = devcd_class_groups,
>> #endif
>> };
>>
>> This is because the new devcoredump.c in 4.10-rc1 now triggers a
>> Coccinelle script to kick in, ie.
>> patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci.
>> It seems to kick in because of the ATTRIBUTE_GROUPS(devcd_class) macro.
> 
> Did you ever get this to work? I'm getting this warnings:
> 
> home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:197:3: warning: initialization from incompatible pointer type [enabled by default]
>    .class_attrs = devcd_class_attrs,
>    ^
> /home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:197:3: warning: (near initialization for ‘devcd_class.class_attrs’) [enabled by default]
> In file included from /home/luca/iwlwifi/stack-dev/backport-include/linux/sysfs.h:3:0,
>                  from include/linux/kobject.h:21,
>                  from include/linux/module.h:17,
>                  from /home/luca/iwlwifi/stack-dev/backport-include/linux/module.h:3,
>                  from /home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:27:
> /home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:179:18: warning: ‘devcd_class_groups’ defined but not used [-Wunused-variable]
>  ATTRIBUTE_GROUPS(devcd_class);
>                   ^
> include/linux/sysfs.h:131:38: note: in definition of macro ‘__ATTRIBUTE_GROUPS’
>  static const struct attribute_group *_name##_groups[] = { \
>                                       ^
> /home/luca/iwlwifi/stack-dev/compat/drivers-base-devcoredump.c:179:1: note: in expansion of macro ‘ATTRIBUTE_GROUPS’
>  ATTRIBUTE_GROUPS(devcd_class);
>  ^
> 
> Any idea how to fix it?

Yeah. This is what I hit after fixing the devcoredump.patch. Because of
the recent change in drivers/base/devcoredump.c I think
0001-group_attr_class.cocci needs to be quite a bit smarter. My SmPL
knowledge is still somewhat limited so I did not get it working
properly. Maybe posting the problem (in simplified form) on the Cocci
mailing list will get us a solution.

Regards,
Arend

--
To unsubscribe from this list: send the line "unsubscribe backports" in
