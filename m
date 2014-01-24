Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38667 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAXUjO (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: fix uninstall filename
Date: Fri, 24 Jan 2014 21:38:52 +0100
Message-Id: <1390595932-21877-6-git-send-email-hauke@hauke-m.de> (sfid-20140124_213915_713693_04986217)
In-Reply-To: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
References: <1390595932-21877-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The uninstall script calculated the filename in the wrong way. It added
the current working dir into the file name, this resulted in names like
this:
/lib/modules/2.6.32-431.3.1.el6.x86_64/updates//home/hauke/backports-20140124/drivers/net/wireless/ipw2x00/ipw2100.ko
The correct one would be this
/lib/modules/2.6.32-431.3.1.el6.x86_64/updates/drivers/net/wireless/ipw2x00/ipw2100.ko

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/scripts/uninstall.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/scripts/uninstall.sh b/backport/scripts/uninstall.sh
index 99f74ab..1eb42b0 100755
--- a/backport/scripts/uninstall.sh
+++ b/backport/scripts/uninstall.sh
@@ -11,7 +11,7 @@ else
 fi
 
 for driver in $(find ${BACKPORT_PWD} -type f -name *.ko); do
-	mod_name=${KLIB}${KMODDIR}/${driver}${compr}
+	mod_name=${driver/${BACKPORT_PWD}/${KLIB}${KMODDIR}}${compr}
 	echo "  uninstall" $mod_name
 	rm -f $mod_name
 done
-- 
1.7.10.4

