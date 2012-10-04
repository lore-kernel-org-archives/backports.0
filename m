Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:54401 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752216Ab2JDUNw (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 4 Oct 2012 16:13:52 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 57A5A5403E6
	for <backports@vger.kernel.org>; Thu,  4 Oct 2012 16:13:51 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-04 is baked
Message-Id: <20121004201351.12E2D40ABF@repository3.orbit-lab.org>
Date: Thu,  4 Oct 2012 16:13:49 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 7110a5c compat-drivers: copy over amp.h as a bluetooth header
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at fb4936e compat: backport seq_file's user namespace addition
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 4f22dc6 Add linux-next specific files for 20121004
Error while updating from wireless-testing

compat-drivers code metrics

   1176386 - Total upstream lines of code being pulled
      3107 - backport code changes
      2580 - backport code additions
       527 - backport code deletions
     12696 - backport from compat module
     15803 - total backport code
    1.3434 - % of code consists of backport work
