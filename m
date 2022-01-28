Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4BDC433EF
	for <backports@archiver.kernel.org>; Fri, 28 Jan 2022 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347414AbiA1Iwr (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 28 Jan 2022 03:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347385AbiA1Iwk (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 28 Jan 2022 03:52:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D1C061747
        for <backports@vger.kernel.org>; Fri, 28 Jan 2022 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=U+5JvG8I7u02yMiA/HPT/x9S1+Fo8GzerjLG7LFlU5A=;
        t=1643359959; x=1644569559; b=Hs1rOsYNdLEktjnn6wlo8xgYPBk6+iKq0COXKsPnET4nKCB
        JEzrhKwSCOy3vcrqaksZ15G8Dc3ioBZ/j/TWS2D8RkS1E4ELEFIzUy6dZ3cRLYgiB11Li3lmA4xw7
        /S3RFtjt6tejRxqNsIkuqKCANjxsBuuu0dy5NsvraUepyyGEyplRpez/bPdD4IuAHlame9yPEd7gI
        XQve9m2BnaKAgm1tWCpWuGFwV0vuYYM2RPuoHPFzNotbucT1F4Yhe2VrUTU1roEX1tVGJgxOiDet+
        e8KkbJRl9qEHROV2ZiQr9qbj1f095qW1Rbk/Bhm8rm6IUsZ+lqR4CN1nkdYezMyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nDMzj-00BMr8-MC;
        Fri, 28 Jan 2022 09:52:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] backports: add kthread.h
Date:   Fri, 28 Jan 2022 09:52:30 +0100
Message-Id: <20220128095230.0d32af21ba08.I0c3c1ed3d75dcd800d0a4ef41943a4db10ea5df4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128095230.da47bbe7d248.I29005f305b7808de21837d75e992b07444b4eaaa@changeid>
References: <20220128095230.da47bbe7d248.I29005f305b7808de21837d75e992b07444b4eaaa@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In 5.17, complete_and_exit() gets replaced by
kthread_complete_and_exit(), so support that API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kthread.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/linux/kthread.h

diff --git a/backport/backport-include/linux/kthread.h b/backport/backport-include/linux/kthread.h
new file mode 100644
index 000000000000..0b36bdcc2d2a
--- /dev/null
+++ b/backport/backport-include/linux/kthread.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_KTHREAD_H
+#define __BACKPORT_LINUX_KTHREAD_H
+#include_next <linux/kthread.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void kthread_complete_and_exit(struct completion *c, long ret)
+{
+	complete_and_exit(c, ret);
+}
+#endif /* < 5.17 */
+
+#endif /* __BACKPORT_LINUX_KTHREAD_H */
-- 
2.34.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
