Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:39242 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbaAXWro (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:47:44 -0500
Received: by mail-pb0-f54.google.com with SMTP id uo5so3742651pbc.41
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:47:43 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 04/11] rel-html: add 3.14 for backports project release file
Date: Fri, 24 Jan 2014 14:47:09 -0800
Message-Id: <1390603636-27841-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20140124_234752_747270_ACFF7BFD)
In-Reply-To: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
References: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is in preparation for the 3.14-rc1 release.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/backports.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index 2ea2ca3..ae9cdac 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -2,6 +2,7 @@
 rel_html_proj		= backports
 rel_html_proj_aliases	= compat-drivers
 supported =
+	3.14
 	3.13
 	3.12
 	3.11
-- 
1.8.5.2

