Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40682 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab3C1TSn (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:18:43 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] compat: fix export of __sg_page_iter*
Date: Thu, 28 Mar 2013 20:18:24 +0100
Message-Id: <1364498307-11855-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
References: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.9.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/compat-3.9.c b/compat/compat-3.9.c
index 7134caa..1f24842 100644
--- a/compat/compat-3.9.c
+++ b/compat/compat-3.9.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/scatterlist.h>
 
-#ifndef __sg_page_iter_next
+#ifdef __sg_page_iter_next
 
 void __sg_page_iter_start(struct sg_page_iter *piter,
 			  struct scatterlist *sglist, unsigned int nents,
-- 
1.7.10.4

