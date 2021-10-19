Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2B6C433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3581E610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhJSVqC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJSVp5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:57 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C46C06174E
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:43 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLP1WHqzQjgJ;
        Tue, 19 Oct 2021 23:43:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5w8Ys+x6fUHz9cKGllYakHITV+fYf0/NO303WCbmurs=;
        b=lv/iUN8ctfEN2kVxIIjwW/Dc1V/1b0daL0L3OMh9thtzN2/pCOdGQ6+5z8/f5G32/w34rz
        NagjZlcWMTccrq1JMY729c4jroZaGrV0MVWa+PQX8KToO8moQ06vr9L2EdlxR3bS+yURSL
        o0m6ew1YuvchSzg+fGjz/TLOcb9Yxietkla3tgAMCwQiNdcRJPes9dGBpVXVm8DPA5eu4Z
        PIZRdkzaQxkZ6NTrsdQ5VcfwbTsAKhOJQwZ8Tg9Gr0oIou3++Beh5CjppYlRmjIRmxtpB1
        zyk39aJw4f4uzYTfcyJ3Oic1qJRzH96dGt28Sf3gplKDfAL2hT74PqBhdC7+AQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/47] patches: Remove const from struct rchan_callbacks
Date:   Tue, 19 Oct 2021 23:42:42 +0200
Message-Id: <20211019214320.2035704-10-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 85BA711FD
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The struct rchan_callbacks parameter to the relay_open function was
changed to const in kernel 5.11 and the drivers were adapted. On older
kernel versions the struct rchan_callbacks should not be costs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 ...05-remove-const-from-rchan_callbacks.patch | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 patches/0105-remove-const-from-rchan_callbacks.patch

diff --git a/patches/0105-remove-const-from-rchan_callbacks.patch b/patches/0105-remove-const-from-rchan_callbacks.patch
new file mode 100644
index 00000000..16c14707
--- /dev/null
+++ b/patches/0105-remove-const-from-rchan_callbacks.patch
@@ -0,0 +1,42 @@
+--- a/drivers/net/wireless/ath/ath10k/spectral.c
++++ b/drivers/net/wireless/ath/ath10k/spectral.c
+@@ -497,7 +497,11 @@ static int remove_buf_file_handler(struc
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(5,11,0)
+ static const struct rchan_callbacks rfs_spec_scan_cb = {
++#else
++static struct rchan_callbacks rfs_spec_scan_cb = {
++#endif
+ 	.create_buf_file = create_buf_file_handler,
+ 	.remove_buf_file = remove_buf_file_handler,
+ };
+--- a/drivers/net/wireless/ath/ath11k/spectral.c
++++ b/drivers/net/wireless/ath/ath11k/spectral.c
+@@ -148,7 +148,11 @@ static int remove_buf_file_handler(struc
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(5,11,0)
+ static const struct rchan_callbacks rfs_scan_cb = {
++#else
++static struct rchan_callbacks rfs_scan_cb = {
++#endif
+ 	.create_buf_file = create_buf_file_handler,
+ 	.remove_buf_file = remove_buf_file_handler,
+ };
+--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
++++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
+@@ -1053,7 +1053,11 @@ static int remove_buf_file_handler(struc
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(5,11,0)
+ static const struct rchan_callbacks rfs_spec_scan_cb = {
++#else
++static struct rchan_callbacks rfs_spec_scan_cb = {
++#endif
+ 	.create_buf_file = create_buf_file_handler,
+ 	.remove_buf_file = remove_buf_file_handler,
+ };
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
