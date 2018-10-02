Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172DBC64EB9
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5F22082A
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5F22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJCCR3 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:17:29 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48352 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJCCR2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:17:28 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QPH-0004o0-Jv; Tue, 02 Oct 2018 21:32:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/6] backports: add copy-list.hwsim
Date:   Tue,  2 Oct 2018 21:32:12 +0200
Message-Id: <20181002193215.399-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181002193215.399-1-johannes@sipsolutions.net>
References: <20181002193215.399-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is can be useful for minimal testing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 copy-list.hwsim | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 copy-list.hwsim

diff --git a/copy-list.hwsim b/copy-list.hwsim
new file mode 100644
index 000000000000..c56f0bcb915c
--- /dev/null
+++ b/copy-list.hwsim
@@ -0,0 +1,91 @@
+#
+# This file specifies which sources are copied from the kernel
+# into the backports package.
+#
+# Directories must end with a slash (e.g. "net/wireless/") and
+# are then copied with all their contents.
+#
+# It is also possible to rename while copying, to do so list
+# old name -> new name
+# Note that in this case the spaces are needed: " -> "
+#
+
+COPYING
+MAINTAINERS
+include/linux/unaligned/
+include/linux/hashtable.h
+include/linux/fixp-arith.h
+include/linux/crc32poly.h
+
+# This just defines some macros, simply take it
+include/linux/bitfield.h
+include/linux/average.h
+include/linux/overflow.h
+
+# crypto_memneq
+crypto/memneq.c -> compat/memneq.c
+
+# 802.11
+drivers/net/wireless/Kconfig
+drivers/net/wireless/Makefile
+
+include/linux/wireless.h
+include/uapi/linux/wireless.h
+include/linux/ieee80211.h
+include/linux/pci_ids.h
+include/uapi/linux/pci_regs.h
+include/linux/mmc/sdio_ids.h
+include/linux/ath9k_platform.h
+include/linux/wl12xx.h
+include/linux/rndis.h
+include/linux/bcm47xx_wdt.h
+include/linux/usb/usbnet.h
+include/linux/usb/cdc.h
+include/uapi/linux/usb/cdc.h
+include/uapi/linux/usb/cdc-wdm.h
+include/linux/usb/cdc_ncm.h
+include/linux/usb/cdc-wdm.h
+include/linux/usb/rndis_host.h
+include/linux/spi/libertas_spi.h
+include/linux/platform_data/brcmfmac.h
+include/linux/platform_data/net-cw1200.h
+include/uapi/linux/nl80211.h
+include/net/rsi_91x.h
+
+include/net/cfg80211.h
+include/net/cfg80211-wext.h
+include/net/ieee80211_radiotap.h
+include/net/lib80211.h
+include/net/mac80211.h
+include/net/regulatory.h
+include/net/codel.h
+include/net/codel_impl.h
+include/net/codel_qdisc.h
+include/net/fq.h
+include/net/fq_impl.h
+
+# signature verification code
+include/linux/asn1.h
+include/linux/asn1_ber_bytecode.h
+include/linux/oid_registry.h
+lib/build_OID_registry -> compat/build_OID_registry
+crypto/asymmetric_keys/pkcs7_parser.c -> compat/verification/pkcs7_parser.c
+crypto/asymmetric_keys/pkcs7_parser.h -> compat/verification/pkcs7_parser.h
+crypto/asymmetric_keys/pkcs7_trust.c -> compat/verification/pkcs7_trust.c
+crypto/asymmetric_keys/pkcs7_verify.c -> compat/verification/pkcs7_verify.c
+crypto/asymmetric_keys/x509_cert_parser.c -> compat/verification/x509_cert_parser.c
+crypto/asymmetric_keys/x509_parser.h -> compat/verification/x509_parser.h
+crypto/asymmetric_keys/x509_public_key.c -> compat/verification/x509_public_key.c
+
+net/Makefile
+net/Kconfig
+net/wireless/
+net/mac80211/
+# MPLS labels, checked on skb->protocol on the
+# respective 802 family, only ethernet seems to use
+# this right now, see 960d97f95
+include/linux/mpls.h
+include/uapi/linux/mpls.h
+
+drivers/net/wireless/mac80211_hwsim.c
+drivers/net/wireless/mac80211_hwsim.h
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
