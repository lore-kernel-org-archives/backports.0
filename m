Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:40705 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754652Ab2HVU0e (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 Aug 2012 16:26:34 -0400
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 91B645401D6
	for <backports@vger.kernel.org>; Wed, 22 Aug 2012 16:16:40 -0400 (EDT)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-08-22 is baked
Message-Id: <20120822201609.DB0FC40ABD@repository3.orbit-lab.org>
Date: Wed, 22 Aug 2012 16:16:01 -0400 (EDT)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at 40ec2b6 compat-wireless: add certification onus / base station pending patches
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at b8471d8 compat: add tty_port_register_device
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at bc6bbd1 Add linux-next specific files for 20120822
find: `/var/opt/compat//linux-next//drivers/net/wireless/iwmc3200wifi/': No such file or directory
find: `/var/opt/compat//linux-next//drivers/net/ethernet/atheros/alx/': No such file or directory
Error while updating from wireless-testing
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-wireless code metrics

    841457 - Total upstream lines of code being pulled
