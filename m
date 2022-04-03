Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA4C433EF
	for <backports@archiver.kernel.org>; Sun,  3 Apr 2022 23:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376654AbiDCX2u (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 3 Apr 2022 19:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCX2s (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 3 Apr 2022 19:28:48 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A346A193DF
        for <backports@vger.kernel.org>; Sun,  3 Apr 2022 16:26:53 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4KWqmr14kkz9sSy;
        Mon,  4 Apr 2022 01:26:52 +0200 (CEST)
Message-ID: <17bf5fc4-fdd3-15b2-93b9-5d73500e3590@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649028410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rz6Qu0XowA95LH33QKj/y6gdcBR3Wop1PitU7jx7suA=;
        b=ke0u6/3HDjPkLUQo/mD+dVXhYiKnWk5PlOnysMzm85sZizvOk9X8O2c3lQ9vqKAoG1S4pg
        nHPHEV9+cx04Vy4NikqV3WYKeYbWd5wKyft/bBjTrQ/Di57gTbbujnSI2yJ1CWJ7UubQvw
        Z+Eiu3wedmN1qPMMItu6BcrQSIqU9ERQcZYysvjRIpTrhRZGpM+i47BhgRGOz5MnwHGmAP
        P04s+B9uewdTXS0jmPYK0fAZ3n2UHTJJeQLMfs+6vaGbnjrhoxMzvIZVDI3gcDE79foz4I
        sISEg9vCFf6QeEKDGh+oTJhhRI/iSoVVHXdDetu+nXEiBwH6Q4QVR7DD70FAhA==
Date:   Mon, 4 Apr 2022 01:26:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/7] backports: backport {get,set}_user_ifreq
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, mcgrof@kernel.org
Cc:     backports@vger.kernel.org
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
 <20220207113338.214748-4-jiaxun.yang@flygoat.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220207113338.214748-4-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2/7/22 12:33, Jiaxun Yang wrote:
> Backport them from 5.15, they are required by QRTR.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   backport/backport-include/linux/netdevice.h |  5 +++
>   backport/compat/Makefile                    |  1 +
>   backport/compat/backport-5.15.c             | 47 +++++++++++++++++++++
>   3 files changed, 53 insertions(+)
>   create mode 100644 backport/compat/backport-5.15.c
> 
> diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
> index 22942398..4e553791 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -152,6 +152,11 @@ bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
>   #endif /* < 4.11 */
>   
>   #if LINUX_VERSION_IS_LESS(5,15,0)
> +#define get_user_ifreq LINUX_BACKPORT(get_user_ifreq)
> +int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg);
> +#define put_user_ifreq LINUX_BACKPORT(put_user_ifreq)
> +int put_user_ifreq(struct ifreq *ifr, void __user *arg);
> +
>   static inline void backport_dev_put(struct net_device *dev)
>   {
>   	if (dev)
> diff --git a/backport/compat/Makefile b/backport/compat/Makefile
> index 2761e5f5..b9f1dee9 100644
> --- a/backport/compat/Makefile
> +++ b/backport/compat/Makefile
> @@ -20,6 +20,7 @@ compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
>   compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
>   compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
>   compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
> +compat-$(CPTCFG_KERNEL_5_15) += backport-5.15.o
>   
>   compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
>   compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
> diff --git a/backport/compat/backport-5.15.c b/backport/compat/backport-5.15.c
> new file mode 100644
> index 00000000..cc0a48fd
> --- /dev/null
> +++ b/backport/compat/backport-5.15.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/compat.h>
> +#include <linux/export.h>
> +#include <linux/uaccess.h>
> +#include <linux/netdevice.h>
> +
> +#include <uapi/linux/if.h>
> +
> +int get_user_ifreq(struct ifreq *ifr, void __user **ifrdata, void __user *arg)
> +{
> +	if (in_compat_syscall()) {

in_compat_syscall() is not available on kernel <= 4.5 and the 
compilation fails.
get_user_ifreq() and put_user_ifreq() are only needed for QRTR which is 
only added for kernel >= 5.2.

Please add "#if LINUX_VERSION_IS_GEQ(4,6,0)" here and "#if 
LINUX_VERSION_IN_RANGE(4,6,0, 5,15,0)" to the header file.

I will do it when applying the patch.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
