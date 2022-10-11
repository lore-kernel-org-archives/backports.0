Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744BC433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJKVFQ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930C20184
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4WSUQMOB2sB9mh61yW1Bj3hqV9V5TTtO//utFohF4Z8=;
        t=1665522297; x=1666731897; b=JZJ1mT1PQNFNHBchZvQzWvFUAQMl1B3/Z4wE4zcZJcwtfqN
        6+gLFpt2U5lk4AyXIsQIzPVvDe5X+olNlYt29ZmI8FHbVa4BaYfiM7tVUJBDrbgVJICLw8snNgmln
        Do7NaDA5CmsDKWON6Hb7u9hsGw1eQEUNNCrPnBq1wI1gi6vAOtWM5kNB/BZTQfG7i48g1XwyB4JB5
        OAf808qkzH1VQIBAGr/gbyo0UN/dCQOmYPim2NAqys3H0g3Ed76Fnq67Yb5KrYBEHLj+V6A5zGPno
        k9p7dBikyk8mo5BaWgrc612xYNxbd1HQvxOmLzQ7r6/b4Pt2pmoapwiq0oIcryAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQo-0045LP-2B;
        Tue, 11 Oct 2022 23:04:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/38] backports: add eth_hw_addr_set()
Date:   Tue, 11 Oct 2022 23:04:29 +0200
Message-Id: <20221011230356.8f08adab3cba.I04584880e09adbe7318583f88d24358005f95ccf@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/etherdevice.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 55672f69ddaa..f6fa51f3829c 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -38,4 +38,18 @@ static inline void u64_to_ether_addr(u64 u, u8 *addr)
 }
 #endif /* LINUX_VERSION_IS_LESS(4,11,0) */
 
+#if LINUX_VERSION_IS_LESS(5,15,0)
+/**
+ * eth_hw_addr_set - Assign Ethernet address to a net_device
+ * @dev: pointer to net_device structure
+ * @addr: address to assign
+ *
+ * Assign given address to the net_device, addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
+{
+	ether_addr_copy(dev->dev_addr, addr);
+}
+#endif /* LINUX_VERSION_IS_LESS(5,15,0) */
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
