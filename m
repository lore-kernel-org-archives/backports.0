Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C979C4321E
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJMIx7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJMIx4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:56 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73215FD82
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=u7mysV/d1il4LuCgj4M44OEoRWIgqcQCjr8HdvPmXbo=; b=qSbmaWyuRUhcQXPDiz/guRKFsz
        d8eouVwndOHtOe6bV5pYHFMDrVosz929JCF3byfQtGyp0YR1w+NmSJUYe+AzLwfwlaENHfmOAJasj
        75MoGhHIVM4jJov40Jsoc+7L6EPy5FrS3iiSUKyGglWcc9qHP+nBKm0wbr/0i8/dmfYM=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityT-00CO7a-4T
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 6/8] headers: add DEFINE_SIMPLE_DEV_PM_OPS
Date:   Thu, 13 Oct 2022 10:53:49 +0200
Message-Id: <20221013085351.14516-6-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221013085351.14516-1-nbd@nbd.name>
References: <20221013085351.14516-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/pm.h | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 926b0bf15c8e..24d760fab33c 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -14,4 +14,34 @@
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
 #endif
 
+#ifndef DEFINE_SIMPLE_DEV_PM_OPS
+
+#define pm_sleep_ptr(_ptr) (IS_ENABLED(CONFIG_PM_SLEEP) ? (_ptr) : NULL)
+
+#define SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend = pm_sleep_ptr(suspend_fn), \
+	.resume = pm_sleep_ptr(resume_fn), \
+	.freeze = pm_sleep_ptr(suspend_fn), \
+	.thaw = pm_sleep_ptr(resume_fn), \
+	.poweroff = pm_sleep_ptr(suspend_fn), \
+	.restore = pm_sleep_ptr(resume_fn),
+
+#define RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+
+#define _DEFINE_DEV_PM_OPS(name, \
+			   suspend_fn, resume_fn, \
+			   runtime_suspend_fn, runtime_resume_fn, idle_fn) \
+const struct dev_pm_ops name = { \
+	SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	RUNTIME_PM_OPS(runtime_suspend_fn, runtime_resume_fn, idle_fn) \
+}
+
+#define DEFINE_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+	_DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
+
+#endif
+
 #endif /* __BACKPORT_PM_H */
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
