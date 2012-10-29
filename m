Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:35002 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758455Ab2J2U7C (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 29 Oct 2012 16:59:02 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 88B6E540245
	for <backports@vger.kernel.org>; Mon, 29 Oct 2012 16:59:00 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-29 is baked
Message-Id: <20121029205900.5B34540AC0@repository3.orbit-lab.org>
Date: Mon, 29 Oct 2012 16:59:00 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 38a17ae compat-drivers: Copy core/ subdir of nouveau driver
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 8de8ebb compat: encourage non-root use of bin/get-compat-kernels
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at f83c772 Add linux-next specific files for 20121029
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

   1235789 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3114 - backport code changes
      2583 - backport code additions
       531 - backport code deletions
     12754 - backport from compat module
     15868 - total backport code
    1.2840 - % of code consists of backport work

   drm
   ----------------------------------------
       305 - backport code changes
       221 - backport code additions
        84 - backport code deletions
     12754 - backport from compat module
     13059 - total backport code
    1.0567 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121029
compat.git: compat-v3.7-rc1-1
compat-drivers release: compat-drivers-2012-10-16-12-g38a17ae-pc
Code metrics archive: http://bit.ly/H6BTF7
