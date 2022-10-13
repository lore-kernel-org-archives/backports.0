Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBFC43217
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJMIx6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJMIxz (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA7D16EB4A
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RpcK/q7kvXHnZ79IPpPIx24zBcawHO4zMYVbq4G6A6I=; b=XLuNTAbJuM0exhgy5kAuWnD79e
        Qo1mLQgBzLmK+fPdRxsS+OWZSS1lD0xk1gX3n3PCTlXeMgA+ipyovRuuUGGJsL/NoOkCDW/+o+h7a
        +ltmSbwqzrtEvC3npKBC135E+8OuYycM0o1ESzFW7rzsfRdNOiG/hFe+6XU4QEjEHWJg=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityS-00CO7a-P7
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:52 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 4/8] headers: add __vstring and __assign_vstr
Date:   Thu, 13 Oct 2022 10:53:47 +0200
Message-Id: <20221013085351.14516-4-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221013085351.14516-1-nbd@nbd.name>
References: <20221013085351.14516-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Used within tracepoints on a few drivers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/trace/trace_events.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/trace/trace_events.h

diff --git a/backport/backport-include/trace/trace_events.h b/backport/backport-include/trace/trace_events.h
new file mode 100644
index 000000000000..fd6a4f3c343d
--- /dev/null
+++ b/backport/backport-include/trace/trace_events.h
@@ -0,0 +1,16 @@
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+#undef VSTRING_MSG_MAX
+#define VSTRING_MSG_MAX	512
+
+#undef __vstring
+#define __vstring(msg, fmt, va) __dynamic_array(char, msg, VSTRING_MSG_MAX)
+
+#undef __assign_vstr
+#define __assign_vstr(msg, fmt, va)					  \
+	WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg), VSTRING_MSG_MAX, \
+			       fmt, *va) >= VSTRING_MSG_MAX)
+#endif /* <6.0 */
+
+#include_next <trace/trace_events.h>
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
