Return-Path: <SRS0=k+Hr=TX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C8C282CE
	for <backports@archiver.kernel.org>; Thu, 23 May 2019 02:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB30B20881
	for <backports@archiver.kernel.org>; Thu, 23 May 2019 02:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r05mQGsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfEWCa4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 22 May 2019 22:30:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40494 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWCa4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 May 2019 22:30:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so2345065pfn.7
        for <backports@vger.kernel.org>; Wed, 22 May 2019 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=Pg1VCL0xEJIMTeDS562nPQ+9/2PfBKH563jZ2j/wxK8=;
        b=r05mQGsbR1XVcLrk37iZYoW4dTwseU8RioqXUxGVawNGzVsvpyYde3YRIv8QQ8ubt6
         8uiUA0F8xq6VhmbQ1NYIUSQxSg0YMn2HPUaJayig9DepaQ6KN+50ySXflUwcQ5HTzix9
         7QJYvDPPtZCAoHX9Pdw0h45acoC5tLRt+S6s8nFlSezDDPIDW81Xb9aXX+N1pEFw+Kxw
         31uECpLMo057BKMGsZLJUbpuVAUq4XmVOH5RXrTfIw7b/BPOBnbkLex2RDHn7I3TyDrT
         ZFmL9XqfAlWs8HCIULV65JOSj3dt3oHICyk6VKk7V7uA9h6Q1zRsmViZSFTmPDw7zRam
         pHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=Pg1VCL0xEJIMTeDS562nPQ+9/2PfBKH563jZ2j/wxK8=;
        b=IDskHlkN9l/z4hHjtR5MlzTEabT20QKWWaUSDVJUQXSLA4iQPBJYt9WjxJk4NRe8nD
         D/uAa+UWBHZ+jANXhUovy/qO2ITCrqPxifpxSQuQcloeGtA4ZKpEl3cWkVr6fNWQmt4g
         kfE78oUbEOUdGKz8+15eyKnimvgmCVf/NNA37JmIS2du2IcqvYwMn0fS+a0yfI1f9K8L
         dkVYjKgLeRAr8itaoO4EeSA+oRiOZqXLKB/sIVUp3j8SEdXJC2JFZ5j2k741KW0rxxSk
         VtZOmtF1e5k8e3PkEqYt/GMrdtXr5NKPzSvhZx3yuD2IAF6cBTqZd6u2HXhWa5e+giTq
         obzw==
X-Gm-Message-State: APjAAAW3DvbnB9HmDyiGqBViv3nXDQWIKOI2b4UOU2RaOcG6Woo7wGsY
        uXkZLEPsTVNjKocmOsWMn3Uw28oj
X-Google-Smtp-Source: APXvYqyF2tw91BHDsAn5AX0ky1i2OadvyoQtL0CqGOWYzhPKD0vCjMq+O7ZvEP9rY7waXM5X4UWvXw==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr89172397pgv.96.1558578655589;
        Wed, 22 May 2019 19:30:55 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id r1sm33498074pfg.65.2019.05.22.19.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 19:30:54 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH] backports: update 0069-iwlwifi-pd-string-fix.patch patch for v5.1
Date:   Thu, 23 May 2019 10:30:52 +0800
Message-Id: <20190523023052.28420-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Fix 0069-iwlwifi-pd-string-fix.patch to match the code changes on v5.1
kernel.

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 patches/0069-iwlwifi-pd-string-fix.patch | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index 8a2ae81a..eef1c903 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -1,3 +1,9 @@
+diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
+index d4b19673b06a..d4806c20dcbc 100644
+diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+index 6925527d8457..1cf9e0b6cde5 100644
+diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+index 776b24f54200..acc60acd6a3d 100644
 --- a/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
 +++ b/drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c
 @@ -2386,12 +2386,23 @@ void iwl_dbgfs_register(struct iwl_priv
@@ -26,10 +32,10 @@
  	}
 --- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
 +++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
-@@ -776,8 +776,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
- 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
+@@ -775,8 +775,13 @@ void iwl_mvm_vif_dbgfs_register(struct i
  
- 	if (!mvmvif->dbgfs_dir) {
+ 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
+ 	if (IS_ERR_OR_NULL(mvmvif->dbgfs_dir)) {
 +#if LINUX_VERSION_IS_GEQ(3,12,0)
  		IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
  			dbgfs_dir);
@@ -40,7 +46,7 @@
  		return;
  	}
  
-@@ -806,15 +811,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
+@@ -805,15 +810,28 @@ void iwl_mvm_vif_dbgfs_register(struct i
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
