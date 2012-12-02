Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:43538 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751789Ab2LBV6q (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Dec 2012 16:58:46 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 66861540184
	for <backports@vger.kernel.org>; Sun,  2 Dec 2012 16:58:45 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-02 is baked
Message-Id: <20121202215845.281A540AC0@repository3.orbit-lab.org>
Date: Sun,  2 Dec 2012 16:58:45 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at d39ffb7 compat-drivers: fix typo which removed entries on Makefile
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 71273f8 compat: backport PCI MSI-X entry definitions
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 85924a0 Add linux-next specific files for 20121130
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]
Worked!

Trying kernel  3.4.4-030404-generic [OK]
Trying kernel  3.3.7-030307-generic [OK]
Trying kernel  3.2.2-030202-generic [OK]
Trying kernel  3.1.10-030110-generic [OK]
Trying kernel  3.0.18-030018-generic [OK]
Trying kernel  2.6.39-02063904-generic [OK]
Trying kernel  2.6.38-02063808-generic [OK]
Trying kernel  2.6.37-02063706-generic [OK]
Trying kernel  2.6.36-02063604-generic [OK]
Trying kernel  2.6.35-02063512-generic [OK]
Trying kernel  2.6.34-02063410-generic [OK]
Trying kernel  2.6.33-02063305-generic [OK]
Trying kernel  2.6.31-02063113-generic [OK]
Trying kernel  2.6.30-02063010-generic [OK]
Trying kernel  2.6.29-02062906-generic [OK]
Trying kernel  2.6.28-02062810-generic [OK]
Trying kernel  2.6.27-020627-generic [OK]
Trying kernel  2.6.26-020626-generic [OK]
Trying kernel  2.6.25-020625-generic [OK]
Trying kernel  2.6.24-020624-generic [OK]

compat-drivers code metrics

   1264388 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3146 - backport code changes
      2600 - backport code additions
       546 - backport code deletions
     13074 - backport from compat module
     16220 - total backport code
    1.2828 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     13074 - backport from compat module
     13510 - total backport code
    1.0685 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121130
compat.git: compat-2012-11-30-4-g71273f8
compat-drivers release: compat-drivers-2012-11-30-2-gd39ffb7-pc
Code metrics archive: http://bit.ly/H6BTF7
