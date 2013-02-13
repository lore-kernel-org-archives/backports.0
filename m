Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:46864 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964889Ab3BMVSH (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 13 Feb 2013 16:18:07 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 25D335400FC
	for <backports@vger.kernel.org>; Wed, 13 Feb 2013 16:18:05 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-02-13 is baked
Message-Id: <20130213211805.0905540AC0@repository3.orbit-lab.org>
Date: Wed, 13 Feb 2013 16:18:04 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch hauke (/var/opt/compat/compat-drivers)
Nothing new to pack.
HEAD is now at 9ae3560 compat-drivers: refresh patches
git fetch hauke (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 1de0315 compat: move tty_flip_buffer_push() and tty_insert_flip_string()
git fetch origin (/var/opt/compat/linux-next)
>From git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
 + 14baa7b...0cf69bb master     -> origin/master  (forced update)
 + dad99cd...2968ab7 akpm       -> origin/akpm  (forced update)
 + 871433f...5058b21 akpm-base  -> origin/akpm-base  (forced update)
   836dc9e..211b0cd  stable     -> origin/stable
 * [new tag]         next-20130213 -> next-20130213
Nothing new to pack.
HEAD is now at 0cf69bb Add linux-next specific files for 20130213
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
