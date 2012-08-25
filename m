Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:34211 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751596Ab2HYUKd (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 25 Aug 2012 16:10:33 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id E8C5D540091
	for <backports@vger.kernel.org>; Sat, 25 Aug 2012 16:10:58 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-08-25 is baked
Message-Id: <20120825201031.A526D40ABE@repository3.orbit-lab.org>
Date: Sat, 25 Aug 2012 16:10:31 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 40ec2b6 compat-wireless: add certification onus / base station pending patches
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 99d7ff9 compat: Backport eth_broadcast_addr()
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at c0deb77 Add linux-next specific files for 20120824
find: `/var/opt/compat//linux-next//drivers/net/wireless/iwmc3200wifi/': No such file or directory
find: `/var/opt/compat//linux-next//drivers/net/ethernet/atheros/alx/': No such file or directory
Error while updating from wireless-testing
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-wireless code metrics

    841647 - Total upstream lines of code being pulled
