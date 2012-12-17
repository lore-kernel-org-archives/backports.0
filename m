Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:47566 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750889Ab2LQWCW (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 17 Dec 2012 17:02:22 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 2A19B5400ED
	for <backports@vger.kernel.org>; Mon, 17 Dec 2012 17:02:21 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-17 is baked
Message-Id: <20121217220221.1006E40ABF@repository3.orbit-lab.org>
Date: Mon, 17 Dec 2012 17:02:20 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at c5da34e compat-drivers: allow git-paranoia to work on current directory
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 744a6dd compat: add 3.2 and 3.3 kernels to rebuild headers
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 1cfc3a4 Add linux-next specific files for 20121217
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

   1270433 - Total upstream lines of code being pulled

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
Base tree version: next-20121217
compat.git: compat-2012-12-14-8
compat-drivers release: compat-drivers-2012-12-14-3-pc
Code metrics archive: http://bit.ly/H6BTF7
