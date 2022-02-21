Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13EC433EF
	for <backports@archiver.kernel.org>; Mon, 21 Feb 2022 11:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiBULIy (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:08:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355531AbiBULIn (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Feb 2022 06:08:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081F1C109
        for <backports@vger.kernel.org>; Mon, 21 Feb 2022 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=yQRGE0ADjubTtJFPtNokTLvsR+agAoij+wNgPTdAYf8=; t=1645439831; x=1646649431; 
        b=DisOFst0uCkZ1N7C5bb3gd7w0P1HgKYG4Xx694XoCo8ejndiMEv8wCzJwMfXBiFUYNNj0q1HbM1
        C3pOMtmjEd19WmkgxXfYnXv2oBI/H859vHOkayqOaWchmEXqDdJB5UTOfSwziQ73U0V3cODaVHZlF
        PXWijyehGz5uWcX2h/fE1zWwSV0h+uGV+p8L1DThOF7dOuymIpjYmgFJMl7l1vFTEZvZpJPleBUo+
        GSUf05bm8gUgOxr0Kg2RJckKtk3Zb2AL/EsUepI7JEV2Wd5Z5pgEVbSAiSsxSDZ39CEJJPt++K+NP
        k4m5Ytq3Ar+tLTeYH4zCQizpZUp7TkYLNa0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nM643-003ncx-Uk;
        Mon, 21 Feb 2022 11:37:08 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: add virtio_reset_device
Date:   Mon, 21 Feb 2022 11:37:04 +0100
Message-Id: <20220221113704.ebf650b2a169.I3dd09cc0b68e7a93e003ef10216ec310d74e80de@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/virtio.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/linux/virtio.h

diff --git a/backport/backport-include/linux/virtio.h b/backport/backport-include/linux/virtio.h
new file mode 100644
index 000000000000..0bca8fa8d839
--- /dev/null
+++ b/backport/backport-include/linux/virtio.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_VIRTIO_H
+#define __BACKPORT_LINUX_VIRTIO_H
+#include_next <linux/virtio.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void virtio_reset_device(struct virtio_device *dev)
+{
+	dev->config->reset(dev);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_VIRTIO_H */
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
