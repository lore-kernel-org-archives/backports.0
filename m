Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:33181 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755147Ab2JOUOX (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Oct 2012 16:14:23 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 19268540055
	for <backports@vger.kernel.org>; Mon, 15 Oct 2012 16:14:22 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-10-15 is baked
Message-Id: <20121015201421.E3B3A40ABF@repository3.orbit-lab.org>
Date: Mon, 15 Oct 2012 16:14:21 -0400 (EDT)
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
HEAD is now at 50a723f Add linux-next specific files for 20121015
cp: cannot stat `/var/opt/compat//linux-next//include/linux/nl80211.h': No such file or directory
Error while updating from wireless-testing

compat-drivers code metrics

   1250678 - Total upstream lines of code being pulled
