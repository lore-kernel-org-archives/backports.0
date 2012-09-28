Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:42465 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932215Ab2I1UuY (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 28 Sep 2012 16:50:24 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 04982540256
	for <backports@vger.kernel.org>; Fri, 28 Sep 2012 16:50:23 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-09-28 is baked
Message-Id: <20120928205022.D773F40AC0@repository3.orbit-lab.org>
Date: Fri, 28 Sep 2012 16:50:22 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at e9b2207 compat-drivers: refresh drm patches for next-20120925
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 22e6331 compat: backport netlink pid to portid rename
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

    846075 - Total upstream lines of code being pulled
      3107 - backport code changes
      2580 - backport code additions
       527 - backport code deletions
     12556 - backport from compat module
     15663 - total backport code
    1.8513 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20120928
compat.git: compat-2012-09-25
compat-drivers release: compat-drivers-2012-09-25
Code metrics archive: http://bit.ly/H6BTF7
