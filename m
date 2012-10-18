Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:35974 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751691Ab2JRUQV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 18 Oct 2012 16:16:21 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 211225402E0
	for <backports@vger.kernel.org>; Thu, 18 Oct 2012 16:16:20 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-18 is baked
Message-Id: <20121018201619.E7FD840AC0@repository3.orbit-lab.org>
Date: Thu, 18 Oct 2012 16:16:19 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 788f585 compat-drivers: add UAPI backport fixes
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at fb4936e compat: backport seq_file's user namespace addition
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at d646959 Add linux-next specific files for 20121018
cp: cannot stat `/var/opt/compat//linux-next//include/linux/nl80211.h': No such file or directory
Error while updating from wireless-testing

compat-drivers code metrics

   1254585 - Total upstream lines of code being pulled
