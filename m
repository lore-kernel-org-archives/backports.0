Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:50500 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759803AbaJ3NeO (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 30 Oct 2014 09:34:14 -0400
Message-ID: <54523E51.5070205@kpanic.de> (sfid-20141030_143417_269831_4A4DEC13)
Date: Thu, 30 Oct 2014 14:34:09 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Integration issues found and status
References: <CAB=NE6XpVW1J1E-0mZQvsHgAnCzAsw+yJHpYyvtXMsc_9-2hUA@mail.gmail.com>
In-Reply-To: <CAB=NE6XpVW1J1E-0mZQvsHgAnCzAsw+yJHpYyvtXMsc_9-2hUA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040203070203090403070502"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040203070203090403070502
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 29.10.2014 22:07, Luis R. Rodriguez wrote:
> OK a few obvious issues and their status:
> 
> 1) dependencies file does not use BACKPORT_ prefix and as such they
> are not mapped correctly, I'm about to address this
> 2) some Kconfig files don't get the change:
> 
> -source "foo"
> +source "backports/foo"
> 
> This is not allowing them to creep up on integration menuconfig, I'll
> look into that next.
> 
> 3) vmlinux build - something is missing on the last step on gentree.py
> for integration, this can be observed when using gitdebug, I'm hoping
> Stefan can help with this :D

Applying the attached patch gets us one step further. We probably
need to make these modifications in place instead of pushing them to
the end of the Makefile.

~/backports/linux-test-3.15> make -j16
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
make[3]: `arch/x86/realmode/rm/realmode.bin' is up to date.
  LINK    vmlinux
  LD      vmlinux.o
backports/built-in.o:(___ksymtab_gpl+devm_kstrdup+0x0): multiple definition of `__ksymtab_devm_kstrdup'
drivers/built-in.o:(___ksymtab_gpl+devm_kstrdup+0x0): first defined here
backports/built-in.o: In function `devm_kstrdup':
(.text+0x10): multiple definition of `devm_kstrdup'
drivers/built-in.o:(.text+0x14c3e0): first defined here
make: *** [vmlinux] Error 1

  Stefan

--------------040203070203090403070502
Content-Type: text/x-patch;
 name="Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Makefile.patch"

diff --git a/Makefile b/Makefile
index 692f6e0..55de920 100644
--- a/Makefile
+++ b/Makefile
@@ -542,6 +542,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Objects we will link into vmlinux / subdirs we need to visit
+backports-y	:= backports/
 init-y		:= init/
 drivers-y	:= drivers/ sound/ firmware/
 net-y		:= net/
@@ -820,6 +821,7 @@ core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
+			$(backports-y) $(backports-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
 
 vmlinux-alldirs	:= $(sort $(vmlinux-dirs) $(patsubst %/,%,$(filter %/, \

--------------040203070203090403070502--
