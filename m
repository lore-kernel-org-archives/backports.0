Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <stefan.kuhn@foss-group.ch>
From: stefan.kuhn@foss-group.ch
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
	Stefan Kuhn <stefan.kuhn@hispeed.ch>
Subject: [compat-drivers 0/1] scripts/driver-select: use $BACKUP_EXT everywhere
Date: Sat,  2 Mar 2013 20:07:40 +0100
Message-Id: <1362251261-7270-1-git-send-email-stefan.kuhn@hispeed.ch>
List-ID: <backports@vger.kernel.org>

"bk" was used in the code, replaced it with $BACKUP_EXT

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
