Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:48087 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751481Ab2IZUz4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 26 Sep 2012 16:55:56 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id A7BC454034A
	for <backports@vger.kernel.org>; Wed, 26 Sep 2012 16:57:01 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-09-26 is baked
Message-Id: <20120926205558.6CF8040ABF@repository3.orbit-lab.org>
Date: Wed, 26 Sep 2012 16:55:58 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at e9b2207 compat-drivers: refresh drm patches for next-20120925
git fetch github (/var/opt/compat/compat)
HEAD is now at 22e6331 compat: backport netlink pid to portid rename
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 0ea37fe Add linux-next specific files for 20120926
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

    845105 - Total upstream lines of code being pulled
      3107 - backport code changes
      2580 - backport code additions
       527 - backport code deletions
     12556 - backport from compat module
     15663 - total backport code
    1.8534 - % of code consists of backport work
     19083 - Crap changes not yet posted
     19023 - Crap additions not yet posted
        60 - Crap deletions not yet posted
    2.2581 - % of crap code

Base tree: linux-next.git
Base tree version: next-20120926
compat.git: compat-2012-09-25
compat-drivers release: compat-drivers-2012-09-25-pc
Code metrics archive: http://bit.ly/H6BTF7
