Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbaDYHPD (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Apr 2014 03:15:03 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 0/3] backports: fixes for RHEL7.0
Date: Fri, 25 Apr 2014 09:14:27 +0200
Message-Id: <1398410070-30529-1-git-send-email-sassmann@kpanic.de> (sfid-20140425_091506_291877_A332F708)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Get backports ready for RHEL7.0.

Stefan Assmann (3):
  backports: wrap dma_set_mask_and_coherent in LINUX_BACKPORT()
  backports: add linux/of_graph.h to copy-list
  backports: ifdef code already present in RHEL7.0

 backport/backport-include/linux/device.h      | 2 +-
 backport/backport-include/linux/dma-mapping.h | 1 +
 backport/backport-include/linux/skbuff.h      | 2 +-
 backport/compat/dma-shared-helpers.c          | 2 ++
 copy-list                                     | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.9.0

