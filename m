Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:60998 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752499Ab3BLVUR (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 12 Feb 2013 16:20:17 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 3AB8754000C
	for <backports@vger.kernel.org>; Tue, 12 Feb 2013 16:20:16 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-02-12 is baked
Message-Id: <20130212212016.18ACD40AC0@repository3.orbit-lab.org>
Date: Tue, 12 Feb 2013 16:20:16 -0500 (EST)
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
 + a96bb84...14baa7b master     -> origin/master  (forced update)
 + 201286e...dad99cd akpm       -> origin/akpm  (forced update)
 + 9eb7d78...871433f akpm-base  -> origin/akpm-base  (forced update)
 * [new tag]         next-20130212 -> next-20130212
Nothing new to pack.
HEAD is now at 14baa7b Add linux-next specific files for 20130212
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
