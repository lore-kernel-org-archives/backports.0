Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51868 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668AbaEHUkc (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:32 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so342212wiv.1
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:31 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 09/10] backports: compress_module.sh: gzip silently overrides existing compressed modules
Date: Thu,  8 May 2014 22:39:32 +0200
Message-Id: <1399581573-12072-10-git-send-email-s.martin49@gmail.com> (sfid-20140508_224036_131972_1D9DF0C2)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/scripts/compress_modules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/scripts/compress_modules.sh b/backport/scripts/compress_modules.sh
index b2034c2..631eec9 100755
--- a/backport/scripts/compress_modules.sh
+++ b/backport/scripts/compress_modules.sh
@@ -7,6 +7,6 @@ source ./scripts/mod_helpers.sh
 if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
 	for driver in $(find "$1" -type f -name *.ko); do
 		echo COMPRESS $driver
-		gzip -9 $driver
+		gzip -f -9 $driver
 	done
 fi
-- 
1.9.2

