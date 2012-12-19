Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:39234 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751278Ab2LSVQA (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 19 Dec 2012 16:16:00 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 8043654025C
	for <backports@vger.kernel.org>; Wed, 19 Dec 2012 16:15:59 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-19 is baked
Message-Id: <20121219211559.61F2540ABF@repository3.orbit-lab.org>
Date: Wed, 19 Dec 2012 16:15:59 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at 86d0f1f compat-drivers: refresh patches for next-20121218
git fetch github (/var/opt/compat/compat)
HEAD is now at a3fad85 compat: rewrite ckmake in Python
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at ba93608 Add linux-next specific files for 20121219
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...

compat-drivers code metrics

   1270444 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3076 - backport code changes
      2581 - backport code additions
       495 - backport code deletions
     14593 - backport from compat module
     17669 - total backport code
    1.3908 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14593 - backport from compat module
     15029 - total backport code
    1.1830 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121219
compat.git: compat-2012-12-14-9
compat-drivers release: compat-drivers-2012-18
Code metrics archive: http://bit.ly/H6BTF7
