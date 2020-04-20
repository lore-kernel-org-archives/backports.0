Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D66C55181
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AC320722
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDTWQe (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:34 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:34596 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgDTWQd (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:33 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 495gyl5TzqzKmcK;
        Tue, 21 Apr 2020 00:16:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id P9ZkOfxgd6aC; Tue, 21 Apr 2020 00:16:28 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/9] backports: virtio_config: Add virtio_find_vqs()
Date:   Tue, 21 Apr 2020 00:16:12 +0200
Message-Id: <20200420221615.14734-7-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0130B1734
X-Rspamd-Score: -5.43 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The virtio_find_vqs() function is now used by the mac80211_hwsim driver.
This is just a wrapper around the find_vqs callback. The find_vqs
callback changed over the time.
With kernel 4.10 the names parameter was changed from "const char
*names[]" to "const char * const names[]".
With kernel 4.11 the "struct irq_affinity *desc" was added. We have to
define struct irq_affinity here for older kernel versions, because it
is used in this new parameter in kernel >= 4.12 this is already done in
the upstream header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../backport-include/linux/virtio_config.h    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 backport/backport-include/linux/virtio_config.h

diff --git a/backport/backport-include/linux/virtio_config.h b/backport/backport-include/linux/virtio_config.h
new file mode 100644
index 00000000..aeb1ba10
--- /dev/null
+++ b/backport/backport-include/linux/virtio_config.h
@@ -0,0 +1,31 @@
+#ifndef _COMPAT_LINUX_VIRTIO_CONFIG_H
+#define _COMPAT_LINUX_VIRTIO_CONFIG_H
+#include_next <linux/virtio_config.h>
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(4,11,0)
+struct irq_affinity;
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,12,0)
+static inline
+int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+			struct virtqueue *vqs[], vq_callback_t *callbacks[],
+#if LINUX_VERSION_IS_LESS(4,10,0)
+			const char * const names[],
+#else
+			const char *names[],
+#endif
+			struct irq_affinity *desc)
+{
+#if LINUX_VERSION_IS_LESS(4,11,0)
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names);
+#else
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, desc);
+#endif
+}
+#endif /* < 4.12 */
+
+
+#endif	/* _COMPAT_LINUX_VIRTIO_CONFIG_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
