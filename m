Return-Path: <SRS0=cdpY=BY=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE746C433DF
	for <backports@archiver.kernel.org>; Fri, 14 Aug 2020 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CA020885
	for <backports@archiver.kernel.org>; Fri, 14 Aug 2020 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="qhW+uhDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgHNORJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:17:09 -0400
Received: from nbd.name ([46.4.11.11]:60384 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgHNORJ (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 14 Aug 2020 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MqW5V2pmwkeUhR4O8G0JPacK2/TwfocGM58JOs2y9yw=; b=qhW+uhDdrsddgDU9T70FM7yQFR
        gOYuZTTcUTTNSA9mL49ksEF54c0qsYV7tZqpqf8rSqkkoiSTs8OTz68zSDqc3HPFJozt8UC9mDI/P
        5JKnbzYcs3KBS2OjKuArDQtahLl9zZd/KMz+hvOk+WYptsJ06qTZ9lGRjGo8ZFUk+Q5k=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k6aVv-0002Bj-Ok
        for backports@vger.kernel.org; Fri, 14 Aug 2020 16:16:59 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 1/2] backports: add netif_receive_skb_list
Date:   Fri, 14 Aug 2020 16:16:57 +0200
Message-Id: <20200814141658.5384-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

It will be needed by pending mac80211 changes

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/netdevice.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index edb0aaf33cde..ba3d352350ad 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -372,6 +372,18 @@ static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
 	macro_dispatcher(netdev_upper_dev_link, __VA_ARGS__)(__VA_ARGS__)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,20,0)
+static inline void netif_receive_skb_list(struct list_head *head)
+{
+	struct sk_buff *skb, *next;
+
+	list_for_each_entry_safe(skb, next, head, list) {
+		skb_list_del_init(skb);
+		netif_receive_skb(skb);
+	}
+}
+#endif
+
 #if LINUX_VERSION_IS_LESS(5,0,0)
 static inline int backport_dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 {
-- 
2.28.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
