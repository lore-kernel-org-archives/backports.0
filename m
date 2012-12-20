Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:53425 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751168Ab2LTVQA (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 20 Dec 2012 16:16:00 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 048FC540178
	for <backports@vger.kernel.org>; Thu, 20 Dec 2012 16:15:59 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-20 is baked
Message-Id: <20121220211558.CFB0E40AC0@repository3.orbit-lab.org>
Date: Thu, 20 Dec 2012 16:15:58 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
HEAD is now at b40c676 compat-drivers: refresh 0001-backport-alx.patch
git fetch github (/var/opt/compat/compat)
HEAD is now at 46faf02 compat: move HID_USB_DEVICE and HID_BLUETOOTH_DEVICE
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 6f49e03 Add linux-next specific files for 20121220
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...

compat-drivers code metrics

   1270452 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3076 - backport code changes
      2581 - backport code additions
       495 - backport code deletions
     14595 - backport from compat module
     17671 - total backport code
    1.3909 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14595 - backport from compat module
     15031 - total backport code
    1.1831 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20121220
compat.git: compat-2012-12-19
compat-drivers release: compat-drivers-2012-12-19
Code metrics archive: http://bit.ly/H6BTF7
