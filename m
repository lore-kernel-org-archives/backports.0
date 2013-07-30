Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:62829 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab3G3KaP (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 06:30:15 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so6534301pdi.2
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 03:30:15 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] rel-html: eol the same Linux releases
Date: Tue, 30 Jul 2013 03:30:01 -0700
Message-Id: <1375180201-5274-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_123018_190949_AC8F815D)
In-Reply-To: <1375180201-5274-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375180201-5274-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

It just so happens that the same releases on Linux that are EOL'd
are also the old name releases for backports, ie. 'compat-drivers'.
These are now deprecated and you should be using the release marked
as supported. These should match the latest supported stable
kernel releases.

Note that for backports you should be using the *latest* stable
release. The release will work on *older* kernel releases. That
is the point.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 projects/backports.cfg |    1 +
 1 file changed, 1 insertion(+)

diff --git a/projects/backports.cfg b/projects/backports.cfg
index 13afc71..ba6a275 100644
--- a/projects/backports.cfg
+++ b/projects/backports.cfg
@@ -4,6 +4,7 @@ rel_html_proj_aliases	= compat-drivers
 supported =
 	3.11
 	3.10
+eol =
 	3.9
 	3.8
 	3.7
-- 
1.7.10.4

