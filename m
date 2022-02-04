Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A20C433EF
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiBDVlh (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbiBDVlh (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:41:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83620C061401
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=va+GFbJtuFa8qyREMbGE1xprniCUfpqAZI1Z3uusfwo=; b=nui6gOX/wQlYSavUAlTO8/+Uhm
        OXpn4xnjBjSvsMNSqeRPYlA/euVELo6RcNXt1m1Rwaetl3vhAEye7AcM8Zi2ZmYTXMKb0wTbxZbke
        C/uXPhHJ+J/kqJfx3sPPDaA1CcUceFraRb+F99C6Xw1fZZatlsoLvtgn+46QYbp/vGtCwb1zs+gvn
        vdj3f+j8v1MpzNUEQvbe9YP8pv+NSkKOke9VIu05vkmDFEc9zfpe4H7dxASPyiYK965qX+rNKl7Px
        W2WOONSK6fq0nwiVnlALeRL01TtKL8j/+0/2Kde1VWwZ63QCC3LPyfKXOmOsOexKx+uJ7odqEypOa
        3crmtYVg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Kk-005TzK-5W; Fri, 04 Feb 2022 21:41:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hauke@hauke-m.de, backports@vger.kernel.org, mcgrof@kernel.org
Cc:     thomas@adapt-ip.com, johannes@sipsolutions.net
Subject: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
Date:   Fri,  4 Feb 2022 13:41:31 -0800
Message-Id: <20220204214131.1306843-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204214131.1306843-1-mcgrof@kernel.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

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
index 00000000..49bb13b3
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
2.34.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
