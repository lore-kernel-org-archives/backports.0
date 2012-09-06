Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:60871 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751759Ab2IFUqI (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 6 Sep 2012 16:46:08 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id BB5FA54003A
	for <backports@vger.kernel.org>; Thu,  6 Sep 2012 16:46:47 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-09-06 is baked
Message-Id: <20120906204607.5A05240ABF@repository3.orbit-lab.org>
Date: Thu,  6 Sep 2012 16:46:07 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 5f3ec57 compat-drivers: copy .compat_base on scripts/refresh-compat
git fetch github (/var/opt/compat/compat)
HEAD is now at 169203f compat: fix ARM architecture support for atomic_t and atomic64_t changes
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 1ad4cd6 Add linux-next specific files for 20120906
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
Trying kernel 2.6.28-02062810-generic [FAILED]
Trying kernel 2.6.27-020627-generic [FAILED]
Trying kernel 2.6.26-020626-generic [FAILED]
Trying kernel 2.6.25-020625-generic [FAILED]
Trying kernel 2.6.24-020624-generic [FAILED]
Failed...

compat-drivers code metrics

    841836 - Total upstream lines of code being pulled
      3041 - backport code changes
      2546 - backport code additions
       495 - backport code deletions
     12548 - backport from compat module
     15589 - total backport code
    1.8518 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20120906
compat.git: compat-2012-09-04-1-g169203f
compat-drivers release: compat-drivers-2012-09-04
Code metrics archive: http://bit.ly/H6BTF7
