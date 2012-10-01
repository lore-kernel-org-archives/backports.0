Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:45679 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750848Ab2JAUQL (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 1 Oct 2012 16:16:11 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 38EDB540378
	for <backports@vger.kernel.org>; Mon,  1 Oct 2012 16:16:10 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-01 is baked
Message-Id: <20121001201610.07DFC40AC0@repository3.orbit-lab.org>
Date: Mon,  1 Oct 2012 16:16:09 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 3df9094 compat-drivers: enable DRM drivers compilation
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at fb4936e compat: backport seq_file's user namespace addition
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 1aa4477 Add linux-next specific files for 20121001
Error while updating from wireless-testing
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1212766 - Total upstream lines of code being pulled
