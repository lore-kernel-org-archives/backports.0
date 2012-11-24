Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:57277 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752238Ab2KXV5G (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 24 Nov 2012 16:57:06 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id E21D4540188
	for <backports@vger.kernel.org>; Sat, 24 Nov 2012 16:57:04 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-11-24 is baked
Message-Id: <20121124215704.A822F40AC0@repository3.orbit-lab.org>
Date: Sat, 24 Nov 2012 16:57:04 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 41121c4 compat-drivers: disable mwifiex for kernels older than 2.6.27
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 2306855 compat: add USB_SUBCLASS_VENDOR_SPEC
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 3805711 Add linux-next specific files for 20121115
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

   1255031 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3125 - backport code changes
      2589 - backport code additions
       536 - backport code deletions
     12755 - backport from compat module
     15880 - total backport code
    1.2653 - % of code consists of backport work

   drm
   ----------------------------------------
       424 - backport code changes
       285 - backport code additions
       139 - backport code deletions
     12755 - backport from compat module
     13179 - total backport code
    1.0501 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121115
compat.git: compat-2012-11-15
compat-drivers release: compat-drivers-2012-11-15-pc
Code metrics archive: http://bit.ly/H6BTF7
