Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48974 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbbHaAay (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 30 Aug 2015 20:30:54 -0400
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: newbie questions
To: backports@vger.kernel.org
Message-ID: <55E3A03D.6050607@linux.intel.com> (sfid-20150831_023101_616135_D37C8DBB)
Date: Sun, 30 Aug 2015 19:30:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,
I am trying to figure out how complicated it'd be to add the sound subsystem to the list of supported packages - there are many cases where I only want the latest and greatest sound drivers and nothing else beyond the minimal dependencies. Bear with me if I am asking silly questions, I am not familiar at all with the backports environment and only tried to progress from the wiki and code.

question1: is there a way the list of packages can be selected? I'd like to use the backports infrastructure only for what I care about (media, usb, audio). It'd be really nice if I could limit the updates to the parts I care about (media, usb, sound) and remove all the networking part I don't really have a use for. It's fine if the releases include everything, I only want to limit the changes in my own workspace.

question2: I am not sure I understand how the code is generated. Nothing seems to work/compile even without my changes... If I use linux-next with the next-20150731 tag and the latest backport code, I get:

~/backports$ ./gentree.py --clean --verbose --gitdebug --git-revision  v4.1.6  ../linux-next ../linux-next-backport
Get original source files from git ...
Applying patches from patches to ../linux-next-backport ...
Applying patch 0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
> patching file drivers/net/wireless/mwifiex/decl.h
> Hunk #1 succeeded at 26 with fuzz 1.
> patching file drivers/net/wireless/mwifiex/sta_rx.c
Applying patch backport-adjustments/crypto-ccm.patch
> patching file compat/crypto-ccm.c
> Hunk #2 succeeded at 872 (offset -60 lines).
> Hunk #3 succeeded at 898 (offset -60 lines).
Applying patch backport-adjustments/devcoredump.patch
> patching file compat/drivers-base-devcoredump.c
> patching file include/linux/backport-devcoredump.h
Not applying backport-adjustments/flow_dissector.patch, not needed
Applying patch collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
> patching file drivers/media/v4l2-core/videobuf2-dma-contig.c
Applying patch collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
> patching file drivers/media/v4l2-core/Kconfig
> Hunk #1 succeeded at 68 (offset -11 lines).
> Hunk #2 succeeded at 79 (offset -11 lines).
> patching file drivers/media/v4l2-core/v4l2-mem2mem.c
> Hunk #1 succeeded at 440 (offset -19 lines).
> Hunk #2 succeeded at 454 (offset -19 lines).
> Hunk #3 succeeded at 805 with fuzz 2 (offset -36 lines).
> Hunk #4 succeeded at 814 (offset -36 lines).
> patching file drivers/media/v4l2-core/videobuf2-core.c
> Hunk #1 succeeded at 252 (offset -1 lines).
> Hunk #2 succeeded at 281 (offset -1 lines).
> Hunk #3 succeeded at 425 (offset -1 lines).
> Hunk #4 succeeded at 787 (offset -1 lines).
> Hunk #5 succeeded at 801 (offset -1 lines).
> Hunk #6 succeeded at 835 (offset -1 lines).
> Hunk #7 succeeded at 1502 (offset -5 lines).
> Hunk #8 succeeded at 1621 (offset -5 lines).
> Hunk #9 succeeded at 1684 (offset -5 lines).
> Hunk #10 succeeded at 2074 (offset -10 lines).
> Hunk #11 succeeded at 2085 (offset -10 lines).
> Hunk #12 succeeded at 2094 (offset -10 lines).
> Hunk #13 succeeded at 2401 (offset -14 lines).
> Hunk #14 succeeded at 2479 (offset -14 lines).
> Hunk #15 succeeded at 3417 (offset -22 lines).
> Hunk #16 succeeded at 3427 (offset -22 lines).
> patching file drivers/media/v4l2-core/videobuf2-dma-contig.c
> patching file drivers/media/v4l2-core/videobuf2-vmalloc.c
> patching file include/media/v4l2-mem2mem.h
> Hunk #1 succeeded at 119 (offset -2 lines).
> Hunk #2 succeeded at 244 (offset -2 lines).
> patching file include/media/videobuf2-core.h
> Hunk #3 succeeded at 463 (offset -4 lines).
> Hunk #4 succeeded at 630 (offset -13 lines).
> patching file drivers/media/usb/uvc/uvc_queue.c
> Hunk #1 FAILED at 270.
> Hunk #2 succeeded at 269 (offset -12 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file drivers/media/usb/uvc/uvc_queue.c.rej
> patching file drivers/media/v4l2-core/videobuf2-dma-sg.c
> Hunk #1 succeeded at 373 (offset -4 lines).
Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 906, in process
    apply_patches(args, "backport", source_dir, 'patches', bpid.target_dir, logwrite)
  File "./gentree.py", line 552, in apply_patches
    raise Exception('Patch failed')
Exception: Patch failed

Now if I use branch origin/linux-4.1.y, the tree is generated but usually doesn't compile (random options selected)

Can anyone help with a known config that works?


question 3: how exactly does ckmake work and what am I missing?
:~/backports$ ./devel/ckmake 
[snip] backports/Makefile does not exist

Thanks,
-Pierre
--
To unsubscribe from this list: send the line "unsubscribe backports" in
