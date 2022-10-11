Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F09C43217
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJKVFF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJKVE7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E963205F9
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RK7fnMKD/8RKFG5Iq86GkD6uix3KhD14ieOadtyGsrY=;
        t=1665522295; x=1666731895; b=Ku7qvbMN4Vky7Bb70cts5P75mCciqUfhIFKzBaW65S4JIhM
        2lsIEb2TOzJbxrgBhA5uJ8FITW9ggo8dPti2CfmE0GPcmBHx8shU7seje7HuSBHRQgjZcy2QZZbWy
        FoEOSF3wVdu/bXrIcq8Ul6p/vCF+qKwF5ZsE01jEl5P4YzpLEcnc1KKXh99b8Zx+VjaSAB2TSrRa9
        JKZN1vIisMn/H88N0ARJstqLiXcvOhO/3lzm1wAFgfcdTJhcYxzpP52sLhiobTc4cK8DTyQUPz6R8
        Dhj2W2bvX9KTGh3HrnxlaYpCooq7GttX+uKIBhxelwMQBqMeeJ2Ei0x1S2tBlsbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQl-0045LP-1C;
        Tue, 11 Oct 2022 23:04:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 10/38] backports: add kthread.h
Date:   Tue, 11 Oct 2022 23:04:18 +0200
Message-Id: <20221011230356.6f6ee6b34e1e.I0c3c1ed3d75dcd800d0a4ef41943a4db10ea5df4@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In 5.17, complete_and_exit() gets replaced by
kthread_complete_and_exit(), so support that API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/149477
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Tested-by: Luciano Coelho <luciano.coelho@intel.com>
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
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
