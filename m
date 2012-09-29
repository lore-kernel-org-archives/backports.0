Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:52118 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751501Ab2I2UsP (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 29 Sep 2012 16:48:15 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 946005402FE
	for <backports@vger.kernel.org>; Sat, 29 Sep 2012 16:48:13 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-09-29 is baked
Message-Id: <20120929204813.5FD9D40AC0@repository3.orbit-lab.org>
Date: Sat, 29 Sep 2012 16:48:13 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at 3df9094 compat-drivers: enable DRM drivers compilation
git fetch github (/var/opt/compat/compat)
HEAD is now at fb4936e compat: backport seq_file's user namespace addition
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at c88a977 Add linux-next specific files for 20120928
Trying kernel 3.4.4-030404-generic [FAILED]
Trying kernel 3.3.7-030307-generic [FAILED]
Trying kernel 3.2.2-030202-generic [FAILED]
Trying kernel 3.1.10-030110-generic [FAILED]
Trying kernel 3.0.18-030018-generic [FAILED]
Trying kernel 2.6.39-02063904-generic [FAILED]
Trying kernel 2.6.38-02063808-generic [FAILED]
Trying kernel 2.6.37-02063706-generic [FAILED]
Trying kernel 2.6.36-02063604-generic [FAILED]
Trying kernel 2.6.35-02063512-generic [FAILED]
Trying kernel 2.6.34-02063410-generic [FAILED]
Trying kernel 2.6.33-02063305-generic [FAILED]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]
Failed...

compat-drivers code metrics

   1210855 - Total upstream lines of code being pulled
      3107 - backport code changes
      2580 - backport code additions
       527 - backport code deletions
     12696 - backport from compat module
     15803 - total backport code
    1.3051 - % of code consists of backport work
       304 - backport code changes
       222 - backport code additions
        82 - backport code deletions
     12696 - backport from compat module
     13000 - total backport code
    1.0736 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20120928
compat.git: compat-2012-09-26
compat-drivers release: compat-drivers-2012-09-26
Code metrics archive: http://bit.ly/H6BTF7
