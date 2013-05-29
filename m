Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:33917 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966728Ab3E2UNk (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 May 2013 16:13:40 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: update output template .gitignore for kconfig move
Date: Wed, 29 May 2013 22:13:34 +0200
Message-Id: <1369858414-4066-1-git-send-email-johannes@sipsolutions.net> (sfid-20130529_221341_963629_4BC3E537)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

I clearly forgot this during the Kconfig move, the .gitignore
that is in the output template directory (and used with the
git-tracker) needs to be updated for the kconf directory move.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/.gitignore | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/.gitignore b/backport/.gitignore
index c906800..43a3d08 100644
--- a/backport/.gitignore
+++ b/backport/.gitignore
@@ -14,8 +14,8 @@ Kconfig.versions
 modules.order
 backport-include/backport/autoconf.h
 modules
-kconfig/mconf
-kconfig/conf
+kconf/mconf
+kconf/conf
 .tmp_versions
 Module.symvers
 *.mod.c
-- 
1.8.0

