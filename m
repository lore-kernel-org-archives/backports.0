Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52400 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3G3KaL (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 06:30:11 -0400
Received: by mail-pd0-f173.google.com with SMTP id p11so2418201pdj.4
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 03:30:10 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/2] rel-html: update linux and backports project releases
Date: Tue, 30 Jul 2013 03:30:00 -0700
Message-Id: <1375180201-5274-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_123014_630644_D36388D3)
In-Reply-To: <1375180201-5274-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375180201-5274-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This adds v3.11 to the list of supported releases.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/backports.cfg |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index ee64a5c..13afc71 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,10 +2,11 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	3.11
+	3.10
 	3.9
 	3.8
 	3.7
-	3.10
 rel_html_url_releases	= http://www.kernel.org/pub/linux/kernel/projects/backports/stable/
 			  http://www.kernel.org/pub/linux/kernel/projects/backports/2013/
 rel_license 		= GPLv2
-- 
1.7.10.4

