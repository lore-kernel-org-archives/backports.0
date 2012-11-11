Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:50659 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752000Ab2KKV4i (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 11 Nov 2012 16:56:38 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 3690C5402E9
	for <backports@vger.kernel.org>; Sun, 11 Nov 2012 16:56:37 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-11-11 is baked
Message-Id: <20121111215637.081C640AC0@repository3.orbit-lab.org>
Date: Sun, 11 Nov 2012 16:56:36 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 0d443c4 compat-drivers: refresh patches
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 0022049 compat: run ckmake with num cpu threads
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 75e0eba Add linux-next specific files for 20121109
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

   1239527 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3114 - backport code changes
      2583 - backport code additions
       531 - backport code deletions
     12754 - backport from compat module
     15868 - total backport code
    1.2802 - % of code consists of backport work

   drm
   ----------------------------------------
       382 - backport code changes
       264 - backport code additions
       118 - backport code deletions
     12754 - backport from compat module
     13136 - total backport code
    1.0598 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121109
compat.git: compat-2012-11-02-3-g0022049
compat-drivers release: compat-drivers-2012-11-02-pc
Code metrics archive: http://bit.ly/H6BTF7
