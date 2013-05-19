Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:39485 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3ESCe2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:28 -0400
Received: by mail-pd0-f182.google.com with SMTP id z10so854552pdj.13
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:27 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Jouni Malinen <j@w1.fi>
Subject: [PATCH 8/8] rel-html: update hostapd releases
Date: Sat, 18 May 2013 19:33:42 -0700
Message-Id: <1368930822-13641-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043429_420126_DFA3810F)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Jouni released v2.0 of hostapd a while ago in January, update
the project file for it.

Cc: Jouni Malinen <j@w1.fi>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/hostapd.cfg |    1 +
 1 file changed, 1 insertion(+)

diff --git a/projects/hostapd.cfg b/projects/hostapd.cfg
index 703a120..c2f0c68 100644
--- a/projects/hostapd.cfg
+++ b/projects/hostapd.cfg
@@ -2,6 +2,7 @@
 rel_html_proj           = hostapd
 supported =
 	1.1
+	2.0
 rel_html_url_releases	= http://hostap.epitest.fi/releases/
 rel_license 		= BSD
 ignore_signatures	= True
-- 
1.7.10.4

