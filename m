Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F2C433FE
	for <backports@archiver.kernel.org>; Mon, 21 Feb 2022 11:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiBULMX (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:12:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbiBULML (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Feb 2022 06:12:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672DB24BFC
        for <backports@vger.kernel.org>; Mon, 21 Feb 2022 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=DcJwCudJcMwesVc5+XMvMUWtz27I5Aema/crgYw0mrM=; t=1645440275; x=1646649875; 
        b=kq0Dq+Jdd2m1UNmklO+dPSAn+ACa8hPMKsZNR07vpFLSh3ZPlQmThp25gd8oZqjTkVBM2gTXMkM
        4qa+sX9Pb0u8l+fHRfAEAxQYOKZ4O46KrhX55UD4exrlpdU5O3+REVFGjiaWDvdKaRMhCu4OreRbK
        jSatwACYwua49u3zItA4YMyrwaordEFkDRg3Q5MTj3CvSfjs/raz58zdmUkbu59w6BAE/9EVNNwl2
        JPzLLnJEEEZAAi9BytKTrR81bClHmo/E5MrellCBT9254GiA3JF8rMVmLPEKqL9GKCgjsT4i0OSLS
        UmgvbvjsZe/MkvjcCE2r21Pvmt5vsfD18NzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nM6BD-003nmG-U2;
        Mon, 21 Feb 2022 11:44:32 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: add virtio_reset_device
Date:   Mon, 21 Feb 2022 11:44:29 +0100
Message-Id: <20220221114429.56b8eaea0fd7.I3dd09cc0b68e7a93e003ef10216ec310d74e80de@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

ticket=none

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
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
