Return-path: <backports-owner@vger.kernel.org>
Received: from mail.nanl.de ([217.115.11.12]:40312 "EHLO mail.nanl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450Ab3ESSsS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 14:48:18 -0400
From: Jonas Gorski <jogo@openwrt.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Subject: [PATCH 1/2] compat: add missing include in #else for compat-3.10.h
Date: Sun, 19 May 2013 20:47:44 +0200
Message-Id: <1368989265-15164-2-git-send-email-jogo@openwrt.org> (sfid-20130519_204826_655360_AAA8B2CA)
In-Reply-To: <1368989265-15164-1-git-send-email-jogo@openwrt.org>
References: <1368989265-15164-1-git-send-email-jogo@openwrt.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When compiling against 3.10-rc1, the build fails as follows:

  CC [M]  compat/main.o
In file included from include/linux/compat-2.6.h:75:0,
                 from <command-line>:0:
include/linux/compat-3.10.h:91:52: warning: 'struct fb_info' declared inside parameter list [enabled by default]
include/linux/compat-3.10.h:91:52: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
include/linux/compat-3.10.h: In function 'backport_fb_enable_skip_vt_switch':
include/linux/compat-3.10.h:93:6: error: dereferencing pointer to incomplete type

Fix this adding the missing include to the else branch to stay true to
the original commit, instead of pulling it out of the #if #else #endif
block.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 include/linux/compat-3.10.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/compat-3.10.h b/include/linux/compat-3.10.h
index f972203..9d6e55c 100644
--- a/include/linux/compat-3.10.h
+++ b/include/linux/compat-3.10.h
@@ -87,6 +87,8 @@ static inline void fb_enable_skip_vt_switch(struct fb_info *info)
  * clash on the backport for 3.12 as the routine would
  * already be defined *but* we'd need it for 3.11.
  */
+#include <linux/fb.h>
+
 #define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
 static inline void fb_enable_skip_vt_switch(struct fb_info *info)
 {
-- 
1.7.10.4

