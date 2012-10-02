Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:56962 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752533Ab2JBUP5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2012 16:15:57 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 836185402F2
	for <backports@vger.kernel.org>; Tue,  2 Oct 2012 16:15:56 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-02 is baked
Message-Id: <20121002201556.61F1F40ABF@repository3.orbit-lab.org>
Date: Tue,  2 Oct 2012 16:15:56 -0400 (EDT)
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
HEAD is now at 046301d Add linux-next specific files for 20121002
Error while updating from wireless-testing
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1213197 - Total upstream lines of code being pulled
