Return-Path: <SRS0=wwGC=C6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7342DC4363C
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB720888
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgIUSpA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:45:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:56210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgIUSpA (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Sep 2020 14:45:00 -0400
IronPort-SDR: dXzudNWskOErQSLbW0PK6+RnZUJY+wWojnsJmv2gjsyFSGQnR6R7Dg9LtLlxJrjFtVY//DNjes
 GBjBOhpay2aA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="160521068"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="160521068"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 11:45:00 -0700
IronPort-SDR: fOMXSJGvA8Fq6sXdnyaXSkSZe1s2lTCS6GrcoqIbu3dWfGuadBZOJ6Pb7O1Srv2hmLLQfEDPC/
 0qIutFG6hvhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="334663819"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:59 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     linux-nvme@lists.infradead.org, hch@lst.de
Cc:     kbusch@kernel.org, damien.lemoal@wdc.com,
        backports@vger.kernel.org,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 3/3] [backport] nvme: consolidate chunk_sectors settings
Date:   Mon, 21 Sep 2020 12:47:28 -0600
Message-Id: <20200921184728.11291-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com>
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

commit 38adf94e166e3cb4eb89683458ca578051e8218d

Move the quirked chunk_sectors setting to the same location as noiob so
one place registers this setting. And since the noiob value is only used
locally, remove the member from struct nvme_ns.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 22 ++++++++++------------
 drivers/nvme/host/nvme.h |  1 -
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9ac27c9a1..f8068d150 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1692,12 +1692,6 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */

-static void nvme_set_chunk_size(struct nvme_ns *ns)
-{
-	u32 chunk_size = nvme_lba_to_sect(ns, ns->noiob);
-	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
-}
-
 static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -1852,6 +1846,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
+	u32 iob;

 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -1860,7 +1855,13 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
-	ns->noiob = le16_to_cpu(id->noiob);
+
+	if ((ns->ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ns->ctrl->max_hw_sectors))
+		iob = ns->ctrl->max_hw_sectors;
+	else
+		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
+
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	/* the PI implementation requires metadata equal t10 pi tuple size */
@@ -1869,8 +1870,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	else
 		ns->pi_type = 0;

-	if (ns->noiob)
-		nvme_set_chunk_size(ns);
+	if (iob)
+		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
@@ -2221,9 +2222,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
-	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
-	    is_power_of_2(ctrl->max_hw_sectors))
-		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
 	blk_queue_virt_boundary(q, ctrl->page_size - 1);
 	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		vwc = true;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 73065952f..a177b918f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -376,7 +376,6 @@ struct nvme_ns {
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
-	u16 noiob;

 	struct nvme_fault_inject fault_inject;

--
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
