Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:50357 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751657Ab3AaVM2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 31 Jan 2013 16:12:28 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id C6D4C5401FA
	for <backports@vger.kernel.org>; Thu, 31 Jan 2013 16:12:26 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-01-31 is baked
Message-Id: <20130131211226.A6DC440ABF@repository3.orbit-lab.org>
Date: Thu, 31 Jan 2013 16:12:26 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch hauke (/var/opt/compat/compat-drivers)
Nothing new to pack.
HEAD is now at 3e51785 compat-drivers: update genlog-3.8 for rc5
git fetch hauke (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 5c165fc compat: backport nla_put_be{16,32,64}()
git fetch origin (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at a6670e3 Add linux-next specific files for 20130128
git fetch origin (/var/opt/compat/unified/alx)
Nothing new to pack.
HEAD is now at 8f56f40 alx: improve self-test for FPGA
Failed...
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
