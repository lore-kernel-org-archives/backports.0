Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:52910 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030247Ab2JKUvG (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Oct 2012 16:51:06 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 06D7454046F
	for <backports@vger.kernel.org>; Thu, 11 Oct 2012 16:51:05 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-11 is baked
Message-Id: <20121011205104.C019940ABF@repository3.orbit-lab.org>
Date: Thu, 11 Oct 2012 16:51:04 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at b074e4b compat-drivers: change condition for kernel.org release target
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at fb4936e compat: backport seq_file's user namespace addition
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 1f3b59e Add linux-next specific files for 20121011
Trying kernel 3.4.4-030404-generic [FAILED]
Trying kernel 3.3.7-030307-generic [FAILED]
Trying kernel 3.2.2-030202-generic [FAILED]
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
Failed...

compat-drivers code metrics

   1170477 - Total upstream lines of code being pulled
      3107 - backport code changes
      2580 - backport code additions
       527 - backport code deletions
     12696 - backport from compat module
     15803 - total backport code
    1.3501 - % of code consists of backport work
       301 - backport code changes
       219 - backport code additions
        82 - backport code deletions
     12696 - backport from compat module
     12997 - total backport code
    1.1104 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121011
compat.git: compat-2012-10-08
compat-drivers release: compat-drivers-2012-10-08
Code metrics archive: http://bit.ly/H6BTF7
