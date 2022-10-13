Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15635C4167B
	for <backports@archiver.kernel.org>; Thu, 13 Oct 2022 08:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJMIx7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJMIx5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Oct 2022 04:53:57 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0BE16EB5C
        for <backports@vger.kernel.org>; Thu, 13 Oct 2022 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/6fwFqVTKTQUDdTTIa//A3YNABtTKyq5AxEVQAK8mPs=; b=irEs0xJbyJwbgPdk6U41w5IEw8
        YHKrw2vpIUL58WpQ3/yzRWqG/EXf8v3zEllSXaPixxujbAue/3Y/KpAHOZRPhCmhdUjWhEz8iofwi
        ePosNrxrw4lxkFH48BzgNpTJdrsb6w8ns5lYi10rTtB7GGZKIrIXTTab7QfzBPiIGZ4w=;
Received: from p200300daa7301d0028e1e1004b08c350.dip0.t-ipconnect.de ([2003:da:a730:1d00:28e1:e100:4b08:c350] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oityT-00CO7a-GX
        for backports@vger.kernel.org; Thu, 13 Oct 2022 10:53:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 8/8] headers: add skb_tcp_all_headers
Date:   Thu, 13 Oct 2022 10:53:51 +0200
Message-Id: <20221013085351.14516-8-nbd@nbd.name>
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
 backport/backport-include/linux/tcp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/tcp.h

diff --git a/backport/backport-include/linux/tcp.h b/backport/backport-include/linux/tcp.h
new file mode 100644
index 000000000000..2483cbebf66c
--- /dev/null
+++ b/backport/backport-include/linux/tcp.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_LINUX_TCP_H
+#define __BACKPORT_LINUX_TCP_H
+
+#include_next <linux/tcp.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+static inline int skb_tcp_all_headers(const struct sk_buff *skb)
+{
+	return skb_transport_offset(skb) + tcp_hdrlen(skb);
+}
+#endif
+
+#endif
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
