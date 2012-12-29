Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:42162 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753149Ab2L2VOl (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 29 Dec 2012 16:14:41 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 030E85400C4
	for <backports@vger.kernel.org>; Sat, 29 Dec 2012 16:14:40 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-29 is baked
Message-Id: <20121229211439.D709740ABF@repository3.orbit-lab.org>
Date: Sat, 29 Dec 2012 16:14:39 -0500 (EST)
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
HEAD is now at 3979da7 Add linux-next specific files for 20121224
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...

compat-drivers code metrics

   1270452 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3076 - backport code changes
      2581 - backport code additions
       495 - backport code deletions
     14599 - backport from compat module
     17675 - total backport code
    1.3912 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14599 - backport from compat module
     15035 - total backport code
    1.1834 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121224
compat.git: compat-2012-12-24
compat-drivers release: compat-drivers-2012-12-24
Code metrics archive: http://bit.ly/H6BTF7
