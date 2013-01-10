Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:47042 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754322Ab3AJVUT (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 10 Jan 2013 16:20:19 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 8C79B5404E6
	for <backports@vger.kernel.org>; Thu, 10 Jan 2013 16:20:17 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-01-10 is baked
Message-Id: <20130110212017.5A03440AC0@repository3.orbit-lab.org>
Date: Thu, 10 Jan 2013 16:20:17 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at 37969ca compat-drivers: trim 'v' prefix from ChangeLog file
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 681f758 compat: export platform_device_register_data()
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 62406ac Add linux-next specific files for 20130110
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1272825 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3039 - backport code changes
      2553 - backport code additions
       486 - backport code deletions
     14599 - backport from compat module
     17638 - total backport code
    1.3857 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14599 - backport from compat module
     15035 - total backport code
    1.1812 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20130110
compat.git: compat-v3.8-rc2-1
compat-drivers release: compat-drivers-2013-01-08-3-1-g37969ca
Code metrics archive: http://bit.ly/H6BTF7
