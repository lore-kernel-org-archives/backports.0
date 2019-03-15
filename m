Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D546C10F0B
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D120521871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfCOOd1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44024 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729283AbfCOOd1 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntl-0004kR-I1; Fri, 15 Mar 2019 16:33:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:14 +0200
Message-Id: <20190315143318.4714-3-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315143318.4714-1-luca@coelho.fi>
References: <20190315143318.4714-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 2/6] backports: update iwlwifi pci device removal patch for v5.0
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The code surrounding the #ifdef we add has changed.  Update the patch
accordingly.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 patches/0085-iwlwifi-pci-device-removal.patch | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/patches/0085-iwlwifi-pci-device-removal.patch b/patches/0085-iwlwifi-pci-device-removal.patch
index 84fa7f9264a8..97a904f6365f 100644
--- a/patches/0085-iwlwifi-pci-device-removal.patch
+++ b/patches/0085-iwlwifi-pci-device-removal.patch
@@ -1,18 +1,18 @@
 diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-index cc8c53dc0ab6..68296b65a680 100644
+index f74281508197..3b11bd68f261 100644
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
-@@ -1968,6 +1968,9 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1964,6 +1964,9 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
  	struct iwl_trans_pcie_removal *removal =
  		container_of(wk, struct iwl_trans_pcie_removal, work);
  	struct pci_dev *pdev = removal->pdev;
 +#if LINUX_VERSION_IS_LESS(3,14,0)
 +	dev_err(&pdev->dev, "Device gone - can't remove on old kernels.\n");
 +#else
- 	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
+ 	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
  
  	dev_err(&pdev->dev, "Device gone - attempting removal\n");
-@@ -1976,6 +1979,7 @@ static void iwl_trans_pcie_removal_wk(st
+@@ -1972,6 +1975,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
  	pci_dev_put(pdev);
  	pci_stop_and_remove_bus_device(pdev);
  	pci_unlock_rescan_remove();
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
