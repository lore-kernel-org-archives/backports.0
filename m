Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B4C433EF
	for <backports@archiver.kernel.org>; Sun, 28 Nov 2021 21:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhK1V4a (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 28 Nov 2021 16:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhK1Vy3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 28 Nov 2021 16:54:29 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B303C061759
        for <backports@vger.kernel.org>; Sun, 28 Nov 2021 13:51:05 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4J2McR4ZDPzQk21;
        Sun, 28 Nov 2021 22:51:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1638136261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhNOmxhBhetPZIyBi1Li7jM08cgIpjVnj6Rb1TxQWDY=;
        b=s6ufHEMcZxOf+cfrhqToK791ZP/pvxmXIy/47BbX2x72SLt8WTQART2MrHlAwyNyoFGopz
        1ArRJ/xk3vNoxXJG5iI1fJOGfwQmnaRsGoyjwbbRf7U+oDmzpBxchc0cr8Ug6vOn7wrCeo
        t+mQE4P68Aakzlur0NoP/cNuwT8vIoQEC93P8FtgL1a5nFdwRiq/enuEC8+/GUjUW/S2aa
        4cVmzPd6hJPxa8hr9wJFElmkzpWPZDfe8mWyfMCHJrkESf00t4VdEuGspT4jykx6i0o2IS
        KSf7kwTvzehEWfxbAE2/3oXUKYgEu8t9j9CnOmS5EUgWaeqMjiXlyePW/Fya0w==
Subject: Re: [PATCH 1/7] backport: refresh integration patch
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        backports <backports@vger.kernel.org>
Cc:     Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@ibsgaard.io>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
 <20211124055505.1267128-2-thomas@adapt-ip.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <f1d3c92d-1532-09ee-5ce2-4d81793c16b7@hauke-m.de>
Date:   Sun, 28 Nov 2021 22:50:59 +0100
MIME-Version: 1.0
In-Reply-To: <20211124055505.1267128-2-thomas@adapt-ip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 11/24/21 6:54 AM, Thomas Pedersen wrote:
> From: Thomas Pedersen <thomas@ibsgaard.io>
> 
> This was refreshed on Linux v5-10.42.

Does this patch still apply with kernel 5.15?

> 
> Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
> ---
>   .../0001-enable-backports-built-in.patch      | 34 ++++++++-----------
>   1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch b/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
> index d66b203d0d07..35765ed113eb 100644
> --- a/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
> +++ b/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
> @@ -1,40 +1,36 @@
> -Allow backports to be integrated into vmlinux.
> -
>   diff --git a/Makefile b/Makefile
> -index 6d1e304..de26b18 100644
> +index e5d41b6792d7..cdd600bda9d1 100644
>   --- a/Makefile
>   +++ b/Makefile
> -@@ -542,6 +542,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
> - 	$(Q)$(MAKE) $(build)=$(@)
> +@@ -594,6 +594,7 @@ export KBUILD_MODULES KBUILD_BUILTIN
>    
> + ifeq ($(KBUILD_EXTMOD),)
>    # Objects we will link into vmlinux / subdirs we need to visit
>   +backports-y 	:= backports/
>    init-y		:= init/
>    drivers-y	:= drivers/ sound/ firmware/
>    net-y		:= net/
> -@@ -820,13 +821,16 @@ core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
> +@@ -989,11 +990,13 @@ core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
>    
>    vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>    		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
>   +		     $(backports-y) $(backports-m) \
> - 		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
> + 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
>    
>    vmlinux-alldirs	:= $(sort $(vmlinux-dirs) $(patsubst %/,%,$(filter %/, \
> - 		     $(init-n) $(init-) \
> - 		     $(core-n) $(core-) $(drivers-n) $(drivers-) \
> -+		     $(backports-n) $(backports-) \
> - 		     $(net-n)  $(net-)  $(libs-n)    $(libs-))))
> +-		     $(init-) $(core-) $(drivers-) $(net-) $(libs-) $(virt-))))
> ++		     $(init-) $(core-) $(drivers-) $(net-) $(libs-) $(virt-) $(backports))))
>    
> -+backports-y	:= $(patsubst %/, %/built-in.o, $(backports-y))
> - init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
> - core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
> - drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
> -@@ -837,7 +841,7 @@ libs-y		:= $(libs-y1) $(libs-y2)
> ++backports-y	:= $(patsubst %/, %/built-in.a, $(backports-y))
> + init-y		:= $(patsubst %/, %/built-in.a, $(init-y))
> + core-y		:= $(patsubst %/, %/built-in.a, $(core-y))
> + drivers-y	:= $(patsubst %/, %/built-in.a, $(drivers-y))
> +@@ -1004,7 +1007,7 @@ virt-y		:= $(patsubst %/, %/built-in.a, $(virt-y))
>    
>    # Externally visible symbols (used by link-vmlinux.sh)
>    export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
> --export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> -+export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y) $(backports-y)
> +-export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y)
> ++export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y) $(backports-y)
> + export KBUILD_VMLINUX_LIBS := $(libs-y1)
>    export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>    export LDFLAGS_vmlinux
> - # used by scripts/pacmage/Makefile
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
