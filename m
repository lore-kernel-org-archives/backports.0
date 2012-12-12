Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:57116 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755168Ab2LLV55 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 12 Dec 2012 16:57:57 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id E14B0540274
	for <backports@vger.kernel.org>; Wed, 12 Dec 2012 16:57:55 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-12 is baked
Message-Id: <20121212215755.CC7B240ABF@repository3.orbit-lab.org>
Date: Wed, 12 Dec 2012 16:57:55 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at b84f870 compat-drivers: ship include/linux/bcm47xx_wdt.h
git fetch github (/var/opt/compat/compat)
HEAD is now at 20ace73 compat: add HID_QUIRK_IGNORE
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 3377153 Add linux-next specific files for 20121211
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
Trying kernel 2.6.27-020627-generic [FAILED]
Trying kernel 2.6.26-020626-generic [FAILED]
Trying kernel 2.6.25-020625-generic [FAILED]
Trying kernel 2.6.24-020624-generic [FAILED]
Failed...

compat-drivers code metrics

   1266702 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3076 - backport code changes
      2581 - backport code additions
       495 - backport code deletions
     14512 - backport from compat module
     17588 - total backport code
    1.3885 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14512 - backport from compat module
     14948 - total backport code
    1.1801 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121211
compat.git: compat-2012-12-04-7-g20ace73
compat-drivers release: compat-drivers-2012-12-04-1-6-gb84f870
Code metrics archive: http://bit.ly/H6BTF7
