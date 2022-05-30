Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E33FC433F5
	for <backports@archiver.kernel.org>; Mon, 30 May 2022 17:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbiE3RrG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 30 May 2022 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiE3RrF (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 30 May 2022 13:47:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CC532FB
        for <backports@vger.kernel.org>; Mon, 30 May 2022 10:47:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l19so4330555ejr.8
        for <backports@vger.kernel.org>; Mon, 30 May 2022 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QKPMST3Y5qMCcUw7ZEMfpiqFdWPcTX7PSIyN2SFQ+s=;
        b=EVbo6FSXPQLJWCNEhhKuO0zmYpNJgKisauvbPo6ioHBXQXmJ0WNe2ObXb1hpqAHvim
         lA9SQiP/9THIKNXgQ+iybiilwuh1ShkJPu9YnHXmhESPmsw4wS61OL6o+AZ7CfH6URai
         RotC2xNl1938VxRMBfzI/irOOebbNOWi2L7+ZihOyrG6rMJppzYSYQuYMGVK9jCL6oUv
         0mKmDYlBv+OGyUOa9sHSCx9nKMB0oB3OE93rJR7VG7G4t0TXGRQ3ADnalKctAfXKrpmu
         zg3cAxQqO/rdsU1qX9ls1dVgIJ5UCvuGaCWmsnReRcy/iA2UYsFxLcwSZIYVjW4ewBJ+
         jb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QKPMST3Y5qMCcUw7ZEMfpiqFdWPcTX7PSIyN2SFQ+s=;
        b=xCYKolIUEiBRTMwwWap0wAepESX++l+K94Jne8BuhF4ziy55ukpkzDn7TU5cYZK4da
         MavVGUMu8+MWJ15eStzY9GxJgYUOJ5tcTnAxXVwKlTWw6osl4oPcTpjDcNFh89vm1Obj
         A+qHTTBklKhaMAbdsIYJANNou95xIepI4stHjM0LcYQQqEPCD7rU/QvPUGZ3KNNpbBxc
         ptIxq5Oee+VMs4UL9pnK/wXmwGF9EeY9XE8fIe4M9d+6FjDjvBciCbuN6mvbPlZCOcEn
         Poq9DjRQQdw56Zf71oAsMuJk8Aci3zl14bLHn2AI2bnVq3oP9sYsCv5OhoGU/aNVvcxU
         fddQ==
X-Gm-Message-State: AOAM532nHrmQVH6RrIhHgHy79ht/AgvhBe4v08dUPuJpPN0RBJssrvYV
        k1RmK5KogSWyx+ORR6ms7lR8apkXHHM=
X-Google-Smtp-Source: ABdhPJw5+lTHnCBcYHOC9ApGRjSJo4p+o5Z24F88iSQJQ3hRo4FrtJpp7bFJDL0enLBkUXvlbFTRwQ==
X-Received: by 2002:a17:906:a397:b0:6fe:a1e5:de70 with SMTP id k23-20020a170906a39700b006fea1e5de70mr45993369ejz.2.1653932822819;
        Mon, 30 May 2022 10:47:02 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-167-cbl.xnet.hr. [94.253.144.167])
        by smtp.googlemail.com with ESMTPSA id k9-20020a50c089000000b0042617ba63c3sm6867968edf.77.2022.05.30.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 10:47:02 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     backports@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] backports: add QMI helpers
Date:   Mon, 30 May 2022 19:47:00 +0200
Message-Id: <20220530174700.1669944-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

QMI helpers are used by ath11k for both AHB and PCI support.
They are also not user selectable but rather are meant to be selected
by ath11k, so backport them as well to avoid patching the kernel to
provide these from OpenWrt for example.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 backport/Kconfig.sources | 1 +
 backport/Makefile.kernel | 1 +
 copy-list                | 5 +++++
 dependencies             | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/backport/Kconfig.sources b/backport/Kconfig.sources
index 87ffca94..2ea4d8a6 100644
--- a/backport/Kconfig.sources
+++ b/backport/Kconfig.sources
@@ -6,6 +6,7 @@ source "$BACKPORT_DIR/net/wireless/Kconfig"
 source "$BACKPORT_DIR/net/mac80211/Kconfig"
 source "$BACKPORT_DIR/net/qrtr/Kconfig"
 source "$BACKPORT_DIR/drivers/bus/mhi/Kconfig"
+source "$BACKPORT_DIR/drivers/soc/qcom/Kconfig"
 source "$BACKPORT_DIR/drivers/net/wireless/Kconfig"
 source "$BACKPORT_DIR/drivers/net/usb/Kconfig"
 
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 373fed96..11ce4177 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -40,6 +40,7 @@ obj-y += compat/
 obj-$(CPTCFG_CFG80211) += net/wireless/
 obj-$(CPTCFG_MAC80211) += net/mac80211/
 obj-$(CPTCFG_QRTR) += net/qrtr/
+obj-$(CPTCFG_QCOM_QMI_HELPERS) += drivers/soc/qcom/
 obj-$(CPTCFG_MHI_BUS) += drivers/bus/mhi/
 obj-$(CPTCFG_WLAN) += drivers/net/wireless/
 obj-$(CPTCFG_SSB) += drivers/ssb/
diff --git a/copy-list b/copy-list
index 480a9fb3..21bf6c58 100644
--- a/copy-list
+++ b/copy-list
@@ -102,6 +102,11 @@ drivers/ssb/
 include/linux/ssb/
 drivers/bcma/
 include/linux/bcma/
+drivers/soc/qcom/Makefile
+drivers/soc/qcom/Kconfig
+drivers/soc/qcom/qmi_encdec.c
+drivers/soc/qcom/qmi_interface.c
+include/linux/soc/qcom/qmi.h
 drivers/net/wireless/atmel/
 drivers/net/wireless/broadcom/
 drivers/net/wireless/st/
diff --git a/dependencies b/dependencies
index 5bb9c563..3f88c446 100644
--- a/dependencies
+++ b/dependencies
@@ -44,5 +44,7 @@ MHI_BUS 4.19
 # sock_gettstamp()
 QRTR 5.2
 
+QCOM_QMI_HELPERS 4.16
+
 # QRTR
 ATH11K 5.2
-- 
2.36.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
