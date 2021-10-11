Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09074C433EF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE49460EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhJKWY7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2CC061745
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HStbK4TMNzQjwN;
        Tue, 12 Oct 2021 00:22:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YA/GL2PaUe9pIHOkyQuV9WYlp72H86e0w3jxEVBT/JU=;
        b=Vkf74Rvq1rS03sLjAx5YbwZ96NyvnHrFObxPrdUVbNUg41m8Taa05rTKO8BDUsymDJcpqi
        11s1Mr8pjekxFO++2EInFKuvLIGoE51DxnR8Whfr1d3a6tbkptuw4FkokFGAAP4XLYJMSD
        ZEfCLK04KAVXCOgbNRAaaf271+/pIkWQYgg9TRU/OopvObUuPHdvef3MeUn406emc5uyk+
        N9v3Ow13kbP19k3hQWh50mGLovqptvLDjebv7DDWuhY6JPkzLujrN+2b2/8ZK88Fl6ouIZ
        9c553Q2Y4tQnk9WtKre6Y2so8CvHCnF6B/FyuJCqQ+anLBuydIUt/9Akzq4fNw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/14] backports: cmake: Fixes for python3
Date:   Tue, 12 Oct 2021 00:22:15 +0200
Message-Id: <20211011222227.1189850-3-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5B0518B6
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Make ckmake work with python3.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/ckmake | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index d16de3a7..9252df84 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -20,7 +20,7 @@ import subprocess
 import sys
 import signal
 
-from Queue import Queue
+from queue import Queue
 from threading import Thread, Lock
 from shutil import copytree, ignore_patterns, rmtree, copyfileobj
 from time import sleep
@@ -232,7 +232,6 @@ def cpu_info_build_jobs():
 
 def kill_curses():
     curses.endwin()
-    sys.stdout = os.fdopen(0, 'w', 0)
 
 
 def sig_handler(signal, frame):
@@ -643,10 +642,10 @@ if __name__ == "__main__":
             target_kranges.append(krange)
 
     if not os.path.exists(modules):
-        print "%s does not exist" % (modules)
+        print ("%s does not exist" % (modules))
         sys.exit(1)
     if not os.path.exists(my_cwd + '/Makefile'):
-        print "%s does not exist" % (my_cwd + '/Makefile')
+        print ("%s does not exist" % (my_cwd + '/Makefile'))
         sys.exit(1)
     if os.path.exists(ckmake_log):
         os.remove(ckmake_log)
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
