Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:40966 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752071Ab2LVVO1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 22 Dec 2012 16:14:27 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 0DD7A540178
	for <backports@vger.kernel.org>; Sat, 22 Dec 2012 16:14:26 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2012-12-22 is baked
Message-Id: <20121222211425.DAB3B40ABF@repository3.orbit-lab.org>
Date: Sat, 22 Dec 2012 16:14:25 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch github (/var/opt/compat/compat-wireless-2.6)
Nothing new to pack.
HEAD is now at b40c676 compat-drivers: refresh 0001-backport-alx.patch
git fetch github (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at 46faf02 compat: move HID_USB_DEVICE and HID_BLUETOOTH_DEVICE
git fetch  (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at 0233d95 Add linux-next specific files for 20121221
/var/opt/compat//compat-ksrc/lib/modules does not exist
Failed...

compat-drivers code metrics

   1270453 - Total upstream lines of code being pulled

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
Base tree version: next-20121221
compat.git: compat-2012-12-19
compat-drivers release: compat-drivers-2012-12-19
Code metrics archive: http://bit.ly/H6BTF7
