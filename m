Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35519 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbbFCSb4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 14:31:56 -0400
Message-ID: <556F4819.3020706@hauke-m.de> (sfid-20150603_203219_631927_B8E9263B)
Date: Wed, 03 Jun 2015 20:31:53 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Bhuvan <bhuvanchandradv@gmail.com>,
	Kernel backports mailinglist <backports@vger.kernel.org>
Subject: Re: Issues while integrating backports(20150525) to target Kernel
 3.1.10
References: <556D9D89.2020500@gmail.com>
In-Reply-To: <556D9D89.2020500@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/02/2015 02:11 PM, Bhuvan wrote:
> Hello,
> 
> I'm trying to integrate backports(20150525) to target Kernel 3.1.10.
> Followed the instructions available in the backports wiki for kernel
> integration procedure. Nice! documentation.
> Used linux-next.git, backports.git with next-20150525 and
> backports-20150525 tags respectively.
> The target Linux kernel version is based on NVIDIA's L4T and it was not
> a clean 3.1 baseline but
> rather some pre 3.2 version with further Android additions.
> My aim is to backport the iwlwifi drivers on 3.1.10 kernel.
> 
> Backporting 20150525 on 3.1.10 using gentree.py was not successful:
> 
> # ./gentree.py --integrate --clean --gitdebug --git-revision
> next-20150525 ../linux-next ~/linux
> Get original source files from git ...
> Applying patches from patches to ~/backports ...
> Modify Kconfig tree ...
> Rewrite Makefiles and Kconfig files ...
> Applying patches from integration-patches/ to ~/linux ...
> Failed to apply changes from
> 001-enable-backports/0001-enable-backports-built-in.patch
>> patching file Makefile
>> Hunk #1 succeeded at 506 (offset -36 lines).
>> Hunk #2 succeeded at 713 (offset -108 lines).
>> Hunk #3 FAILED at 841.
>> 1 out of 3 hunks FAILED -- saving rejects to file Makefile.rej
> Traceback (most recent call last):
>   File "./gentree.py", line 1091, in <module>
>     ret = _main()
>   File "./gentree.py", line 724, in _main
>     logwrite=logwrite)
>   File "./gentree.py", line 1078, in process
>     bpid.project_dir, logwrite)
>   File "./gentree.py", line 552, in apply_patches
>     raise Exception('Patch failed')
> Exception: Patch failed
> ....
> 
> Makefile.ref :
> 
> --- Makefile
> +++ Makefile
> @@ -841,7 +845,7 @@ libs-y        := $(libs-y1) $(libs-y2)
> 
>  # Externally visible symbols (used by link-vmlinux.sh)
>  export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
> -export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> +export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> $(backports-y)
>  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>  export LDFLAGS_vmlinux
>  # used by scripts/pacmage/Makefile
> 
> Am i missing some thing or doing some thing wrong!.
> Can some one provide few pointers for fixing the issues and few pointers
> on backporting kernel integration
> on non standard kernel trees, like the one which i am working on.
> 
> Best regards,
> Bhuvan

I think the documentation is not so good. ;-)

If you just want to compile the drivers against your kernel the easiest
way is to download the tar from here:
http://www.kernel.org/pub/linux/kernel/projects/backports/2015/05/25/backports-20150525.tar.xz

You can compile it against your kernel like any other external kernel
module.
The git repository is only needed if you want to generate your own tar
with the drivers form your kernel.

Hauke

