Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:39871 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932669Ab2IDUTo (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 4 Sep 2012 16:19:44 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 6E4865402F4
	for <backports@vger.kernel.org>; Tue,  4 Sep 2012 16:20:21 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-09-04 is baked
Message-Id: <20120904201943.30C3840ABE@repository3.orbit-lab.org>
Date: Tue,  4 Sep 2012 16:19:43 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at cb14a84 compat-drivers: synch with linux-next 20120824
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 99d7ff9 compat: Backport eth_broadcast_addr()
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 919596d Add linux-next specific files for 20120904
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

    841615 - Total upstream lines of code being pulled
      3041 - backport code changes
      2546 - backport code additions
       495 - backport code deletions
     12246 - backport from compat module
     15287 - total backport code
    1.8164 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20120904
compat.git: compat-2012-08-23
compat-drivers release: compat-drivers-2012-08-23-1-gcb14a84
Code metrics archive: http://bit.ly/H6BTF7
