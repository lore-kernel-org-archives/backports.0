Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail.stepping-stone.ch ([194.176.109.206]:40875 "EHLO
	mail.stepping-stone.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab3CBTbr (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 2 Mar 2013 14:31:47 -0500
From: stefan.kuhn@foss-group.ch
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Stefan Kuhn <stefan.kuhn@hispeed.ch>
Subject: [compat-drivers 0/1] scripts/driver-select: use $BACKUP_EXT everywhere
Date: Sat,  2 Mar 2013 20:31:37 +0100
Message-Id: <1362252698-13736-1-git-send-email-stefan.kuhn@hispeed.ch>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

"bk" was used in the code, replaced it with $BACKUP_EXT
(minor typos fixed)

This is my first commit - pls tell if I should commit differently
Regards
Stefan Kuhn (Wuodan)

Signed-off-by: Stefan Kuhn <stefan.kuhn@hispeed.ch>

Stefan Kuhn (1):
  scripts/driver-select: use $BACKUP_EXT everywhere

 scripts/driver-select | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
1.7.12.4

