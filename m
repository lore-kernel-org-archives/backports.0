Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <johannes@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: mcgrof@do-not-panic.com,
	backports@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] compat-drivers: rename GPL file to COPYING
Date: Mon, 18 Feb 2013 15:39:23 +0100
Message-Id: <1361198363-29244-1-git-send-email-johannes@sipsolutions.net>
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Code or other references in the kernel would point to
a file called "COPYING" (as in the upstream kernel),
so rename the GPL file to that name.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 COPYRIGHT => COPYING | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename COPYRIGHT => COPYING (100%)

diff --git a/COPYRIGHT b/COPYING
similarity index 100%
rename from COPYRIGHT
rename to COPYING
-- 
1.8.0
