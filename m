Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37859 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbbCLUGo (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Mar 2015 16:06:44 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id F1D5820320
	for <backports@vger.kernel.org>; Thu, 12 Mar 2015 20:06:42 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 2F921202F8
	for <backports@vger.kernel.org>; Thu, 12 Mar 2015 20:06:42 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94811] Backport kernel integration fails
Date: Thu, 12 Mar 2015 20:06:41 +0000
Message-ID: <bug-94811-58281-e1c6R8K4rU@https.bugzilla.kernel.org/> (sfid-20150312_210646_339245_66885D8B)
In-Reply-To: <bug-94811-58281@https.bugzilla.kernel.org/>
References: <bug-94811-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94811

--- Comment #1 from Mike McElroy <mikem388@gmail.com> ---
My mistake. I didn't have the backports tree set to the right tag. Now I have
the backports tree and the linux-next tree set to the same tag. All the patches
get applied but it still fails on the main Makefile. 

ike@mikes-laptop:~/backports$ ./gentree.py --integrate --clean --gitdebug
~/devel/integrate/linux-next/ ~/devel/integrate/linux-stable/
Copy original source files ...
Applying patches from patches to
/home/mike/devel/integrate/linux-stable/backports/ ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Applying patches from integration-patches/ to
/home/mike/devel/integrate/linux-stable/ ...
Failed to apply changes from
001-enable-backports/0001-enable-backports-built-in.patch
> patching file Makefile
> Hunk #1 succeeded at 506 (offset -36 lines).
> Hunk #2 succeeded at 715 (offset -106 lines).
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

On the backports tree:
detached from backports-20150129

integration-patches/0001-enable-backports
0001-enable-backports-built-in.patch
@@ -837,7 +841,7 @@ libs-y              := $(libs-y1) $(libs-y2)

 # Externally visible symbols (used by link-vmlinux.sh)
 export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
-export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
$(backports-y)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 export LDFLAGS_vmlinux
 # used by scripts/pacmage/Makefile

This doesn't exist in the linux-3.4.t Makefile.

-- 
You are receiving this mail because:
You are the assignee for the bug.
