Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49502 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcD3PsY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 11:48:24 -0400
Subject: Re: Build failures using recent backports
To: Marty Faltesek <mfaltesek@google.com>, backports@vger.kernel.org
References: <CAOiWkA-v6sbEP0v4E7uAzrpO=dkhJvNsht-h8Wt0+kNwGffwnQ@mail.gmail.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5724D3BF.7070703@hauke-m.de> (sfid-20160430_174829_046151_4EB7ABDC)
Date: Sat, 30 Apr 2016 17:48:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAOiWkA-v6sbEP0v4E7uAzrpO=dkhJvNsht-h8Wt0+kNwGffwnQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030701030904040601070308"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030701030904040601070308
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 02/23/2016 08:45 PM, Marty Faltesek wrote:
> We are building backports 20160122 for a 3.3.8 kernel, and get
> multiple build failures. The last backports build that works is
> 20151115.   20151120 fails.
> 
> One of several of the failures relates to atomics:
> 
> mkdir -p /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/.tmp_versions
> ; rm -f /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/.tmp_versions/*
> /usr/bin/make -f scripts/Makefile.build
> obj=/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD
> /usr/bin/make -f scripts/Makefile.build
> obj=/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat
>    /usr/local/google/home/bk/src/gfiber/out/host/usr/bin/mips-qca-linux-uclibc-gcc
> -Wp,-MD,/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/.main.o.d
> -I/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/
> -I/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/uapi
> -I/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/include/
> -I/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/include/uapi
> -include /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/backport/backport.h
> -Wno-unused-but-set-variable
> -DCPTCFG_VERSION=\""backports-20160122-0-ga91a3e6"\"
> -DCPTCFG_KERNEL_VERSION=\""next-20160122-0-gcccc613"\"
> -DCPTCFG_KERNEL_NAME=\""Linux"\"
> -I/usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/arch/mips/include
> -Iarch/mips/include/generated -Iinclude  -include
> /usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/include/linux/kconfig.h
> -D__KERNEL__ -D"VMLINUX_LOAD_ADDRESS=0xffffffff80060000"
> -D"DATAOFFSET=0" -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
> -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration
> -Wno-format-security -fno-delete-null-pointer-checks -Os
> -fno-caller-saves -mno-check-zero-division -mabi=32 -G 0 -mno-abicalls
> -fno-pic -pipe -msoft-float -ffreestanding -march=mips32r2
> -Wa,-mips32r2 -Wa,--trap
> -I/usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/arch/mips/include/asm/mach-ath79
> -I/usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/arch/mips/include/asm/mach-generic
> -Wframe-larger-than=1024 -fno-stack-protector
> -Wno-unused-but-set-variable -fomit-frame-pointer -g
> -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
> -fconserve-stack -DCC_HAVE_ASM_GOTO
> -I/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat
>  -DMODULE -mno-long-calls  -D"KBUILD_STR(s)=#s"
> -D"KBUILD_BASENAME=KBUILD_STR(main)"
> -D"KBUILD_MODNAME=KBUILD_STR(compat)" -c -o
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/main.o
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/main.c
> In file included from include/linux/bitops.h:22:0,
>                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/linux/bitops.h:3,
>                  from include/linux/kernel.h:17,
>                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/linux/kernel.h:3,
>                  from include/linux/cache.h:4,
>                  from include/linux/time.h:7,
>                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/linux/time.h:3,
>                  from include/linux/stat.h:60,
>                  from include/linux/module.h:10,
>                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/linux/module.h:3,
>                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/main.c:1:
> /usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/arch/mips/include/asm/bitops.h:
> In function 'clear_bit_unlock':
> /usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/arch/mips/include/asm/bitops.h:180:2:
> error: implicit declaration of function 'smp_mb__before_llsc'
> [-Werror=implicit-function-declaration]
>   smp_mb__before_clear_bit();
>   ^
> 
> Looking through the commits between 11/15 and 11/20, I found the patch
> below could be related. So reverted it and problem disappeared:
> 
> commit bf4cedc367324783befc64bcc081474faf607932
> Author: Hauke Mehrtens <hauke@hauke-m.de>
> Date:   Sun Nov 22 19:03:18 2015 +0100
> 
>     header: make asm/atomic.h include asm/barrier.h
> 
> 
> 
> Then on to the next unrelated failure:
> 
> finaltargets.backports-custom-HEAD:   CC [M]
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/compat-3.7.o
> finaltargets.backports-custom-HEAD: In file included from
> include/linux/dma-mapping.h:68:0,
> finaltargets.backports-custom-HEAD:                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/linux/dma-mapping.h:3,
> finaltargets.backports-custom-HEAD:                  from
> include/asm-generic/pci-dma-compat.h:7,
> finaltargets.backports-custom-HEAD:                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/asm-generic/pci-dma-compat.h:3,
> finaltargets.backports-custom-HEAD:                  from
> /usr/local/google/home/bk/src/gfiber/out/build/linux-HEAD/arch/mips/include/asm/pci.h:132,
> finaltargets.backports-custom-HEAD:                  from
> include/linux/pci.h:1321,
> finaltargets.backports-custom-HEAD:                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/linux/pci.h:3,
> finaltargets.backports-custom-HEAD:                  from
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/compat-3.7.c:13:
> finaltargets.backports-custom-HEAD:
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/asm/dma-mapping.h:
> In function 'backport_dma_get_sgtable_attrs':
> finaltargets.backports-custom-HEAD:
> /usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/backport-include/asm/dma-mapping.h:21:2:
> error: implicit declaration of function 'dma_common_get_sgtable'
> [-Werror=implicit-function-declaration]
> finaltargets.backports-custom-HEAD:   return
> dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
> finaltargets.backports-custom-HEAD:   ^
> finaltargets.backports-custom-HEAD: cc1: some warnings being treated as errors
> finaltargets.backports-custom-HEAD: make[8]: ***
> [/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat/compat-3.7.o]
> Error 1
> finaltargets.backports-custom-HEAD: make[7]: ***
> [/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD/compat]
> Error 2
> finaltargets.backports-custom-HEAD: make[6]: ***
> [_module_/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD]
> Error 2
> finaltargets.backports-custom-HEAD: make[5]: *** [modules] Error 2
> finaltargets.backports-custom-HEAD: make[4]: *** [modules] Error 2
> finaltargets.backports-custom-HEAD: make[3]: *** [modules] Error 2
> finaltargets.backports-custom-HEAD: make[2]: *** [default] Error 2
> finaltargets.backports-custom-HEAD: make[2]: Leaving directory
> `/usr/local/google/home/bk/src/gfiber/out/build/backports-custom-HEAD'
> finaltargets.backports-custom-HEAD: exit: 2
> 
> 
> This dirty hack works, but really prefer a better solution:
> 
> diff --git a/backport-include/asm/dma-mapping.h
> b/backport-include/asm/dma-mapping.h
> index b73b7da..7efd450 100644
> --- a/backport-include/asm/dma-mapping.h
> +++ b/backport-include/asm/dma-mapping.h
> @@ -10,6 +10,7 @@ dma_common_get_sgtable(struct device *dev, struct
> sg_table *sgt,
>                        void *cpu_addr, dma_addr_t dma_addr, size_t size);
>  #endif /* defined(CPTCFG_BPAUTO_BUILD_DMA_SHARED_HELPERS) */
> 
> +#if 0
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
> 
>  #define dma_get_sgtable_attrs LINUX_BACKPORT(dma_get_sgtable_attrs)
> @@ -23,5 +24,6 @@ dma_get_sgtable_attrs(struct device *dev, struct
> sg_table *sgt, void *cpu_addr,
> 
>  #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v,
> h, s, NULL)
>  #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
> +#endif
> 
>  #endif /* __BACKPORT_ASM_DMA_MAPPING_H */
> 
> 
> Suggestions appreciated.
> 
> Thanks,
> 
> Marty

Hi,

MIPS and Alpha are already shipping a asm/barrier.h file in kernel <
3.4, for all other architectures it was added in 3.4.

Please try to replace apply the attached patch.

Hauke

--------------030701030904040601070308
Content-Type: text/x-diff;
 name="0021-header-add-asm-barrier.h-on-mips-and-alpha.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0021-header-add-asm-barrier.h-on-mips-and-alpha.patch"

>From 02917a80be65cf23970b9575fd6b202b03e9b0f0 Mon Sep 17 00:00:00 2001
From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Sat, 30 Apr 2016 17:43:29 +0200
Subject: [PATCH 21/21] header: add asm/barrier.h on mips and alpha

The MIPA and Alpha architecture already ships a asm/barrier.h on kernel
< 3.4, call the include_next on such architectures.

Reported-by: Marty Faltesek <mfaltesek@google.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 423a581..04120bc 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_ASM_BARRIER_H
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) || CONFIG_MIPS || CONFIG_ALPHA
 #include_next <asm/barrier.h>
 #endif /* >= 3.4 */
 
-- 
2.8.0.rc3


--------------030701030904040601070308--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
