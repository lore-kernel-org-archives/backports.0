Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:51374 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750891Ab2IKUXB (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 11 Sep 2012 16:23:01 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id C58CB540055
	for <backports@vger.kernel.org>; Tue, 11 Sep 2012 16:23:47 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-09-11 is baked
Message-Id: <20120911202301.BCFA040ABF@repository3.orbit-lab.org>
Date: Tue, 11 Sep 2012 16:23:01 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at ddac993 compat-drivers: Update 53-pr_fmt.patch
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at be1c030 compat: fix typo on previous atomic changes
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at b5b1d8a Add linux-next specific files for 20120911
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
Trying kernel 2.6.31-02063113-generic [FAILED]
Trying kernel 2.6.30-02063010-generic [FAILED]
Trying kernel 2.6.29-02062906-generic [FAILED]
Trying kernel 2.6.28-02062810-generic [FAILED]
Trying kernel 2.6.27-020627-generic [FAILED]
Trying kernel 2.6.26-020626-generic [FAILED]
Trying kernel 2.6.25-020625-generic [FAILED]
Trying kernel 2.6.24-020624-generic [FAILED]
Failed...

compat-drivers code metrics

    842071 - Total upstream lines of code being pulled
      3045 - backport code changes
      2549 - backport code additions
       496 - backport code deletions
     12548 - backport from compat module
     15593 - total backport code
    1.8517 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20120911
compat.git: compat-2012-09-04-2-gbe1c030
compat-drivers release: compat-drivers-2012-09-04-2-gddac993
Code metrics archive: http://bit.ly/H6BTF7
