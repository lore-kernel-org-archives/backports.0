Return-Path: <SRS0=wwGC=C6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAE4C4346E
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E06B20888
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 18:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgIUSoz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:44:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:56210 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgIUSoz (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Sep 2020 14:44:55 -0400
IronPort-SDR: UgrZVs5EYS/74JYxtGRT8rWjLnaI9osKi+LIgmY2rLIdwIKnAR/4mlRtXJyaz+x7Zq3eLMj3W1
 fGhPhHqKx17w==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="160521057"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="160521057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 11:44:53 -0700
IronPort-SDR: SDkFz9FkJPmevQG049DhiaO77fNmC2qcPbzKKsZGWW1kWdEA3kZCKSXjcyrKL0iRZ01llk1UPL
 DvLRqB/tAf4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; 
   d="scan'208";a="334663783"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
  by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:53 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     linux-nvme@lists.infradead.org, hch@lst.de
Cc:     kbusch@kernel.org, damien.lemoal@wdc.com,
        backports@vger.kernel.org,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 0/3] [backport] nvme: Consolidate chunk_sectors settings
Date:   Mon, 21 Sep 2020 12:47:25 -0600
Message-Id: <20200921184728.11291-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Backport commit 38adf94e166e3cb4eb89683458ca578051e8218d and it's
dependencies to linux-stable 5.4.y.

Dependent commits:
314d48dd224897e35ddcaf5a1d7d133b5adddeb7
e08f2ae850929d40e66268ee47e443e7ea56eeb7

When running test cases to stress NVMe device, a race condition / deadlocks is
seen every couple of days or so where multiple threads are trying to acquire
ctrl->subsystem->lock or ctrl->scan_lock.

The test cases send a lot nvme-cli requests to do Sanitize, Format, FW Download,
FW Activate, Flush, Get Log, Identify, and reset requests to two controllers
that share a namespace. Some of those commands target a namespace, some target
a controller.  The commands are sent in random order and random mix to the two
controllers.

The test cases does not wait for nvme-cli requests to finish before sending more.
So for example, there could be multiple reset requests, multiple format requests,
outstanding at the same time as a sanitize, on both paths at the same time, etc.
Many of these test cases include combos that don't really make sense in the
context of NVMe, however it is used to create as much stress as possible.

This patchset fixes this issue.

Similar issue with a detailed call trace/log was discussed in the LKML
Link: https://lore.kernel.org/linux-nvme/04580CD6-7652-459D-ABDD-732947B4A6DF@javigon.com/

Revanth Rajashekar (3):
  nvme: Cleanup and rename nvme_block_nr()
  nvme: Introduce nvme_lba_to_sect()
  nvme: consolidate chunk_sectors settings

 drivers/nvme/host/core.c | 40 +++++++++++++++++++---------------------
 drivers/nvme/host/nvme.h | 16 +++++++++++++---
 2 files changed, 32 insertions(+), 24 deletions(-)

--
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
