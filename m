Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:40155 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933388Ab3AIVWM (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Jan 2013 16:22:12 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 6DB9C5402DB
	for <backports@vger.kernel.org>; Wed,  9 Jan 2013 16:22:10 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-01-09 is baked
Message-Id: <20130109212210.4D3A140ABF@repository3.orbit-lab.org>
Date: Wed,  9 Jan 2013 16:22:10 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at 0b8598f compat-drivers: update genlog-3.8
git fetch github (/var/opt/compat/compat)
HEAD is now at 681f758 compat: export platform_device_register_data()
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 0f7b07b Add linux-next specific files for 20130109
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1271873 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3039 - backport code changes
      2553 - backport code additions
       486 - backport code deletions
     14599 - backport from compat module
     17638 - total backport code
    1.3868 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14599 - backport from compat module
     15035 - total backport code
    1.1821 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20130109
compat.git: compat-v3.8-rc2-1
compat-drivers release: compat-drivers-2013-01-08-3
Code metrics archive: http://bit.ly/H6BTF7
