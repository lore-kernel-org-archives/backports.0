Return-Path: <SRS0=wwGC=C6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C146C46466
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5019C22574
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgIUSo4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:44:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:56210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgIUSo4 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Sep 2020 14:44:56 -0400
IronPort-SDR: IFVcZ2qAdMoa7zy7WbaD8ITGhVuEqYzSEFwHrShiLA3FD/JJeze1eJD8HxxbFtb0DKswKN3mYT
 klRUrTg1N86Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="160521059"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="160521059"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 11:44:55 -0700
IronPort-SDR: HXfVGUk2Pe9BpRHxJsrXVYoiwz4H9g9zfupcWsJtFzkc+zE0J9hLdIu6kXvra3sp6GxH/yl1LJ
 khuBw9qU1RJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="334663793"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:55 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     linux-nvme@lists.infradead.org, hch@lst.de
Cc:     kbusch@kernel.org, damien.lemoal@wdc.com,
        backports@vger.kernel.org,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 1/3] [backport] nvme: Cleanup and rename nvme_block_nr()
Date:   Mon, 21 Sep 2020 12:47:26 -0600
Message-Id: <20200921184728.11291-2-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com>
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 314d48dd224897e35ddcaf5a1d7d133b5adddeb7

Rename nvme_block_nr() to nvme_sect_to_lba() and use SECTOR_SHIFT
instead of its hard coded value 9. Also add a comment to decribe this
helper.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/nvme.h | 7 +++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 071b63146..f7d32eeee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -633,7 +633,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}

 	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_block_nr(ns, bio->bi_iter.bi_sector);
+		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
 		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;

 		if (n < segments) {
@@ -674,7 +674,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
-		cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 	cmnd->write_zeroes.control = 0;
@@ -698,7 +698,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,

 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);

 	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ed0226086..f93ba2da1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -421,9 +421,12 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 0x4E564D65);
 }

-static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
+/*
+ * Convert a 512B sector number to a device logical block number.
+ */
+static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
 {
-	return (sector >> (ns->lba_shift - 9));
+	return sector >> (ns->lba_shift - SECTOR_SHIFT);
 }

 static inline void nvme_end_request(struct request *req, __le16 status,
--
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
