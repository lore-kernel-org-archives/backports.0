Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA0C64EB8
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA812147C
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA812147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeJCBzd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:55:33 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48146 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCBzd (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 21:55:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7Q49-0004TE-G0; Tue, 02 Oct 2018 21:10:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add missing include in 3.13 compat code
Date:   Tue,  2 Oct 2018 21:10:26 +0200
Message-Id: <20181002191026.5894-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we don't include <linux/net.h> then __BACKPORT_NET_GET_RANDOM_ONCE
can never be defined, and we'll never get the compat code. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/backport-3.13.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 23c759ef2388..2b61711d233d 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/hwmon.h>
+#include <linux/net.h>
 
 #ifdef __BACKPORT_NET_GET_RANDOM_ONCE
 struct __net_random_once_work {
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
