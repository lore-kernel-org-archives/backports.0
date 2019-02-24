Return-Path: <SRS0=hOG9=Q7=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84FC43381
	for <backports@archiver.kernel.org>; Sun, 24 Feb 2019 16:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65C0205C9
	for <backports@archiver.kernel.org>; Sun, 24 Feb 2019 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfBXQDb (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:03:31 -0500
Received: from hera.iit.uni-miskolc.hu ([193.6.5.4]:34732 "EHLO
        hera.iit.uni-miskolc.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXQDa (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 24 Feb 2019 11:03:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 9A21813F;
        Sun, 24 Feb 2019 16:27:54 +0100 (CET)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FFIq13tQMGuY; Sun, 24 Feb 2019 16:27:45 +0100 (CET)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:227c:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id BD65413D;
        Sun, 24 Feb 2019 16:27:42 +0100 (CET)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org,
        =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] backports: add defconfigs for Marvell wifi drivers
Date:   Sun, 24 Feb 2019 16:27:20 +0100
Message-Id: <20190224152720.3592-1-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Enable users to be able to conveniently select the Marvell wifi drivers that
they need.

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 backport/defconfigs/libertas    | 10 ++++++++++
 backport/defconfigs/libertas_tf |  9 +++++++++
 backport/defconfigs/mwifiex     |  8 ++++++++
 backport/defconfigs/mwl8k       |  7 +++++++
 4 files changed, 34 insertions(+)
 create mode 100644 backport/defconfigs/libertas
 create mode 100644 backport/defconfigs/libertas_tf
 create mode 100644 backport/defconfigs/mwifiex
 create mode 100644 backport/defconfigs/mwl8k

diff --git a/backport/defconfigs/libertas b/backport/defconfigs/libertas
new file mode 100644
index 00000000..1cbb97d5
--- /dev/null
+++ b/backport/defconfigs/libertas
@@ -0,0 +1,10 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_WLAN=y
+CPTCFG_WLAN_VENDOR_MARVELL=y
+CPTCFG_LIBERTAS=m
+CPTCFG_LIBERTAS_USB=m
+CPTCFG_LIBERTAS_CS=m
+CPTCFG_LIBERTAS_SDIO=m
+CPTCFG_LIBERTAS_SPI=m
+CPTCFG_LIBERTAS_MESH=y
diff --git a/backport/defconfigs/libertas_tf b/backport/defconfigs/libertas_tf
new file mode 100644
index 00000000..dc931666
--- /dev/null
+++ b/backport/defconfigs/libertas_tf
@@ -0,0 +1,9 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_MESH=y
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_WLAN=y
+CPTCFG_WLAN_VENDOR_MARVELL=y
+CPTCFG_LIBERTAS_THINFIRM=m
+CPTCFG_LIBERTAS_THINFIRM_USB=m
diff --git a/backport/defconfigs/mwifiex b/backport/defconfigs/mwifiex
new file mode 100644
index 00000000..25c1113e
--- /dev/null
+++ b/backport/defconfigs/mwifiex
@@ -0,0 +1,8 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_WLAN=y
+CPTCFG_WLAN_VENDOR_MARVELL=y
+CPTCFG_MWIFIEX=m
+CPTCFG_MWIFIEX_SDIO=m
+CPTCFG_MWIFIEX_PCIE=m
+CPTCFG_MWIFIEX_USB=m
diff --git a/backport/defconfigs/mwl8k b/backport/defconfigs/mwl8k
new file mode 100644
index 00000000..5f25b07c
--- /dev/null
+++ b/backport/defconfigs/mwl8k
@@ -0,0 +1,7 @@
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_WLAN=y
+CPTCFG_WLAN_VENDOR_MARVELL=y
+CPTCFG_MWL8K=m
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
