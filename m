Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32822 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbFBML5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Jun 2015 08:11:57 -0400
Received: by padj3 with SMTP id j3so66298730pad.0
        for <backports@vger.kernel.org>; Tue, 02 Jun 2015 05:11:56 -0700 (PDT)
Received: from [10.18.0.154] ([115.115.225.206])
        by mx.google.com with ESMTPSA id g10sm5116165pat.35.2015.06.02.05.11.55
        for <backports@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 05:11:56 -0700 (PDT)
From: Bhuvan <bhuvanchandradv@gmail.com>
Message-ID: <556D9D89.2020500@gmail.com> (sfid-20150602_141159_169819_E776CB04)
Date: Tue, 02 Jun 2015 17:41:53 +0530
MIME-Version: 1.0
To: Kernel backports mailinglist <backports@vger.kernel.org>
Subject: Issues while integrating backports(20150525) to target Kernel 3.1.10
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I'm trying to integrate backports(20150525) to target Kernel 3.1.10.
Followed the instructions available in the backports wiki for kernel 
integration procedure. Nice! documentation.
Used linux-next.git, backports.git with next-20150525 and 
backports-20150525 tags respectively.
The target Linux kernel version is based on NVIDIA's L4T and it was not 
a clean 3.1 baseline but
rather some pre 3.2 version with further Android additions.
My aim is to backport the iwlwifi drivers on 3.1.10 kernel.

Backporting 20150525 on 3.1.10 using gentree.py was not successful:

# ./gentree.py --integrate --clean --gitdebug --git-revision 
next-20150525 ../linux-next ~/linux
Get original source files from git ...
Applying patches from patches to ~/backports ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Applying patches from integration-patches/ to ~/linux ...
Failed to apply changes from 
001-enable-backports/0001-enable-backports-built-in.patch
 > patching file Makefile
 > Hunk #1 succeeded at 506 (offset -36 lines).
 > Hunk #2 succeeded at 713 (offset -108 lines).
 > Hunk #3 FAILED at 841.
 > 1 out of 3 hunks FAILED -- saving rejects to file Makefile.rej
Traceback (most recent call last):
   File "./gentree.py", line 1091, in <module>
     ret = _main()
   File "./gentree.py", line 724, in _main
     logwrite=logwrite)
   File "./gentree.py", line 1078, in process
     bpid.project_dir, logwrite)
   File "./gentree.py", line 552, in apply_patches
     raise Exception('Patch failed')
Exception: Patch failed
....

Makefile.ref :

--- Makefile
+++ Makefile
@@ -841,7 +845,7 @@ libs-y        := $(libs-y1) $(libs-y2)

  # Externally visible symbols (used by link-vmlinux.sh)
  export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
-export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y) 
$(backports-y)
  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
  export LDFLAGS_vmlinux
  # used by scripts/pacmage/Makefile

Am i missing some thing or doing some thing wrong!.
Can some one provide few pointers for fixing the issues and few pointers 
on backporting kernel integration
on non standard kernel trees, like the one which i am working on.

Best regards,
Bhuvan
