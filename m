Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 5/8] compat-drivers: update genlog-3.8 for rc5
Date: Tue, 26 Feb 2013 21:42:32 +0100
Message-Id: <1361911355-29256-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
References: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 3e5178598c2ce38853638c42e0b3103ce39fa96e

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 scripts/genlog-3.8 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/genlog-3.8 b/scripts/genlog-3.8
index d89ecdc..72153cb 100755
--- a/scripts/genlog-3.8
+++ b/scripts/genlog-3.8
@@ -5,7 +5,7 @@ COMPAT_WIRELESS=$HOME/devel/compat-drivers/.git
 
 OLD_VER=7
 let VER="8"
-RC="-rc4"
+RC="-rc5"
 export GIT_DIR=${COMPAT_WIRELESS}
 CD_VER="$(git describe | sed -e 's|compat-drivers-v||g')"
 LOG="ChangeLog-${CD_VER}"
-- 
1.7.10.4
