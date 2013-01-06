Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:38612 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752950Ab3AFVNa (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 6 Jan 2013 16:13:30 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id C8180540274
	for <backports@vger.kernel.org>; Sun,  6 Jan 2013 16:13:28 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-01-06 is baked
Message-Id: <20130106211328.A94DA40ABF@repository3.orbit-lab.org>
Date: Sun,  6 Jan 2013 16:13:28 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 91cd77f compat-drivers: refresh patches
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 681f758 compat: export platform_device_register_data()
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 1d4849d Add linux-next specific files for 20130104
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1270981 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3076 - backport code changes
      2581 - backport code additions
       495 - backport code deletions
     14599 - backport from compat module
     17675 - total backport code
    1.3907 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14599 - backport from compat module
     15035 - total backport code
    1.1829 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20130104
compat.git: compat-2012-12-24
compat-drivers release: compat-drivers-2012-12-24
Code metrics archive: http://bit.ly/H6BTF7
