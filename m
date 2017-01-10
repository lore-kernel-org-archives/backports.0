Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36313 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdAJUjx (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 10 Jan 2017 15:39:53 -0500
Received: by mail-qk0-f177.google.com with SMTP id 11so89104227qkl.3
        for <backports@vger.kernel.org>; Tue, 10 Jan 2017 12:39:53 -0800 (PST)
Received: from [10.177.251.13] ([80.82.130.242])
        by smtp.gmail.com with ESMTPSA id 14sm2304246qtp.19.2017.01.10.12.39.51
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 12:39:52 -0800 (PST)
Subject: Re: issue with devcoredump.patch
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <118eb454-703f-9de9-6fc4-5326de6592ca@broadcom.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <79134735-3833-5b38-e7b8-e311ad1e925b@broadcom.com> (sfid-20170110_214132_713280_CC867BE4)
Date: Tue, 10 Jan 2017 21:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <118eb454-703f-9de9-6fc4-5326de6592ca@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10-1-2017 12:16, Arend Van Spriel wrote:
> With 4.10-rc1 the devcoredump.patch in patches/backport-adjustment no
> longer applies due to following commit:
> 
> commit f76d25275c314defb684fdd692239507001774bc
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Mon Nov 28 16:41:58 2016 +0100
> 
>     driver core: devcoredump: convert to use class_groups
> 
>     Convert devcoredump to use class_groups instead of class_attrs as that's
>     the correct way to handle lists of class attribute files.
> 
>     Acked-by: Johannes Berg <johannes@sipsolutions.net>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> So I am reworking the patch file (attached). When I run gentree I get
> following:
> 
> Traceback (most recent call last):
>   File "./gentree.py", line 1091, in <module>
>     ret = _main()
>   File "./gentree.py", line 724, in _main
>     logwrite=logwrite)
>   File "./gentree.py", line 906, in process
>     apply_patches(args, "backport", source_dir, 'patches',
> bpid.target_dir, logwrite)
>   File "./gentree.py", line 514, in apply_patches
>     raise Exception('No patch content found in %s' % print_name)
> Exception: No patch content found in backport-adjustments/devcoredump.patch
> 
> However, go into the target dir and applying patch works fine:
> 
> $ patch -p1 < ~-/patches/backport-adjustments/devcoredump.patch
> patching file compat/drivers-base-devcoredump.c
> Hunk #7 succeeded at 181 with fuzz 1 (offset 2 lines).
> Hunk #8 succeeded at 248 (offset 2 lines).
> Hunk #9 succeeded at 339 (offset 2 lines).
> Hunk #10 succeeded at 386 (offset 2 lines).
> patching file include/linux/backport-devcoredump.h
> 
> So I am a bit puzzled as to what is going on so currently debugging
> lib/patch.py. If anyone has a good hint feel free to let me know.

Turns out that at line 70 of the patch file there is no single space
before the tab, which lib/patch.py marks as an error. With that fixed
the fun really starts as I get following code:

static CLASS_ATTR_RW(disabled);

static struct attribute *devcd_class_attrs[] = {
        &class_attr_disabled.attr,
        NULL,
};
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
ATTRIBUTE_GROUPS(devcd_class);
#else
#define BP_ATTR_GRP_STRUCT device_attribute
ATTRIBUTE_GROUPS_BACKPORT(devcd_class);
#endif

static struct class devcd_class = {
        .name           = "devcoredump",
        .owner          = THIS_MODULE,
        .dev_release    = devcd_dev_release,
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        .dev_groups     = devcd_dev_groups,
#else
        .dev_attrs = devcd_class_dev_attrs,
#endif
#endif
#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
        .class_attrs    = devcd_class_attrs,
#else
        .class_groups   = devcd_class_groups,
#endif
};

This is because the new devcoredump.c in 4.10-rc1 now triggers a
Coccinelle script to kick in, ie.
patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci.
It seems to kick in because of the ATTRIBUTE_GROUPS(devcd_class) macro.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
