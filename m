Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1F5C433EF
	for <backports@archiver.kernel.org>; Mon, 31 Jan 2022 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbiAaNJH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 31 Jan 2022 08:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378529AbiAaNJD (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 31 Jan 2022 08:09:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B723C06173B
        for <backports@vger.kernel.org>; Mon, 31 Jan 2022 05:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=DV9sKq+6xFSKgzFpvJ3XZaBSrXAMWOlfv9FJKukUar8=; t=1643634543; x=1644844143; 
        b=KUHf3klc+Prddf5bcuxl6FgxjRuQ0TKAn9C6rRgBuGMgRzi1BqhN1E2dgg0tGeHjZ077vIJibau
        yOwxTvxBhvUba8M0yMkLu7QLW4wx9lsn0keu7+om95RhuFFsDw37uZyDPU5vL9NNIQ3r+4v9Vg4UA
        xsZQCA/vKugbtjy7YHL9EGRlGkAgq5jVfhDbwzA6llYUA8+tfYZjTNUbC8DAzZuR5s8bPAVADeuTI
        ZKz4shL9GCmQlRRcmLZKeca97Gge6Y228leMBP6F058m1K0bAy/cgdSZ2W0KHFtteKYDEsXvCFBt/
        a15KRXDPZiHauuYIiCUH9aUeREK5S/xst9Ug==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nEWQW-00CdS4-EY;
        Mon, 31 Jan 2022 14:09:00 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: add kthread.h
Date:   Mon, 31 Jan 2022 14:08:55 +0100
Message-Id: <20220131140855.29ba6773df38.I0c3c1ed3d75dcd800d0a4ef41943a4db10ea5df4@changeid>
X-Mailer: git-send-email 2.34.1
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
 backport/backport-include/linux/kthread.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/kthread.h

diff --git a/backport/backport-include/linux/kthread.h b/backport/backport-include/linux/kthread.h
new file mode 100644
index 000000000000..23a599e92b30
--- /dev/null
+++ b/backport/backport-include/linux/kthread.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_KTHREAD_H
+#define __BACKPORT_LINUX_KTHREAD_H
+#include_next <linux/kthread.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void __noreturn
+kthread_complete_and_exit(struct completion *c, long ret)
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
