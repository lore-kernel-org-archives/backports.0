Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A68C43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJKVF1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJKVFF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F9222B5
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sAb9rVwfBDA/YRqir10+ZsxQ/6vrxEgD+J54ZZWiws0=;
        t=1665522302; x=1666731902; b=AHdCfmVXKyr/b63dCiRw+QGRJJmdyco+p6bxKIs1hiq5NoV
        FSXvLrPaLhtkVoI3tjU81K+cvaz/uZFKKoWtGb5+TRVhIPMthzsk9JBSXaQgggw7A/Vr+ur0pJtqG
        l1TISq+sa2Mi1cRGPNIMuKrh3WNcx+DOAudYAmaGD5HMz6aHDDdVTxQRy3hjSEPwIhlcAi3RhxMfH
        8HyNUuSNuMXhRxOjudwXudbTuBNp0el6LncpLPAH180L5wDBLw1IksAFo2lQQyftRhYBqsGu/jv1L
        C6Ic7hKQGVEtpdHj7ycD6PgKX3srd545+UE1WWy6Ba5e2qkEQdRMwlAFWk5lzmOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQu-0045LP-0Z;
        Tue, 11 Oct 2022 23:05:00 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 38/38] backports: add virtio_reset_device
Date:   Tue, 11 Oct 2022 23:04:46 +0200
Message-Id: <20221011230356.4571ec239020.I3dd09cc0b68e7a93e003ef10216ec310d74e80de@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We need this for hwsim.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/virtio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/virtio.h

diff --git a/backport/backport-include/linux/virtio.h b/backport/backport-include/linux/virtio.h
new file mode 100644
index 000000000000..98c844918251
--- /dev/null
+++ b/backport/backport-include/linux/virtio.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_VIRTIO_H
+#define __BACKPORT_LINUX_VIRTIO_H
+#include_next <linux/virtio.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+#include <linux/virtio_config.h>
+static inline void virtio_reset_device(struct virtio_device *dev)
+{
+	dev->config->reset(dev);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_VIRTIO_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
