Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:52130 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932531Ab3BKVWv (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 11 Feb 2013 16:22:51 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 3384D5402D5
	for <backports@vger.kernel.org>; Mon, 11 Feb 2013 16:22:50 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-02-11 is baked
Message-Id: <20130211212250.125F040AC0@repository3.orbit-lab.org>
Date: Mon, 11 Feb 2013 16:22:49 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch hauke (/var/opt/compat/compat-drivers)
>From git://github.com/hauke/compat-drivers
   1ef7c8a..9ae3560  master     -> hauke/master
 * [new branch]      linux-3.7.y -> hauke/linux-3.7.y
   0603c85..ddf5ae0  linux-3.8.y -> hauke/linux-3.8.y
 * [new tag]         compat-drivers-2013-02-10 -> compat-drivers-2013-02-10
 * [new tag]         compat-drivers-v3.7.6-1 -> compat-drivers-v3.7.6-1
 * [new tag]         compat-drivers-v3.8-rc7-1 -> compat-drivers-v3.8-rc7-1
HEAD is now at 9ae3560 compat-drivers: refresh patches
git fetch hauke (/var/opt/compat/compat)
>From git://github.com/hauke/compat
   3dfdf5d..1de0315  hauke      -> hauke/hauke
 * [new branch]      linux-3.7.y -> hauke/linux-3.7.y
   b4c0baf..e6b114a  linux-3.8.y -> hauke/linux-3.8.y
   726d9b2..1de0315  master     -> hauke/master
 * [new tag]         compat-2013-02-10 -> compat-2013-02-10
 * [new tag]         compat-v3.7.6-1 -> compat-v3.7.6-1
 * [new tag]         compat-v3.8-rc7-1 -> compat-v3.8-rc7-1
HEAD is now at 1de0315 compat: move tty_flip_buffer_push() and tty_insert_flip_string()
git fetch origin (/var/opt/compat/linux-next)
>From git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
 + e347c98...a96bb84 master     -> origin/master  (forced update)
 + 830ddd5...201286e akpm       -> origin/akpm  (forced update)
 + a25c469...9eb7d78 akpm-base  -> origin/akpm-base  (forced update)
   6bacaa9..836dc9e  stable     -> origin/stable
 * [new tag]         next-20130211 -> next-20130211
 * [new tag]         v3.8-rc7   -> v3.8-rc7
Nothing new to pack.
HEAD is now at a96bb84 Add linux-next specific files for 20130211
git fetch origin (/var/opt/compat/unified/alx)
Nothing new to pack.
HEAD is now at 8f56f40 alx: improve self-test for FPGA
Error while updating from linux-next
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1278976 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3047 - backport code changes
      2557 - backport code additions
       490 - backport code deletions
     14654 - backport from compat module
     17701 - total backport code
    1.3840 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14654 - backport from compat module
     15090 - total backport code
    1.1799 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20130110
compat.git: compat-v3.8-rc2-1-5-g59a1d45
compat-drivers release: compat-drivers-2013-01-08-3-6-g06fd418
Code metrics archive: http://bit.ly/H6BTF7
