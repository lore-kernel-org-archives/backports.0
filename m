Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F00C433F5
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381712AbiEMQGJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381696AbiEMQGH (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:07 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA8A6442
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 32C226E3A75;
        Fri, 13 May 2022 16:06:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id essUCZcfeqFD; Fri, 13 May 2022 16:06:00 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id E5A5A6E3A79;
        Fri, 13 May 2022 16:05:26 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 04/15] Makefile.subtrees: document how to update kconfig
Date:   Fri, 13 May 2022 09:05:12 -0700
Message-Id: <20220513160523.2944694-5-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Now that kconfig is a git sub tree document what we need to do
to update version of config. We use squash here so we don't
carry the kconfig tree update logs in our commit log.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.subtrees | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Makefile.subtrees

diff --git a/Makefile.subtrees b/Makefile.subtrees
new file mode 100644
index 000000000000..49bb13b36060
--- /dev/null
+++ b/Makefile.subtrees
@@ -0,0 +1,10 @@
+# If you need to use a git subtree, please add it here.
+add-kconfig-remote:
+	git remote add kconfig https://github.com/mcgrof/kconfig.git
+
+add-kconfig:
+	git subtree add --prefix=backport/kconf --squash kconfig master
+
+refresh-kconfig:
+	git fetch kconfig
+	git subtree pull --prefix=backport/kconf --squash kconfig master
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
