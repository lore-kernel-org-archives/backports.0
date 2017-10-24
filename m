Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:44284 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdJXKiD (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 24 Oct 2017 06:38:03 -0400
Received: by mail-wm0-f53.google.com with SMTP id 196so11718401wma.1
        for <backports@vger.kernel.org>; Tue, 24 Oct 2017 03:38:03 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5ZCz6YeN5q+F?= <uranus0206@gmail.com>
Date: Tue, 24 Oct 2017 18:37:41 +0800
Message-ID: <CAN+BLYGmKpHm+iJOMynv6Qhvyh=ECaJnAM96QiU=LptiisW0xw@mail.gmail.com> (sfid-20171024_123805_971082_E604BA18)
Subject: Compiling error of backport-4.12.c
To: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi:
I am using backport  (git commit: 60f18a) and linux-stable(git commit:
bb176f) with command
"./gentree.py --verbose --clean ../linux-stable ../backport_test"
to generate backport source.

And I am going to backport the drivers to compiled linux source(tag v4.2)

After setting make environment i encounter error while compiling. (I
was successfully compiled before.)

The error message as below:

  if [ "-pg" =3D "-pg" ]; then if [
/home/chungyi/backport_test/compat/backport-4.10.o !=3D
"scripts/mod/empty.o" ]; then ./scripts/recordmcount
"/home/chungyi/backport_test/compat/backport-4.10.o"; fi; fi;
  gcc -Wp,-MD,/home/chungyi/backport_test/compat/.backport-4.12.o.d
-I/home/chungyi/backport_test/backport-include/
-I/home/chungyi/backport_test/backport-include/uapi
-I/home/chungyi/backport_test/include/
-I/home/chungyi/backport_test/include/uapi -include
/home/chungyi/backport_test/backport-include/backport/backport.h
-Wno-unused-but-set-variable
-DCPTCFG_VERSION=3D\""v4.14-rc2-1-25-g60f18ad"\"
-DCPTCFG_KERNEL_VERSION=3D\""v4.14-rc6-0-gbb176f6"\"
-DCPTCFG_KERNEL_NAME=3D\""Linux"\"   -I./arch/x86/include
-Iarch/x86/include/generated/uapi -Iarch/x86/include/generated
-Iinclude -I./arch/x86/include/uapi -Iarch/x86/include/generated/uapi
-I./include/uapi -Iinclude/generated/uapi -include
./include/linux/kconfig.h -D__KERNEL__ -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Wno-format-security -std=3Dgnu89
-m64 -falign-jumps=3D1 -falign-loops=3D1 -mno-80387 -mno-fp-ret-in-387
-mskip-rax-setup -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel
-funit-at-a-time -maccumulate-outgoing-args -DCONFIG_X86_X32_ABI
-DCONFIG_AS_FXSAVEQ=3D1 -DCONFIG_AS_SSSE3=3D1 -DCONFIG_AS_CRC32=3D1
-DCONFIG_AS_AVX=3D1 -DCONFIG_AS_AVX2=3D1 -pipe -Wno-sign-compare
-fno-asynchronous-unwind-tables -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-mno-avx -fno-delete-null-pointer-checks -O2
--param=3Dallow-store-data-races=3D0 -Wframe-larger-than=3D1024
-fstack-protector-strong -Wno-unused-but-set-variable
-fno-omit-frame-pointer -fno-optimize-sibling-calls
-fno-var-tracking-assignments -g -gdwarf-4 -pg -mfentry
-DCC_USING_FENTRY -Wdeclaration-after-statement -Wno-pointer-sign
-fno-strict-overflow -fconserve-stack -Werror=3Dimplicit-int
-Werror=3Dstrict-prototypes -Werror=3Ddate-time -DCC_HAVE_ASM_GOTO
-fno-pie -no-pie -Wno-pointer-sign
-I/home/chungyi/backport_test/compat  -DMODULE  -D"KBUILD_STR(s)=3D#s"
-D"KBUILD_BASENAME=3DKBUILD_STR(backport_4.12)"
-D"KBUILD_MODNAME=3DKBUILD_STR(compat)" -c -o
/home/chungyi/backport_test/compat/.tmp_backport-4.12.o
/home/chungyi/backport_test/compat/backport-4.12.c
/home/chungyi/backport_test/compat/backport-4.12.c: In function
=E2=80=98extack_pre_doit=E2=80=99:
/home/chungyi/backport_test/compat/backport-4.12.c:46:26: error:
lvalue required as left operand of assignment
  genl_info_userhdr(info) =3D extack;
                          ^
/home/chungyi/backport_test/compat/backport-4.12.c:49:27: error:
lvalue required as left operand of assignment
   genl_info_userhdr(info) =3D ERR_PTR(-ENOMEM);
                           ^
/home/chungyi/backport_test/compat/backport-4.12.c:62:27: error:
lvalue required as left operand of assignment
   genl_info_userhdr(info) =3D ERR_PTR(err);
                           ^
scripts/Makefile.build:258: recipe for target
'/home/chungyi/backport_test/compat/backport-4.12.o' failed
make[6]: *** [/home/chungyi/backport_test/compat/backport-4.12.o] Error 1
scripts/Makefile.build:403: recipe for target
'/home/chungyi/backport_test/compat' failed
make[5]: *** [/home/chungyi/backport_test/compat] Error 2
Makefile:1386: recipe for target '_module_/home/chungyi/backport_test' fail=
ed
make[4]: *** [_module_/home/chungyi/backport_test] Error 2
Makefile.build:6: recipe for target 'modules' failed
make[3]: *** [modules] Error 2
Makefile.real:88: recipe for target 'modules' failed
make[2]: *** [modules] Error 2
Makefile:40: recipe for target 'modules' failed
make[1]: *** [modules] Error 2
Makefile:30: recipe for target 'default' failed
make: *** [default] Error 2
--
To unsubscribe from this list: send the line "unsubscribe backports" in
