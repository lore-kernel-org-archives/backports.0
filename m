Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:58146 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752808Ab2LIXLN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 9 Dec 2012 18:11:13 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 5761E54023E
	for <backports@vger.kernel.org>; Sun,  9 Dec 2012 18:11:12 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-09 is baked
Message-Id: <20121209231112.3456040ABF@repository3.orbit-lab.org>
Date: Sun,  9 Dec 2012 18:11:12 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 0a2da43 compat-drivers: fix alx suspend/resume calls for old kernels
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 3a85112 compat: backport unsigned netlink attribute accessors
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 7bd0111 Add linux-next specific files for 20121207
Error while updating from wireless-testing

compat-drivers code metrics

   1266565 - Total upstream lines of code being pulled

   network
   ----------------------------------------
Write failed: Broken pipe
rsync: connection unexpectedly closed (909507 bytes received so far) [sender]
rsync error: unexplained error (code 255) at io.c(605) [sender=3.0.9]
